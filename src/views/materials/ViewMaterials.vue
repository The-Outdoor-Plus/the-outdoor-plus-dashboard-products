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

interface Color {
  id?: number;
  name?: string;
  image_url?: string;
  slug?: string;
}

interface Material {
  id?: number;
  name: string;
  slug?: string;
  image_url?: string | null;
  color?: Color[];
}

const store = useAppStore();
const route = useRoute();
const { notify } = useNotification();

const loading = ref(false);
const material: Ref<Material> = ref<Material>({
  id: 0,
  name: '',
  slug: '',
  image_url: '',
  color: [],
});

onMounted(async () => {
  store.pageTitle = 'Material - View';
  try {
    loading.value = true;
    const { data, error } = await supabase
      .from('material')
      .select(`id, name, slug, image_url, color (id, name, slug, image_url)`)
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