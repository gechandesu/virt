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
#include <virterror.h>

// failed to start interface driver
pub const war_no_interface = C.VIR_WAR_NO_INTERFACE

// failed to start network
pub const war_no_network = C.VIR_WAR_NO_NETWORK

// failed to start node driver
pub const war_no_node = C.VIR_WAR_NO_NODE

// failed to start nwfilter driver
pub const war_no_nwfilter = C.VIR_WAR_NO_NWFILTER

// failed to start secret storage
pub const war_no_secret = C.VIR_WAR_NO_SECRET

// failed to start storage
pub const war_no_storage = C.VIR_WAR_NO_STORAGE

// operation on the object/resource
// was denied
pub const err_access_denied = C.VIR_ERR_ACCESS_DENIED

// guest agent is unresponsive,
// not running or not usable
pub const err_agent_unresponsive = C.VIR_ERR_AGENT_UNRESPONSIVE

// guest agent replies with wrong id
// to guest-sync command (DEPRECATED)
pub const err_agent_unsynced = C.VIR_ERR_AGENT_UNSYNCED

// valid API use but unsupported by
// the given driver
pub const err_argument_unsupported = C.VIR_ERR_ARGUMENT_UNSUPPORTED

// authentication cancelled
pub const err_auth_cancelled = C.VIR_ERR_AUTH_CANCELLED

// authentication failed
pub const err_auth_failed = C.VIR_ERR_AUTH_FAILED

// authentication unavailable
pub const err_auth_unavailable = C.VIR_ERR_AUTH_UNAVAILABLE

// action prevented by block copy job
pub const err_block_copy_active = C.VIR_ERR_BLOCK_COPY_ACTIVE

// nw filter pool not found
pub const err_build_firewall = C.VIR_ERR_BUILD_FIREWALL

// not supported by the drivers
// (DEPRECATED)
pub const err_call_failed = C.VIR_ERR_CALL_FAILED

// checkpoint can&apos;t be used
pub const err_checkpoint_inconsistent = C.VIR_ERR_CHECKPOINT_INCONSISTENT

// failed to parse the syntax of a
// conf file
pub const err_conf_syntax = C.VIR_ERR_CONF_SYNTAX

// unsupported configuration
// construct
pub const err_config_unsupported = C.VIR_ERR_CONFIG_UNSUPPORTED

// given CPU is incompatible with host CPU
pub const err_cpu_incompatible = C.VIR_ERR_CPU_INCOMPATIBLE

// error from a dbus service
pub const err_dbus_service = C.VIR_ERR_DBUS_SERVICE

// fail to find the desired device
pub const err_device_missing = C.VIR_ERR_DEVICE_MISSING

// the domain already exist
pub const err_dom_exist = C.VIR_ERR_DOM_EXIST

// too many drivers registered
pub const err_driver_full = C.VIR_ERR_DRIVER_FULL

// An error
pub const err_error = C.VIR_ERR_ERROR

// a HTTP GET command to failed
pub const err_get_failed = C.VIR_ERR_GET_FAILED

// error from a GNUTLS call
pub const err_gnutls_error = C.VIR_ERR_GNUTLS_ERROR

// a synchronous hook script failed
pub const err_hook_script_failed = C.VIR_ERR_HOOK_SCRIPT_FAILED

// unexpected HTTP error code
pub const err_http_error = C.VIR_ERR_HTTP_ERROR

// internal error
pub const err_internal_error = C.VIR_ERR_INTERNAL_ERROR

// invalid function argument
pub const err_invalid_arg = C.VIR_ERR_INVALID_ARG

// invalid connection object
pub const err_invalid_conn = C.VIR_ERR_INVALID_CONN

// invalid domain object
pub const err_invalid_domain = C.VIR_ERR_INVALID_DOMAIN

// invalid domain checkpoint
pub const err_invalid_domain_checkpoint = C.VIR_ERR_INVALID_DOMAIN_CHECKPOINT

// invalid domain snapshot
pub const err_invalid_domain_snapshot = C.VIR_ERR_INVALID_DOMAIN_SNAPSHOT

// invalid interface object
pub const err_invalid_interface = C.VIR_ERR_INVALID_INTERFACE

// invalid MAC address
pub const err_invalid_mac = C.VIR_ERR_INVALID_MAC

// invalid network object
pub const err_invalid_network = C.VIR_ERR_INVALID_NETWORK

// invalid network port object
pub const err_invalid_network_port = C.VIR_ERR_INVALID_NETWORK_PORT

// invalid node device object
pub const err_invalid_node_device = C.VIR_ERR_INVALID_NODE_DEVICE

// invalid nwfilter object
pub const err_invalid_nwfilter = C.VIR_ERR_INVALID_NWFILTER

// invalid nwfilter binding
pub const err_invalid_nwfilter_binding = C.VIR_ERR_INVALID_NWFILTER_BINDING

