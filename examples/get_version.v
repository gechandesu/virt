import virt

fn main() {
	// Note: libvirtd connection is not required for this method.
	println('libvirt version is ${virt.version()}')
}
