SHELL=/bin/bash
HFLAGS=--hacks
CONF=collect.hc

###################################
#HERODOTOS is set locally or automatically find by `which`
-include ../../Makefile.local

HOST=$(or $(shell uname -n | cut -f1 -d"." | tr '-' '_'),$(error HOST computation failed))
PWD=$(or $(shell pwd),$(error PWD computation failed))
DIR=$(or $(shell basename $(PWD)),$(error DIR computation failed))

include /usr/share/herodotos/Makefile.inc

.PHONY:: pack

$(CONF): $(CONF).base
	 cpp -undef -P -D$(HOST) $^ > $@

pack:
	tar cjvf ../$(DIR)_$(CONF:%.hc=%)_data.tbz2 -C .. --exclude-vcs $(DIR)

include Makefile.local
