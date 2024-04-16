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
      v-if="isDistributor"
      class="tw-w-60 tw-pl-6 tw-pr-2"
      src="@/assets/TOP_DistributorPortal.png"
    />
    <img
      v-else-if="isDealer"
      class="tw-w-60 tw-pl-6 tw-pr-2"
      src="@/assets/TOP_DealerPortal.png"
    />
    <img
      v-else
      class="tw-w-60 tw-pl-6 tw-pr-2"
      src="@/assets/TOP_VendorPortal.png"
    />
    <!-- <v-icon v-if="companyLogo" icon="mdi-alpha-x"></v-icon>
    <img
      v-if="companyLogo"
      class="tw-w-60 tw-pl-2"
      :src="(companyLogo as string)"
    /> -->
    <!-- <v-app-bar-title class="tw-pl-6">{{ props.title }}</v-app-bar-title> -->
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
import { onMounted, ref, computed } from 'vue';

const store = useAppStore();
const userStore = useUserStore();
const router = useRouter();
const { notify } = useNotification();

const companyLogo = ref<boolean | string>(false)

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

const isDistributor = computed(() => {
  return ['DISTRIBUTOR', 'MASTER_DISTRIBUTOR'].includes(userStore.currentRole || '');
});

const isDealer = computed(() => {
  return ['DEALER', 'INTERNET'].includes(userStore.currentRole || '');
});

onMounted(async () => {
  try {
    companyLogo.value = await userStore.showCompanyLogo();
  } catch (e: any) {
    console.error(e);
  }
})
</script>

