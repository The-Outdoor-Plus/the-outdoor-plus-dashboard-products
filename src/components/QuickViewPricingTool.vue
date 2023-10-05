<template>
  <div>
    <div class="tw-w-full tw-text-center">
      <h1 class="tw-text-4xl tw-font-bold">Quick View Pricing Tool</h1>
      <span class="tw-text-lg">Enter SKU in the search bar below</span>
    </div>

    <div class="tw-w-full tw-mt-8">
      <v-text-field
        v-model="skuSearch"
        variant="solo"
        @keyup.enter="onEnterSearch"
      ></v-text-field>
    </div>
    <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row tw-mt-10">
      <div class="tw-w-full lg:tw-w-7/12">
        <div v-if="product && product.id && userIsAdmin" class="tw-w-full tw-flex">
          <v-spacer></v-spacer>
          <v-menu>
            <template v-slot:activator="{ props }">
              <v-btn
                color="white"
                v-bind="props"
                class="tw-mb-5"
              >
                Year: {{ currentYear }}
                <v-icon class="tw-ml-2" icon="mdi-filter-variant"></v-icon>
              </v-btn>
            </template>
            <v-list>
              <v-list-item
                v-for="(item, index) in availableYears"
                :key="index"
                :value="index"
              >
                <v-list-item-title @click="currentYear = item">{{ item }}</v-list-item-title>
              </v-list-item>
            </v-list>
          </v-menu>
        </div>
        <v-card
          v-if="product && product.id"
          class="py-6 px-8 tw-text-base"
        >
          <h2 class="tw-font-bold tw-text-3xl tw-text-center">{{ product.name }}</h2>
          <div class="tw-text-lg tw-text-center">
            <span class="tw-font-semibold">Part #: </span><span class="tw-text-blue-600">{{ product.sku }}</span>
          </div>
          <div class="tw-w-full tw-flex tw-flex-row tw-flex-wrap tw-mt-4 tw-justify-center">
            <template
              v-for="(priceType, i) in allowedPrices"
              :key="i"
            >
              <div
                v-if="getPriceByYear(priceType as keyof PriceData, currentYear)"
                class="tw-min-w-[50%] tw-px-4 tw-mb-4 tw-text-2xl tw-flex-grow"
              >
              <span class="tw-uppercase tw-font-bold">{{ priceType }} </span> <span class="tw-font-bold">Price:</span>
              {{ formatPrice(getPriceByYear(priceType as keyof PriceData, currentYear)) }}
            </div>
            </template>

          </div>
          <div class="tw-flex tw-w-full tw-flex-col lg:tw-flex-row tw-mt-8 tw-text-lg">
            <div class="tw-w-6/12 tw-px-4">
              <!-- Material -->
              <div v-if="product?.material?.name" class="mb-4">
                <span class="tw-font-semibold">Material: </span>
                <span>{{ product.material.name }}</span>
              </div>
              <!-- Ignition -->
              <div v-if="product?.gas?.name" class="mb-4">
                <span class="tw-font-semibold">Gas Type: </span>
                <span>{{ product.gas.name }}</span>
              </div>
              <!-- Collection -->
              <div v-if="product?.color?.name" class="mb-4">
                <span class="tw-font-semibold">Color: </span>
                <span>{{ product.color.name }}</span>
              </div>
              <!-- Collection -->
              <div v-if="product?.collection?.name" class="mb-4">
                <span class="tw-font-semibold">Collection: </span>
                <span>{{ product.collection.name }}</span>
              </div>
              <!-- Shape -->
              <div v-if="product?.shape?.name" class="mb-4">
                <span class="tw-font-semibold">Shape: </span>
                <span>{{ product.shape.name }}</span>
              </div>
            </div>
            <div class="tw-w-6/12 tw-px-4">
              <!-- Ignition -->
              <div v-if="product?.ignition?.name" class="mb-4">
                <span class="tw-font-semibold">Ignition Type: </span>
                <span>{{ product.ignition.name }}</span>
              </div>
              <!-- Size -->
              <div v-if="product?.product_length" class="mb-4">
                <span class="tw-font-semibold">Size (Length): </span>
                <span>{{ product.product_length }}</span>
              </div>
              <div v-else-if="product?.product_diameter" class="mb-4">
                <span class="tw-font-semibold">Size (Diameter): </span>
                <span>{{ product.product_diameter }}</span>
              </div>
              <!-- Width -->
              <div v-if="product?.product_width" class="mb-4">
                <span class="tw-font-semibold">Width: </span>
                <span>{{ product.product_width }}</span>
              </div>
              <!-- Width -->
              <div v-if="product?.product_height" class="mb-4">
                <span class="tw-font-semibold">Height: </span>
                <span>{{ product.product_height }}</span>
              </div>
              <!-- Company Division -->
              <div v-if="product?.company_division && (userStore.user?.user_metadata.role === 'ADMIN' || userStore.user?.user_metadata.role === 'MANAGER')" class="mb-4">
                <span class="tw-font-semibold">Division: </span>
                <span>{{ product.company_division }}</span>
              </div>
            </div>
          </div>
        </v-card>
      </div>
      <div class="tw-w-full lg:tw-w-5/12 lg:tw-pl-10">
        <v-skeleton-loader v-if="isLoading" type="image" class="mb-6 tw-h-96">
        </v-skeleton-loader>
        <template v-else>
          <v-card
            v-if="product && allImages.length"
            max-height="400"
          >
            <v-carousel
              hide-delimiter-background
              class="tw-max-h-[400px]"
            >
              <v-carousel-item
                v-for="(img, i) in allImages"
                :key="i"
                :src="img.previewUrl"
                :lazy-src="img.previewUrl"
                max-height="400"
              ></v-carousel-item>
            </v-carousel>
          </v-card>
        </template>
        <template v-if="isLoading">
          <v-skeleton-loader v-for="i in 3" :key="i" type="list-item-avatar" class="mt-4">
          </v-skeleton-loader>
        </template>
        <template v-else>
          <template v-if="!!(product && product.id && allSpecSheets.length)">
            <h3 class="tw-text-xl tw-font-bold tw-my-8">Specification Sheets:</h3>
            <div class="tw-w-full">
              <v-card
                v-for="(specSheet, i) in allSpecSheets"
                :key="i"
                class="px-4 py-2"
              >
                <div class="tw-w-full tw-flex tw-items-center">
                  <v-avatar color="blue-darken-2" size="36" class="tw-mr-3">
                    <v-icon color="white" size="small" icon="mdi-file-document-multiple"></v-icon>
                  </v-avatar>
                  <a
                    class="hover:tw-underline hover:tw-cursor-pointer tw-transition-all tw-font-medium"
                    rel="noopener noreferrer"
                    :href="specSheet.previewUrl"
                    target="_blank"
                  >{{ specSheet.name }}</a>
                  <v-spacer></v-spacer>
                  <v-btn
                    variant="text"
                    icon="mdi-open-in-new"
                    color="gray-darken-2"
                    tag="a"
                    target="_blank"
                    :href="specSheet.previewUrl"
                  ></v-btn>
                  <v-btn
                    variant="text"
                    icon="mdi-download"
                    color="gray-darken-2"
                    tag="a"
                    :href="specSheet.url"
                  ></v-btn>
                </div>
              </v-card>
            </div>
          </template>
        </template>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { supabase } from '@/supabase';
