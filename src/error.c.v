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
#include <virterror.h>

fn C.virCopyLastError(voidptr) int

fn C.virResetError(voidptr)

@[typedef]
struct C.virError {
	code    int
	domain  int
	message &char = &char(''.str)
	level   voidptr
	conn    voidptr
	dom     voidptr
	str1    &char = &char(''.str)
	str2    &char = &char(''.str)
	str3    &char = &char(''.str)
	int1    int
	int2    int
	net     voidptr
}

pub struct VirtError implements IError {
pub:
	msg    string
	code   int
	domain int
	level  int
}

pub fn (e VirtError) str() string {
	return e.msg
}

pub fn (e VirtError) msg() string {
	return e.msg
}

pub fn (e VirtError) code() int {
	return e.code
}

fn VirtError.new(virerr C.virError) IError {
	e := VirtError{
		msg:    unsafe { cstring_to_vstring(virerr.message) }
		code:   virerr.code
		domain: virerr.domain
		level:  virerr.level
	}
	C.virResetError(&virerr)
	return &e
}

fn last_error() &C.virError {
	virerr := &C.virError{}
	C.virCopyLastError(virerr)
	return virerr
}

fn C.virSetErrorFunc(voidptr, ErrorHandlerFn)

type ErrorHandlerFn = fn (voidptr, &C.virError)

fn dummy_error_handler(userdata voidptr, virerror &C.virError) {}

fn set_dummy_global_error_handler() {
	unsafe {
		C.virSetErrorFunc(nil, dummy_error_handler)
	}
}
