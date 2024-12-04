import os
import virt

fn main() {
	domain_name := os.args[1] or {
		eprintln('error: no domain name specified')
		eprintln('usage: ${os.file_name(@FILE)} <name>')
		exit(2)
	}
	connection := virt.Connect.open('qemu:///system') or {
		eprintln(err)
		exit(1)
	}
	defer {
		connection.close() or {}
	}
	domain := connection.lookup_domain_by_name(domain_name) or {
		eprintln(err)
		exit(1)
	}
	name := domain.get_name() or { '' }
	println(domain)
	println('Domain name: ${name}')
}
