# Build stage 0
ARG projectname
FROM erlang:alpine as builder

# Install some libs
RUN apk add --no-cache make

# Set working directory
RUN mkdir /buildroot
WORKDIR /buildroot

# Add our Erlang application
ADD . /buildroot

# Build the release
RUN make prod

# Production container
FROM alpine
ARG projectname

ENV projectname=$projectname
# Install some libs
RUN apk add --no-cache openssl && \
    apk add --no-cache ncurses-libs

# Install the released application
COPY --from=builder /buildroot/_build/prod/rel/$projectname /$projectname

# Expose relevant ports
EXPOSE 3868 9000
CMD ["/bin/sh", "-c", "/$projectname/bin/$projectname", "foreground"]