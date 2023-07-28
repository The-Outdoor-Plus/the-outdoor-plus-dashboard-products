<template>
  <v-app-bar 
    flat
    border
    color="white"
    class="!tw-fixed"
  >
    <template v-slot:prepend>
      <v-app-bar-nav-icon @click="store.rail = !store.rail"></v-app-bar-nav-icon>
    </template>
    <img
      class="tw-w-60 tw-px-6"
      src="@/assets/top_logo.png"
    />
    <v-app-bar-title>{{ props.title }}</v-app-bar-title>
    <v-spacer></v-spacer>
    <v-tooltip text="Sign Out" location="bottom">
      <template v-slot:activator="{ props }">
        <v-btn icon v-bind="props" @click="signOut">
          <v-icon>mdi-logout</v-icon>
        </v-btn>
      </template>
    </v-tooltip>
    
  </v-app-bar>
</template>

<script setup lang="ts">
import { useAppStore } from '@/store/app';
import { useUserStore } from '@/store/user';
import { useNotification } from '@kyvg/vue3-notification';
import { useRouter } from 'vue-router';

const store = useAppStore();
const userStore = useUserStore();
const router = useRouter();
const { notify } = useNotification();

const props = defineProps({
  title: {
    type: String,
    default: 'Dashboard',
  }
});

const signOut = async () => {
  await userStore.logOut();
  router.push('/login');
  notify({
    title: 'You Signed Out',
    duration: 4000,
  })
}
</script>

