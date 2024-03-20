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
    <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row tw-mt-10 tw-mb-12">
      <div class="tw-w-full lg:tw-w-7/12">
        <div v-if="product && product.id && availableYears.length > 0 && userIsAdmin" class="tw-w-full tw-flex">
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
          <h2 class="tw-font-bold tw-text-3xl tw-text-center"><a :href="websiteLink" target="_blank" class="hover:tw-text-blue-600 hover:tw-underline">{{ product.name }}</a></h2>
          <div class="tw-text-xl tw-text-center tw-mt-3 tw-pb-2.5">
            <span class="tw-font-semibold">Part #: </span><span class="tw-text-blue-600">{{ product.sku }}</span>
            <v-btn
              size="small"
              @click="copyTextToClipboard(product.sku!, 'UPC')"
              icon="mdi-content-copy"
              variant="text"
            >
            </v-btn>
            <v-btn
                size="small"
                @click="skuDialog = true"
                icon="mdi-barcode"
                variant="text"
              >
              </v-btn>
            <v-dialog v-model="skuDialog" max-width="400px">
              <v-card>
                <v-card-title class="d-flex justify-space-between align-center tw-px-10">
                  <div class="tw-text-xl">
                    Part Number (SKU)
                  </div>
                  <v-btn
                    icon="mdi-close"
                    variant="text"
                    @click="skuDialog = false"
                  ></v-btn>
                </v-card-title>
                <v-card-text class="tw-flex tw-justify-center tw-items-center">
                  <Barcode
                    :value="product.sku"
                    :line-color="'#000'"
                  />
                </v-card-text>
              </v-card>
            </v-dialog>
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
          <div class="tw-flex tw-w-full tw-flex-col lg:tw-flex-row tw-mt-8 tw-text-lg tw-px-4 tw-flex-wrap">
            <!-- Collection -->
            <div v-if="product?.parent?.collection?.name" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Collection: </span>
              <span>{{ product.parent.collection.name }}</span>
            </div>
            <!-- Shape -->
            <div v-if="product?.parent?.shape?.name" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Shape: </span>
              <span>{{ product.parent.shape.name }}</span>
            </div>
           <!-- UPC -->
            <div v-if="product?.upc_codes" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">UPC: </span>
              <span>{{ product.upc_codes }}</span>
              <v-btn
                size="small"
                @click="copyTextToClipboard(product.upc_codes, 'UPC')"
                icon="mdi-content-copy"
                color="blue"
                variant="text"
              >
              </v-btn>
              <v-btn
                size="small"
                @click="upcCodeDialog = true"
                icon="mdi-barcode"
                color="blue"
                variant="text"
              >
              </v-btn>
              <v-dialog v-model="upcCodeDialog" max-width="400px">
                <v-card>
                  <v-card-title class="d-flex justify-space-between align-center tw-px-10">
                    <div class="tw-text-xl">
                      UPC Code
                    </div>
                    <v-btn
                      icon="mdi-close"
                      variant="text"
                      @click="upcCodeDialog = false"
                    ></v-btn>
                  </v-card-title>
                  <v-card-text class="tw-flex tw-justify-center tw-items-center">
                    <Barcode
                      :value="product.upc_codes"
                      :format="'UPC'"
                      :line-color="'#000'"
                    />
                  </v-card-text>
                </v-card>
              </v-dialog>
            </div>
           <!-- Encoded UPC -->
            <div v-if="product?.encoded_upc_codes" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Encoded UPC: </span>
              <span>{{ product.encoded_upc_codes }}</span>
              <v-btn
                size="small"
                @click="copyTextToClipboard(product.encoded_upc_codes, 'Encoded UPC')"
                icon="mdi-content-copy"
                color="blue"
                variant="text"
              >
              </v-btn>
              <v-btn
                size="small"
                @click="encodedUpcCodeDialog = true"
                icon="mdi-barcode"
                color="blue"
                variant="text"
              >
              </v-btn>
              <v-dialog v-model="encodedUpcCodeDialog" max-width="400px">
                <v-card>
                  <v-card-title class="d-flex justify-space-between align-center tw-px-10">
                    <div class="tw-text-xl">
                      Encoded UPC Code
                    </div>
                    <v-btn
                      icon="mdi-close"
                      variant="text"
                      @click="encodedUpcCodeDialog = false"
                    ></v-btn>
                  </v-card-title>
                  <v-card-text class="tw-flex tw-justify-center tw-items-center">
                    <Barcode
                      :value="product.encoded_upc_codes"
                      :line-color="'#000'"
                    />
                  </v-card-text>
                </v-card>
              </v-dialog>
            </div>
            <!-- Product Length -->
            <div v-if="product?.product_length" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Size (Length): </span>
              <span>{{ product.product_length }}</span>
            </div>
            <!-- Product Diameter -->
            <div v-else-if="product?.product_diameter" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Size (Diameter): </span>
              <span>{{ product.product_diameter }}</span>
            </div>
            <!-- Width -->
            <div v-if="product?.product_width" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Width: </span>
              <span>{{ product.product_width }}</span>
            </div>
            <!-- Height -->
            <div v-if="product?.product_height" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Height: </span>
              <span>{{ product.product_height }}</span>
            </div>
            <!-- Base Length -->
            <div v-if="product?.base_length" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Base Length: </span>
              <span>{{ product.base_length }}</span>
            </div>
            <!-- Base Diameter -->
            <div v-if="product?.base_diameter" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Base Diameter: </span>
              <span>{{ product.base_diameter }}</span>
            </div>
            <!-- Base Width -->
            <div v-if="product?.base_width" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Base Width: </span>
              <span>{{ product.base_width }}</span>
            </div>
            <!-- Base Opening -->
            <div v-if="product?.base_opening" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Base Opening: </span>
              <span>{{ product.base_opening }}</span>
            </div>
            <!-- Toe Kick -->
            <div v-if="product?.toe_kick" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Toe Kick: </span>
              <span>{{ product.toe_kick }}</span>
            </div>
            <!-- Soil Usage -->
            <div v-if="product?.soil_usage" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Soil Usage: </span>
              <span>{{ product.soil_usage }}</span>
            </div>
            <!-- Scupper Width -->
            <div v-if="product?.scupper_width" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Scupper Width: </span>
              <span>{{ product.scupper_width }}</span>
            </div>
            <!-- Scupper Inlet Opening -->
            <div v-if="product?.scupper_inlet_opening" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Scupper Inlet Opening: </span>
              <span>{{ product.scupper_inlet_opening }}</span>
            </div>
            <!-- GPM -->
            <div v-if="product?.gpm" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">GPM (Gallons Per Minute): </span>
              <span>{{ product.gpm }}</span>
            </div>
            <!-- Fire Glass -->
            <div v-if="product?.fire_glass" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Fire Glass: </span>
              <span>{{ product.fire_glass }}</span>
            </div>
            <!-- BA Length -->
            <div v-if="product?.ba_length" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">BA Length: </span>
              <span>{{ product.fire_glass }}</span>
            </div>
            <!-- BA Diameter -->
            <div v-if="product?.ba_diameter" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">BA Diameter: </span>
              <span>{{ product.ba_diameter }}</span>
            </div>
            <!-- BA Width -->
            <div v-if="product?.ba_width" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">BA Width: </span>
              <span>{{ product.ba_width }}</span>
            </div>
            <!-- BA Depth -->
            <div v-if="product?.ba_depth" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">BA Depth: </span>
              <span>{{ product.ba_depth }}</span>
            </div>
            <!-- Burner Shape -->
            <div v-if="product?.burner_shape || product?.parent?.burner_shape" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Burner Shape: </span>
              <span>{{ product.burner_shape || product.parent?.burner_shape }}</span>
            </div>
            <!-- Burner Length -->
            <div v-if="product?.burner_length" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Burner Length: </span>
              <span>{{ product.burner_length }}</span>
            </div>
            <!-- Burner Diameter -->
            <div v-if="product?.burner_diameter" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Burner Diameter: </span>
              <span>{{ product.burner_diameter }}</span>
            </div>
            <!-- Company Division -->
            <div v-if="product?.parent?.company_division && (userStore.user?.user_metadata.role === 'ADMIN' || userStore.user?.user_metadata.role === 'MANAGER')" class="tw-w-6/12 mb-4">
              <span class="tw-font-semibold">Division: </span>
              <span>{{ product.parent.company_division }}</span>
            </div>
            <!-- Certifications -->
            <div v-if="product?.certifications" class="tw-w-full mb-4 tw-flex tw-justify-end">
              <template v-for="(cert, key) in product.certifications" :key="key">
                <div class="px-3">
                  <v-img
                    :width="70"
                    :lazy-src="certificationsLogo(cert)"
                    :src="certificationsLogo(cert)"
                  ></v-img>
                </div>
              </template>
            </div>
          </div>
          <div><hr></div>
          <div class="tw-flex tw-w-full tw-flex-col lg:tw-flex-row tw-text-lg tw-mt-4 tw-px-4 tw-flex-wrap">
            <div
              v-for="(item, index) in prodAttributesList"
              :key="index"
              class="tw-w-6/12"
            >
              <div class="mb-4">
                <span class="tw-font-semibold">{{ item.attribute?.name }}: </span>
                <span>{{ getAttributeValue(item) }}</span>
              </div>
            </div>
          </div>
          <div v-if="websiteLink && urlTitle" class="tw-flex tw-w-full tw-flex-col lg:tw-flex-row tw-mt-4 tw-text-lg">
            <div>
              <span class="tw-font-semibold tw-ml-4">Website Link: </span>
              <a :href="websiteLink" target="_blank" class="tw-text-blue-600 hover:tw-underline">{{ urlTitle }}</a>
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
            max-height="435"
          >
            <v-carousel
              v-model="imageSlider"
              hide-delimiter-background
              class="tw-max-h-[435px]"
            >
              <v-carousel-item
                v-for="(img, i) in allImages"
                :key="i"
                :src="img.previewUrl"
                :lazy-src="img.previewUrl"
                max-height="400"
              >
              </v-carousel-item>
            </v-carousel>
          </v-card>
          <div v-if="imageSlider >= 0" class="tw-w-full tw-flex tw-justify-center tw-mt-2 -tw-mb-1.5">
            <div class="tw-flex tw-text-lg tw-font-semibold">
              {{ allImages[imageSlider].name }}
              </div>
          </div>
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
                class="px-4 py-2 mb-3"
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
          <template v-if="!!(product && product.id && allDocuments.length)">
            <h3 class="tw-text-xl tw-font-bold tw-my-8">Manuals/Marketing:</h3>
            <div class="tw-w-full">
              <v-card
                v-for="(docs, i) in allDocuments"
                :key="i"
                class="px-4 py-2 mb-3"
              >
                <div class="tw-w-full tw-flex tw-items-center">
                  <v-avatar color="blue-darken-2" size="36" class="tw-mr-3">
                    <v-icon color="white" size="small" icon="mdi-file-document-multiple"></v-icon>
                  </v-avatar>
                  <a
                    class="hover:tw-underline hover:tw-cursor-pointer tw-transition-all tw-font-medium"
                    rel="noopener noreferrer"
                    :href="docs.previewUrl"
                    target="_blank"
                  >{{ docs.name }}</a>
                  <v-spacer></v-spacer>
                  <v-btn
                    variant="text"
                    icon="mdi-open-in-new"
                    color="gray-darken-2"
                    tag="a"
                    target="_blank"
                    :href="docs.previewUrl"
                  ></v-btn>
                  <v-btn
                    variant="text"
                    icon="mdi-download"
                    color="gray-darken-2"
                    tag="a"
                    :href="docs.url"
                  ></v-btn>
                </div>
              </v-card>
            </div>
          </template>
        </template>
      </div>
    </div>
    <div v-if="product && product.id" class="tw-w-full tw-flex tw-flex-col tw-mt-10 tw-mb-12">
      <h2 class="tw-text-xl tw-font-bold">Product Configuration</h2>
      <v-expansion-panels class="tw-mb-6 tw-w-full" multiple>
        <v-expansion-panel v-for="(attr, i) in prodAttributesList" :key="`attribute-${i}`" class="tw-my-2">
          <v-expansion-panel-title>{{ attr.attribute?.name }}</v-expansion-panel-title>
          <v-expansion-panel-text>
            <div class="tw-flex tw-flex-row tw-flex-wrap tw-justify-center lg:tw-justify-start mx-auto">
              <div
                v-for="(attrVal, index) in attr.attribute_values"
                :key="index"
                class="tw-w-6/12 md:tw-w-4/12 lg:tw-w-2/12 3xl:tw-w-1/12 tw-mx-4 tw-my-2 tw-px-1 tw-py-5 tw-border-gray-300 tw-border tw-rounded-md tw-flex tw-flex-col tw-justify-center tw-items-center tw-text-center"
                :class="{ 'tw-bg-green-100 tw-border-green-400': isCurrentConfiguration(attr?.attribute?.id!, attrVal.id), 'hover:tw-cursor-pointer tw-transition hover:tw-bg-blue-100': getVariationConfiguration(attr?.attribute?.id!, attrVal.id)?.exists }"
                @click.prevent="redirectToVariation(getVariationConfiguration(attr?.attribute?.id!, attrVal.id))"
              >
                <div class="tw-text-lg lg:tw-px-6">
                  {{ attrVal.name }}
                </div>
                <div v-if="attrVal.image_url">
                  <v-img
                    :width="50"
                    :src="attrVal.image_url"
                    class="tw-my-2"
                  ></v-img>
                </div>
                <span v-if="!isCurrentConfiguration(attr?.attribute?.id!, attrVal.id)" class="tw-text-xs tw-mt-1">
                  SKU: <span class="tw-text-blue-600">{{ getVariationConfiguration(attr?.attribute?.id!, attrVal.id)?.sku }}</span>
                </span>
              </div>
            </div>

          </v-expansion-panel-text>
        </v-expansion-panel>
      </v-expansion-panels>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { supabase } from '@/supabase';
