<template>
  <div>
    <material-form new></material-form>
  </div>
</template>
<script lang="ts" setup>
import MaterialForm from '@/components/MaterialForm.vue';
import { useAppStore } from '@/store/app';
import { onMounted } from 'vue';

const store = useAppStore();

onMounted(() => {
  store.pageTitle = 'Materials - New';
});
</script>