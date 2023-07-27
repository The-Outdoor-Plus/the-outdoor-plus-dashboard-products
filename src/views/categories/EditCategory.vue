<template>
  <div>
    <category-form
      :loading="loading"
      :category="category"
      edit
    ></category-form>
  </div>
</template>
<script lang="ts" setup>
import CategoryForm from '@/components/CategoryForm.vue';
import { useAppStore } from '@/store/app';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { onMounted, ref, Ref } from 'vue';
import { useRoute } from 'vue-router';

interface Category {
  id?: number;
  name: string;
  slug?: string;
}

const store = useAppStore();
const route = useRoute();
const { notify } = useNotification();

const loading = ref(false);
const category: Ref<Category> = ref<Category>({
  id: 0,
  name: '',
  slug: '',
});

onMounted(async () => {
  store.pageTitle = 'Category - Edit';
  try {
    loading.value = true;
    const { data, error } = await supabase
      .from('category')
      .select()
      .eq('id', route.params.id);
    if (error) throw error;
    if (data.length) category.value = data[0];
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error retrieving category.',
      text: e?.message || 'An error ocurred trying to retrieve category. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    loading.value = false;
  }
});
</script>