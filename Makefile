REBAR = escript rebar

.PHONY: clean deps

all: deps compile

deps:
	${REBAR} get-deps

compile: deps
	@ $(MAKE) -C apps/dccaserver/src/diameter-dict
	${REBAR} compile

shell:
	erl -pa deps/*/ebin apps/*/ebin -s startapp start

clean:
	$(MAKE) -C apps/dccaserver/src/diameter-dict clean
	${REBAR} clean

distclean: clean
	@${REBAR} delete-deps

rel: compile
	${REBAR} generate
