#!/usr/bin/env -S v run

import build

mut context := build.context(default: 'gen')

context.task(
	name: 'gen'
	help: 'Generate bindings. See also ./generate.vsh -help'
	run:  fn (self build.Task) ! {
		system('./generate.vsh -header libvirt.h -by-prefix virConnect > connect_generated.c.v')
		system('./generate.vsh -header libvirt.h -by-prefix virDomain -not-prefix virDomainSnapshot -not-prefix virDomainCheckpoint > domain_generated.c.v')
		system('./generate.vsh -header virterror.h -by-prefix VIR_WAR_ -by-prefix VIR_ERR_ -by-prefix VIR_FROM_ > error_generated.c.v')
		system('v fmt -w .')
	}
)

context.run()