// invalid secret
pub const err_invalid_secret = C.VIR_ERR_INVALID_SECRET

// invalid storage pool object
pub const err_invalid_storage_pool = C.VIR_ERR_INVALID_STORAGE_POOL

// invalid storage vol object
pub const err_invalid_storage_vol = C.VIR_ERR_INVALID_STORAGE_VOL

// stream pointer not valid
pub const err_invalid_stream = C.VIR_ERR_INVALID_STREAM

// error in libssh transport driver
pub const err_libssh = C.VIR_ERR_LIBSSH

// Finish API succeeded but it is expected to return NULL
pub const err_migrate_finish_ok = C.VIR_ERR_MIGRATE_FINISH_OK

// a migration worked, but making the
// VM persist on the dest host failed
pub const err_migrate_persist_failed = C.VIR_ERR_MIGRATE_PERSIST_FAILED

// Migration is not safe
pub const err_migrate_unsafe = C.VIR_ERR_MIGRATE_UNSAFE

// more than one matching domain found
pub const err_multiple_domains = C.VIR_ERR_MULTIPLE_DOMAINS

// more than one matching interface
// found
pub const err_multiple_interfaces = C.VIR_ERR_MULTIPLE_INTERFACES

// the network already exist
pub const err_network_exist = C.VIR_ERR_NETWORK_EXIST

// the network port already exist
pub const err_network_port_exist = C.VIR_ERR_NETWORK_PORT_EXIST

// Client was not found
pub const err_no_client = C.VIR_ERR_NO_CLIENT

// can&apos;t connect to hypervisor
pub const err_no_connect = C.VIR_ERR_NO_CONNECT

// missing domain devices information
pub const err_no_device = C.VIR_ERR_NO_DEVICE

// domain not found or unexpectedly
// disappeared
pub const err_no_domain = C.VIR_ERR_NO_DOMAIN

// domain backup job id not found
pub const err_no_domain_backup = C.VIR_ERR_NO_DOMAIN_BACKUP

// domain checkpoint not found
pub const err_no_domain_checkpoint = C.VIR_ERR_NO_DOMAIN_CHECKPOINT

// The metadata is not present
pub const err_no_domain_metadata = C.VIR_ERR_NO_DOMAIN_METADATA

// domain snapshot not found
pub const err_no_domain_snapshot = C.VIR_ERR_NO_DOMAIN_SNAPSHOT

// no domain&apos;s hostname found
pub const err_no_hostname = C.VIR_ERR_NO_HOSTNAME

// interface driver not running
pub const err_no_interface = C.VIR_ERR_NO_INTERFACE

// missing kernel information
pub const err_no_kernel = C.VIR_ERR_NO_KERNEL

// memory allocation failure
pub const err_no_memory = C.VIR_ERR_NO_MEMORY

// missing domain name information
pub const err_no_name = C.VIR_ERR_NO_NAME

// network not found
pub const err_no_network = C.VIR_ERR_NO_NETWORK

// Network metadata is not present
pub const err_no_network_metadata = C.VIR_ERR_NO_NETWORK_METADATA

// network port not found
pub const err_no_network_port = C.VIR_ERR_NO_NETWORK_PORT

// node device not found
pub const err_no_node_device = C.VIR_ERR_NO_NODE_DEVICE

// nw filter pool not found
pub const err_no_nwfilter = C.VIR_ERR_NO_NWFILTER

// no nwfilter binding
pub const err_no_nwfilter_binding = C.VIR_ERR_NO_NWFILTER_BINDING

// missing domain OS information
pub const err_no_os = C.VIR_ERR_NO_OS

// missing root device information
pub const err_no_root = C.VIR_ERR_NO_ROOT

// secret not found
pub const err_no_secret = C.VIR_ERR_NO_SECRET

// security model not found
pub const err_no_security_model = C.VIR_ERR_NO_SECURITY_MODEL

// Server was not found
pub const err_no_server = C.VIR_ERR_NO_SERVER

// missing source device information
pub const err_no_source = C.VIR_ERR_NO_SOURCE

// storage pool not found
pub const err_no_storage_pool = C.VIR_ERR_NO_STORAGE_POOL

// storage volume not found
pub const err_no_storage_vol = C.VIR_ERR_NO_STORAGE_VOL

// no support for this function
pub const err_no_support = C.VIR_ERR_NO_SUPPORT

// missing target device information
pub const err_no_target = C.VIR_ERR_NO_TARGET

// could not open Xen hypervisor
// control
pub const err_no_xen = C.VIR_ERR_NO_XEN

// could not open Xen Store control
pub const err_no_xenstore = C.VIR_ERR_NO_XENSTORE

pub const err_none = C.VIR_ERR_NONE

pub const err_ok = C.VIR_ERR_OK

