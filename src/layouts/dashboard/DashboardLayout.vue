<template>
  <v-layout>
    <top-bar :title="store.pageTitle"></top-bar>
    <nav-bar></nav-bar>
    <v-main class="tw-bg-gray-50">
      <div class="tw-px-20 tw-pt-14">
        <router-view />
      </div>
    </v-main>
  </v-layout>
</template>

<script lang="ts" setup>
import TopBar from '@/components/TopBar.vue';
import NavBar from '@/components/NavBar.vue';
import { useAppStore } from '@/store/app';

const store = useAppStore();
</script>
