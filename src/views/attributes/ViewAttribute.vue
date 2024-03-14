<template>
  <div>
    <attributes-form
      :loading="loading"
      :attribute="attribute"
      readonly
    ></attributes-form>
  </div>
</template>
<script lang="ts" setup>
import AttributesForm from '@/components/AttributesForm.vue';
import { useAppStore } from '@/store/app';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { onMounted, ref, Ref } from 'vue';
import { useRoute } from 'vue-router';

/**
 *
 * Defining Interface
 *
 **/

interface Attribute {
  id: number;
  name: string;
  table_name?: string | undefined;
  slug?: string;
  values?: string[];
}

interface AttributeValue {
  id?: number;
  attribute_id?: number;
  value: string;
  material_id?: number;
  color_id?: number;
  gas_id?: number;
  ignition_id?: number;
}

const store = useAppStore();
const route = useRoute();
const { notify } = useNotification();

const loading = ref(false);
const attribute: Ref<Attribute> = ref<Attribute>({
  id: 0,
  name: '',
  table_name: '',
  slug: '',
  values: [],
});

onMounted(async() => {
  store.pageTitle = 'Attributes - Show';
  try {
    loading.value = true;
    const { data, error } = await supabase
      .from('attributes')
      .select(`id, name, slug, values: attribute_value(
        value
      )`)
      .eq('id', route.params.id);
    if (error) throw error;
    if (data.length) {
      const flattenedData = data.map((item) => ({
        ...item,
        values: item.values.map((value: any) => {
          return value.value;
        }),
      }));
      attribute.value = flattenedData[0];
    }
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error retrieving attribute.',
      text: e?.message || 'An error ocurred trying to retrieve attribute. Please contact TOP Support',
      type: 'error',
      duration: 6000,
    });
  } finally {
    loading.value = false;
  }
});
</script>
