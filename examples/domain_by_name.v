import os
import virt

fn main() {
	dname := os.args[1] or {
		eprintln('error: no domain name specified')
		eprintln('usage: ${os.file_name(@FILE)} <name>')
		exit(2)
	}
	connection := virt.Connect.open('qemu:///system')!
	defer {
		connection.close()
	}
	domain := connection.lookup_domain_by_name(dname) or {
		eprintln(err)
		exit(1)
	}
	name := domain.get_name() or { '' }
	println('Domain name: ${name}')
}
