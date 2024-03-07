<template>
  <div class="tw-w-full">
    <v-card class="py-12 px-10" :loading="isLoading">
      <v-btn
        class="-tw-mt-6 tw-mb-6 -tw-ml-4"
        icon="mdi-arrow-left"
        flat
        @click="router.back()"
      ></v-btn>
      <form @submit.prevent="submit">
        <div class="tw-w-full">
          <h1 class="tw-text-base tw-font-semibold">{{ title }}</h1>
          <div class="tw-text-sm">{{ subtitle }}</div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div>
          <v-row>
            <v-col
              cols="12"
              sm="6"
              md="5"
              lg="3"
              xl="2"
            >
              <v-checbox
                v-model="enabled.value.value"
                color="green-darken-1"
                label="Enable Product"
                :readonly="readonly"
              >
              </v-checbox>
            </v-col>
          </v-row>
          <span class="tw-text-sm tw-text-gray-500"><b>Enable variation: </b>If checked, it means that the variation is enable for display on the dashboard and on the quick view pricing tool. This will allow dealers and sales to see the details about the product.</span>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Product/Variation Name</h3>
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
            ></v-text-field>
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
            ></v-text-field>
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
            ></v-text-field>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12 tw-pr-4">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Product Serial Base</h3>
            <span class="tw-text-sm tw-text-gray-500">This will define the starting text part of the serial. E.g: E1110-23</span>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-text-field
              v-model="productSerialBase.value.value"
              variant="outlined"
              density="compact"
              name="SerialBase"
              placeholder="Product Serial Base"
              :error-messages="productSerialBase.errorMessage.value"
              :readonly="readonly"
            ></v-text-field>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12 tw-pr-4">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Website Link</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-text-field
              v-model="websiteLink.value.value"
              variant="outlined"
              density="compact"
              name="WebsiteLink"
              placeholder="https://www.theoutdoorplus.com/product/..."
              :error-messages="websiteLink.errorMessage.value"
              :readonly="readonly"
            ></v-text-field>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Prices</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12">
            <template
              v-for="(priceType, key) in productStore.priceTypeList"
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
                  hide-details
                  :itesm="yearToShowList(priceType.key as keyof PriceData)"
                  :readonly="readonly"
                ></v-select>
                <v-select
                  v-model="price.price"
                  class="tw-w-7/12"
                  label="Price"
                  variant="outlined"
                  density="compact"
                  prefix="$"
                  hide-details
                  :readonly="readonly"
                ></v-select>
                <v-btn
                  v-if="!readonly"
                  size="small"
                  class="ml-2"
                  icon="mdi-close"
                  variant="text"
                  @click="removeYearFromList(priceType.key as keyof PriceData, price)"
                ></v-btn>
              </div>
              <v-btn
                v-if="yearToShowList(priceType.key as keyof PriceData).length && !readonly"
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
        <v-expansion-panels variant="accordion" class="tw-mb-6 tw-mt-4 tw-w-full">
          <v-expansion-panel elevation="0">
            <v-expansion-panel-title color="grey-lighten-4">Attributes</v-expansion-panel-title>
            <v-expansion-panel-text>
              <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row tw-mt-4">
                <div class="tw-w-full lg:tw-w-3/12">
                  <h3 class="tw-text-base tw-font-semibold tw-mt-1">Material</h3>
                  <span class="tw-text-sm tw-text-gray-500"></span>
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
                    :clearable="!readonly"
                    :items="itemsList.material"
                    :error-messages="materialId.errorMessage.value"
                    :loading="itemsLoading.materialLoading"
                    :readonly="readonly"
                    @click:clear="materialId.value.value = 0"
                  >
                  </v-autocomplete>
                </div>
              </div>
            </v-expansion-panel-text>
          </v-expansion-panel>
        </v-expansion-panels>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <v-expansion-panels variant="accordion" class="tw-mb-6 tw-mt-4 tw-w-full">
          <v-expansion-panel elevation="0">
            <v-expansion-panel-title color="grey-lighten-4">More Information</v-expansion-panel-title>
            <v-expansion-panel-text></v-expansion-panel-text>
          </v-expansion-panel>
        </v-expansion-panels>
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
import { useField, useForm } from 'vee-validate';
import { ref, onMounted, watch, computed } from 'vue';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { useRoute, useRouter } from 'vue-router';
import { useVariationStore } from '@/store/variation';
import { Ref } from 'vue';
import {
  Image,
  Price,
  PriceData,
} from '@/types/product';
import {
  Props, Variation
} from '@/types/variation';
import { readonly } from 'vue';

