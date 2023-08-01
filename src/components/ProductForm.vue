<template>
  <div class="tw-w-full">
    <v-card class="py-12 px-10" :loading="isLoading">
      <v-btn
        class="-tw-mt-6 tw-mb-6 -tw-ml-4" 
        icon="mdi-arrow-left" 
        flat
        @click="$router.push('/products')"
      ></v-btn>
      <form @submit.prevent="submit">
        <div class="tw-w-full">
          <h1 class="tw-text-base tw-font-semibold">{{ title }}</h1>
          <div class="tw-text-sm">{{ subtitle }}</div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Product Name</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-text-field
              v-model="name.value.value"
              variant="outlined"
              density="compact"
              name="Name"
              placeholder="Name"
              :error-messages="name.errorMessage.value"
              :readonly="readonly"
            >
            </v-text-field>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">SKU</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-text-field
              v-model="sku.value.value"
              variant="outlined"
              density="compact"
              name="SKU"
              placeholder="SKU"
              :error-messages="sku.errorMessage.value"
              :readonly="readonly"
            >
            </v-text-field>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">UPC Codes</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-text-field
              v-model="upcCodes.value.value"
              variant="outlined"
              density="compact"
              name="UpcCode"
              placeholder="UPC Code"
              label="UPC Code"
              :error-messages="upcCodes.errorMessage.value"
              :readonly="readonly"
            >
            </v-text-field>
            <v-text-field
              v-model="encodedUpcCodes.value.value"
              variant="outlined"
              density="compact"
              name="EncodedUpcCode"
              placeholder="Encoded UPC Code"
              label="Encoded UPC Code"
              :error-messages="encodedUpcCodes.errorMessage.value"
              :readonly="readonly"
            >
            </v-text-field>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Prices</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12">
            <template 
              v-for="(priceType, key) in priceTypeList"
              :key="key"
            >
              <h3 class="tw-text-base tw-font-semibold">{{ priceType.value }} Price</h3>
              <div
                v-for="(price, i) in prices[(priceType.key as keyof PriceData)]"
                :key="i"
                class="tw-flex tw-items-center tw-w-full tw-mt-4 tw-mb-2"
              >
                <v-select
                  v-model="price.year"
                  class="tw-w-4/12 tw-mr-12"
                  label="Year"
                  variant="outlined"
                  density="compact"
                  :items="yearToShowList(priceType.key as keyof PriceData)"
                  hide-details
                >
                </v-select>
                <v-text-field
                  v-model="price.price"
                  class="tw-w-7/12"
                  label="Price"
                  variant="outlined"
                  density="compact"
                  prefix="$"
                  hide-details
                ></v-text-field>
                <v-btn
                  size="small"
                  class="ml-2"
                  icon="mdi-close"
                  variant="text"
                  @click="removeYearFromList(priceType.key as keyof PriceData, price)"
                ></v-btn>
              </div>
              <v-btn
                v-if="yearToShowList(priceType.key as keyof PriceData).length"
                color="teal-darken-2" 
                class="px-2 tw-mt-2 tw-mb-5"
                size="small"
                @click="addPrice(priceType.key as keyof PriceData)"
              >
                Add Price
                <v-icon icon="mdi-plus" class="ml-2"></v-icon>
              </v-btn>
            </template> 
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Collection</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-autocomplete
              v-model="collectionId.value.value"
              variant="outlined"
              density="compact"
              name="Collection"
              placeholder="Collection"
              item-title="name"
              item-value="id"
              clearable
              :items="itemsList.collection"
              :error-messages="collectionId.errorMessage.value"
              :readonly="readonly"
            >
            </v-autocomplete>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Category</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-autocomplete
              v-model="categoryId.value.value"
              variant="outlined"
              density="compact"
              name="Category"
              placeholder="Category"
              item-title="name"
              item-value="id"
              clearable
              :items="itemsList.category"
              :error-messages="categoryId.errorMessage.value"
              :readonly="readonly"
            >
            </v-autocomplete>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Shape</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-autocomplete
              v-model="shapeId.value.value"
              variant="outlined"
              density="compact"
              name="Shape"
              placeholder="Shape"
              item-title="name"
              item-value="id"
              clearable
              :items="itemsList.shape"
              :error-messages="shapeId.errorMessage.value"
              :readonly="readonly"
            >
            </v-autocomplete>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Material</h3>
            <span class="tw-text-sm tw-text-gray-500">If Base Material is selected, this becomes the material of the top.</span>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-autocomplete
              v-model="materialId.value.value"
              variant="outlined"
              density="compact"
              name="Material"
              placeholder="Material"
              item-title="name"
              item-value="id"
              clearable
              :items="itemsList.material"
              :error-messages="materialId.errorMessage.value"
              :readonly="readonly"
            >
            </v-autocomplete>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Base Material</h3>
            <span class="tw-text-sm tw-text-gray-500">If applicable.</span>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-autocomplete
              v-model="materialId.value.value"
              variant="outlined"
              density="compact"
              name="Material"
              placeholder="Material"
              item-title="name"
              item-value="id"
              clearable
              :items="itemsList.material"
              :error-messages="materialId.errorMessage.value"
              :readonly="readonly"
            >
            </v-autocomplete>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Colors</h3>
            <span class="tw-text-sm tw-text-gray-500"></span>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-autocomplete
              v-model="colors"
              variant="outlined"
              density="compact"
              name="Colors"
              placeholder="Colors"
              item-title="name"
              item-value="id"
              clearable
              :multiple="isParent"
              :chips="isParent"
              :items="itemsList.material"
              :error-messages="colorId.errorMessage.value"
              :readonly="readonly"
            >
            </v-autocomplete>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-mb-6 tw-mt-1"></v-divider>
        <div class="tw-w-full">
          <v-spacer></v-spacer>
          <v-btn
            v-if="!readonly"  
            type="submit"
            color="primary"
          >Submit</v-btn>
        </div>
      </form>
    </v-card>
  </div>
