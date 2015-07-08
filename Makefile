APP					= dccaserver
REBAR 				= escript rebar3
APPS				:= $(shell ls apps)
REL_DIR				= _build/default/rel

ifeq ($(OS),Windows_NT)
		ERL ?= run werl
		SCRIPT_PATH  := $(REL_DIR)/$(APP)/bin/$(APP).cmd
else
		ERL ?= erl
		SCRIPT_PATH  := $(REL_DIR)/$(APP)/bin/$(APP)
endif

.PHONY: all compile clean distclean cleanall test rel prod

all: compile

compile:
	@$(REBAR) compile

clean:
	@$(REBAR) clean

distclean:
	@$(REBAR) clean -a

cleanall: distclean
	@echo
	@echo "Are you sure? This will clean all untracked and ignored files."
	@echo "In 5 seconds the following files/dirs will be removed. Ctrl-C to cancel."
	@echo
	@rm -rf _build
	@git clean -n -d -x
	@echo "..."
	@sleep 5
	@git clean -x -d -f

test: all
	@$(REBAR) ct

rel:
	@$(REBAR) release

prod: compile
	$(REBAR) as prod tar

doc:
	$(REBAR) edoc
	for app in $(APPS); do \
		cp -R apps/$${app}/doc doc/$${app}; \
	done;

xref: compile
	${REBAR} xref skip_deps=true

shell:
	# $(REBAR) shell
	$(ERL) -args_file config/vm.args -config config/sys.config -pa _build/default/lib/*/ebin --boot start_sasl -s dccaserver

##
## Release commands
##
start: $(SCRIPT_PATH)
	@./$(SCRIPT_PATH) start

stop: $(SCRIPT_PATH)
	@./$(SCRIPT_PATH) stop

ping: $(SCRIPT_PATH)
	@./$(SCRIPT_PATH) ping

attach: $(SCRIPT_PATH)
	@./$(SCRIPT_PATH) attach

console: $(SCRIPT_PATH)
	@./$(SCRIPT_PATH) console

restart: $(SCRIPT_PATH)
	@./$(SCRIPT_PATH) restart

reboot: $(SCRIPT_PATH)
	@./$(SCRIPT_PATH) reboot

##
## Dialyzer
##
APPS = kernel stdlib sasl erts ssl tools inets compiler diameter
ifeq ($(OS),Windows_NT)
	COMBO_PLT = `cygpath -m $(HOME)/.aggregation_combo_dialyzer_plt`
else
	COMBO_PLT = $(HOME)/.aggregation_combo_dialyzer_plt
endif

check_plt: compile
	dialyzer --check_plt --plt $(COMBO_PLT) --apps $(APPS) \
		deps/*/ebin apps/*/ebin

build_plt: compile
	dialyzer --build_plt --output_plt $(COMBO_PLT) --apps $(APPS) \
		deps/*/ebin apps/*/ebin

dialyzer: compile
	@echo
	@echo Use "'make check_plt'" to check PLT prior to using this target.
	@echo Use "'make build_plt'" to build PLT prior to using this target.
	@echo
	@sleep 1
	dialyzer -Wno_return --plt $(COMBO_PLT) deps/*/ebin apps/*/ebin


cleanplt:
	@echo
	@echo "Are you sure?  It takes about 1/2 hour to re-build."
	@echo Deleting $(COMBO_PLT) in 5 seconds.
	@echo
	sleep 5
	rm $(COMBO_PLT)
