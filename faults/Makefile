CONF?=study.hc
MINVER=3.1
VER=3.19
#bad_lock3a bad_lock4a bad_lock5a  bad_null2 bad_null3 bad_kfree
PATTERNS=block1a block1b block1c var isnull5 null_ref6 copy get  \
	double_lock2 lock intr intr_noarg_cli_sti \
	intr_noarg_local_irq_enable_disable \
	double_lockintr2 lockintr floatop realloc
# Wait: size_rule noderef kfree
# rcu_lock rcu_lock_bh rcu_lock_sched rcu_lock_sched_notrace srcu_lock bad_rcu rcu_deref_out

#HERODOTOS is set locally or automatically find by `which`
-include ../Makefile.local

HFLAGS=--hacks --diff hybrid $(PATT)
HOST=$(or $(shell uname -n | cut -f1 -d"." | tr '-' '_'),$(error HOST computation failed))
PWD=$(or $(shell pwd),$(error PWD computation failed))
DIR=$(or $(shell basename $(PWD)),$(error DIR computation failed))
# It's also specified in the *.hc.base (NEEDS TO BE IDENTICAL!):
MY_INPUT_PROJECT_DIR:=linux
NEW=$(PATTERNS:%=results/$(MY_INPUT_PROJECT_DIR)/Linux_%.new.org)

include /usr/share/herodotos/Makefile.inc

.PHONY:: fix-bossa fix-palace fix-cluster pack exist.tbz2

$(CONF): $(CONF).base
	 cpp -P -undef -D$(HOST) $(@:%=%.base) > $@
fix-mc4:
	set -e; for f in `find results/ -name "*.org"`; do sed -i "s|/var/linuxes|/scratch/$(MY_INPUT_PROJECT_DIR)|g" $$f ; done

fix-bossa:
	set -e; for f in `find results/ -name "*.org"`; do sed -i "s|/home/palix/projects/linux|/var/$(MY_INPUT_PROJECT_DIR)|g" $$f ; done

fix-palace:
	set -e; for f in `find results/ -name "*.org"`; do sed -i "s|/var/storage/projects/linux|/var/$(MY_INPUT_PROJECT_DIR)|g" $$f ; done

fix-cluster:
	set -e; for f in `find results/ -name "*.org"`; do sed -i "s|/home/npalix|/var|g" $$f ; done

exist.tbz2:
	set -e -o -pipefail; find results -name "*.exist" | xargs tar cjvf $@

pack:
	tar cjvf ../$(DIR)_$(CONF:%.hc=%)_data.tbz2 -C .. --exclude-vcs $(DIR)

extract:
	mkdir -p v$(VER)
	cd results/$(MY_INPUT_PROJECT_DIR)/ ; find -name "Linux_*.new.org" -exec $(HERODOTOS) extract --orgfile \{} --tag linux-$(VER) --prefix /scratch/$(MY_INPUT_PROJECT_DIR)/ -o ../../v$(VER)/\{} \;


UPDATE=$(PATTERNS:%=update-%)
update: $(UPDATE)
$(UPDATE): $(NEW)
	mkdir -p sql
	$(HERODOTOS) export-reports --prefix /fast_scratch/$(MY_INPUT_PROJECT_DIR)/ \
		--orgfile results/$(MY_INPUT_PROJECT_DIR)/Linux_$(@:update-%=%).new.org \
		--to-sql-update linux-$(MINVER) > sql/$@.$(MINVER).sql

EXPORT=$(PATTERNS:%=export-%)
export: $(EXPORT)
$(EXPORT): $(NEW)
	mkdir -p sql
	$(HERODOTOS) export-reports --prefix /fast_scratch/$(MY_INPUT_PROJECT_DIR)/ \
		--orgfile results/$(MY_INPUT_PROJECT_DIR)/Linux_$(@:export-%=%).new.org \
		--to-sql > sql/$@.sql