</template>
<script lang="ts" setup>
import * as yup from 'yup';
import { toTypedSchema } from '@vee-validate/yup';
import { useField, useForm } from 'vee-validate';
import { ref, onMounted, watch, computed } from 'vue';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { useRoute, useRouter } from 'vue-router';
import { Ref } from 'vue';

/**
 * 
 * Defining Interfaces
 * 
 */
interface Shape {
  id?: number;
  name: string;
}

interface Material {
  id?: number;
  name: string;
}

interface IgnitionType {
  id?: number;
  name: string;
}

interface GasType {
  id?: number;
  name: string;
}

interface Color {
  id?: number;
  name: string;
}

interface Collection {
  id?: number;
  name: string;
}

interface Category {
  id?: number;
  name: string;
}

interface ItemsList {
  category: Category[];
  collection: Collection[];
  color: Color[];
  gas: GasType[];
  ignition: IgnitionType[];
  material: Material[];
  shape: Shape[];
}

interface Price {
  id?: number;
  product_id?: number;
  price?: number;
  year?: number;
}

interface PriceData {
  msrp: Price[];
  map: Price[];
  internet: Price[];
  group: Price[];
  dealer: Price[];
  distributor: Price[];
  landscape: Price[];
  master_distributor: Price[];
}

interface ProductImage {
  product_id?: number;
  image_id?: number;
  display_order?: number;
  is_primary?: boolean;
  url?: string;
  name?: string;
}

