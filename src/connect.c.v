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

// See also https://libvirt.org/html/libvirt-libvirt-host.html#virConnectOpen
pub fn Connect.open(uri string) !Connect {
	ptr := C.virConnectOpen(&char(uri.str))
	if isnil(ptr) {
		return VirtError.new(last_error())
	}
	return Connect{ptr}
}

fn C.virConnectOpen(&char) voidptr

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainLookupByName
pub fn (c Connect) lookup_domain_by_name(name string) !Domain {
	ptr := C.virDomainLookupByName(c.ptr, &char(name.str))
	if isnil(ptr) {
		return VirtError.new(last_error())
	}
	return Domain{ptr}
}

fn C.virDomainLookupByName(voidptr, &char) voidptr
