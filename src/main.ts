/**
 * main.ts
 *
 * Bootstraps Vuetify and other plugins then mounts the App`
 */

import './index.css';
// Components
import App from './App.vue';

// Composables
import { createApp } from 'vue';

// Plugins
import { registerPlugins } from './plugins';

// GraphQL
import { ApolloClients } from '@vue/apollo-composable';
import { mondayApolloClient } from './graphql';

const app = createApp(App);

app.provide(ApolloClients, {
  default: mondayApolloClient,
});

registerPlugins(app);

app.mount('#app');
