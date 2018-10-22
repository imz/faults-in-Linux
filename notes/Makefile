
CONF=notes.hc

###################################
#HERODOTOS is defined locally (or automatically with which)
-include ../Makefile.local

HOST=$(or $(shell uname -n | cut -f1 -d"." | tr '-' '_'),$(error HOST computation failed))
PWD=$(or $(shell pwd),$(error PWD computation failed))
DIR=$(or $(shell basename $(PWD)),$(error DIR computation failed))

include /usr/local/share/herodotos/Makefile.inc

all:: /usr/share/pyshared/psycopg2/__init__.py

$(CONF): $(CONF).base 
	 cpp -undef -P -D$(HOST) $^ > $@
