import virt

fn main() {
	// Note: for call this method libvirtd connection is not required.
	println('libvirt version is ${virt.version()}')
}