interface Product {
  id?: number;
  sku?: string
  upc_codes?: string;
  encoded_upc_codes?: string;
  relation: string;
  product_length?: string;
  product_diameter?: string;
  product_width?: string;
  product_height?: string;
  base_length?: string;
  base_diameter?: string;
  base_width?: string;
  base_opening?: string;
  toe_kick?: string;
  soil_usage?: string;
  scupper_width?: string;
  scupper_inlet_opening?: string;
  gpm?: string;
  fire_glass?: string;
  ba_length?: string;
  ba_diameter?: string;
  ba_width?: string;
  ba_depth?: string;
  burner_shape?: string;
  burner_length?: string;
  burner_diameter?: string;
  compatible_canvas_cover?: string;
  compatible_bullet_burner?: string;
  compatible_glass_wind_guard?: string;
  access_door?: boolean;
  parent_id?: number;
  collection_id?: number;
  category_id?: number;
  shape_id?: number;
  material_id?: number;
  color_id?: number;
  ignition_id?: number;
  gas_id?: number;
  product_serial_base?: string;
  certifications?: string[];
  base_color_id?: number;
  base_material_id?: number;
  published?: boolean;
  enabled?: boolean;
  created_by?: string;
  updated_by?: string;
  company_division?: string;
  updated_at?: string;
  created_at?: string;
  name?: string;
  short_description?: string;
  description?: string;
  dealer_prices?: Price[];
  distributor_prices?: Price[];
  group_prices?: Price[];
  internet_prices?: Price[];
  landscape_prices?: Price[];
  map_prices?: Price[];
  master_distributor_prices?: Price[];
  msrp_prices?: Price[];
  images?: ProductImage[];
}

interface Props {
  new?: boolean;
  edit?: boolean;
  readonly?: boolean;
  product?: Product | null;
  loading?: boolean;
}

/**
 * 
 * General Definitions
 * 
 */

 const router = useRouter();
 const route = useRoute();
 const isLoading = ref(false);
 const { notify } = useNotification();

 const props = withDefaults(defineProps<Props>(), {
  new: false,
  edit: false,
  readonly: false,
  product: null,
  loading: false,
 });
watch(
  () => props.loading,
  (value) => {
    isLoading.value = value;
  }
);

const isParent = computed(() => {
  if (!route.params.parent_id) return true
  if (route.params.relation_type === 'parent') return true
  return false;
});

const title = computed(() => {
  if (props.new) return 'Create Product';
  if (props.edit) return 'Edit Product';
  if (props.readonly) return 'View Product'; 
  return 'Product Form';
});

const subtitle = computed(() => {
  if (props.new) return 'Fill out the information below to create a product';
  if (props.edit) return 'Use the form below to edit the product';
  if (props.readonly) return 'View Product Information';
  return '';
});

const itemsList: Ref<ItemsList> = ref<ItemsList>({
  category: [],
  collection: [],
  color: [],
  gas: [],
  ignition: [],
  material: [],
  shape: [],
});
const loadItemsList = async (itemType: keyof ItemsList) => {
  try {
    isLoading.value = true;
    const { data, error } = await supabase
      .from(itemType)
      .select('id, name');
    if (error) throw error;
    itemsList.value[itemType] = data;
  } catch (e: any) {
    console.error(e);
    notify({
      title: `Error loading ${itemType} list`,
      text: e?.message || `An error occurred trying to load ${itemType} list. Please contact TOP Support.`,
      type: 'error',
      duration: 6000,
    }); 
  } finally {
    isLoading.value = false;
  }
}

const yearList: Ref<number[]> = ref<number[]>([]);
const generateYearList = (currentYear: number): number[] => {
  const startYear = 2015;
  const endYear = currentYear + 1;
  const yearArray: number[] = [];

  for (let year = startYear; year <= endYear; year++) {
    yearArray.push(year);
  }

  return yearArray;
}
  
const priceTypeList = ref([
  { value: 'Internet', key: 'internet' },
  { value: 'MAP', key: 'map' }, 
  { value: 'MSRP', key: 'msrp' },
  { value: 'Group', key: 'group' },
  { value: 'Dealer', key: 'dealer' }, 
  { value: 'Distributor', key: 'distributor' }, 
  { value: 'Landscape', key: 'landscape' }, 
  { value: 'Master Distributor', key: 'master_distributor' },
]);

