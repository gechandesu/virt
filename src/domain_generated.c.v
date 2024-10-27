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

// Requests that the current background job be aborted at the
// soonest opportunity. In case the job is a migration in a post-copy mode,
// virDomainAbortJob will report an error (see virDomainMigrateStartPostCopy
// for more details).
pub fn (d Domain) abort_job() !int {
	result := C.virDomainAbortJob(d.ptr)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainAbortJob(domain voidptr) int

// Requests that the current background job be aborted at the
// soonest opportunity. In case the job is a migration in a post-copy mode,
// this function will report an error unless VIR_DOMAIN_ABORT_JOB_POSTCOPY
// flag is used (see virDomainMigrateStartPostCopy for more details).
pub fn (d Domain) abort_job_flags(flags u32) !int {
	result := C.virDomainAbortJobFlags(d.ptr, flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainAbortJobFlags(domain voidptr, flags u32) int

// Dynamically add an IOThread to the domain. It is left up to the
// underlying virtual hypervisor to determine the valid range for an
// @iothread_id and determining whether the @iothread_id already exists.
//
// Note that this call can fail if the underlying virtualization hypervisor
// does not support it or if growing the number is arbitrarily limited.
// This function requires privileged access to the hypervisor.
//
// @flags may include VIR_DOMAIN_AFFECT_LIVE or VIR_DOMAIN_AFFECT_CONFIG.
// Both flags may be set.
// If VIR_DOMAIN_AFFECT_LIVE is set, the change affects a running domain
// and may fail if domain is not alive.
// If VIR_DOMAIN_AFFECT_CONFIG is set, the change affects persistent state,
// and will fail for transient domains. If neither flag is specified (that is,
// @flags is VIR_DOMAIN_AFFECT_CURRENT), then an inactive domain modifies
// persistent setup, while an active domain is hypervisor-dependent on whether
// just live or both live and persistent state is changed.
pub fn (d Domain) add_io_thread(iothread_id u32, flags u32) !int {
	result := C.virDomainAddIOThread(d.ptr, iothread_id, flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainAddIOThread(domain voidptr, iothread_id u32, flags u32) int

// Set how long to wait for a response from guest agent commands. By default,
// agent commands block forever waiting for a response.
//
// @timeout must be a value from virDomainAgentResponseTimeoutValues or
// positive:
//
//   VIR_DOMAIN_AGENT_RESPONSE_TIMEOUT_BLOCK(-2): meaning to block forever
//      waiting for a result.
//   VIR_DOMAIN_AGENT_RESPONSE_TIMEOUT_DEFAULT(-1): use default timeout value.
//   VIR_DOMAIN_AGENT_RESPONSE_TIMEOUT_NOWAIT(0): does not wait.
//   positive value: wait for @timeout seconds
pub fn (d Domain) agent_set_response_timeout(timeout int, flags u32) !int {
	result := C.virDomainAgentSetResponseTimeout(d.ptr, timeout, flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainAgentSetResponseTimeout(domain voidptr, timeout int, flags u32) int

// Create a virtual device attachment to backend.  This function,
// having hotplug semantics, is only allowed on an active domain.
//
// For compatibility, this method can also be used to change the media
// in an existing CDROM/Floppy device, however, applications are
// recommended to use the virDomainUpdateDeviceFlags method instead.
//
// Be aware that hotplug changes might not persist across a domain going
// into S4 state (also known as hibernation) unless you also modify the
// persistent domain definition.
pub fn (d Domain) attach_device(xml string) !int {
	result := C.virDomainAttachDevice(d.ptr, &char(xml.str))
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainAttachDevice(domain voidptr, xml &char) int

// Attach a virtual device to a domain, using the flags parameter
// to control how the device is attached.  VIR_DOMAIN_AFFECT_CURRENT
// specifies that the device allocation is made based on current domain
// state.  VIR_DOMAIN_AFFECT_LIVE specifies that the device shall be
// allocated to the active domain instance only and is not added to the
// persisted domain configuration.  VIR_DOMAIN_AFFECT_CONFIG
// specifies that the device shall be allocated to the persisted domain
// configuration only.  Note that the target hypervisor must return an
// error if unable to satisfy flags.  E.g. the hypervisor driver will
// return failure if LIVE is specified but it only supports modifying the
// persisted device allocation.
//
// For compatibility, this method can also be used to change the media
// in an existing CDROM/Floppy device, however, applications are
// recommended to use the virDomainUpdateDeviceFlag method instead.
//
// Be aware that hotplug changes might not persist across a domain going
// into S4 state (also known as hibernation) unless you also modify the
// persistent domain definition.
pub fn (d Domain) attach_device_flags(xml string, flags u32) !int {
	result := C.virDomainAttachDeviceFlags(d.ptr, &char(xml.str), flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainAttachDeviceFlags(domain voidptr, xml &char, flags u32) int

// Launch a defined domain. If the call succeeds the domain moves from the
// defined to the running domains pools.  The domain will be paused only
// if restoring from managed state created from a paused domain.  For more
// control, see virDomainCreateWithFlags().
pub fn (d Domain) create() !int {
	result := C.virDomainCreate(d.ptr)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainCreate(domain voidptr) int

// Destroy the domain object. The running instance is shutdown if not down
// already and all resources used by it are given back to the hypervisor. This
// does not free the associated virDomainPtr object.
// This function may require privileged access.
//
// virDomainDestroy first requests that a guest terminate
// (e.g. SIGTERM), then waits for it to comply. After a reasonable
// timeout, if the guest still exists, virDomainDestroy will
// forcefully terminate the guest (e.g. SIGKILL) if necessary (which
// may produce undesirable results, for example unflushed disk cache
// in the guest). To avoid this possibility, it's recommended to
// instead call virDomainDestroyFlags, sending the
// VIR_DOMAIN_DESTROY_GRACEFUL flag.
//
// If the domain is transient and has any snapshot metadata (see
// virDomainSnapshotNum()), then that metadata will automatically
// be deleted when the domain quits.
pub fn (d Domain) destroy() !int {
	result := C.virDomainDestroy(d.ptr)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainDestroy(domain voidptr) int

// Destroy the domain object. The running instance is shutdown if not down
// already and all resources used by it are given back to the hypervisor.
// This does not free the associated virDomainPtr object.
// This function may require privileged access.
//
// Calling this function with no @flags set (equal to zero) is
// equivalent to calling virDomainDestroy, and after a reasonable
// timeout will forcefully terminate the guest (e.g. SIGKILL) if
// necessary (which may produce undesirable results, for example
// unflushed disk cache in the guest). Including
// VIR_DOMAIN_DESTROY_GRACEFUL in the flags will prevent the forceful
// termination of the guest, and virDomainDestroyFlags will instead
// return an error if the guest doesn't terminate by the end of the
// timeout; at that time, the management application can decide if
// calling again without VIR_DOMAIN_DESTROY_GRACEFUL is appropriate.
//
// If VIR_DOMAIN_DESTROY_REMOVE_LOGS flag is set then domain specific
// logs will be deleted as well if there are any. Note that not all
// deployments are be supported. For example in case of QEMU driver
// this flags is noop if virtlogd is not used for handling QEMU
// process output.
//
// Another alternative which may produce cleaner results for the
// guest's disks is to use virDomainShutdown() instead, but that
// depends on guest support (some hypervisor/guest combinations may
// ignore the shutdown request).
pub fn (d Domain) destroy_flags(flags u32) !int {
	result := C.virDomainDestroyFlags(d.ptr, flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainDestroyFlags(domain voidptr, flags u32) int

// Get the hostname for that domain. If no hostname is found,
// then an error is raised with VIR_ERR_NO_HOSTNAME code.
//
// Dependent on hypervisor and @flags used, this may require a
// guest agent to be available.
pub fn (d Domain) get_hostname(flags u32) !string {
	result := C.virDomainGetHostname(d.ptr, flags)
	if isnil(result) {
		return VirtError.new(last_error())
	}
	return unsafe { cstring_to_vstring(result) }
}

fn C.virDomainGetHostname(domain voidptr, flags u32) &char

// Get the hypervisor ID number for the domain
pub fn (d Domain) get_id() !u32 {
	result := C.virDomainGetID(d.ptr)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainGetID(domain voidptr) u32

// Get the public name for that domain
pub fn (d Domain) get_name() !string {
	result := C.virDomainGetName(d.ptr)
	if isnil(result) {
		return VirtError.new(last_error())
	}
	return unsafe { cstring_to_vstring(result) }
}

fn C.virDomainGetName(domain voidptr) &char

// Get the type of domain operation system.
pub fn (d Domain) get_os_type() !string {
	result := C.virDomainGetOSType(d.ptr)
	if isnil(result) {
		return VirtError.new(last_error())
	}
	return unsafe { cstring_to_vstring(result) }
}

fn C.virDomainGetOSType(domain voidptr) &char

// Reboot a domain, the domain object is still usable thereafter, but
// the domain OS is being stopped for a restart.
// Note that the guest OS may ignore the request.
// Additionally, the hypervisor may check and support the domain
// 'on_reboot' XML setting resulting in a domain that shuts down instead
// of rebooting.
//
// If @flags is set to zero, then the hypervisor will choose the
// method of shutdown it considers best. To have greater control
// pass one or more of the virDomainRebootFlagValues. The order
// in which the hypervisor tries each shutdown method is undefined,
// and a hypervisor is not required to support all methods.
//
// To use guest agent (VIR_DOMAIN_REBOOT_GUEST_AGENT) the domain XML
// must have <channel> configured.
//
// Due to implementation limitations in some drivers (the qemu driver,
// for instance) it is not advised to migrate or save a guest that is
// rebooting as a result of this API. Migrating such a guest can lead
// to a plain shutdown on the destination.
pub fn (d Domain) reboot(flags u32) !int {
	result := C.virDomainReboot(d.ptr, flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainReboot(domain voidptr, flags u32) int

// Increment the reference count on the domain. For each
// additional call to this method, there shall be a corresponding
// call to virDomainFree to release the reference count, once
// the caller no longer needs the reference to this object.
//
// This method is typically useful for applications where multiple
// threads are using a connection, and it is required that the
// connection remain open until all threads have finished using
// it. ie, each new thread using a domain would increment
// the reference count.
pub fn (d Domain) ref() !int {
	result := C.virDomainRef(d.ptr)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainRef(domain voidptr) int

// Rename a domain. New domain name is specified in the second
// argument. Depending on each driver implementation it may be
// required that domain is in a specific state.
//
// There might be some attributes and/or elements in domain XML that if no
// value provided at XML defining time, libvirt will derive their value from
// the domain name. These are not updated by this API. Users are strongly
// advised to change these after the rename was successful.
pub fn (d Domain) rename(new_name string, flags u32) !int {
	result := C.virDomainRename(d.ptr, &char(new_name.str), flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainRename(dom voidptr, new_name &char, flags u32) int

// Reset a domain immediately without any guest OS shutdown.
// Reset emulates the power reset button on a machine, where all
// hardware sees the RST line set and reinitializes internal state.
//
// Note that there is a risk of data loss caused by reset without any
// guest OS shutdown.
pub fn (d Domain) reset(flags u32) !int {
	result := C.virDomainReset(d.ptr, flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainReset(domain voidptr, flags u32) int

// Resume a suspended domain, the process is restarted from the state where
// it was frozen by calling virDomainSuspend().
// This function may require privileged access
// Moreover, resume may not be supported if domain is in some
// special state like VIR_DOMAIN_PMSUSPENDED.
pub fn (d Domain) resume() !int {
	result := C.virDomainResume(d.ptr)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainResume(domain voidptr) int

// This method will suspend a domain and save its memory contents to a file or
// direcotry (based on the vmm) on disk. After the call, if successful,the domain
// is not listed as running anymore (this ends the life of a transient domain).
// Use virDomainRestore() to restore a domain after saving.
//
// See virDomainSaveFlags() and virDomainSaveParams() for more control.
// Also, a save file can be inspected or modified slightly with
// virDomainSaveImageGetXMLDesc() and virDomainSaveImageDefineXML().
pub fn (d Domain) save(to string) !int {
	result := C.virDomainSave(d.ptr, &char(to.str))
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainSave(domain voidptr, to &char) int

// This method will suspend a domain and save its memory contents to
// a file on disk. After the call, if successful, the domain is not
// listed as running anymore (this ends the life of a transient domain).
// Use virDomainRestore() to restore a domain after saving.
//
// If the hypervisor supports it, @dxml can be used to alter
// host-specific portions of the domain XML that will be used when
// restoring an image.  For example, it is possible to alter the
// backing filename that is associated with a disk device, in order to
// prepare for file renaming done as part of backing up the disk
// device while the domain is stopped.
//
// If @flags includes VIR_DOMAIN_SAVE_BYPASS_CACHE, then libvirt will
// attempt to bypass the file system cache while creating the file, or
// fail if it cannot do so for the given system; this can allow less
// pressure on file system cache, but also risks slowing saves to NFS.
//
// Normally, the saved state file will remember whether the domain was
// running or paused, and restore defaults to the same state.
// Specifying VIR_DOMAIN_SAVE_RUNNING or VIR_DOMAIN_SAVE_PAUSED in
// @flags will override what state gets saved into the file.  These
// two flags are mutually exclusive.
//
// A save file can be inspected or modified slightly with
// virDomainSaveImageGetXMLDesc() and virDomainSaveImageDefineXML().
//
// Some hypervisors may prevent this operation if there is a current
// block job running; in that case, use virDomainBlockJobAbort()
// to stop the block job first.
pub fn (d Domain) save_flags(to string, dxml string, flags u32) !int {
	result := C.virDomainSaveFlags(d.ptr, &char(to.str), &char(dxml.str), flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainSaveFlags(domain voidptr, to &char, dxml &char, flags u32) int

// This updates the definition of a domain stored in a saved state
// file.  @file must be a file created previously by virDomainSave()
// or virDomainSaveFlags().
//
// @dxml can be used to alter host-specific portions of the domain XML
// that will be used when restoring an image.  For example, it is
// possible to alter the backing filename that is associated with a
// disk device, to match renaming done as part of backing up the disk
// device while the domain is stopped.
//
// Normally, the saved state file will remember whether the domain was
// running or paused, and restore defaults to the same state.
// Specifying VIR_DOMAIN_SAVE_RUNNING or VIR_DOMAIN_SAVE_PAUSED in
// @flags will override the default saved into the file; omitting both
// leaves the file's default unchanged.  These two flags are mutually
// exclusive.
pub fn (d Domain) save_image_define_xml(file string, dxml string, flags u32) !int {
	result := C.virDomainSaveImageDefineXML(d.ptr, &char(file.str), &char(dxml.str), flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainSaveImageDefineXML(conn voidptr, file &char, dxml &char, flags u32) int

// This method will extract the XML describing the domain at the time
// a saved state file was created.  @file must be a file created
// previously by virDomainSave() or virDomainSaveFlags().
//
// No security-sensitive data will be included unless @flags contains
// VIR_DOMAIN_SAVE_IMAGE_XML_SECURE.
pub fn (d Domain) save_image_get_xmld_esc(file string, flags u32) !string {
	result := C.virDomainSaveImageGetXMLDesc(d.ptr, &char(file.str), flags)
	if isnil(result) {
		return VirtError.new(last_error())
	}
	return unsafe { cstring_to_vstring(result) }
}

fn C.virDomainSaveImageGetXMLDesc(conn voidptr, file &char, flags u32) &char

// Configure the domain to be automatically started
// when the host machine boots.
pub fn (d Domain) set_autostart(autostart int) !int {
	result := C.virDomainSetAutostart(d.ptr, autostart)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainSetAutostart(domain voidptr, autostart int) int

// Enables/disables individual vcpus described by @vcpumap in the hypervisor.
//
// Various hypervisor implementations may limit to operate on just 1
// hotpluggable entity (which may contain multiple vCPUs on certain platforms).
//
// Note that OSes and hypervisors may require vCPU 0 to stay online.
pub fn (d Domain) set_vcpu(vcpumap string, state int, flags u32) !int {
	result := C.virDomainSetVcpu(d.ptr, &char(vcpumap.str), state, flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainSetVcpu(domain voidptr, vcpumap &char, state int, flags u32) int

// Dynamically change the number of virtual CPUs used by the domain.
// Note that this call may fail if the underlying virtualization hypervisor
// does not support it or if growing the number is arbitrarily limited.
// This function may require privileged access to the hypervisor.
//
// Note that if this call is executed before the guest has finished booting,
// the guest may fail to process the change.
//
// This command only changes the runtime configuration of the domain,
// so can only be called on an active domain.  It is hypervisor-dependent
// whether it also affects persistent configuration; for more control,
// use virDomainSetVcpusFlags().
pub fn (d Domain) set_vcpus(nvcpus u32) !int {
	result := C.virDomainSetVcpus(d.ptr, nvcpus)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainSetVcpus(domain voidptr, nvcpus u32) int

// Dynamically change the number of virtual CPUs used by the domain.
// Note that this call may fail if the underlying virtualization hypervisor
// does not support it or if growing the number is arbitrarily limited.
// This function may require privileged access to the hypervisor.
//
// @flags may include VIR_DOMAIN_AFFECT_LIVE to affect a running
// domain (which may fail if domain is not active), or
// VIR_DOMAIN_AFFECT_CONFIG to affect the next boot via the XML
// description of the domain.  Both flags may be set.
// If neither flag is specified (that is, @flags is VIR_DOMAIN_AFFECT_CURRENT),
// then an inactive domain modifies persistent setup, while an active domain
// is hypervisor-dependent on whether just live or both live and persistent
// state is changed.
//
// Note that if this call is executed before the guest has finished booting,
// the guest may fail to process the change.
//
// If @flags includes VIR_DOMAIN_VCPU_MAXIMUM, then
// VIR_DOMAIN_AFFECT_LIVE must be clear, and only the maximum virtual
// CPU limit is altered; generally, this value must be less than or
// equal to virConnectGetMaxVcpus().  Otherwise, this call affects the
// current virtual CPU limit, which must be less than or equal to the
// maximum limit. Note that hypervisors may not allow changing the maximum
// vcpu count if processor topology is specified.
//
// If @flags includes VIR_DOMAIN_VCPU_GUEST, then the state of processors is
// modified inside the guest instead of the hypervisor. This flag can only
// be used with live guests and is incompatible with VIR_DOMAIN_VCPU_MAXIMUM.
// The usage of this flag may require a guest agent configured.
//
// Not all hypervisors can support all flag combinations.
pub fn (d Domain) set_vcpus_flags(nvcpus u32, flags u32) !int {
	result := C.virDomainSetVcpusFlags(d.ptr, nvcpus, flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainSetVcpusFlags(domain voidptr, nvcpus u32, flags u32) int

// Shutdown a domain, the domain object is still usable thereafter, but
// the domain OS is being stopped. Note that the guest OS may ignore the
// request. Additionally, the hypervisor may check and support the domain
// 'on_poweroff' XML setting resulting in a domain that reboots instead of
// shutting down. For guests that react to a shutdown request, the differences
// from virDomainDestroy() are that the guests disk storage will be in a
// stable state rather than having the (virtual) power cord pulled, and
// this command returns as soon as the shutdown request is issued rather
// than blocking until the guest is no longer running.
//
// If the domain is transient and has any snapshot metadata (see
// virDomainSnapshotNum()), then that metadata will automatically
// be deleted when the domain quits.
pub fn (d Domain) shutdown() !int {
	result := C.virDomainShutdown(d.ptr)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainShutdown(domain voidptr) int

// Shutdown a domain, the domain object is still usable thereafter but
// the domain OS is being stopped. Note that the guest OS may ignore the
// request. Additionally, the hypervisor may check and support the domain
// 'on_poweroff' XML setting resulting in a domain that reboots instead of
// shutting down. For guests that react to a shutdown request, the differences
// from virDomainDestroy() are that the guest's disk storage will be in a
// stable state rather than having the (virtual) power cord pulled, and
// this command returns as soon as the shutdown request is issued rather
// than blocking until the guest is no longer running.
//
// If the domain is transient and has any snapshot metadata (see
// virDomainSnapshotNum()), then that metadata will automatically
// be deleted when the domain quits.
//
// If @flags is set to zero, then the hypervisor will choose the
// method of shutdown it considers best. To have greater control
// pass one or more of the virDomainShutdownFlagValues. The order
// in which the hypervisor tries each shutdown method is undefined,
// and a hypervisor is not required to support all methods.
//
// To use guest agent (VIR_DOMAIN_SHUTDOWN_GUEST_AGENT) the domain XML
// must have <channel> configured.
pub fn (d Domain) shutdown_flags(flags u32) !int {
	result := C.virDomainShutdownFlags(d.ptr, flags)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainShutdownFlags(domain voidptr, flags u32) int

// Suspends an active domain, the process is frozen without further access
// to CPU resources and I/O but the memory used by the domain at the
// hypervisor level will stay allocated. Use virDomainResume() to reactivate
// the domain.
// This function may require privileged access.
// Moreover, suspend may not be supported if domain is in some
// special state like VIR_DOMAIN_PMSUSPENDED.
pub fn (d Domain) suspend() !int {
	result := C.virDomainSuspend(d.ptr)
	if result == -1 {
		return VirtError.new(last_error())
	}
	return result
}

fn C.virDomainSuspend(domain voidptr) int
