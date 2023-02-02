Powered by Bun and Apollo Server. That's it.

I wrote an article about making an Apollo Server with Bun [here](https://groff.dev/bun-apollo/) (Coming Soon)

## Features:
* Apollo Server 4

## Run Instructions
```bash
bun install
bun start
```

## Docker Instructions
```bash
docker build -t bun-apollo .
docker run -p 4000:4000 bun-apollo
```

## Docker-Compose Instructions
```bash
docker-compose up
```

The Apollo Server should be running on the port `4000` you can visit: `http://localhost:4000` to see the GraphQL Playground.