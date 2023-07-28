<template>
  <div>
    <collection-form
      :loading="loading"
      :collection="collection"
      edit
    ></collection-form>
  </div>
</template>
<script lang="ts" setup>
import CollectionForm from '@/components/CollectionForm.vue';
import { useAppStore } from '@/store/app';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { onMounted, ref, Ref } from 'vue';
import { useRoute } from 'vue-router';

interface Collection {
  id?: number;
  name: string;
  slug?: string;
}

const store = useAppStore();
const route = useRoute();
const { notify } = useNotification();

const loading = ref(false);
const collection: Ref<Collection> = ref<Collection>({
  id: 0,
  name: '',
  slug: '',
});

onMounted(async () => {
  store.pageTitle = 'Collection - Edit';
  try {
    loading.value = true;
    const { data, error } = await supabase
      .from('collection')
      .select()
      .eq('id', route.params.id);
    if (error) throw error;
    if (data.length) collection.value = data[0];
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error retrieving collection.',
      text: e?.message || 'An error ocurred trying to retrieve collection. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    loading.value = false;
  }
});
</script>