import { ref, computed, watch, Ref } from 'vue';
import { Product as BaseProduct, Image, PriceData } from '@/types/product';
import { VSkeletonLoader } from 'vuetify/lib/labs/components.mjs';
import { useNotification } from '@kyvg/vue3-notification';
import { useUserStore } from '@/store/user';
import { useProductStore } from '@/store/product';
import { onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';

interface Product extends BaseProduct {
  base_color?: {
    name: string;
  };
  base_material?: {
    name: string;
  };
  category?: {
    name: string;
  };
  collection?: {
    name: string;
  };
  color?: {
    name: string;
  };
  gas?: {
    name: string;
  };
  ignition?: {
    name: string;
  };
  material?: {
    name: string;
  };
  shape?: {
    name: string;
  }
}

interface SpecSheet {
  specification_sheet?: {
    id?: number;
    name?: string;
    url?: string;
  };
  name?: string;
  url?: string;
  previewUrl?: string;
}

interface Img extends Image {
  image?: {
    name?: string;
    url?: string;
  };
  previewUrl?: string;
}

const { notify } = useNotification();
const userStore = useUserStore();
const productStore = useProductStore();
const route = useRoute();
const router = useRouter();

const skuSearch = ref('');
const isLoading = ref(false);
const product: Ref<Product | undefined> = ref<Product | undefined>({});
const images: Ref<Img[]> = ref<Img[]>([]);
const parentImages: Ref<Img[]> = ref<Img[]>([]);
const specSheets: Ref<SpecSheet[]> = ref<SpecSheet[]>([]);
const parentSpecSheets: Ref<SpecSheet[]> = ref<SpecSheet[]>([]);
const allowedPrices: Ref<string[]> = ref<string[]>([]);
const currentYear = ref(0);
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

const userIsAdmin = computed(() => {
  const adminRoles = ['MANAGER', 'ADMIN'];
  if (adminRoles.includes(userStore.currentUser?.user_metadata?.role))
    return true
  return false;
});

onMounted(async () => {
  console.log(route.query.sku);
  if (route.query.sku) {
    skuSearch.value = String(route.query.sku);
    await loadProductInformation();
  }
})

const formatPrice = (price: number | null) => {
  if (!price)
    return 'No Price Available';
  return new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
  }).format(price);
}

