/*
 * V binding generator for libvirt C API
 *
 */
module main

import arrays
import encoding.xml
import flag
import os
import strings

const module_name = 'virt'
const symbols_ignore_file = 'symbols-ignore'

// C type -> V type
const types = {
	'const char *':          '&char'
	'const unsigned char *': '&char'
	'char *':                '&char'
	'char **':               '&&char'
	'int':                   'int'
	'int *':                 '&int'
	'int **':                '&&int'
	'unsigned int':          'u32'
	'unsigned int *':        '&u32'
	'long long':             'i64'
	'long long *':           '&i64'
	'unsigned long':         'u32'
	'unsigned long long':    'u64'
	'unsigned long long *':  '&u64'
	'double':                'f64'
	'double *':              '&f64'
	'void':                  ''
	'void *':                'voidptr'
	'byte *':                '&u8'
	'size_t':                'string' // FIXME
	'size_t *':              'string' // FIXME
}

type Symbol = Const | Function | FunctionType // | Struct | StructField

struct Const {
mut:
	c_name string
	c_type string
	name   string
	type   string
	value  string
	doc    string
}

struct Function {
mut:
	c_name    string
	c_type    string
	type      string
	name      string
	args      []FunctionArg
	doc       string
	method_of string // name of corresponding V struct
}

struct FunctionArg {
mut:
	c_name string
	c_type string
	name   string
	type   string
	doc    string
}

struct FunctionType {
mut:
	c_name string
	c_type string
	name   string
	type   string
	args   []FunctionArg
	doc    string
}

// TODO
struct Struct {
	c_name string
	name   string
	fields []StructField
	doc    string
}

// TODO
struct StructField {
	c_name string
	c_type string
	name   string
	type   string
	doc    string
}

fn write_file_header(mut b strings.Builder, mod string, headers []string, headers_path string) {
	b.writeln(license_notice_template())
	b.writeln('// WARN: This file is automatically written by generate.v')
	b.writeln('// do not edit it manually, any changes made here will be lost!')
	b.writeln('')
	b.writeln('module ${mod}')
	b.writeln('')
	b.writeln('#flag -I${headers_path}')
	b.writeln('#flag -lvirt')
	for header in headers {
		b.writeln('#include <${header}>')
	}
	b.writeln('')
}

fn license_notice_template() string {
	modname := module_name
	return $tmpl('notice.tmpl')
}

fn write_file_content(mut b strings.Builder, symbols []Symbol) {
	for symbol in symbols {
		match symbol {
			Const {
				if symbol.doc != '' {
					b.writeln(format_doc_string(symbol.doc))
				}
				b.writeln('pub const ${symbol.name} = C.${symbol.c_name}')
				b.writeln('')
			}
			Function {
				// TODO move this code to separate function
				// V function defenition
				if symbol.doc != '' {
					b.writeln(format_doc_string(symbol.doc))
				}
				letter := symbol.method_of[..1].to_lower()
				mut may_be_null := false
				mut v_return_type := ctype_to_vtype(symbol.c_type)
				if v_return_type.contains('char') {
					v_return_type = 'string'
					may_be_null = true
				}
				mut fn_c_args_arr := []string{}
				mut fn_v_args_arr := []string{}
				for idx, arg in symbol.args {
					if arg.c_type.ends_with('Ptr') && idx == 0 {
						continue // skip first argument if it is pointer
					}
					mut c_arg := arg.name
					mut v_arg := arg.name
					mut v_arg_type := ctype_to_vtype(arg.c_type)
					match v_arg_type {
						'&char' {
							c_arg = '&char(${arg.name}.str)'
							v_arg_type = 'string'
						}
						else {}
					}
					fn_v_args_arr << v_arg + ' ' + v_arg_type
					fn_c_args_arr << c_arg
				}
				fn_c_args := fn_c_args_arr.join(', ')
				fn_v_args := fn_v_args_arr.join(', ')

				// V function signature
				b.writeln('pub fn (${letter} ${symbol.method_of}) ' +
					'${symbol.name}(${fn_v_args}) !${v_return_type} {')
				// C function call
				if fn_c_args_arr.len > 0 {
					b.writeln('\tresult := C.${symbol.c_name}(${letter}.ptr, ${fn_c_args})')
				} else {
					b.writeln('\tresult := C.${symbol.c_name}(${letter}.ptr)')
				}
				// C function result handling
				if v_return_type in ['int', 'u32'] {
					b.writeln('\tif result == -1 {')
					b.writeln('\t\treturn VirtError.new(last_error())')
					b.writeln('\t}')
					b.writeln('\treturn result')
				} else if may_be_null && v_return_type == 'string' {
					b.writeln('\tif isnil(result) {')
					b.writeln('\t\treturn VirtError.new(last_error())')
					b.writeln('\t}')
					b.writeln('\treturn unsafe { cstring_to_vstring(result) }')
				}
				b.writeln('}')
				b.writeln('')
				// C function defenition
				b.writeln(generate_c_fn(symbol))
				b.writeln('')
			}
			FunctionType {
				// TODO
				if symbol.doc != '' {
					b.writeln(format_doc_string(symbol.doc))
				}
				b.writeln('pub type ${symbol.name} = fn()')
				b.writeln('')
			}
		}
	}
}

