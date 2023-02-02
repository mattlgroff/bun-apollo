FROM jarredsumner/bun:0.5.1
WORKDIR /app
COPY package.json package.json
COPY bun.lockb bun.lockb
RUN bun install
COPY . .
EXPOSE 4000
ENTRYPOINT ["bun", "start"]