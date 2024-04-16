<template>
  <div>
    <company-form
      :loading="loading"
      :company="company"
      edit
    ></company-form>
  </div>
</template>
<script setup lang="ts">
import CompanyForm from '@/components/CompanyForm.vue';
import { useAppStore } from '@/store/app';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { onMounted, ref, Ref } from 'vue';
import { useRoute } from 'vue-router';

interface Company {
  id?: number;
  name: string;
  slug?: string;
  logo_url?: string;
  role?: string;
}

const store = useAppStore();
const route = useRoute();
const { notify } = useNotification();

const loading = ref(false);
const company: Ref<Company> = ref<Company>({
  id: 0,
  name: '',
  slug: '',
  role: '',
  logo_url: '',
});

onMounted(async () => {
  store.pageTitle = 'Company - Edit';
  try {
    loading.value = true
    const { data, error } = await supabase
      .from('company')
      .select()
      .eq('id', route.params.id);
    if (error) throw error;
    if (data.length) company.value = data[0];
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error retrieving company.',
      text: e?.message || 'An error ocurred trying to retrieve the company. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    })
  } finally {
    loading.value = false;
  }
});
</script>
