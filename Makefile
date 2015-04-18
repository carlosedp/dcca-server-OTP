APP					= dccaserver
ERLAPPS				= -s ocsgateway -s dccaserver
ERLDEPS				= -s lager -s diameter
COOKIE				= 'abc123'

ifeq ($(OS),Windows_NT)
		ERL ?= run werl
else
		ERL ?= erl
endif
ERLC				= erlc
REBAR 				= escript rebar
EBIN_DIRS			:= $(wildcard deps/*/ebin)
APPS				:= $(shell ls apps)
REL_DIR				= rel
NODE				= $(APP)
REL					= $(APP)
SCRIPT_PATH  := $(REL_DIR)/$(NODE)/bin/$(REL)

.PHONY: all compile deps clean distclean test rel build-plt dialyze

all: deps compile

compile: deps
	@$(REBAR) compile

deps:
	@$(REBAR) get-deps
	@$(REBAR) check-deps

clean:
	@$(REBAR) clean

distclean: clean
	@$(REBAR) delete-deps

test:
	@$(REBAR) skip_deps=true ct

rel: deps
	@$(REBAR) compile generate

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

doc:
	$(REBAR) skip_deps=true doc
	for app in $(APPS); do \
		cp -R apps/$${app}/doc doc/$${app}; \
	done;

analyze: checkplt
	@$(REBAR) skip_deps=true dialyze

buildplt:
	@$(REBAR) skip_deps=true build-plt

checkplt: buildplt
	@$(REBAR) skip_deps=true check-plt

shell:
	$(ERL) -pa deps/*/ebin apps/*/ebin -sname $(APP) -setcookie $(COOKIE) -boot start_sasl $(ERLDEPS) $(ERLAPPS)
