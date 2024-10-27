## V language binding for libvirt native C API

The symbol names and module structure have been changed to better match
the V coding style. This library will be very similar to the Go binding.

Symbol names are transformed by following rules:

* `vir{Name}` prefix is removed from function and type names.

* Case is changed from camelCase to snake\_case.

* Constant names are converted to lower case and the `VIR_` prefix is removed.

Basic example:

```v
import os
import virt

fn main() {
	println('Libvirt version: ${virt.version()}')
	connection := virt.Connect.open('qemu:///system')!
	defer {
		connection.close()
	}
	domain := connection.lookup_domain_by_name(os.args[1]) or {
		eprintln(err)
		exit(1)
	}
	name := domain.get_name() or { '' }
	println('Domain name: ${name}')
}
```
