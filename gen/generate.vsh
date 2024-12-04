#!/usr/bin/env -S v run

module main

import arrays
import encoding.xml
import flag
import os
import strings

const module_name = 'virt'
const symbols_ignore_file = 'symbols-ignore'

// C type -> V C-style type
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
	'size_t':                'usize'
	'size_t *':              '&usize'
}

type Symbol = Const | Function | FunctionType // | Struct | StructField

struct Const {
mut:
	c_name string
	c_type string
	v_name string
	v_type string
	value  string
	doc    string
}

fn (c Const) gen() string {
	mut decl := ''
	if c.doc != '' {
		decl += format_doc_string(c.doc) + '\n'
	}
	decl += 'pub const ${c.v_name} = C.${c.c_name}' + '\n'
	return decl
}

struct Function {
mut:
	c_source_file string
	c_name        string
	c_return_type string
	v_name        string
	v_return_type string
	args          []FunctionArg
	method_of     string // name of corresponding V struct
	self_var      string
}

struct FunctionArg {
mut:
	c_name string
	c_type string
	v_name string
	v_type string
	doc    string
}

fn (f Function) gen_c_fn() string {
	mut fn_args := []string{}
	for arg in f.args {
		fn_args << arg.v_name + ' ' + arg.v_type
	}
	return 'fn C.${f.c_name}(${fn_args.join(', ')}) ${f.v_return_type}'
}

fn (f Function) gen_fn_doc() string {
	return '// See also https://libvirt.org/html/libvirt-${f.c_source_file}.html#${f.c_name}'
}

fn (f Function) gen_fn_signature() string {
	mut fn_args := []string{}
	for i, arg in f.args {
		if arg.c_type == 'vir' + f.method_of + 'Ptr' && i == 0 {
			continue
		}
		mut v_type := arg.v_type
		if v_type == '&char' {
			v_type = 'string'
		}
		fn_args << arg.v_name + ' ' + v_type
	}
	mut return_type := f.v_return_type
	if return_type.ends_with('char') {
		return_type = 'string'
	}
	mut signature := ''
	signature += 'pub fn'
	signature += ' '
	if f.method_of != '' {
		signature += '(${f.self_var} ${f.method_of})'
	}
	signature += ' '
	signature += f.v_name
	signature += '('
	signature += fn_args.join(', ')
	signature += ')'
	signature += ' '
	signature += '!' + return_type
	return signature
}

fn (f Function) gen_fn_body() string {
	mut c_fn_args := []string{}
	for i, arg in f.args {
		if arg.c_type == 'vir' + f.method_of + 'Ptr' && i == 0 {
			continue
		}
		mut c_arg := arg.c_name
		if arg.v_type == '&char' {
			c_arg = '&char(${arg.c_name}.str)'
		}
		c_fn_args << c_arg
	}
	mut body := strings.new_builder(500)
	if c_fn_args.len > 0 {
		body.writeln('\tresult := C.${f.c_name}(${f.self_var}.ptr, ${c_fn_args.join(', ')})')
	} else {
		body.writeln('\tresult := C.${f.c_name}(${f.self_var}.ptr)')
	}
	mut return_type := f.v_return_type
	if return_type.ends_with('char') {
		return_type = 'string'
	}
	if return_type in ['int', 'u32'] {
		body.writeln('\tif result == -1 {')
		body.writeln('\t\treturn VirtError.new(last_error())')
		body.writeln('\t}')
		body.writeln('\treturn result')
	} else if return_type == 'string' {
		body.writeln('\tif isnil(result) {')
		body.writeln('\t\treturn VirtError.new(last_error())')
		body.writeln('\t}')
		body.writeln('\treturn unsafe { cstring_to_vstring(result) }')
	}
	return body.str()
}

fn (f Function) gen() string {
	mut func := strings.new_builder(1000)
	func.writeln(f.gen_fn_doc())
	func.writeln(f.gen_fn_signature() + ' {')
	func.writeln(f.gen_fn_body())
	func.writeln('}')
	func.writeln('')
	func.writeln(f.gen_c_fn())
	return func.str()
}

struct FunctionType {
mut:
	c_name        string
	c_return_type string
	v_name        string
	v_return_type string
	args          []FunctionArg
}

fn (f FunctionType) gen() string {
	return ''
}

// TODO
struct Struct {
	c_name string
	v_name string
	fields []StructField
	doc    string
}

// TODO
struct StructField {
	c_name string
	c_type string
	v_name string
	v_type string
	doc    string
}

fn write_file_header(mut b strings.Builder, mod string, lib string, headers []string, headers_path string) {
	modname := module_name
	b.writeln($tmpl('notice.tmpl'))
	b.writeln('// ! WARNING !')
	b.writeln('// This file is automatically written by generate.vsh')
	b.writeln('// do not edit it manually, any changes made here will be lost!')
	b.writeln('')
	b.writeln('module ${mod}')
	b.writeln('')
	b.writeln('#flag -I${headers_path}')
	b.writeln('#flag -l${lib}')
	for header in headers {
		b.writeln('#include <${header}>')
	}
	b.writeln('')
}

