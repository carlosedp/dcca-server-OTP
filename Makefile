all: deps compile

deps:
	escript rebar get-deps

compile:
	escript rebar compile

shell:
	erl -pa deps/*/ebin apps/*/ebin -s startapp start