const yearToShowList = (priceType: keyof PriceData) => {
  const yearsToExclude = new Set(prices.value[priceType].map(item => item.year));
  return yearList.value.filter((year: number) => !yearsToExclude.has(year));
};

const removeYearFromList = (priceType: keyof PriceData, item: Price) => {
  prices.value[priceType] = prices.value[priceType].filter((priceItem) => priceItem.year !== item.year);
}

onMounted(async () => {
  await loadItemsList('category');
  await loadItemsList('collection');
  await loadItemsList('color');
  // await loadItemsList('gas');
  // await loadItemsList('ignition');
  await loadItemsList('material');
  await loadItemsList('shape');

  yearList.value = generateYearList(new Date().getFullYear());
});

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

const addPrice = (priceType: keyof PriceData) => {
  const lastElement = yearToShowList(priceType)?.slice(-1)?.[0] || new Date().getFullYear();
  const newPrice = { year: lastElement, price: 0 };
  prices.value[priceType].push(newPrice);
}

/**
 * 
 * Slug definitions
 * 
 */


/**
 * Grabbed from https://byby.dev/js-slugify-string
 */
const slugify = (str: string) => (
  String(str)
    .normalize('NFKD') // split accented characters into their base characters and diacritical marks
    .replace(/[\u0300-\u036f]/g, '') // remove all the accents, which happen to be all in the \u03xx UNICODE block.
    .trim() // trim leading or trailing whitespace
    .toLowerCase() // convert to lowercase
    .replace(/[^a-z0-9 -]/g, '') // remove non-alphanumeric characters
    .replace(/\s+/g, '-') // replace spaces with hyphens
    .replace(/-+/g, '-') // remove consecutive hyphens
)

const slugPlaceholder = computed(() => slugify(name.value.value))

/**
 * 
 * Handle Form
 * 
 */

const { handleSubmit } = useForm({
  validationSchema: toTypedSchema(
    yup.object({
      name: yup.string().min(2).required(),
      sku: yup.string().min(2),
      upc_codes: yup.string(),
      encoded_upc_codes: yup.string(),
      relation: yup.string().required(),
      product_length: yup.string(),
      product_diameter: yup.string(),
      product_width: yup.string(),
      product_height: yup.string(),
      base_length: yup.string(),
      base_diameter: yup.string(),
      base_width: yup.string(),
      base_opening: yup.string(),
      toe_kick: yup.string(),
      soil_usage: yup.string(),
      scupper_width: yup.string(),
      scupper_inlet_opening: yup.string(),
      gpm: yup.string(),
      fire_glass: yup.string(),
      ba_length: yup.string(),
      ba_diameter: yup.string(),
      ba_width: yup.string(),
      ba_depth: yup.string(),
      burner_shape: yup.string(),
      burner_length: yup.string(),
      burner_diameter: yup.string(),
      compatible_canvas_cover: yup.string(),
      compatible_bullet_burner: yup.string(),
      compatible_glass_wind_guard: yup.string(),
      access_door: yup.boolean(),
      parent_id: yup.number(),
      collection_id: yup.number().nullable(),
      category_id: yup.number().nullable(),
      shape_id: yup.number().nullable(),
      material_id: yup.number().nullable(),
      color_id: yup.number().nullable(),
      ignition_id: yup.number().nullable(),
      gas_id: yup.number().nullable(),
      product_serial_base: yup.string(),
      certifications: yup.array(),
      base_color_id: yup.number(),
      base_material_id: yup.number(),
      published: yup.boolean(),
      enabled: yup.boolean(),
      created_by: yup.string(),
      company_division: yup.string(),
      short_description: yup.string(),
      description: yup.string(),
    })
  ),
});