const getPriceByYear = (priceType: keyof PriceData, year: number) => {
  const item = prices.value[priceType].find((price) => price.year === year);
  return item?.price || null;
}

const allImages = computed(() => {
  let imgs: Img[] = JSON.parse(JSON.stringify(images.value));
  imgs = imgs.sort((a, b) => (a?.display_order || 0) - (b?.display_order || 0));
  let parentImgs: Img[] = JSON.parse(JSON.stringify(parentImages.value));
  parentImgs = parentImgs.sort((a, b) => (a?.display_order || 0) - (b?.display_order || 0));
  let allImgs = [
    ...imgs,
    ...parentImgs,
  ]
  allImgs = removeDuplicates<Img>(allImgs, 'image');
  allImgs = allImgs.map(({ image, ...img }) => ({
    ...img,
    name: image?.name,
    url: replaceDropboxLink(image?.url, 'dl=1'),
    previewUrl: replaceDropboxLink(image?.url, 'raw=1'),
  }));
  return allImgs;
});

const allSpecSheets = computed(() => {
  let allSpcSheets: SpecSheet[] = [
    ...specSheets.value,
    ...parentSpecSheets.value,
  ]
  allSpcSheets = removeDuplicates<SpecSheet>(allSpcSheets, 'specification_sheet');
  allSpcSheets = allSpcSheets.map(({ specification_sheet, ...spcSheet }) => ({
    ...spcSheet,
    name: specification_sheet?.name,
    url: replaceDropboxLink(specification_sheet?.url, 'dl=1'),
    previewUrl: replaceDropboxLink(specification_sheet?.url, 'raw=1'),
  }));
  return allSpcSheets;
});

const removeDuplicates = <T,>(arr: T[], key: string): T[] => {
  const uniqueUrls = new Map<string, boolean>();
  return arr.reduce((acc: T[], current: T) => {
    const url = (current as any)[key]?.url || '';
    if (!uniqueUrls.has(url)) {
      uniqueUrls.set(url, true);
      acc.push(current);
    }
    return acc;
  }, []);
}

const onEnterSearch = async () => {
  await loadProductInformation();
  if (skuSearch.value)
    router.push(`/?sku=${skuSearch.value}`);
  else
    router.push('/');
}