import { ref, computed, watch, Ref } from 'vue';
import { AttributeValues, Product as BaseProduct, Documents, Image, Price, PriceData, ProductAttribute, SpecificationSheet } from '@/types/product';
import { VSkeletonLoader } from 'vuetify/lib/labs/components.mjs';
import { useNotification } from '@kyvg/vue3-notification';
import { useUserStore } from '@/store/user';
import { useProductStore } from '@/store/product';
import { onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { Variation as BaseVariation } from '@/types/variation';
import Barcode from '@/components/Barcode.vue';
import ULCertification from '@/assets/UL_certification.webp';
import CSACertification from '@/assets/CSA_certification.png';
import ETLCertification from '@/assets/ETL_certification.png';
import LCCertification from '@/assets/LC_certification.png';

interface Variation extends BaseVariation {
  parent?: {
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
    };
    company_division: string;
    website_link: string;
    burner_shape: string;
  }
}

interface ProductVariation extends BaseVariation {
  variation_configuration?: {
    value_id?: {
      attribute_id?: number;
      id?: number;
    }
  }[];
}

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

interface Doc {
  document?: {
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

interface ProductConfigurationTable {
  color?: {
    id: number;
    name: string;
  };
  material?: {
    id: number;
    name: string;
  };
  gas?: {
    id: number;
    name: string;
  };
  ignition?: {
    id: number;
    name: string;
  };
}

interface ProductConfiguration extends ProductConfigurationTable {
  attribute?: {
    name?: string;
    slug?: string;
    table_name?: string;
  };
  value?: string;
}

interface VariationConfiguration {
  sku: string;
  attributeId: number;
  valueId: number;
  exists: boolean;
}

const { notify } = useNotification();
const userStore = useUserStore();
const productStore = useProductStore();
const route = useRoute();
const router = useRouter();

const imageSlider = ref();
const urlTitle = ref('');
const skuSearch = ref('');
const isLoading = ref(false);
const product: Ref<Variation | undefined> = ref<Variation | undefined>({});
const images: Ref<Img[]> = ref<Img[]>([]);
const parentImages: Ref<Img[]> = ref<Img[]>([]);
const specSheets: Ref<SpecSheet[]> = ref<SpecSheet[]>([]);
const parentSpecSheets: Ref<SpecSheet[]> = ref<SpecSheet[]>([]);
const documents: Ref<Doc[]> = ref<Doc[]>([]);
const parentDocuments: Ref<Doc[]> = ref<Doc[]>([]);
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
const upcCodeDialog = ref(false);
const encodedUpcCodeDialog = ref(false);
const skuDialog = ref(false);
const certificationsLogo = (cert: string) => ({
  'LC': LCCertification,
  'CSA': CSACertification,
  'ETL': ETLCertification,
  'UL': ULCertification,
})[cert];

const productConfiguration: Ref<ProductConfiguration[]> = ref<ProductConfiguration[]>([]);
const allProductVariations: Ref<ProductVariation[]> = ref<ProductVariation[]>([]);
const currentConfiguration: Ref<{ [key: number]: number }> = ref<{ [key: number]: number }>({});
const variationConfigurations: Ref<VariationConfiguration[]> = ref<VariationConfiguration[]>([]);

const prodAttributesList: Ref<ProductAttribute[]> = ref<ProductAttribute[]>([]);
const websiteLink: Ref<string> = ref<string>('')

const userIsAdmin = computed(() => {
  const adminRoles = ['MANAGER', 'ADMIN'];
  if (adminRoles.includes(userStore.currentUser?.user_metadata?.role))
    return true
  return false;
});

onMounted(async () => {
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

const allDocuments = computed(() => {
  let allDocs: Doc[] = [
    ...documents.value,
    ...parentDocuments.value,
  ]
  allDocs = removeDuplicates<Doc>(allDocs, 'document');
  allDocs = allDocs.map(({ document, ...docs }) => ({
    ...docs,
    name: document?.name,
    url: replaceDropboxLink(document?.url, 'dl=1'),
    previewUrl: replaceDropboxLink(document?.url, 'raw=1'),
  }));
  return allDocs;
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
      documents.value = await loadDocuments(product.value?.id!) || [];
      websiteLink.value = product.value?.website_link || product.value?.parent?.website_link || '';
      await loadAttributes(product.value?.parent_id || 0);
      await loadProductConfiguration(product.value?.id || 0);
      if (product.value.parent_id) {
        parentImages.value = await loadImages(product.value.parent_id, 'parent') || [];
        parentSpecSheets.value = await loadSpecificationSheets(product.value.parent_id, 'parent') || [];
        parentDocuments.value = await loadDocuments(product.value.parent_id, 'parent') || [];
      }
      await loadOverallProductConfiguration(product.value?.parent_id || 0);
      await loadAllProductVariations(product.value?.parent_id || 0);
      calculateCurrentConfiguration();
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
  () => websiteLink.value,
  async () => {
    try {
      console.log(websiteLink.value);
      const response = await fetch(websiteLink.value);
      const html = await response.text();
      const doc = new DOMParser().parseFromString(html, 'text/html');
      const title = doc.querySelectorAll('title')[0];
      urlTitle.value = title.innerText;
    } catch(e) {
      urlTitle.value = product.value?.name || '';
    }
  },
  { deep: true }
);

watch(
  () => availableYears.value,
  () => {
    currentYear.value = availableYears.value[0] as number;
  },
);

const tableName = (table: string, prodType: string) => ({
  'product': `product_${table}`,
  'variation': `variation_${table}`,
})[prodType] || `product_${table}`;

const columnName = <T,>(prodType: string) => ({
  'product': 'product_id' as keyof T,
  'variation': 'variation_id' as keyof T,
})[prodType] || 'product_id' as keyof T;

const loadProduct = async () => {
  try {
    const { data: product, error } = await supabase.from(`variation`)
      .select(`
        *,
        parent:parent_id(
          category:category_id(name),
          collection:collection_id(name),
          shape:shape_id(name),
          website_link,
          company_division,
          burner_shape,
          compatible_canvas_cover,
          compatible_bullet_burner,
          compatible_glass_wind_guard,
          access_door
        )
      `)
      .eq(`sku`, skuSearch.value.toUpperCase().trim())
      .eq(`enabled`, true)
      .maybeSingle();
    if (error) throw error;
    return product as unknown as Variation;
  } catch(e: any) {
    product.value = {};
    console.error(e);
  }
}

const loadImages = async (id: number, prodType: string = 'variation') => {
  try {
    const { data: images, error: imgError } = await supabase.from(tableName('image', prodType))
      .select(`image:image_id(id, name, url), display_order, is_primary`)
      .eq(`${columnName<Image>(prodType)}`, id);
    if (imgError) throw imgError;
    return images as unknown as Img[];
  } catch (e: any) {
    console.error(e);
  }
}

const loadSpecificationSheets = async (id: number, prodType: string = 'variation') => {
  try {
    const { data: specSheets, error } = await supabase.from(tableName('specification_sheet', prodType))
      .select(`specification_sheet:specification_sheet_id(id, name, url)`)
      .eq(`${columnName<SpecificationSheet>(prodType)}`, id);
    if (error) throw error;
    return specSheets as unknown as SpecSheet[];
  } catch (e: any) {
    console.error(e);
  }
}

const loadDocuments = async (id: number, prodType: string = 'variation') => {
  try {
    const { data: docs, error } = await supabase.from(tableName('documents', prodType))
      .select(`document:document_id(id, name, url)`)
      .eq(`${columnName<Documents>(prodType)}`, id);
    if (error) throw error;
    return docs as unknown as Doc[];
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

const loadProductPrices = async (type: string, product_id: number, prodType: string = 'variation') => {
  try {
    const { data: price, error } = await supabase.from(`${type}_price`)
      .select('price, year')
      .eq(`${columnName<Price>(prodType)}`, product_id);
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

const loadProductConfiguration = async (variationId: number) => {
  try {
    const { data, error } = await supabase.from(`variation_configuration`)
      .select(`attribute_value:value_id(
        attribute:attribute_id(
          name,
          table_name,
          slug
        ),
        value,
        material:material_id(id, name),
        color:color_id(id, name, image_url),
        gas:gas_id(id, name),
        ignition:ignition_id(id, name)
      )`)
      .eq(`variation_id`, variationId);
    if (error) throw error;
    productConfiguration.value = data.map((attr) => attr.attribute_value) as ProductConfiguration[];
  } catch (e: any) {
    notify({
      title: `Error loading product configuration.`,
      text: e?.message || `An error occurred trying to load product configuration. Please contact TOP Support.`,
      type: 'error',
      duration: 6000,
    });
  }
}

const loadAttributes = async (parentId: number) => {
  try {
    if (parentId) {
      const { data, error } = await supabase
        .from('product_attribute')
        .select('id, attribute:attribute_id(id, name, table_name), fill_values')
        .eq('product_id', parentId);
      if (error) throw error;
      prodAttributesList.value = data as ProductAttribute[];
    }
  } catch (e: any) {
    notify({
      title: `Error loading product configuration attributes.`,
      text: e?.message || `An error occurred trying to load product configuration attributes. Please contact TOP Support.`,
      type: 'error',
      duration: 6000,
    });
  }
}

const getAttributeValue = (prodAttr: ProductAttribute) => {
  const prodAttrTableName = prodAttr.attribute?.table_name as keyof ProductConfigurationTable;
  const currentProdConf = productConfiguration.value.find((prodConf) =>
    prodConf.attribute?.table_name ?
      prodConf.attribute?.table_name === prodAttr.attribute?.table_name :
      prodConf.attribute?.name === prodAttr.attribute?.name
  );
  if (prodAttrTableName && currentProdConf) {
    return (currentProdConf as ProductConfigurationTable)[prodAttrTableName]?.name;
  }
  if (currentProdConf) {
    return currentProdConf?.value || '';
  }
  return '';
}

const copyTextToClipboard = async (textToCopy: string, title: string) => {
  try {
    if (navigator?.clipboard?.writeText) {
      await navigator.clipboard.writeText(textToCopy);
      notify({
        title: `${title} copied to clipboard!`,
        duration: 6000,
      });
    }
  } catch (e: any) {
    notify({
      title: `Can't copy to clipboard.`,
      text: `Looks like copying to clipboard is not supported by your browser. Please update your browser or contact TOP Support.`,
      type: 'error',
      duration: 9000,
    });
  }
}

const loadOverallProductConfiguration = async (parentId: number) => {
  try {
    const prodConfiguValuesPromises: Promise<any>[] = [];
    prodAttributesList.value.forEach((prodAttr) => {
      const attributeId = prodAttr?.attribute?.id || 0;
      if (attributeId) {
        if (prodAttr.fill_values)
          prodConfiguValuesPromises.push(loadAttributeValues(attributeId))
        else
          prodConfiguValuesPromises.push(loadProductAttributes(parentId, attributeId))
      }
    });
    const promiseResult = await Promise.allSettled(prodConfiguValuesPromises);
    const hasColor = prodAttributesList.value.find((prodAttr) => prodAttr.attribute?.table_name === 'color');
    let material: undefined | ProductConfiguration = undefined;
    if (hasColor) {
       material = productConfiguration.value.find((prodConf) => prodConf?.material && prodConf.material.id);
    }
    prodAttributesList.value = prodAttributesList.value.map((prodAttr) => {
      const prodAttrTableName = prodAttr.attribute?.table_name as keyof ProductConfigurationTable;
      const attrValue = promiseResult.find((result) => result.status === 'fulfilled' && result.value.attributeId === prodAttr?.attribute?.id);
      const attrValues = attrValue?.status === 'fulfilled' ?
        attrValue.value.data.reduce((result: any, val: any) => {
          let value = null;
          if (!prodAttr.fill_values) {
            if (val.value) {
              if (prodAttrTableName) {
                if (prodAttrTableName === 'color' && material) {
                  if (val?.value?.color?.material_id === material?.material?.id) {
                    value = {
                      id: val.value.id,
                      name: val.value.color.name,
                      image_url: val.value.color.image_url
                    }
                    result.push(value);
                  }
                } else {
                  value = {
                    id: val.value.id,
                    name: val.value[prodAttrTableName].name,
                  }
                  result.push(value);
                }
              } else {
                value = {
                  id: val.value.id,
                  name: val.value.value,
                }
                result.push(value);
              }

            }
          } else {
            if (prodAttrTableName) {
              if (prodAttrTableName === 'color' && material) {
                if (val?.color?.material_id === material?.material?.id) {
                  value = {
                    id: val.id,
                    name: val.color.name,
                    image_url: val.color.image_url
                  }
                  result.push(value);
                }
              } else {
                value = {
                  id: val.id,
                  name: val[prodAttrTableName].name
                }
                result.push(value);
              }

            } else {
              value = {
                id: val.id,
                value: val.value,
              }
              result.push(value);
            }
          }
          return result;
        }, []) :
        [];

      return {
        ...prodAttr,
        attribute_values: attrValues,
      }
    });
  } catch (e) {
    console.error(e);
  }

}

const loadAttributeValues = async(attributeId: number) => {
  try {
    const { data, error } = await supabase
      .from('attribute_value')
      .select('id, attribute_id, value, material:material_id(id, name), color:color_id(id, name, material_id, image_url), gas:gas_id(id, name), ignition:ignition_id(id, name)')
      .eq('attribute_id', attributeId);
    if (error) throw error;
    return { attributeId, data };
  } catch (e: any) {
    console.error(e);
  }
}

const loadProductAttributes = async (productId: number, attributeId: number) => {
  try {
    const { data, error } = await supabase
      .from('product_configuration')
      .select('product_id, value:value_id(id, attribute_id, value, material:material_id(id, name), color:color_id(id, name, material_id, image_url), gas:gas_id(id, name), ignition:ignition_id(id, name))')
      .eq('product_id', productId)
      .eq('value.attribute_id', attributeId);
    if (error) throw error;
    return { attributeId, data };
  } catch (e) {
    console.error(e);
  }
}

const loadAllProductVariations = async (parentId: number) => {
  try {
    const { data, error } = await supabase
      .from('variation')
      .select('id, parent_id, sku, variation_configuration(value_id(id, attribute_id))')
      .eq('parent_id', parentId);
    if (error) throw error;
    allProductVariations.value = data as ProductVariation[];
  } catch (e) {
    console.error(e);
  }
}

const calculateCurrentConfiguration = () => {
  prodAttributesList.value.forEach((attr) => {
    attr.attribute_values?.forEach((attrVal) => {
      let isCurrent = false;
      allProductVariations.value.forEach((variation) => {
        if (variation.id === product?.value?.id) {
          isCurrent = !!variation.variation_configuration?.find((varConf) => (
            varConf?.value_id?.id === attrVal.id
          ));
        }
      });
      if (isCurrent) currentConfiguration.value[attr?.attribute?.id!] = attrVal.id;
    });
  });
  prodAttributesList.value.forEach((attr) => {
    attr.attribute_values?.forEach((attrVal) => {
      calculateConfigurationsData(attr?.attribute?.id!, attrVal.id);
    });
  });
}

const isCurrentConfiguration = (attributeId: number, attributeValueId: number) => {
  return currentConfiguration.value[attributeId] && currentConfiguration.value[attributeId] == attributeValueId;
}

const calculateConfigurationsData = (selectedAttrId: number, selectedAttrValueId: number) => {
  if (!isCurrentConfiguration(selectedAttrId, selectedAttrValueId)) {
    const variation = allProductVariations.value.find((prodVar) => {
      let isVariation = false;
      const hasConfiguration: any = [];
      prodVar.variation_configuration?.forEach((varConf) => {
        const varConfAttrId = varConf?.value_id?.attribute_id || 0;
        const varConfValId = varConf.value_id?.id || 0;
        if (varConfAttrId === selectedAttrId && varConfValId === selectedAttrValueId) {
          hasConfiguration.push({
            id: varConfAttrId,
            isCurrent: true,
          });
          return;
        } else {
          const hasAlreadyBeenEvaluated = hasConfiguration.find((hasConf: any) => hasConf.id === varConfAttrId);
          if (!hasAlreadyBeenEvaluated && varConfAttrId !== selectedAttrId && varConfAttrId in currentConfiguration.value && varConfValId === currentConfiguration.value[varConfAttrId])
            hasConfiguration.push({
              id: varConfAttrId,
              isCurrent: true,
            });
          else
            hasConfiguration.push({
              id: varConfAttrId,
              isCurrent: false,
            });
        }
      });
      isVariation = hasConfiguration.every((hasConf: any) => hasConf.isCurrent);
      return isVariation;
    });
    variationConfigurations.value.push({
      sku: variation?.sku || 'No SKU Assigned.',
      attributeId: selectedAttrId,
      valueId: selectedAttrValueId,
      exists: !!(variation && variation.sku),
    });
  }
}

const getVariationConfiguration = (attrId: number, valueId: number) => {
  return  variationConfigurations.value.find((varConf) => varConf.attributeId === attrId && varConf.valueId === valueId);
}

const redirectToVariation = async (variationConfiguration?: VariationConfiguration) => {
  if (variationConfiguration && variationConfiguration.sku && variationConfiguration.exists) {
    skuSearch.value = variationConfiguration.sku;
    await loadProductInformation();
    router.push(`/?sku=${variationConfiguration.sku}`);
  }
}

</script>
