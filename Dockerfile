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

# Setup the app directory
WORKDIR /app

# Copy the package.json and bun.lockb files
COPY package.json package.json
COPY bun.lockb bun.lockb

# Install the dependencies
RUN ~/.bun/bin/bun install

# Copy the rest of the app code (in this case just index.js is needed)
COPY index.js index.js

# Expose the port that the app is running on
EXPOSE 4000

# The Bun install didn't add the bin to the path, so we do it here
ENV PATH=$PATH:~/.bun/bin/

# Start the app
ENTRYPOINT ~/.bun/bin/bun start