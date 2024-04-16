<template>
  <div>
    <div class="tw-w-full tw-my-16 rounded">
      <v-data-table-server
        v-if="showChildProducts"
        v-model:items-per-page="itemsPerPage"
        :key="`${route.params.id}`"
        :headers="(headers as [])"
        :items-length="totalItems"
        :items="data.serverItems"
        :loading="loading"
        class="elevation-1"
        rounded
        item-value="name"
        @update:options="loadItems"
      >
        <template v-slot:top>
          <v-toolbar flat compact color="green-darken-2" class="rounded-t">
            <v-toolbar-title>{{ childTableTitle }}</v-toolbar-title>
            <v-divider class="mx-4" inset vertical></v-divider>
            <v-spacer></v-spacer>
            <v-btn color="white" dark :to="redirectToNewProduct" exact>{{ newText }}<v-icon icon="mdi-plus" class="ml-2"></v-icon></v-btn>
          </v-toolbar>
          <v-dialog v-model="dialogDelete" max-width="600px">
            <v-card class="pt-4 pb-3" :loading="deleteLoading">
              <v-card-title class="text-h5">Are you sure you want to delelete this variant?</v-card-title>
              <v-card-text>
                <div class="tw-mb-4">
                  Variant <strong>{{ itemToDelete?.name }}</strong> will be deleted.
                  This action cannot be reversed. Are you sure you want to continue?
                </div>
                <span class="tw-text-sm tw-italic">To confirm deletion, please type <span class="tw-font-semibold tw-not-italic">{{ itemToDelete?.name }}</span> below.</span>
                <v-text-field
                  v-model="deleteConfirmationText"
                  class="tw-mt-2"
                  variant="outlined"
                  density="compact"
                  name="deleteConfirmationText"
                  :placeholder="itemToDelete?.name"
                  base-color="red"
                  color="red"
                ></v-text-field>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue-darken-1" variant="text" @click="closeDialogDelete">Cancel</v-btn>
                <v-btn color="red-darken-1" variant="text" @click="deleteItemConfirm(itemToDelete?.name)" :disabled="itemToDelete?.name !== deleteConfirmationText">Delete</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </template>
        <!-- eslint-disable-next-line vue/valid-v-slot -->
        <template v-slot:item.published="{ item }">
          <v-icon v-if="item.raw.published" icon="mdi-checkbox-marked-circle-outline" color="green"></v-icon>
          <v-icon v-else icon="mdi-close-circle-outline" color="red"></v-icon>
        </template>
        <!-- eslint-disable-next-line vue/valid-v-slot -->
        <template v-slot:item.enabled="{ item }">
          <v-icon v-if="item.raw.enabled" icon="mdi-checkbox-marked-circle-outline" color="green"></v-icon>
          <v-icon v-else icon="mdi-close-circle-outline" color="red"></v-icon>
        </template>
        <!-- eslint-disable-next-line vue/valid-v-slot -->
        <template v-slot:item.actions="{ item }">
          <div class="tw-flex tw-flex-nowrap tw-justify-end -tw-mr-1.5">
            <v-tooltip text="See Details" location="top">
              <template v-slot:activator="{ props }">
                <v-btn
                  v-bind="props"
                  size="small"
                  icon="mdi-eye"
                  variant="text"
                  :to="`/products/${route.params.id}/variant/${item.raw.id}`"
                >
                </v-btn>
              </template>
            </v-tooltip>
            <v-tooltip text="Edit Variation" location="top">
              <template v-slot:activator="{ props }">
                <v-btn
                  v-bind="props"
                  size="small"
                  icon="mdi-pencil"
                  variant="text"
                  :to="`/products/${route.params.id}/variant/edit/${item.raw.id}`"
                >
                </v-btn>
              </template>
            </v-tooltip>
            <v-tooltip text="Delete Variation" location="top">
              <template v-slot:activator="{ props }">
                <v-btn
                  v-bind="props"
                  size="small"
                  @click="deleteItem((item.raw as Columns))"
                  icon="mdi-delete"
                  variant="text"
                >
                </v-btn>
              </template>
            </v-tooltip>
            <v-tooltip text="Open in Quick Pricing View" location="top">
              <template v-slot:activator="{ props }">
                <v-btn
                  v-bind="props"
                  size="small"
                  @click="((item.raw as Columns))"
                  :to="`/quick-pricing-view?sku=${(item.raw as Columns).sku}`"
                  icon="mdi-open-in-new"
                  variant="text"
                >
                </v-btn>
              </template>
            </v-tooltip>

          </div>
        </template>
      </v-data-table-server>
    </div>
  </div>