const loadProductInformation = async () => {
  try {
    isLoading.value = true;
    product.value = await loadProduct();
    if (product.value) {
      allowedPrices.value = productStore.allowedPrices(userStore.user?.user_metadata.role);
      const pricesPromises: any = [];
      allowedPrices.value.forEach((priceType) => pricesPromises.push(loadProductPrices(priceType, product.value?.id || 0)))
      const pricesResponse = await Promise.allSettled(pricesPromises);
      setPrices(pricesResponse.filter((priceResponse) => priceResponse.status === 'fulfilled'));
      images.value = await loadImages(product.value?.id!) || [];
      specSheets.value = await loadSpecificationSheets(product.value?.id!) || [];
      if (product.value.parent_id) {
        if (images.value.length <= 0)
          parentImages.value = await loadImages(product.value.parent_id) || [];
        if (specSheets.value.length <= 0)
          parentSpecSheets.value = await loadSpecificationSheets(product.value.parent_id) || [];
      }
    }
  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}

const setPrices = (pricesList: any[]) => {
  pricesList.forEach(({ value }) => {
    prices.value[value.price_type as keyof PriceData] = value.prices;
  });
}

const availableYears = computed((): number[] => {
  const yearsSet = new Set();

  for (const key in prices.value) {
    const hasKey = Object.prototype.hasOwnProperty.call(prices.value, key);
    if (hasKey && Array.isArray(prices.value[key as keyof PriceData])) {
      prices.value[key as keyof PriceData].forEach((item) => {
        if (item.year) {
          yearsSet.add(item.year);
        }
      })
    }
  }
  return (Array.from(yearsSet).sort((a: any, b: any) => a - b) as number[]);
});

watch(
  () => availableYears.value,
  () => {
    currentYear.value = availableYears.value[0] as number;
  },
);

const loadProduct = async () => {
  try {
    const { data: product, error } = await supabase.from(`product`)
      .select(`
        *,
        base_color:base_color_id(name),
        base_material:base_material_id(name),
        category:category_id(name),
        collection:collection_id(name),
        color:color_id(name),
        gas:gas_id(name),
        ignition:ignition_id(name),
        material:material_id(name),
        shape:shape_id(name)
      `)
      .eq(`sku`, skuSearch.value.toUpperCase())
      .eq(`enabled`, true)
      .maybeSingle();
    if (error) throw error;
    return product as unknown as Product;
  } catch(e: any) {
    product.value = {};
    console.error(e);
  }
}

const loadImages = async (id: number) => {
  try {
    const { data: images, error: imgError } = await supabase.from(`product_image`)
      .select(`image:image_id(id, name, url), display_order, is_primary`)
      .eq(`product_id`, id);
    if (imgError) throw imgError;
    return images as unknown as Img[];
  } catch (e: any) {
    console.error(e);
  }
}

const loadSpecificationSheets = async (id: number) => {
  try {
    const { data: specSheets, error } = await supabase.from(`product_specification_sheet`)
      .select(`specification_sheet:specification_sheet_id(id, name, url)`)
      .eq(`product_id`, id);
    if (error) throw error;
    return specSheets as unknown as SpecSheet[];
  } catch (e: any) {
    console.error(e);
  }
}

const replaceDropboxLink = (url: string | undefined, queryParam: string) => {
  if (url) {
    const withoutQueryParam = url.replace(/[?&](dl|raw)=\d/g, '');

    const separator = withoutQueryParam.includes('?') ? '&' : '?';
    return `${withoutQueryParam}${separator}${queryParam}`;
  }
  return url || '';
}

const loadProductPrices = async (type: string, product_id: number) => {
  try {
    const { data: price, error } = await supabase.from(`${type}_price`)
      .select('price, year')
      .eq(`product_id`, product_id);
    if (error) throw error;
    return {
      price_type: type,
      prices: price,
    };
  } catch (e: any) {
    notify({
      title: `Error loading prices.`,
      text: e?.message || `An error occurred trying to load prices. Please contact TOP Support.`,
      type: 'error',
      duration: 6000,
    });
  }
}
</script>