/**
 *
 * General Definitions
 *
 */

const router = useRouter();
const route = useRoute();
const variationStore = useVariationStore();
const isLoading = ref(false);
const { notify } = useNotification();

const props = withDefaults(defineProps<Props>(), {
  new: false,
  edit: false,
  readonly: false,
  variation: null,
  loading: false,
});

watch(
  () => props.loading,
  (value) => {
    isLoading.value = value;
  }
)

const title = computed(() => {
  if (props.new) return 'Create Variation';
  if (props.edit) return 'Edit Variation';
  if (props.readonly) return 'View Variation';
  return 'Variation Form';
});

const subtitle = computed(() => {
  if (props.new) return 'Fill out the information below to create a variation';
  if (props.edit) return 'Use the form below to edit the variation';
  if (props.readonly) return 'View Variation Information';
  return '';
});

onMounted(async () => {
  yearList.value = generateYearList(new Date().getFullYear());
});

/**
 *
 * Prices Definitions and Methods
 *
 */

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
 * Year Definitions and Methods
 *
 */

const yearList: Ref<number[]> = ref<number[]>([]);
const generateYearList = (currentYear: number): number[] => {
  const startYear = currentYear - 2;
  const endYear = currentYear + 1;
  const yearArray: number[] = [];

  for (let year = startYear; year <= endYear; year++) {
    yearArray.push(year);
  }

  return yearArray;
}

const yearToShowList = (priceType: keyof PriceData) => {
  const yearsToExclude = new Set(prices.value[priceType].map(item => item.year));
  return yearList.value.filter((year: number) => !yearsToExclude.has(year));
}

const removeYearFromList = (priceType: keyof PriceData, item: Price) => {
  prices.value[priceType] = prices.value[priceType].filter((priceItem) => priceItem.year !== item.year);
}

/**
 *
 * Images Definitions and Methods
 *
 */

const images: Ref<Image[]> = ref<Image[]>([]);

const addImage = () => {
  let imagesTemp: Image[] = JSON.parse(JSON.stringify(images.value));
  imagesTemp = imagesTemp.sort((a: Image, b: Image) => (a?.id || 0) - (b?.id || 0));
  const id = imagesTemp.length ? (imagesTemp[imagesTemp.length - 1]?.id || 0) + 1 : 0;
  const newImage: Image = {
    id,
    url: '',
    name: '',
    display_order: (images.value.length - 1) + 1,
  }
  images.value.push(newImage);
}

const removeImageFromList = (item: Image) => {
  images.value = images.value.filter((imageItem) => imageItem.id !== item.id);
}

/**
 *
 * Handle Form
 *
 */

const { handleSubmit, resetForm } = useForm({
  validationSchema: variationStore.formValidation,
  initialValues: variationStore.initialValues,
});

/**
 *
 * Declaring Form Fields
 *
 */

const enabled = useField<string>('enabled');
const name = useField<string>('name');
const sku = useField<string>('sku');
const upcCodes = useField<string>('upc_codes');
const encodedUpcCodes = useField<string>('encoded_upc_codes');
const shortDescription = useField<string>('short_description');
const description = useField<string>('description');
const productLength = useField<string>('product_length');
const productDiameter = useField<string>('product_diameter');
const productWidth = useField<string>('product_width');
const productHeight = useField<string>('product_height');
const baseLength = useField<string>('base_length');
const baseDiameter = useField<string>('base_diameter');
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
const productSerialBase = useField<string>('product_serial_base');
const websiteLink = useField<string>('website_link');

const certifications: Ref<string[]> = ref<string[]>([]);

/**
 *
 * Filter form for submission
 *
 */

const filterFormPayload = (form: Variation) => (
  Object.fromEntries(Object.entries(form).filter(([key, value]) => {
    return variationStore.variationKeys.includes(key);
  }))
);

/**
 *
 * Form Submission
 *
 */

const submit = handleSubmit(async (values) => {

});

</script>
