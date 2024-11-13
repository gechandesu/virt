# V binding for libvirt C API

This module allows you to use libvirt methods from [V](https://vlang.io)
programs. See [README](src/README.md).

## Status

WIP.

> [!WARNING]
> This is an experimental module. Not ready for production use.

## Docs

Currently there is no documentation site. You can generate HTML docs and serve
it via command:
```
make serve
```

## About this binding

It is assumed that the main part of the V code will be automatically generated
by the generate.v from the XML specification provided by libvirt in pkg-config
(similar to the Python binding).

`generate.v` does its job in several stages:

1. Getting symbols. The script gets XML files from pkg-config describing
libvirt symbols and translates them into an intermediate representation.
See the `Symbol` sumtype. The script then works only with these
representations.

2. The script reads the `symbols-ignore` file and excludes the symbols listed
there from the list of symbols found in the first stage.

3. Symbol names are converted from camelCase to snake\_case with the removal
of some parts of the names. This is necessary so that the library interface
complies with V code style conventions.

4. `generate.v` generates C wrappers and V code simply operating on strings.

5. The resulting code is written to files. See Makefile.

Not all code can be easily generated automatically. generate.v does very
simple conversions, it is not very smart. Therefore, any symbols that it
cannot convert are easier to write manually and add to symbols-ignore so that
generate.v does not try to generate them.

Since libvirt is a very large library, and usually only a small number of its
capabilities are used, I decided to add most of the library symbols to
`symbols-ignore`. Gradually improving the generator and adding functions
manually, this binding should reach 100% coverage of the libvirt C API. Until
then, the binding is considered experimental.

## License

LGPL-3.0-or-later. See COPYING and COPYING.LESSER for information.
