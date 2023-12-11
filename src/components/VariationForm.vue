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
import { useProductStore } from '@/store/product';
import { Ref } from 'vue';
import {
  Attrs,
  Image,
  ItemsList,
  Price,
  PriceData,
  Product,
  Props,
  SpecificationSheet,
  Documents
} from '@/types/product';
import { readonly } from 'vue';
import { read } from 'fs';

/**
 *
 * General Definitions
 *
 */

const router = useRouter();
const route = useRoute();
const productStore = useProductStore();
const isLoading = ref(false);
const { notify } = useNotification();


</script>
