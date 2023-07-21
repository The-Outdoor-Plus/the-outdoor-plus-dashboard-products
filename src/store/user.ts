// Auth
import { defineStore } from 'pinia';
import { supabase } from '@/supabase';
import { User } from '@supabase/supabase-js';

interface Session {
  access_token: string;
  expires_at: number;
  expires_in: number;
  refresh_token: string;
  token_type: string;
  user: User;
}

interface State {
  user: User | null | undefined;
  token: string | null;
  session: Session | null;
}

export const useUserStore = defineStore('user', {
  state: (): State => {
    let token = null;
    let user = null;
    let session = null;
    const supabaseId = import.meta.env.VITE_SUPABASE_ID;
    const storeData = localStorage.getItem(`sb-${supabaseId}-auth-token`);
    if (storeData) {
      const data = JSON.parse(storeData);
      const today = new Date();
      const expiry = new Date(data?.expires_at * 1000);
      if (expiry.getTime() > today.getTime()) {
        user = data?.user;
        session = data;
        token = `${data.token_type} ${data.access_token}`;
      } else {
        supabase.auth.signOut();
      }
      
    }
    return {
      token,
      user,
      session,
    }
  },
  actions: {
    setUser(user: User) {
      this.user = user;
    },
    setSession(session: Session) {
      this.session = session;
      this.token = `${session.token_type} ${session.access_token}`;
    },
    successfullLogIn(user: User, session: any) {
      this.setUser(user);
      this.setSession(session);
    },
    async logOut() {
      await supabase.auth.signOut();
      this.user = null;
      this.session = null;
      this.token = null;
    }
  },
  getters: {
    currentUser: (state) => {
      return {
        ...state.user,
        ...state.user?.user_metadata,
      }
    },
    isUserAuthenticated(state) {
      return !!state.session;
    },
  },
})