// failed to open a conf file
pub const err_open_failed = C.VIR_ERR_OPEN_FAILED

// operation on a domain was
// canceled/aborted by user
pub const err_operation_aborted = C.VIR_ERR_OPERATION_ABORTED

// operation forbidden on read-only
// connections
pub const err_operation_denied = C.VIR_ERR_OPERATION_DENIED

// a command to hypervisor failed
pub const err_operation_failed = C.VIR_ERR_OPERATION_FAILED

// operation is not applicable at this
// time
pub const err_operation_invalid = C.VIR_ERR_OPERATION_INVALID

// timeout occurred during operation
pub const err_operation_timeout = C.VIR_ERR_OPERATION_TIMEOUT

// The requested operation is not
// supported
pub const err_operation_unsupported = C.VIR_ERR_OPERATION_UNSUPPORTED

// unknown OS type
pub const err_os_type = C.VIR_ERR_OS_TYPE

// integer overflow
pub const err_overflow = C.VIR_ERR_OVERFLOW

// failed to parse a conf file
pub const err_parse_failed = C.VIR_ERR_PARSE_FAILED

// a HTTP POST command to failed
pub const err_post_failed = C.VIR_ERR_POST_FAILED

// failed to read a conf file
pub const err_read_failed = C.VIR_ERR_READ_FAILED

// resource is already in use
pub const err_resource_busy = C.VIR_ERR_RESOURCE_BUSY

// some sort of RPC error
pub const err_rpc = C.VIR_ERR_RPC

// failure to serialize an S-Expr
pub const err_sexpr_serial = C.VIR_ERR_SEXPR_SERIAL

// force was not requested for a
// risky domain snapshot revert
pub const err_snapshot_revert_risky = C.VIR_ERR_SNAPSHOT_REVERT_RISKY

// error in ssh transport driver
pub const err_ssh = C.VIR_ERR_SSH

// storage pool already built
pub const err_storage_pool_built = C.VIR_ERR_STORAGE_POOL_BUILT

// storage pool probe failed
pub const err_storage_probe_failed = C.VIR_ERR_STORAGE_PROBE_FAILED

// the storage vol already exists
pub const err_storage_vol_exist = C.VIR_ERR_STORAGE_VOL_EXIST

// general system call failure
pub const err_system_error = C.VIR_ERR_SYSTEM_ERROR

// could not resolve hostname
pub const err_unknown_host = C.VIR_ERR_UNKNOWN_HOST

// A simple warning
pub const err_warning = C.VIR_ERR_WARNING

// failed to write a conf file
pub const err_write_failed = C.VIR_ERR_WRITE_FAILED

// failure doing an hypervisor call
pub const err_xen_call = C.VIR_ERR_XEN_CALL

// detail of an XML error
pub const err_xml_detail = C.VIR_ERR_XML_DETAIL

// an XML description is not well
// formed or broken
pub const err_xml_error = C.VIR_ERR_XML_ERROR

// XML document doesn&apos;t validate against schema
pub const err_xml_invalid_schema = C.VIR_ERR_XML_INVALID_SCHEMA

// Error from access control manager
pub const from_access = C.VIR_FROM_ACCESS

// Error from admin backend
pub const from_admin = C.VIR_FROM_ADMIN

// Error from auditing subsystem
pub const from_audit = C.VIR_FROM_AUDIT

// Error from auth handling
pub const from_auth = C.VIR_FROM_AUTH

// Error from bhyve driver
pub const from_bhyve = C.VIR_FROM_BHYVE

// Error from BPF code
pub const from_bpf = C.VIR_FROM_BPF

// Error from capabilities
pub const from_capabilities = C.VIR_FROM_CAPABILITIES

// Error from cgroups
pub const from_cgroup = C.VIR_FROM_CGROUP

// Error from Cloud-Hypervisor driver
pub const from_ch = C.VIR_FROM_CH

// Error in the configuration file handling
pub const from_conf = C.VIR_FROM_CONF

// Error from CPU driver
pub const from_cpu = C.VIR_FROM_CPU

// Error from crypto code
pub const from_crypto = C.VIR_FROM_CRYPTO

// Error from DBus
pub const from_dbus = C.VIR_FROM_DBUS

// Error from Device
pub const from_device = C.VIR_FROM_DEVICE

// Error when operating on a domain
pub const from_dom = C.VIR_FROM_DOM

// Error from domain config
pub const from_domain = C.VIR_FROM_DOMAIN

// Error from domain checkpoint
pub const from_domain_checkpoint = C.VIR_FROM_DOMAIN_CHECKPOINT

// Error from domain snapshot
pub const from_domain_snapshot = C.VIR_FROM_DOMAIN_SNAPSHOT

// Error from ESX driver
pub const from_esx = C.VIR_FROM_ESX

// Error from event loop impl
pub const from_event = C.VIR_FROM_EVENT

