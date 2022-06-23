ARG application=dccaserver
# Build stage 0
FROM erlang:25-alpine as builder
ARG application

# Install some libs
RUN apk add --no-cache ncurses-libs && \
    apk add --no-cache alpine-sdk

# Set working directory
RUN mkdir /buildroot
WORKDIR /buildroot

# Add our Erlang application
ADD . /buildroot

# Build the release
RUN make tar && \
    mkdir -p /opt/rel/${application} && \
    tar vxf /buildroot/_build/prod/rel/*/*.tar.gz -C /opt/rel/${application}

# Production container
FROM alpine as prod
ARG application

# Install some libs
RUN apk add --no-cache openssl && \
    apk add --no-cache ncurses-libs && \
    apk add --no-cache libstdc++

# Install the released application
COPY --from=builder /opt/rel/${application} /opt/

# Expose relevant ports
EXPOSE 3868 9000

CMD ["/opt/dccaserver/bin/dccaserver", "foreground"]
