ARG PROJECT=dccaserver
ARG OTP_VERSION=25
# ---------------------
# Builder container
# ---------------------
FROM erlang:${OTP_VERSION}-alpine as builder
ARG PROJECT

# Install some libs
RUN apk add --no-cache ncurses-libs \
        alpine-sdk

# Set working directory
RUN mkdir /buildroot
WORKDIR /buildroot

# Add our Erlang application
ADD . /buildroot

# Build the release using the tarball to avoid copying garbage
RUN make tar && \
    mkdir -p /opt/rel/${PROJECT} && \
    tar vxf /buildroot/_build/prod/rel/*/*.tar.gz -C /opt/rel/${PROJECT}

# ---------------------
# Production container
# ---------------------
FROM alpine as prod
ARG PROJECT

ENV APP=${PROJECT}
# Install some libs
RUN apk add --no-cache openssl \
        ncurses-libs \
        bash \
        libstdc++

# Create application system user & group, directory and correct permissions
ENV USERGRP=${PROJECT}
ENV ERLANGAPP_DATA_DIR=/var/lib/${PROJECT}
RUN set -eux; \
    addgroup -g 1999 -S ${USERGRP}; \
    adduser -u 1999 -S -h "${ERLANGAPP_DATA_DIR}" -G ${USERGRP} ${USERGRP}; \
    mkdir -p "${ERLANGAPP_DATA_DIR}"; \
    chown -fR ${USERGRP}:${USERGRP} "${ERLANGAPP_DATA_DIR}"; \
    chmod 777 "${ERLANGAPP_DATA_DIR}";

ENV ERLANGAPP_HOME=/opt/${PROJECT}

# Add application dir to PATH
ENV PATH=${ERLANGAPP_HOME}/bin:$PATH
ENV LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8

# Install the released application
COPY --from=builder /opt/rel/${PROJECT} ${ERLANGAPP_HOME}

RUN chown -R ${USERGRP}:${USERGRP} ${ERLANGAPP_HOME}

# Do not run application as root
USER ${USERGRP}:${USERGRP}

# Expose relevant ports
EXPOSE 3868 9000

CMD ["sh", "-c", "/opt/${APP}/bin/${APP} foreground"]