fn format_doc_string(doc string) string {
	doc_lines := doc.split_into_lines()
	return arrays.join_to_string(doc_lines, '\n', fn (line string) string {
		return ('// ' + line).trim_space()
	})
}

fn get_pkgconfig_data() []xml.XMLDocument {
	pkgconf := os.execute_opt('pkg-config --variable libvirt_api libvirt') or {
		eprintln('error: cannot retrieve data from pkg-config')
		exit(1)
	}
	mut docs := []xml.XMLDocument{}
	for api in ['api', 'qemu-api', 'lxc-api'] {
		file := pkgconf.output.trim_space().replace_once('-api', '-' + api)
		docs << xml.XMLDocument.from_file(file) or {
			eprintln('error: cannot parse XML file ${file}: ${err}')
			exit(1)
		}
	}
	return docs
}

fn get_ignored_symbols(ignore_file string) []string {
	lines := os.read_lines(ignore_file) or {
		eprintln('Unable to read ${ignore_file}: ${err}')
		exit(1)
	}
	mut symbols := []string{}
	for line in lines {
		symbol := line.all_before('#').trim_space()
		if symbol.is_blank() {
			continue
		}
		symbols << symbol
	}
	return symbols
}

fn get_symbols_from_pkgconfig(doc xml.XMLDocument, ignore_file string) []Symbol {
	raw_symbols := doc.get_elements_by_tag('symbols')
	ignored_symbols := get_ignored_symbols(ignore_file)
	mut all_symbols := []Symbol{}
	mut symbols := []Symbol{}
	for symbol in raw_symbols[0].children {
		s := symbol as xml.XMLNode
		match s.name {
			'function' {
				all_symbols << extract_function_def(s)
			}
			'functype' {
				all_symbols << extract_function_type_def(s)
			}
			'enum' {
				all_symbols << extract_constant_def(s)
			}
			'struct' {
				// TODO
			}
			else {} // Skip any macros, variables and typedefs
		}
	}
	for symbol in all_symbols {
		if symbol.c_name in ignored_symbols {
			continue
		}
		symbols << symbol
	}
	symbols.sort_with_compare(fn (a &Symbol, b &Symbol) int {
		if a.name < b.name {
			return -1
		}
		if a.name > b.name {
			return 1
		}
		return 0
	})
	return symbols
}

// List of function names that cannot be correctly transformed by
// V builtin function string.camel_to_snake()
const fn_names = {
	'virDomainGetOSType':           'get_os_type'
	'virDomainAddIOThread':         'add_io_thread'
	'virDomainSaveImageGetXMLDesc': 'save_image_get_xml_desc'
}

fn extract_function_def(doc xml.XMLNode) Function {
	mut func := Function{}
	func.c_name = doc.attributes['name']
	ret := doc.get_elements_by_tag('return')[0] as xml.XMLNode
	func.c_type = ret.attributes['type']
	name := doc.attributes['name']

	// TODO: make this code compact and clean
	if name.starts_with('virDomainCheckpoint') {
		func.name = fn_names[name] or { name.all_after('virDomainCheckpoint').camel_to_snake() }
		func.method_of = 'DomainCheckpoint'
	} else if name.starts_with('virDomainSnapshot') {
		func.name = fn_names[name] or { name.all_after('virDomainSnapshot').camel_to_snake() }
		func.method_of = 'DomainSnapshot'
	} else if name.starts_with('virDomain') {
		func.name = fn_names[name] or { name.all_after('virDomain').camel_to_snake() }
		func.method_of = 'Domain'
	} else if name.starts_with('virConnect') {
		func.name = fn_names[name] or { name.all_after('virConnect').camel_to_snake() }
		func.method_of = 'Connect'
	} else if name.starts_with('virStream') {
		func.name = fn_names[name] or { name.all_after('virStream').camel_to_snake() }
		func.method_of = 'Stream'
	} else if name.starts_with('virStoragePool') {
		func.name = fn_names[name] or { name.all_after('virStoragePool').camel_to_snake() }
		func.method_of = 'StoragePool'
	} else if name.starts_with('virStorageVol') {
		func.name = fn_names[name] or { name.all_after('virStorageVol').camel_to_snake() }
		func.method_of = 'StorageVol'
	}
	func.type = ctype_to_vtype(func.c_type)
	for arg in doc.get_elements_by_tag('arg') {
		func.args << FunctionArg{
			c_name: arg.attributes['name']
			c_type: arg.attributes['type']
			name:   arg.attributes['name']
			doc:    arg.attributes['info']
		}
	}
	func.doc = extract_function_doc(doc)
	return func
}

