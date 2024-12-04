# V language binding for libvirt native C API

This module allows you to use libvirt in [V](https://vlang.io) programs.

See [src/README.md](src/README.md) and [examples](examples).

## Status

WIP.

> [!WARNING]
> This is an experimental module. Not ready for production use.

libvirt C API coverge is super low for now.

## Docs

Currently there is no documentation site. You can generate HTML docs and serve
it via command:

```
make serve
```

## About this binding

This binding is mostly auto-generated. Files with the `_generated.c.v` suffix
are generated automatically based on the libvirt C API XML specification
provided via pkg-config. Other parts of this library are written by hand.

Generation of C wrappers and V code is done by the `gen/generate.vsh` script.
It uses `symbols-ignore` file to select the symbols for which code will be
generated. Any symbol mentioned in this file will be ignored. See comments in
[symbols-ignore](symbols-ignore) and [gen/generate.vsh](gen/generate.vsh)
source code for details.

Not all code can be easily generated automatically. gen/generate.vsh does very
simple conversions, it is not very smart. Therefore, any symbols that it cannot
convert are easier to write manually and add to symbols-ignore so that
generate.vsh does not try to generate them.

Since libvirt has a very large API and usually only a small number of its
capabilities are used, I decided to add most of the library symbols to
symbols-ignore. Gradually improving the generator and adding functions manually
this binding should reach 100% coverage of the libvirt C API. Unshtil then 
he binding is considered experimental.

## License

`LGPL-3.0-or-later`

See [COPYING](COPYING) and [COPYING.LESSER](COPYING.LESSER) for information.