const name = useField<string>('name');
const sku = useField<string>('sku');
const upcCodes = useField<string>('upc_codes');
const encodedUpcCodes = useField<string>('encoded_upc_codes');
const relation = useField<string>('relation');
const productLength = useField<string>('product_length');
const productDiameter = useField<string>('product_diameter');
const productWidth = useField<string>('product_width');
const productHeight = useField<string>('product_height');
const baseLength = useField<string>('base_length');
const baseDiiameter = useField<string>('base_diameter');
const baseWidth = useField<string>('base_width');
const baseOpening = useField<string>('base_opening');
const toeKick = useField<string>('toe_kick');
const soilUsage = useField<string>('soil_usage');
const scupperWidth = useField<string>('scupper_width');
const scupperInletOpening = useField<string>('scupper_inlet_opening');
const gpm = useField<string>('gpm');
const fireGlass = useField<string>('fire_glass');
const baLength = useField<string>('ba_length');
const baDiameter = useField<string>('ba_diameter');
const baWidth = useField<string>('ba_width');
const baDepth = useField<string>('ba_depth');
const burnerShape = useField<string>('burner_shape');
const burnerLength = useField<string>('burner_length');
const burnerDiameter = useField<string>('burner_diameter');
const compatibleCanvasCover = useField<string>('compatible_canvas_cover');
const compatibleBulletBurner = useField<string>('compatible_bullet_burner');
const compatibleGlassWindGuard = useField<string>('compatible_glass_wind_guard');
const accessDoor = useField<boolean>('access_door');
const parentId = useField<number>('parent_id');
const collectionId = useField<number>('collection_id');
const categoryId = useField<number>('category_id');
const shapeId = useField<number>('shape_id');
const materialId = useField<number>('material_id');
const colorId = useField<number>('color_id');
const colors = ref([]);
const ignitionId = useField<number>('ignition_id');
const gasId = useField<number>('gas_id');
const productSerialBase = useField<string>('product_serial_base');
const certifications = useField<string[]>('certifications');
const baseColorId = useField<number>('base_color_id');
const baseMaterialId = useField<number>('base_material_id');
const published = useField<boolean>('published');
const enabled = useField<boolean>('enabled');
const createdBy = useField<string>('created_by');
const companyDivision = useField<string>('company_division');
const shortDescription = useField<string>('short_description');
const description = useField<string>('description');

const fillProductInformation = () => {
  if (props.edit || props.readonly) {
    name.value.value = props.product?.name || '';
  }
}
onMounted(() => {
  fillProductInformation();
});
watch(
  () => props.product,
  () => {
    fillProductInformation();
  },
  { deep: true }
);

/**
 * 
 * Handle Data
 * 
 */

const handleCreate = async (values: Product) => {
  try {
    isLoading.value = true;
    const form = JSON.parse(JSON.stringify(values));
    const { data: product , error } = await supabase
      .from('product')
      .insert(form)
      .select();
    if (error) throw error;
    if (product.length) router.push(`/products/${product[0].id}`);
    notify({
      title: 'Product created successfully',
      type: 'success',
      duration: 6000,
    });
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error creating product',
      text: e?.message || 'An error occurred trying to create a product. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const handleUpdate = async (values: Product) => {
  try {
    isLoading.value = true;
    const form = JSON.parse(JSON.stringify(values));
    const { data: product, error } = await supabase
      .from('product')
      .update(form)
      .eq('id', props?.product?.id || 0)
      .select();
    if (error) throw error;
    if(product.length) {
      name.value.value = product[0].name;
    }
    notify({
      title: 'Product updated successfully',
      type: 'success',
      duration: 6000,
    });
  } catch (e: any) {
    console.error(e);
    
    notify({
      title: 'Error updating product',
      text: e?.message || 'An error ocurred trying to update the product. Please contact TOP support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const submit = handleSubmit(async (values) => {
  if (props.new) {
    await handleCreate(values);
  } else if (props.edit) {
    await handleUpdate(values);
  }
})

</script>