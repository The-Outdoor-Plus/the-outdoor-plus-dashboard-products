import { ApolloClient, createHttpLink, InMemoryCache } from "@apollo/client/core";

const defaultHttpLink = createHttpLink({
  uri: import.meta.env.VITE_MONDAY_API_URL || 'https://api.monday.com/v2',
  fetch: (input: RequestInfo | URL, options?: RequestInit | undefined) => {
    if (options) {
      options.headers = {
        'Content-Type': 'application/json',
        Authorization : import.meta.env.VITE_MONDAY_TOKEN,
        'API-Version' : '2023-04',
      };
    }
    return fetch(input, options);
  },
});

const defaultCache = new InMemoryCache();

export const mondayApolloClient = new ApolloClient({
  link: defaultHttpLink,
  cache: defaultCache,
});