</template>
<script lang="ts" setup>
import { VDataTableServer } from 'vuetify/lib/labs/components.mjs';
import { computed, ref, reactive, Ref, watch, defineEmits } from 'vue';
import { usePagination } from '@/utils';
import { supabase } from '@/supabase';
import { Product } from '@/types/product';
import { useRoute } from 'vue-router';
import { useNotification } from '@kyvg/vue3-notification';

interface Data {
  serverItems: Product[];
}

interface Columns {
  actions: null | undefined;
  id: number;
  name: string;
  sku: string;
  collection: string;
  category: string;
  material: string;
  published: boolean;
  enabled: boolean;
}

interface TableOptions {
  page: number;
  itemsPerPage: number;
  sortBy: any;
}

interface Props {
  showChildProducts?: boolean;
  redirectToNewProduct?: string;
  productId?: number;
  loadingData?: boolean;
}

 const props = withDefaults(defineProps<Props>(), {
  showChildProducts: false,
  redirectToNewProduct: '/products',
  productId: 0,
  loadingData: false,
 });

const childTableTitle = computed(() => {
  return 'Child products (Variants)';
});

const newText = computed(() => {
  return 'New Variant';
});

const headers = ref([
  {
    title: 'ID',
    align: 'start',
    sortable: false,
    key: 'id',
  },
  { title: 'Name', align: 'end', key: 'name', width: '450px' },
  { title: 'SKU', align: 'end', key: 'sku', width: '400px' },
  { title: 'Enabled', align: 'end', key: 'enabled' },
  { title: 'Actions', key: 'actions', sortable: false, align: 'end' },
]);

const emit = defineEmits(['updateInformation']);
const route = useRoute();
const { notify } = useNotification();

const data: Data = reactive({
  serverItems: [],
});

const loading = ref(false);
const itemsPerPage = ref(50);
const totalItems = ref(50);
const deleteConfirmationText = ref('');

const itemToDelete: Ref<Columns | null> = ref(null);
const deleteLoading = ref(false);
const dialogDelete = ref(false);

watch(dialogDelete, (value) => {
  if (!value) {
    itemToDelete.value = null;
  }
});

const deleteItem = (item: Columns) => {
  dialogDelete.value = true;
  itemToDelete.value = item;
}

const closeDialogDelete = () => {
  dialogDelete.value = false;
  itemToDelete.value = null;
}

const deleteItemConfirm = async (itemName?: string) => {
  try {
    if (deleteConfirmationText.value === itemName) {
      deleteLoading.value = true;
      const { error } = await supabase.from('variation').delete()
        .eq('id', itemToDelete?.value?.id);
      if (error) throw error;
      notify({
        type: 'success',
        title: 'Variant deleted successfully',
        duration: 6000,
      });
      data.serverItems = data.serverItems.filter((item) => item.id !== itemToDelete?.value?.id);
    } else {
      notify({
        title: 'Variation not deleted.',
        text: 'Confirmation text doesn\'t match product name.',
        type: 'info',
        duration: 6000,
      });
    }

  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error deleting variant.',
      text: e?.message || 'An error ocurred trying to delete variant. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    deleteLoading.value = false;
    dialogDelete.value = false;
    itemToDelete.value = null;
  }
}

/**
 *
 * Search
 *
 */
const search = ref('');
const searchFilter = ref('');

const onEnterSearch = () => {
  search.value = String(Date.now());
}

watch(searchFilter, (searchValue) => {
  if(!searchValue) {
    search.value = String(Date.now());
  }
});

const loadItems = async ({ page, itemsPerPage, sortBy }: TableOptions) => {
  try {
    loading.value = true;
    if (+route.params.id !== +(props.productId || 0) && !props.loadingData) {
      emit('updateInformation')
    }
    if (props.showChildProducts) {
      const { from, to } = usePagination(page - 1, itemsPerPage);
      const { data: variations, error, count } = await supabase
        .from('variation')
        .select('id, name, sku, enabled', { count: 'exact' })
        .eq(`parent_id`, +route.params.id)
        .order(sortBy?.[0]?.key || 'name', {
          ascending: sortBy?.[0]?.order === 'desc' ? false : true
        })
        .range(from, to);
      if (error) throw error;
      data.serverItems = variations || [];
      totalItems.value = count || 0;
    }
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error loading variants.',
      text: e?.message || 'An error ocurred trying to load variants. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    loading.value = false;
  }
}

</script>
