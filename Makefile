APP					= dccaserver
DOCKERREPO			= carlosedp
APPS				:= $(shell ls apps)
REL_DIR				= _build/default/rel
APP_FILES = $(wildcard apps/*/*) $(wildcard config/*)
ERL_FLAGS = "-args_file config/vm.args -config config/sys.config"

UNAME := $(shell uname)
ifeq ($(UNAME), Linux)
GET_IP="ip a"
endif
ifeq ($(UNAME), Darwin)
GET_IP="ifconfig"
endif
INTERFACE_IP=$(shell ${GET_IP} | grep "inet " | grep -Fv 127.0.0.1 | cut -d/ -f1  | awk '{print $$2}' |head -1)

REBAR3_URL=https://s3.amazonaws.com/rebar3/rebar3
REBAR3 ?= $(shell test -e `which rebar3` 2>/dev/null && which rebar3 || echo "./rebar3")

.PHONY: all compile clean distclean cleanall test rel prod doc

all: compile

compile: $(REBAR3) deps
	@echo "Building application"
	@$(REBAR3) compile

check-deps:
	@$(REBAR3) update-deps

deps:
	@$(REBAR3) upgrade --all

clean:
	@$(REBAR3) clean

distclean:
	@$(REBAR3) clean -a
	@rm -rf _build

test: all
	@$(REBAR3) ct

$(RELEASE_SCRIPT): Makefile $(APP_FILES)
	@$(REBAR3) release

rel: $(RELEASE_SCRIPT)

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
	@$(REBAR3) dialyzer || true
	@$(REBAR3) dialyzer_html

fmt:
	$(REBAR3) format

shell: compile
	@echo "Running $(APP) shell"
	@ERL_FLAGS=${ERL_FLAGS} $(REBAR3) shell

##
## Release commands
##
status: $(RELEASE_SCRIPT)
	@./$(RELEASE_SCRIPT) status || true

fg: $(RELEASE_SCRIPT)
	@./$(RELEASE_SCRIPT) foreground || true

start: $(RELEASE_SCRIPT)
	@./$(RELEASE_SCRIPT) daemon || true

stop: $(RELEASE_SCRIPT)
	@./$(RELEASE_SCRIPT) stop || true

ping: $(RELEASE_SCRIPT)
	@./$(RELEASE_SCRIPT) ping || true

attach: $(RELEASE_SCRIPT)
	@./$(RELEASE_SCRIPT) daemon_attach || true

console: $(RELEASE_SCRIPT)
	@./$(RELEASE_SCRIPT) console || true

restart: $(RELEASE_SCRIPT)
	@./$(RELEASE_SCRIPT) restart || true

reboot: $(RELEASE_SCRIPT)
	@./$(RELEASE_SCRIPT) reboot || true

##
## Docker and testing commands
##
docker:
	docker build -t $(DOCKERREPO)/dcca-server-otp --build-arg PROJECT=$(APP) .

docker-run:
	docker run -d -p 3868:3868 -p 9000:9000 --name dcca-server-otp $(DOCKERREPO)/dcca-server-otp

stack:
	docker-compose up --build -d

seagull:
	docker run -it --rm -v $(PWD)/test/seagull:/src -w /src --add-host=dccaserver:${INTERFACE_IP} docker.io/carlosedp/docker-seagull ./gprs.sh