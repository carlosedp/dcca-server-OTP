APP					= dccaserver
ERLAPPS				= -s ocsgateway -s dccaserver
ERLDEPS				= -s lager -s diameter
COOKIE				= 'abc123'
ERLC				= erlc
REBAR 				= escript rebar
EBIN_DIRS			:= $(wildcard deps/*/ebin)
APPS				:= $(shell ls apps)
REL_DIR				= rel
NODE				= $(APP)
REL					= $(APP)

ifeq ($(OS),Windows_NT)
		ERL ?= run werl
		SCRIPT_PATH  := $(REL_DIR)/$(NODE)/bin/$(REL).cmd
else
		ERL ?= erl
		SCRIPT_PATH  := $(REL_DIR)/$(NODE)/bin/$(REL)
endif

.PHONY: all compile deps clean distclean test rel
#.PHONY: rel deps test

all: deps compile

compile: deps
	@$(REBAR) compile

app:
	@$(REBAR) compile skip_deps=true

deps:
	@$(REBAR) get-deps
	@$(REBAR) check-deps

clean:
	@$(REBAR) clean

distclean: clean
	@$(REBAR) delete-deps

cleanall: distclean
	@echo
	@echo "Are you sure? This will clean all untracked and ignored files."
	@echo "In 5 seconds the following files/dirs will be removed:"
	@git clean -n -d -x
	@echo "..."
	@sleep 5
	@git clean -x -d -f

test: all
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

xref: compile
	${REBAR} xref skip_deps=true

shell:
	$(ERL) -pa deps/*/ebin apps/*/ebin -sname $(APP) -setcookie $(COOKIE) -boot start_sasl $(ERLDEPS) $(ERLAPPS)
