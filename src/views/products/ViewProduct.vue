<template>
  <div>
    <product-form
      :loading="loading"
      :product="product"
      readonly
      :product-prices="prices"
      :product-attributes="productAttrs"
      :product-images="images"
      :product-spect-sheets="specificationSheets"
    ></product-form>
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
        item-value="first_name"
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
              :to="`/products/${item.raw.id}`"
            ></v-btn>
            <v-btn
              size="small"
              icon="mdi-pencil"
              variant="text"
              :to="`/products/edit/${item.raw.id}`"
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
import { Product } from '@/types/product';
import { usePagination } from '@/utils';
import { Image, SpecificationSheet, PriceData } from '@/types/product';

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
const product: Ref<Product> = ref<Product>({
  id: 0,
  name: '',
});

const showChildProducts = computed(() => {
  return product.value.relation === 'PARENT' || product.value.relation === 'PARENT_GROUP';
});

const childTableTitle = computed(() => {
  if (product.value.relation === 'PARENT') {
    return 'Parent Groups';
  }
  return 'Child products (Variants)';
});

const newText = computed(() => {
  if (product.value.relation === 'PARENT') {
    return 'New Parent Group';
  }
  return 'New Variant';
});

const queryParams = computed(() => {
  const params: any = {
    ...(product.value.company_division ? { division: product.value.company_division } : {}),
    ...(product.value.collection_id ? { collection: product.value.collection_id } : {}),
    ...(product.value.category_id ? { category: product.value.category_id } : {}),
    ...(product.value.shape_id ? { shape: product.value.shape_id } : {}),
    ...(product.value.material_id ? { material: product.value.material_id } : {}),
    ...(product.value.base_material_id ? { base_material: product.value.base_material_id } : {}),
    ...(product.value.color_id ? { color: product.value.color_id } : {}),
    ...(product.value.base_color_id ? { base_material: product.value.base_color_id } : {}),
    ...(product.value.product_diameter ? { product_diameter: JSON.stringify(product.value.product_diameter?.split(',') || []) } : {}),
    ...(product.value.product_length ? { product_length: JSON.stringify(product.value.product_length?.split(',') || []) } : {}),
    ...(prices.value ? { prices: JSON.stringify(prices.value) }: {}),
    ...({ attributes: JSON.stringify(productAttrs) }),
  };
  // return Object.keys(params).map(key => key + '=' + params[key]).join('&');
  return new URLSearchParams(params).toString();
});

const redirectToNewProduct = computed(() => {
  if (product.value.relation === 'PARENT_GROUP') {
    return `/products/new?parent_id=${route.params.id}&relation_type=child&${queryParams.value}`;
  }
  return `/products/new?parent_id=${route.params.id}&relation_type=parent_group&${queryParams.value}`;
});

const loadData = async () => {
  try {
    loading.value = true;
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
  }
}

const loadProductPrices = async (type: string, product_id: number) => {
  try {
    loading.value = true;
    const { data: price, error } = await supabase.from(`${type}_price`)
      .select('price, year')
      .eq(`product_id`, product_id);

    if (error) throw error;
    return price;
  } catch (e: any) {
    notify({
      title: `Error loading prices.`,
      text: e?.message || `An error occurred trying to load prices. Please contact TOP Support.`,
      type: 'error',
      duration: 6000,
    }); 
  } finally {
    loading.value = false;
  }
}

const loadProductAttributes = async (attr_type: string, product_id: number, color_type?: string) => {
  try {
    loading.value = true;
    let query = supabase.from(`product_${attr_type}`)
      .select(`${attr_type}_id`)
      .eq(`product_id`, product_id)
    if (color_type) query = query.eq(`type`, color_type);
    const { data: attribute, error } = await query;
    if (error) throw error;
    return attribute.map((item) => +(item?.[`${attr_type}_id` as any]) as number);
  } catch(e: any) {
    notify({
      title: `Error loading ${attr_type} attribute.`,
      text: e?.message || `An error occurred trying to load ${attr_type} attribute. Please contact TOP Support.`,
      type: 'error',
      duration: 6000,
    }); 
  } finally {
    loading.value = false;
  }
}

const loadProductImages = async (product_id: number) => {
  try {
    loading.value = true;
    const { data: images, error } = await supabase.from(`product_image`)
      .select(`product_id, image:image_id(id, name, url), display_order, is_primary`)
      .eq(`product_id`, product_id)
    if (error) throw error;
    console.log(images);
    return images.map((item) => ({
      id: item.image?.length ? 
        item.image[0].id :
        (item.image as Image).id,
      name: item.image?.length ?
        item.image[0].name :
        (item.image as Image).name,
      url: item.image?.length ?
        item.image[0].url :
        (item.image as Image).url,
      display_order: item.display_order,
      is_primary: item.is_primary,
    }));
  } catch(e: any) {
    notify({
      title: `Error loading image`,
      text: e?.message || `An error occurred trying to load an image. Please contact TOP Support.`,
      type: 'error',
      duration: 6000,
    }); 
  } finally {
    loading.value = false;
  }
}

