<template>
  <div>
    <company-form new></company-form>
  </div>
</template>
<script setup lang="ts">
import CompanyForm from '@/components/CompanyForm.vue';
import { useAppStore } from '@/store/app';
import { onMounted } from 'vue';

const store = useAppStore();

onMounted(() => {
  store.pageTitle = 'Company - New';
})
</script>
