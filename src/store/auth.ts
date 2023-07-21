// Auth
import { defineStore } from 'pinia';

export const useAuthStore = defineStore('auth', {
  state: (): State => ({
    token: undefined,
    isLoading: false,
  }),
  actions: {
    logout() {
      this.token = undefined;
    }
  }
})

interface State {
  token: string | undefined;
  isLoading: boolean;
}
