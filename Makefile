APP					= dccaserver
REBAR 				= escript rebar3
APPS				:= $(shell ls apps)
REL_DIR				= _build/default/rel

ifeq ($(OS),Windows_NT)
		ERL ?= werl
		SCRIPT_PATH  := $(REL_DIR)/$(APP)/bin/$(APP).cmd
else
		ERL ?= erl
		SCRIPT_PATH  := $(REL_DIR)/$(APP)/bin/$(APP)
endif

.PHONY: all compile clean distclean cleanall test rel prod doc

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
	$(REBAR) as prod release

tar:
	$(REBAR) as prod tar

doc:
	$(REBAR) edoc
	for app in $(APPS); do \
		cp -R apps/$${app}/doc doc/$${app}; \
	done;

xref:
	${REBAR} xref

dialyzer:
	${REBAR} dialyzer

shell: compile
	$(REBAR) shell

wshell: compile
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

console: $(SCRIPT_PATH) compile
	@./$(SCRIPT_PATH) console

restart: $(SCRIPT_PATH)
	@./$(SCRIPT_PATH) restart

reboot: $(SCRIPT_PATH)
	@./$(SCRIPT_PATH) reboot
