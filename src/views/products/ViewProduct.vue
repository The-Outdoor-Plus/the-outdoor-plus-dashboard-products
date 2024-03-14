<template>
  <div>
    <product-form
      :loading="loading"
      :product="product"
      :product-prices="prices"
      :product-attributes="productAttributes"
      :product-images="images"
      :product-spect-sheets="specificationSheets"
      :product-documents="documents"
      :attribute-values="attrValues"
      readonly
    ></product-form>
    <div class="tw-w-full tw-my-16 rounded">
      <v-data-table-server
        v-show="showChildProducts"
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
                Variant <strong>{{ itemToDelete?.name }}</strong> will be deleted.
                This action cannot be reversed. Are you sure you want to continue?
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue-darken-1" variant="text" @click="closeDialogDelete">Cancel</v-btn>
                <v-btn color="red-darken-1" variant="text" @click="deleteItemConfirm">Delete</v-btn>
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
            <v-btn
              size="small"
              icon="mdi-eye"
              variant="text"
              :to="`/products/${route.params.id}/variant/${item.raw.id}`"
            ></v-btn>
            <v-btn
              size="small"
              icon="mdi-pencil"
              variant="text"
              :to="`/products/${route.params.id}/variant/edit/${item.raw.id}`"
            ></v-btn>
            <v-btn
              size="small"
              @click="deleteItem((item.raw as Columns))"
              icon="mdi-delete"
              variant="text"
            ></v-btn>
          </div>
        </template>
      </v-data-table-server>
    </div>
  </div>
</template>
<script lang="ts" setup>
import ProductForm from '@/components/ProductForm.vue';
import { VDataTableServer } from 'vuetify/lib/labs/components.mjs';
import { useAppStore } from '@/store/app';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { onMounted, reactive, ref, Ref, watch, computed } from 'vue';
import { useRoute } from 'vue-router';
import { Attribute, Documents, Product } from '@/types/product';
import { usePagination } from '@/utils';
import { Image, SpecificationSheet, PriceData } from '@/types/product';
import { useProduct } from '@/composables/product';

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

const store = useAppStore();
const route = useRoute();
const { notify } = useNotification();

const loading = ref(false);
const isLoading = computed(() => loading.value && productLoading.value);
const loadingData = ref(false);
const product: Ref<Product> = ref<Product>({
  id: 0,
  name: '',
});

const showChildProducts = computed(() => {
  return product.value.product_type === 'VARIABLE';
});

const childTableTitle = computed(() => {
  return 'Child products (Variants)';
});

const newText = computed(() => {
  return 'New Variant';
});

const queryParams = computed(() => {
  const params: any = {
    ...(product.value.sku ? { sku: `${product.value.sku}-(XX)-(XX)` } : {}),
    ...(product.value.burner_shape ? { burner_shape: product.value.burner_shape }: {}),
    ...(product.value.compatible_bullet_burner ? { compatible_bullet_burner: product.value.compatible_bullet_burner } : {}),
    ...(product.value.compatible_canvas_cover ? { compatible_canvas_cover: product.value.compatible_canvas_cover } : {}),
    ...(product.value.compatible_glass_wind_guard ? { compatible_glass_wind_guard: product.value.compatible_glass_wind_guard } : {}),
    ...(product.value.product_serial_base ? { product_serial_base: product.value.product_serial_base } : {}),
    ...(product.value.name ? { name: product.value.name } : {}),
    ...(product.value.short_description ? { short_description: product.value.short_description } : {}),
    ...(product.value.description ? { description: product.value.description } : {}),
    ...(product.value.website_link ? { website_link: product.value.website_link } : {}),
    ...(product.value?.certifications?.length ? { certifications: JSON.stringify(product.value.certifications) }: {}),
    ...(prices.value ? { prices: JSON.stringify(prices.value) }: {}),
  };
  return new URLSearchParams(params).toString();
});

const redirectToNewProduct = computed(() => {
  return `/products/${product.value.id}/variant/new?${queryParams.value}`;
});

const loadData = async () => {
  try {
    loading.value = true;
    loadingData.value = true;
    const { data, error } = await supabase
      .from('product')
      .select()
      .eq('id', route.params.id);
    if (error) throw error;
    if (data.length) product.value = data[0];
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error retrieving product.',
      text: e?.message || 'An error ocurred trying to retrieve product. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    loading.value = false;
    loadingData.value = false;
  }
}

const {
  attrValues,
  productLoading,
  loadDocuments,
  loadProductImages,
  loadProductAttributes,
  loadProductPrices,
  loadSpecificationSheets
} = useProduct();

const prices: Ref<PriceData> = ref<PriceData>({
  map: [],
  dealer: [],
  distributor: [],
  group: [],
  internet: [],
  landscape: [],
  master_distributor: [],
  msrp: [],
});

const productAttributes: Ref<Attribute[]> = ref<Attribute[]>([]);
const images: Ref<Image[]> = ref<Image[]>([]);
const specificationSheets: Ref<SpecificationSheet[]> = ref<SpecificationSheet[]>([]);
const documents: Ref<Documents[]> = ref<Documents[]>([]);

const loadProductInformation = async () => {
  if (product.value?.id) {
    const productId = +product.value?.id;
    prices.value.msrp = await loadProductPrices('msrp', productId) || [];
    prices.value.internet = await loadProductPrices('internet', productId) || [];
    prices.value.map = await loadProductPrices('map', productId) || [];
    prices.value.group = await loadProductPrices('group', productId) || [];
    prices.value.dealer = await loadProductPrices('dealer', productId) || [];
    prices.value.distributor = await loadProductPrices('distributor', productId) || [];
    prices.value.landscape = await loadProductPrices('landscape', productId) || [];
    prices.value.master_distributor = await loadProductPrices('master_distributor', productId) || [];
    images.value = await loadProductImages(productId) || [];
    documents.value = await loadDocuments(productId) || [];
    specificationSheets.value = await loadSpecificationSheets(productId) || [];
    productAttributes.value = await loadProductAttributes(productId) || [];
  }
}


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
const data: Data = reactive({
  serverItems: [],
});
const itemsPerPage = ref(50);
const totalItems = ref(50);

/**
 *
 * Dialog Delete Section
 *
 **/

const itemToDelete: Ref<Columns | null> = ref(null);
const deleteLoading = ref(false);
const dialogDelete = ref(false);

watch(dialogDelete, (value) => {
  if (!value) {
    itemToDelete.value = null;
  }
});
watch(route, async () => {
  if (route.params.id) {
    await loadData();
    await loadProductInformation();
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

const deleteItemConfirm = async () => {
  try {
    deleteLoading.value = true;
    const { error } = await supabase.from('variant').delete()
      .eq('id', itemToDelete?.value?.id);
    if (error) throw error;
    notify({
      type: 'success',
      title: 'Variant deleted successfully',
      duration: 6000,
    });
    data.serverItems = data.serverItems.filter((item) => item.id !== itemToDelete?.value?.id);
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

onMounted(async () => {
  store.pageTitle = 'Product - View';
  await loadData();
  await loadProductInformation();
});

const loadItems = async ({ page, itemsPerPage, sortBy }: TableOptions) => {
  try {
    loading.value = true;
    if (+route.params.id !== +(product.value?.id || 0) && !loadingData.value) {
      await loadData();
      await loadProductInformation();
    }
    if (showChildProducts.value) {
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
