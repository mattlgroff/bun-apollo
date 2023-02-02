import http from 'http';
import { ApolloServer } from '@apollo/server';
import { startStandaloneServer } from '@apollo/server/standalone';
import { buildSchema } from 'graphql'
import { resolvers } from './resolvers';
import * as jose from 'jose'

// Builds schema from a .graphql file
const typeDefs = buildSchema(
  Bun.readFile("./src/schema.graphql")
);

// Initialize Apollo Server
const server = new ApolloServer({
  path: '/graphql',
  enablePlayground: true, // Default is disabled in production
  typeDefs, // Import schema from .graphql file
  resolvers, // Import resolvers from resolvers.js,
});

// Set the default port to 4000, or use the PORT environment variable
const port = process.env.PORT || 4000;

// Start the Apollo Server
await startStandaloneServer(server, {
  context: async ({ req }) => {
    // Handle Authentication
    let user;
    if (req.headers.authorization) {
      try {
          const token = req.headers.authorization.split(' ')[1];

          const secret = new TextEncoder().encode(
            process.env.JWT_SECRET,
          );

          const { payload } = await jose.jwtVerify(token, secret, {
            issuer: 'urn:example:issuer',
            audience: 'urn:example:audience',
          })

          user = payload;
      } catch (err) {
        console.error(err);
      }
    }
      
    // TODO: Implement these
    // Datasources
    const dataSources = {};

    return {
      dataSources,
      user,
    };
  },
  listen: { port },
});

console.log(`🚀 🥟  Server ready at: http://localhost:${port}/graphql`);