fn write_file_content(mut b strings.Builder, symbols []Symbol) {
	for symbol in symbols {
		match symbol {
			Const {
				b.writeln(symbol.gen())
			}
			Function {
				b.writeln(symbol.gen())
			}
			FunctionType {
				b.writeln(symbol.gen())
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
		if os.getenv('VGEN_PRINTALLC') != '' {
			println(s)
			// println('${s.name} ${s.attributes['name']} ${s.attributes['type']}')
			continue
		}
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
			'typedef' {
				// TODO
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
		if a.v_name < b.v_name {
			return -1
		}
		if a.v_name > b.v_name {
			return 1
		}
		return 0
	})
	return symbols
}

// Name prefixes list. The items order matters.
const name_prefixes = [
	'virDomainCheckpoint',
	'virDomainSnapshot',
	'virDomain',
	'virConnect',
	'virStream',
	'virStoragePool',
	'virStorageVol',
]

// Map of function names that cannot be correctly transformed by
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
	func.c_return_type = ret.attributes['type']
	name := doc.attributes['name']
	for prefix in name_prefixes {
		if name.starts_with(prefix) {
			func.v_name = fn_names[name] or { name.all_after(prefix).camel_to_snake() }
			func.method_of = prefix.trim_left('vir')
			func.self_var = func.method_of[..1].to_lower()
			break
		}
	}
	func.v_return_type = ctype_to_vtype(func.c_return_type)
	for arg in doc.get_elements_by_tag('arg') {
		func.args << FunctionArg{
			c_name: arg.attributes['name']
			c_type: arg.attributes['type']
			v_name: arg.attributes['name'] // save arg names unchanged
			v_type: ctype_to_vtype(arg.attributes['type'])
			doc:    arg.attributes['info']
		}
	}
	func.c_source_file = doc.attributes['file']
	return func
}

fn extract_function_type_def(doc xml.XMLNode) FunctionType {
	funcdef := extract_function_def(doc)
	return FunctionType{
		c_name:        funcdef.c_name
		c_return_type: funcdef.c_return_type
		v_name:        doc.attributes['name'].trim_left('virConnectDomain') // FIXME
		args:          funcdef.args
	}
}

fn extract_constant_def(doc xml.XMLNode) Const {
	return Const{
		c_name: doc.attributes['name']
		c_type: doc.attributes['type']
		v_name: doc.attributes['name'].trim_left('VIR_').to_lower()
		value:  doc.attributes['value']
		doc:    doc.attributes['info']
	}
}

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
				'help':          'Print this help message and exit.'
				'by_prefix':     'Select symbols by name prefix. Can contain full name.'
				'not_prefix':    'Ignore symbols prefixed by prefix. Can contain full name.'
				'headers':       'C header file name, e.g. "libvirt.h", etc.'
				'headers_path':  'Path to search C headers [default: /usr/include/libvirt]'
				'lib':           'Library name to link [default: virt]'
				'print_symbols': 'Just print symbols instead of generating code.'
				'print_c_names': 'In conjuction with -print-symbols print only original C symbol names.'
				'ignore_file':   'Path to symbols-ignore file [default: symbols-ignore]'
			}
		)!
		println(helptext)
		exit(0)
	}
	xml_docs := get_pkgconfig_data()
	mut all_symbols := []Symbol{}
	mut symbols := []Symbol{}
	for doc in xml_docs {
		all_symbols << get_symbols_from_pkgconfig(doc, flags.ignore_file)
	}
	if flags.by_prefix.len == 0 {
		symbols = all_symbols.clone()
	} else {
		for prefix in flags.by_prefix {
			symbols = arrays.append(symbols, all_symbols.filter(it.c_name.starts_with(prefix)))
		}
	}
	for prefix in flags.not_prefix {
		symbols = symbols.filter(!it.c_name.starts_with(prefix))
	}
	if flags.print_symbols {
		for symbol in symbols {
			if flags.print_c_names {
				println(symbol.c_name)
			} else {
				match symbol {
					Function {
						println(symbol.gen_fn_signature())
					}
					else {
						println('pub ${symbol.type_name().to_lower()} ${symbol.v_name}')
					}
				}
			}
		}
		exit(0)
	}
	mut b := strings.new_builder(2000)
	write_file_header(mut b, module_name, flags.lib, flags.headers, flags.headers_path)
	write_file_content(mut b, symbols)
	print(b)
}

@[xdoc: 'V code generator for libvirt binding.']
struct FlagConfig {
	help          bool
	by_prefix     []string
	not_prefix    []string
	headers       []string @[only: header]
	headers_path  string = '/usr/include/libvirt'
	lib           string = 'virt'
	print_symbols bool
	print_c_names bool
	ignore_file   string = 'symbols-ignore'
}
