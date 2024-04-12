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
import * as Sentry from '@sentry/vue';

const app = createApp(App);

registerPlugins(app);

app.config.errorHandler = (err, vm, info) => {
  if (import.meta.env.VITE_VERCEL_ENV) {
    Sentry.captureException(err);
  }
}

app.mount('#app');
