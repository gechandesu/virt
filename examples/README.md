### Running the examples

You can run the examples by simply executing commands like this in the current
directory:

```
v run get_version.v
```

The library assumes that `libvirtd` is installed and running on the host where
the examples will be run, and that the user under which the code examples are
run has access to the libvirtd socket. Usually, to allow access to the socket,
it is enough to add the user to the `libvirt` group.
