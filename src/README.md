## V language binding for libvirt native C API

The symbol names and module structure have been changed to better match
the V coding style. This library is very similar to the Go binding.

Symbol names are transformed by following rules:

* `vir${Name}` prefix is removed from function and type names.

* Case is changed from camelCase to snake\_case.

* Constant names are converted to lower case and the `VIR_` prefix is removed.

See examples in `examples` dir in the source code repository.
