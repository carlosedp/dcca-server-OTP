# Erlang Diameter Credit Control Application

This repository contains an example OTP DCCA application server built in Erlang.

To build the modules and diameter dictionaries, use rebar:

    ./rebar get-deps compile generate

To start the module use:

    erl -pa deps/*/ebin apps/*/ebin
    
    application:start(diameter).
    application:start(dccaserver).

Or use the provided Makefile:

    make deps
    make compile
    make shell

## Testing

To test the server, use the client module [diameter-dcca](https://github.com/carlosedp/diameter-dcca) from my other project or Seagull.

### Client

    erl
    client:start().
    client:test().

### Seagull

Seagull can be used to generate Diameter traffic to the server. The configuration and scenario xml are in Seagull dir from [diameter-dcca](https://github.com/carlosedp/diameter-dcca) project.

The application can be downloaded from [http://gull.sourceforge.net/doc/](http://gull.sourceforge.net/doc/).


