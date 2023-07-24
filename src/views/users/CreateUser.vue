<template>
  <div>
    <user-form new></user-form>
  </div>
</template>
<script lang="ts" setup>
import UserForm from '@/components/UserForm.vue';
import { useAppStore } from '@/store/app';
import { onMounted } from 'vue';

const store = useAppStore();

onMounted(() => {
  store.pageTitle = 'Users - New';
})
</script>