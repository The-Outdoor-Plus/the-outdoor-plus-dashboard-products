import { sentryVitePlugin } from "@sentry/vite-plugin";
// Plugins
import vue from '@vitejs/plugin-vue'
import vuetify, { transformAssetUrls } from 'vite-plugin-vuetify'

// Utilities
import { defineConfig } from 'vite'
import { fileURLToPath, URL } from 'node:url'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    // https://github.com/vuetifyjs/vuetify-loader/tree/next/packages/vite-plugin
    vue({
      template: { transformAssetUrls }
    }),
    vuetify({
      autoImport: true,
    }),
    sentryVitePlugin({
      org: "the-outdoor-plus",
      project: "the-outdoor-plus-products-dashboard"
    })
  ],

  define: { 'process.env': {} },

  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    },
    extensions: [
      '.js',
      '.json',
      '.jsx',
      '.mjs',
      '.ts',
      '.tsx',
      '.vue',
    ],
  },

  server: {
    port: 3000,
  },

  build: {
    sourcemap: true
  }
})
