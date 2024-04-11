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

Sentry.init({
  app,
  dsn: import.meta.env.SENTRY_DSN,
  integrations: [
    Sentry.browserTracingIntegration(),
    Sentry.replayIntegration(),
  ],
  // Performance monitoring
  tracesSampleRate: 1.0, //  Capture 100% of the transactions
  // Set 'tracePropagationTargets' to control for which URLs distributed tracing should be enabled
  tracePropagationTargets: ["localhost", import.meta.env.VITE_SUPABASE_URL],
  // Session Replay
  replaysSessionSampleRate: 0.1, // This sets the sample rate at 10%. You may want to change it to 100% while in development and then sample at a lower rate in production.
  replaysOnErrorSampleRate: 1.0, // If you're not already sampling the entire session, change the sample rate to 100% when sampling sessions where errors occur.
})

registerPlugins(app);

app.mount('#app');
