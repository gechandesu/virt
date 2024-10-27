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

// WARN: This file is automatically written by generate.v
// do not edit it manually, any changes made here will be lost!

module virt

#flag -I/usr/include/libvirt
#flag -lvirt
#include <libvirt.h>

// Increment the reference count on the connection. For each
// additional call to this method, there shall be a corresponding
// call to virConnectClose to release the reference count, once
// the caller no longer needs the reference to this object.
//
// This method is typically useful for applications where multiple
// threads are using a connection, and it is required that the
// connection remain open until all threads have finished using
// it. ie, each new thread using a connection would increment
// the reference count.
pub fn (c Connect) ref() !int {
	result := C.virConnectRef(c.ptr)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virConnectRef(conn voidptr) int
