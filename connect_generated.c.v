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

// ! WARNING !
// This file is automatically written by generate.vsh
// do not edit it manually, any changes made here will be lost!

module virt

#flag -I/usr/include/libvirt
#flag -lvirt
#include <libvirt.h>

// See also https://libvirt.org/html/libvirt-libvirt-host.html#virConnectClose
pub fn (c Connect) close() !int {
	result := C.virConnectClose(c.ptr)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virConnectClose(conn voidptr) int

// See also https://libvirt.org/html/libvirt-libvirt-host.html#virConnectRef
pub fn (c Connect) ref() !int {
	result := C.virConnectRef(c.ptr)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virConnectRef(conn voidptr) int
