// This file is part of virt.
//
// virt is free software: you can redistribute it and/or modify it under
// the terms of the GNU Lesser General Public License as published by the
// Free Software Foundation, either version 3 of the License, or (at your
// option) any later version.
//
// virt is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
// License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with virt. If not, see <https://www.gnu.org/licenses/>.

module virt

#flag -I/usr/include/libvirt
#flag -lvirt
#include <libvirt.h>

struct Connect {
	ptr voidptr
}

struct Domain {
	ptr voidptr
}

struct DomainCheckpoint {
	ptr voidptr
}

struct DomainSnapshot {
	ptr voidptr
}

struct Event {
	ptr voidptr
}

struct Node {
	ptr voidptr
}

struct Interface {
	ptr voidptr
}

struct Network {
	ptr voidptr
}

struct NodeDevice {
	ptr voidptr
}

struct NWFilter {
	ptr voidptr
}

struct Secret {
	ptr voidptr
}

struct StoragePool {
	ptr voidptr
}

struct StorageVol {
	ptr voidptr
}

struct Stream {
	ptr voidptr
}

// version returs livbirt version as integer.
pub fn version() int {
	mut libver := 0
	unsafe {
		C.virGetVersion(&libver, nil, nil)
	}
	return *&libver
}

fn C.virGetVersion(&int, &char, &int) int