// Error from firewall
pub const from_firewall = C.VIR_FROM_FIREWALL

// Error from firewalld
pub const from_firewalld = C.VIR_FROM_FIREWALLD

// Error from Synchronous hooks
pub const from_hook = C.VIR_FROM_HOOK

// Error from Hyper-V driver
pub const from_hyperv = C.VIR_FROM_HYPERV

// Error from identity code
pub const from_identity = C.VIR_FROM_IDENTITY

// Error from initctl device communication
pub const from_initctl = C.VIR_FROM_INITCTL

// Error when operating on an interface
pub const from_interface = C.VIR_FROM_INTERFACE

// Error from libssh connection transport
pub const from_libssh = C.VIR_FROM_LIBSSH

// Error from libxenlight driver
pub const from_libxl = C.VIR_FROM_LIBXL

// Error from lock manager
pub const from_locking = C.VIR_FROM_LOCKING

// Error from lockspace
pub const from_lockspace = C.VIR_FROM_LOCKSPACE

// Error from log manager
pub const from_logging = C.VIR_FROM_LOGGING

// Error from Linux Container driver
pub const from_lxc = C.VIR_FROM_LXC

// Error when operating on a network
pub const from_net = C.VIR_FROM_NET

// Error from network config
pub const from_network = C.VIR_FROM_NETWORK

// Error from node device monitor
pub const from_nodedev = C.VIR_FROM_NODEDEV

pub const from_none = C.VIR_FROM_NONE

// Error from network filter driver
pub const from_nwfilter = C.VIR_FROM_NWFILTER

// The OpenNebula driver no longer exists.
// Retained for ABI/API compat only
pub const from_one = C.VIR_FROM_ONE

// Error from OpenVZ driver
pub const from_openvz = C.VIR_FROM_OPENVZ

// Error from Parallels
pub const from_parallels = C.VIR_FROM_PARALLELS

// Error from perf
pub const from_perf = C.VIR_FROM_PERF

// Error from the phyp driver, unused since 6.0.0
pub const from_phyp = C.VIR_FROM_PHYP

// Error from polkit code
pub const from_polkit = C.VIR_FROM_POLKIT

// Error in the proxy code; unused since
// 0.8.6
pub const from_proxy = C.VIR_FROM_PROXY

// Error at the QEMU daemon
pub const from_qemu = C.VIR_FROM_QEMU

// Error from remote driver
pub const from_remote = C.VIR_FROM_REMOTE

// Error from resource control
pub const from_resctrl = C.VIR_FROM_RESCTRL

// Error in the XML-RPC code
pub const from_rpc = C.VIR_FROM_RPC

// Error from secret storage
pub const from_secret = C.VIR_FROM_SECRET

// Error from security framework
pub const from_security = C.VIR_FROM_SECURITY

// Error in the S-Expression code
pub const from_sexpr = C.VIR_FROM_SEXPR

// Error from libssh2 connection transport
pub const from_ssh = C.VIR_FROM_SSH

// Error in the Linux Stats code
pub const from_stats_linux = C.VIR_FROM_STATS_LINUX

// Error from storage driver
pub const from_storage = C.VIR_FROM_STORAGE

// Error from I/O streams
pub const from_streams = C.VIR_FROM_STREAMS

// Error from sysinfo/SMBIOS
pub const from_sysinfo = C.VIR_FROM_SYSINFO

// Error from systemd code
pub const from_systemd = C.VIR_FROM_SYSTEMD

// Error from test driver
pub const from_test = C.VIR_FROM_TEST

// Error from thread utils
pub const from_thread = C.VIR_FROM_THREAD

// Error from TPM
pub const from_tpm = C.VIR_FROM_TPM

// Error at the UML driver; unused since 5.0.0
pub const from_uml = C.VIR_FROM_UML

// Error from URI handling
pub const from_uri = C.VIR_FROM_URI

// Error from VirtualBox driver
pub const from_vbox = C.VIR_FROM_VBOX

// Error from VMware driver
pub const from_vmware = C.VIR_FROM_VMWARE

// Error at Xen hypervisor layer
pub const from_xen = C.VIR_FROM_XEN

// Error from xen inotify layer
pub const from_xen_inotify = C.VIR_FROM_XEN_INOTIFY

// Error from XenAPI
pub const from_xenapi = C.VIR_FROM_XENAPI

// Error at connection with xend daemon
pub const from_xend = C.VIR_FROM_XEND

// Error at connection with xen store
pub const from_xenstore = C.VIR_FROM_XENSTORE

// Error from Xen xl config code
pub const from_xenxl = C.VIR_FROM_XENXL

// Error at Xen XM layer
pub const from_xenxm = C.VIR_FROM_XENXM

// Error in the XML code
pub const from_xml = C.VIR_FROM_XML
