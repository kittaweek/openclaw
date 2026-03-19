FROM alpine/openclaw:latest

ARG OPENCLAW_DOCKER_APT_PACKAGES=""
ARG OPENCLAW_EXTENSIONS=""

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends git jq curl ${OPENCLAW_DOCKER_APT_PACKAGES} && \
    rm -rf /var/lib/apt/lists/*

RUN if [ -n "${OPENCLAW_EXTENSIONS}" ]; then \
    npm install -g ${OPENCLAW_EXTENSIONS}; \
    fi

USER node