const loadSpecificationSheets = async (product_id: number) => {
  try {
    loading.value = true;
    const { data: specSheets, error } = await supabase.from(`product_specification_sheet`)
      .select(`product_id, specification_sheet:specification_sheet_id(id, name, url)`)
      .eq(`product_id`, product_id)
    if (error) throw error;
    console.log(specSheets);
    return specSheets.map((item) => ({
      id: item.specification_sheet?.length ?
        item.specification_sheet[0].id :
        (item.specification_sheet as SpecificationSheet).id,
      name: item.specification_sheet?.length ?
        item.specification_sheet[0].name :
        (item.specification_sheet as SpecificationSheet).name,
      url: item.specification_sheet?.length ?
        item.specification_sheet[0].url :
        (item.specification_sheet as SpecificationSheet).url,
    }));
  } catch(e: any) {
    notify({
      title: `Error loading specification sheets`,
      text: e?.message || `An error occurred trying to load specification sheets. Please contact TOP Support.`,
      type: 'error',
      duration: 6000,
    }); 
  } finally {
    loading.value = false;
  }
}

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

const productAttrs: {
  colors: Ref<number[] | number>
  baseColors: Ref<number[] | number>
  ignitionTypes: Ref<number[] | number>
  gasTypes: Ref<number[] | number>
} = {
  colors: ref<number[] | number>([]),
  baseColors: ref<number[] | number>([]),
  ignitionTypes: ref<number[] | number>([]),
  gasTypes: ref<number[] | number>([]),
}

const images: Ref<Image[]> = ref<Image[]>([]);
const specificationSheets: Ref<SpecificationSheet[]> = ref<SpecificationSheet[]>([]);

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
    if (product.value.relation === 'PARENT' || product.value.relation === 'PARENT_GROUP') {
      productAttrs.colors.value = await loadProductAttributes('color', productId, 'default') || [];
      productAttrs.baseColors.value = await loadProductAttributes('color', productId, 'base') || [];
      productAttrs.gasTypes.value = await loadProductAttributes('gas', productId) || [];
      productAttrs.ignitionTypes.value = await loadProductAttributes('ignition', productId) || [];
      images.value = await loadProductImages(productId) || [];
      specificationSheets.value = await loadSpecificationSheets(productId) || [];
    }
  }
}


const headers = ref([
  {
    title: 'ID',
    align: 'start',
    sortable: false,
    key: 'id',
  },
  { title: 'Name', align: 'end', key: 'name', width: '250px' },
  { title: 'SKU', align: 'end', key: 'sku', width: '300px' },
  { title: 'Collection', align: 'end', key: 'collection', width: '150px' },
  { title: 'Category', align: 'end', key: 'category', width: '220px' },
  { title: 'Material', align: 'end', key: 'material', width: '220px' },
  { title: 'Published', align: 'end', key: 'published' },
  { title: 'Enabled', align: 'end', key: 'enabled' },
  { title: 'Actions', key: 'actions', sortable: false, align: 'end' },
]);
const data: Data = reactive({
  serverItems: [],
});
const itemsPerPage = ref(40);
const totalItems = ref(40);

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
watch(route, async (value) => {
  if (route.params.id)
    await loadData();
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
    const { error } = await supabase.from('product').delete()
      .eq('id', itemToDelete?.value?.id);
    if (error) throw error;
    notify({
      type: 'success',
      title: 'Product deleted successfully',
      duration: 6000,
    });
    data.serverItems = data.serverItems.filter((item) => item.id !== itemToDelete?.value?.id);
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error deleting product.',
      text: e?.message || 'An error ocurred trying to delete product. Please contact TOP Support.',
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
    const { from, to } = usePagination(page -1, itemsPerPage);
    const { data: products, error, count } = await supabase
      .from('product')
      .select('id, name, sku, relation, enabled, published, collection(name), category(name), material:material_id(name)', { count: 'exact' })
      .eq(`relation`, 'CHILD')
      .eq(`parent_id`, +route.params.id)
      .order(sortBy?.[0]?.key || 'name', {
        ascending: sortBy?.[0]?.order === 'desc' ? false : true
      })
      .range(from, to);
    if (error) throw error;
    const transformedProducts = products.map(product => ({
      ...product,
      category: (product.category as any)?.name || '', 
      material: (product.material as any)?.name || '',
      collection: (product.collection as any)?.name || '',
    }));  
    data.serverItems = transformedProducts || [];
    totalItems.value = count || 0;
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