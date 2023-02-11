FROM oven/bun:0.5
WORKDIR /app
COPY package.json package.json
COPY bun.lockb bun.lockb
RUN bun install
COPY index.js index.js
EXPOSE 4000
ENTRYPOINT ["bun", "run", "index.js"]
