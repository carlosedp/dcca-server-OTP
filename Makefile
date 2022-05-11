APP					= dccaserver
DOCKERREPO			= carlosedp
APPS				:= $(shell ls apps)
REL_DIR				= _build/default/rel

REBAR3_URL=https://s3.amazonaws.com/rebar3/rebar3
ifeq ($(wildcard rebar3),rebar3)
REBAR3 = $(CURDIR)/rebar3
endif

REBAR3 ?= $(shell test -e `which rebar3` 2>/dev/null && which rebar3 || echo "./rebar3")

ifeq ($(REBAR3),)
REBAR3 = $(CURDIR)/rebar3
endif

ifeq ($(OS),Windows_NT)
		ERL ?= werl
		SCRIPT_PATH  := $(REL_DIR)/$(APP)/bin/$(APP).cmd
else
		ERL ?= erl
		SCRIPT_PATH  := $(REL_DIR)/$(APP)/bin/$(APP)
endif

.PHONY: all compile clean distclean cleanall test rel prod doc

all: compile

compile: $(REBAR3) deps
	@echo "Building application"
	@$(REBAR3) compile

deps:
	@$(REBAR3) upgrade --all

clean:
	@$(REBAR3) clean

distclean:
	@$(REBAR3) clean -a
	@rm -rf _build

test: all
	@$(REBAR3) ct

rel:
	@$(REBAR3) release

prod: compile
	$(REBAR3) as prod release

tar:
	$(REBAR3) as prod tar

doc:
	$(REBAR3) edoc
	for app in $(APPS); do \
		cp -R apps/$${app}/doc doc/$${app}; \
	done;

xref:
	$(REBAR3) xref

dialyzer:
	$(REBAR3) dialyzer

fmt:
	$(REBAR3) format

shell: compile
	@echo "Running $(APP) shell"
	@$(REBAR3) shell

wshell: compile
	$(ERL) -args_file config/vm.args -config config/sys.config -pa _build/default/lib/*/ebin --boot start_sasl -s $(APP)

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

docker:
	docker build -t $(DOCKERREPO)/$(APP) --build-arg projectname=$(APP) .

docker-run:
	docker run -d -p 3868:3868 -p 9000:9000 --name $(APP) $(DOCKERREPO)/$(APP)