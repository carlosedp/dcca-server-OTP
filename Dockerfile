# Build stage 0
FROM erlang:25-alpine as builder

# Install some libs
RUN apk add --no-cache ncurses-libs && \
    apk add --no-cache alpine-sdk

# Set working directory
RUN mkdir /buildroot
WORKDIR /buildroot

# Add our Erlang application
ADD . /buildroot

# Build the release
RUN make prod

# Production container
FROM alpine as prod

# Install some libs
RUN apk add --no-cache openssl && \
    apk add --no-cache ncurses-libs && \
    apk add --no-cache libstdc++

# Install the released application
COPY --from=builder /buildroot/_build/prod/rel/dccaserver /opt/dccaserver

# Expose relevant ports
EXPOSE 3868 9000

CMD ["/opt/dccaserver/bin/dccaserver", "foreground"]