fn extract_function_doc(doc xml.XMLNode) string {
	mut docs := []string{}
	if doc.children.len > 0 {
		info := doc.children[0] as xml.XMLNode
		for node in info.children {
			cdata := node as xml.XMLCData
			docs << cdata.text
		}
	}
	return docs.join('\n')
}

fn extract_function_type_def(doc xml.XMLNode) FunctionType {
	funcdef := extract_function_def(doc)
	return FunctionType{
		c_name: funcdef.c_name
		c_type: funcdef.c_type
		name:   doc.attributes['name'].trim_left('virConnectDomain') // FIXME
		args:   funcdef.args
		doc:    funcdef.doc
	}
}

fn extract_constant_def(doc xml.XMLNode) Const {
	return Const{
		c_name: doc.attributes['name']
		c_type: doc.attributes['type']
		name:   doc.attributes['name'].trim_left('VIR_').to_lower()
		value:  doc.attributes['value']
		doc:    doc.attributes['info']
	}
}

fn generate_c_fn(f Function) string {
	fn_args := generate_c_fn_args(f.args)
	return_type := ctype_to_vtype(f.c_type)
	return 'fn C.${f.c_name}(${fn_args}) ${return_type}'
}

fn generate_c_fn_args(args []FunctionArg) string {
	mut signature := []string{}
	for arg in args {
		signature << arg.name + ' ' + ctype_to_vtype(arg.c_type)
	}
	return signature.join(', ')
}

// ctype_to_vtype converts C types to corresponding V C-style types.
fn ctype_to_vtype(ctype string) string {
	mut vtype := types[ctype] or { ctype }
	if vtype.ends_with('Ptr') {
		vtype = 'voidptr'
	}
	return vtype
}

fn main() {
	flags, no_matches := flag.to_struct[FlagConfig](os.args, skip: 1, style: .v) or {
		eprintln('Flag parser error. Try -help for info.')
		exit(2)
	}
	if no_matches.len > 0 {
		eprintln('Extra flags is not allowed: ${no_matches} Try -help for info.')
		exit(2)
	}
	if flags.help {
		helptext := flag.to_doc[FlagConfig](
			style:  .v
			fields: {
				'help':           'Print this help message and exit.'
				'by_prefix':      'Select symbols by name prefix. Can contain full name.'
				'not_prefix':     'Ignore symbols prefixed by prefix. Can contain full name.'
				'headers':        'C header file name, e.g. "libvirt.h", etc.'
				'headers_path':   'Path to search C headers [default: /usr/include/libvirt]'
				'print_symbols':  'Just print symbols instead of generating code.'
				'symbols_ignore': 'Path to symbols-ignore file [default: symbols-ignore]'
			}
		)!
		println(helptext)
		exit(0)
	}
	xml_docs := get_pkgconfig_data()
	mut all_symbols := []Symbol{}
	mut symbols := []Symbol{}
	for doc in xml_docs {
		all_symbols << get_symbols_from_pkgconfig(doc, flags.symbols_ignore)
	}
	for prefix in flags.by_prefix {
		symbols = arrays.append(symbols, all_symbols.filter(it.c_name.starts_with(prefix)))
	}
	for prefix in flags.not_prefix {
		symbols = symbols.filter(!it.c_name.starts_with(prefix))
	}
	if flags.print_symbols {
		for symbol in symbols {
			println(symbol.c_name)
		}
		exit(0)
	}
	mut b := strings.new_builder(2000)
	write_file_header(mut b, module_name, flags.headers, flags.headers_path)
	write_file_content(mut b, symbols)
	print(b)
}

@[xdoc: 'V code generator for libvirt binding.']
struct FlagConfig {
	help           bool
	by_prefix      []string
	not_prefix     []string
	headers        []string @[only: header]
	headers_path   string = '/usr/include/libvirt'
	print_symbols  bool
	symbols_ignore string = 'symbols-ignore'
}
