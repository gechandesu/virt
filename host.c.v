module virt

#flag -I/usr/include/libvirt
#flag -lvirt
#include <libvirt.h>

// version returs library version.
// See also https://libvirt.org/html/libvirt-libvirt-host.html#virGetVersion
pub fn version() int {
	mut libver := 0
	unsafe {
		C.virGetVersion(&libver, nil, nil)
	}
	return *&libver
}

fn C.virGetVersion(&int, &char, &int) int
