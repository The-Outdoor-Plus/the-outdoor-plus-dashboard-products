<template>
  <div>
    <material-form
      :loading="loading"
      :material="material"
      readonly
    ></material-form>
  </div>
</template>
<script lang="ts" setup>
import MaterialForm from '@/components/MaterialForm.vue';
import { useAppStore } from '@/store/app';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { onMounted, ref, Ref } from 'vue';
import { useRoute } from 'vue-router';

interface Material {
  id?: number;
  name: string;
  slug?: string;
}

const store = useAppStore();
const route = useRoute();
const { notify } = useNotification();

const loading = ref(false);
const material: Ref<Material> = ref<Material>({
  id: 0,
  name: '',
  slug: '',
});

onMounted(async () => {
  store.pageTitle = 'Material - View';
  try {
    loading.value = true;
    const { data, error } = await supabase
      .from('material')
      .select()
      .eq('id', route.params.id);
    if (error) throw error;
    if (data.length) material.value = data[0];
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error retrieving material.',
      text: e?.message || 'An error ocurred trying to retrieve material. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    loading.value = false;
  }
});
</script>