// Utilities
import { defineStore } from 'pinia'

export const useAppStore = defineStore('app', {
  state: () => ({
    rail: false,
    pageTitle: 'Dashboard',
  }),
})
