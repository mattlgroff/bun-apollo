# Debain is what Bun uses for their docker image
FROM debian:bullseye-slim

# Install curl and unzip and source
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y  \
    curl \
    unzip

# Install latest version of Bun
RUN curl -fsSL https://bun.sh/install | bash

WORKDIR /app

COPY package.json package.json

COPY bun.lockb bun.lockb

RUN ~/.bun/bin/bun install

COPY index.js index.js

EXPOSE 4000

# The Bun install didn't add the bin to the path, so we do it here
ENV PATH=$PATH:~/.bun/bin/

ENTRYPOINT ~/.bun/bin/bun start