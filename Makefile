REBAR = escript rebar

.PHONY: clean deps

all: deps compile

deps:
	${REBAR} get-deps

compile: deps
	${REBAR} compile

shell:
	erl -pa deps/*/ebin apps/*/ebin -s startapp start

clean:
	${REBAR} clean

distclean: clean
	@${REBAR} delete-deps

rel: compile
	${REBAR} generate
