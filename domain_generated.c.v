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

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainAbortJob
pub fn (d Domain) abort_job() !int {
	result := C.virDomainAbortJob(d.ptr)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainAbortJob(domain voidptr) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainAbortJobFlags
pub fn (d Domain) abort_job_flags(flags u32) !int {
	result := C.virDomainAbortJobFlags(d.ptr, flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainAbortJobFlags(domain voidptr, flags u32) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainAddIOThread
pub fn (d Domain) add_io_thread(iothread_id u32, flags u32) !int {
	result := C.virDomainAddIOThread(d.ptr, iothread_id, flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainAddIOThread(domain voidptr, iothread_id u32, flags u32) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainAgentSetResponseTimeout
pub fn (d Domain) agent_set_response_timeout(timeout int, flags u32) !int {
	result := C.virDomainAgentSetResponseTimeout(d.ptr, timeout, flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainAgentSetResponseTimeout(domain voidptr, timeout int, flags u32) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainAttachDevice
pub fn (d Domain) attach_device(xml string) !int {
	result := C.virDomainAttachDevice(d.ptr, &char(xml.str))
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainAttachDevice(domain voidptr, xml &char) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainAttachDeviceFlags
pub fn (d Domain) attach_device_flags(xml string, flags u32) !int {
	result := C.virDomainAttachDeviceFlags(d.ptr, &char(xml.str), flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainAttachDeviceFlags(domain voidptr, xml &char, flags u32) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainCreate
pub fn (d Domain) create() !int {
	result := C.virDomainCreate(d.ptr)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainCreate(domain voidptr) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainDelThrottleGroup
pub fn (d Domain) del_throttle_group(group string, flags u32) !int {
	result := C.virDomainDelThrottleGroup(d.ptr, &char(group.str), flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainDelThrottleGroup(dom voidptr, group &char, flags u32) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainDestroy
pub fn (d Domain) destroy() !int {
	result := C.virDomainDestroy(d.ptr)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainDestroy(domain voidptr) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainDestroyFlags
pub fn (d Domain) destroy_flags(flags u32) !int {
	result := C.virDomainDestroyFlags(d.ptr, flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainDestroyFlags(domain voidptr, flags u32) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainGetHostname
pub fn (d Domain) get_hostname(flags u32) !string {
	result := C.virDomainGetHostname(d.ptr, flags)
	if isnil(result) {
		return VirtError.new(last_error())
	}
	return unsafe { cstring_to_vstring(result) }
}

fn C.virDomainGetHostname(domain voidptr, flags u32) &char

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainGetID
pub fn (d Domain) get_id() !u32 {
	result := C.virDomainGetID(d.ptr)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainGetID(domain voidptr) u32

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainGetName
pub fn (d Domain) get_name() !string {
	result := C.virDomainGetName(d.ptr)
	if isnil(result) {
		return VirtError.new(last_error())
	}
	return unsafe { cstring_to_vstring(result) }
}

fn C.virDomainGetName(domain voidptr) &char

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainGetOSType
pub fn (d Domain) get_os_type() !string {
	result := C.virDomainGetOSType(d.ptr)
	if isnil(result) {
		return VirtError.new(last_error())
	}
	return unsafe { cstring_to_vstring(result) }
}

fn C.virDomainGetOSType(domain voidptr) &char

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainReboot
pub fn (d Domain) reboot(flags u32) !int {
	result := C.virDomainReboot(d.ptr, flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainReboot(domain voidptr, flags u32) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainRef
pub fn (d Domain) ref() !int {
	result := C.virDomainRef(d.ptr)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainRef(domain voidptr) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainRename
pub fn (d Domain) rename(new_name string, flags u32) !int {
	result := C.virDomainRename(d.ptr, &char(new_name.str), flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainRename(dom voidptr, new_name &char, flags u32) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainReset
pub fn (d Domain) reset(flags u32) !int {
	result := C.virDomainReset(d.ptr, flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainReset(domain voidptr, flags u32) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainResume
pub fn (d Domain) resume() !int {
	result := C.virDomainResume(d.ptr)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainResume(domain voidptr) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainSave
pub fn (d Domain) save(to string) !int {
	result := C.virDomainSave(d.ptr, &char(to.str))
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainSave(domain voidptr, to &char) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainSaveFlags
pub fn (d Domain) save_flags(to string, dxml string, flags u32) !int {
	result := C.virDomainSaveFlags(d.ptr, &char(to.str), &char(dxml.str), flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainSaveFlags(domain voidptr, to &char, dxml &char, flags u32) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainSetAutostart
pub fn (d Domain) set_autostart(autostart int) !int {
	result := C.virDomainSetAutostart(d.ptr, autostart)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainSetAutostart(domain voidptr, autostart int) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainSetThrottleGroup
pub fn (d Domain) set_throttle_group(group string, params voidptr, nparams int, flags u32) !int {
	result := C.virDomainSetThrottleGroup(d.ptr, &char(group.str), params, nparams, flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainSetThrottleGroup(dom voidptr, group &char, params voidptr, nparams int, flags u32) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainSetVcpu
pub fn (d Domain) set_vcpu(vcpumap string, state int, flags u32) !int {
	result := C.virDomainSetVcpu(d.ptr, &char(vcpumap.str), state, flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainSetVcpu(domain voidptr, vcpumap &char, state int, flags u32) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainSetVcpus
pub fn (d Domain) set_vcpus(nvcpus u32) !int {
	result := C.virDomainSetVcpus(d.ptr, nvcpus)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainSetVcpus(domain voidptr, nvcpus u32) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainSetVcpusFlags
pub fn (d Domain) set_vcpus_flags(nvcpus u32, flags u32) !int {
	result := C.virDomainSetVcpusFlags(d.ptr, nvcpus, flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainSetVcpusFlags(domain voidptr, nvcpus u32, flags u32) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainShutdown
pub fn (d Domain) shutdown() !int {
	result := C.virDomainShutdown(d.ptr)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainShutdown(domain voidptr) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainShutdownFlags
pub fn (d Domain) shutdown_flags(flags u32) !int {
	result := C.virDomainShutdownFlags(d.ptr, flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainShutdownFlags(domain voidptr, flags u32) int

// See also https://libvirt.org/html/libvirt-libvirt-domain.html#virDomainSuspend
pub fn (d Domain) suspend() !int {
	result := C.virDomainSuspend(d.ptr)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainSuspend(domain voidptr) int
