### Running the examples

You can run the examples by `v run` in the current directory.

If `virt` module is installed in your `@vmodules` directory (usually
`~/.vmodules`) via `v install` then run:

```
v run get_version.v
```

If you just cloned this repo and `virt` module is not installed yet, first set
modules search path in `VFLAGS` environment variable:

```
export VFLAGS="-path $(realpath $PWD/../../)|@vlib|@vmodules"
```

Don't forget `unset VFLAGS` after running examples.

The library assumes that `libvirtd` is installed and running on the host where
the examples will be run, and that the user under which the code examples are
run has access to the libvirtd socket. Usually, to allow access to the socket,
it is enough to add the user to the `libvirt` group.
