<template>
  <div class="tw-w-full">
    <v-text-field
      v-model="search"
      variant="solo"
      prepend-inner-icon="mdi-magnify"
      class="tw-w-full"
      label="Search By Name or SKU"
      @keyup.enter="onEnterSearch"
    ></v-text-field>

    <div class="tw-mt-8 tw-mb-16 tw-w-full">
      <div v-if="productsList?.length" class="tw-w-full tw-flex tw-justify-end">
        <v-btn
          color="white"
          class="tw-mb-3"
        >
          Sort Order: {{ sortBy }}
          <v-menu activator="parent">
            <v-list>
              <v-list-item
                v-for="(item, index) in ['DESC', 'ASC']"
                :key="index"
                :value="index"
              >
                <v-list-item-title @click="sortBy !== item ? sortBy = item : ''">{{ item }}</v-list-item-title>
              </v-list-item>
            </v-list>
          </v-menu>
        </v-btn>
      </div>
      <div v-if="productsList?.length" class="tw-w-full tw-flex tw-flex-wrap tw-justify-end">
        <template
          v-for="(attribute) in attributes"
          :key="attribute.slug"
        >
          <v-btn
            v-if="showAttributes(attribute)"
            color="white"
            class="tw-mb-3 tw-ml-5 tw-mt-2"
          >
            {{ attribute.name }}: {{ attributesFilter[attribute.slug].value }}
            <v-menu activator="parent">
              <v-list>
                <template
                  v-if="attribute.slug === 'color'"
                >
                  <v-list-item
                    v-for="(item) in colorAttributes"
                    :key="item.value_id"
                    :value="item.value_id || 'All'"
                  >
                    <v-list-item-title @click="updateAttributeFilter(attribute.slug, item)">{{ item.value }}</v-list-item-title>
                  </v-list-item>
                </template>
                <template v-else>
                  <v-list-item
                    v-for="(item) in attribute.attribute_value"
                    :key="item.value_id"
                    :value="item.value_id || 'All'"
                  >
                    <v-list-item-title @click="updateAttributeFilter(attribute.slug, item)">{{ item.value }}</v-list-item-title>
                  </v-list-item>
                </template>
              </v-list>
            </v-menu>
          </v-btn>
        </template>
      </div>
        <v-virtual-scroll
          :items="productsList"
        >
          <template v-slot:default="{ item, index }">
            <v-card
              elevation="0"
              rounded="0"
              :class="{ '!tw-border-b-2 !tw-border-gray-200' : index+1 < productsList.length }"
            >
              <v-list-item
                :key="item.id"
                lines="two"
                :to="getProductLink(item.sku, !!item.parent_id)"
              >
                <template v-slot:default>
                  <div class="tw-ml-8 tw-flex tw-justify-between tw-flex-wrap">
                    <div>
                      <RouterLink
                        class="tw-font-semibold tw-text-lg hover:tw-underline hover:tw-cursor-pointer hover:tw-text-blue-500"
                        :to="getProductLink(item.sku, !!item.parent_id)"
                      >
                        {{ item.name }}
                      </RouterLink>
                      <div class="tw-w-full" >
                        <template v-if="item.parent_id">
                          SKU: {{ item.sku }}
                        </template>
                        <template v-else>
                          <div class="tw-text-gray-400">
                            PARENT PRODUCT
                          </div>
                        </template>
                      </div>
                    </div>
                    <div>
                      <v-btn
                        v-if="item.parent_id"
                        icon="mdi-open-in-new"
                        variant="text"
                      ></v-btn>
                      <v-btn
                        v-else
                        icon="mdi-chevron-right"
                        variant="text"
                      ></v-btn>
                    </div>
                  </div>
                  <!-- <hr v-if="index+1 < productsList.length" class="tw-w-full"> -->
                </template>
                <template v-slot:prepend>
                  <div>
                    <v-img
                      :src="item.image_url || `@/assets/top_logo.png`"
                      lazy-src="@/assets/top_logo.png"
                      width="120"
                      height="120"
                    >
                      <template v-slot:placeholder>
                        <div class="d-flex align-center justify-center fill-height">
                          <v-progress-circular
                            color="grey-lighten-4"
                            indeterminate
                          >
                          </v-progress-circular>
                        </div>
                      </template>
                      <template v-slot:error>
                        <div class="lg:tw-px-4">
                          <v-img
                            height="120"
                            width="120"
                            src="@/assets/top_logo.png"
                          >
                          </v-img>
                        </div>
                      </template>
                    </v-img>
                  </div>
                </template>
              </v-list-item>
            </v-card>
          </template>
        </v-virtual-scroll>
      <div v-if="productsList.length" class="tw-w-full tw-flex tw-flex-wrap tw-justify-between tw-items-center tw-mt-6">
        <div class="tw-flex tw-items-center">
          Items per page:
          <v-select
            v-model="itemsPerPage"
            :items="[10, 25, 50, 100, 200, 500, 1000]"
            variant="outlined"
            density="compact"
            hide-details
            class="tw-ml-2"
          ></v-select>
        </div>
        <v-pagination
          v-model="page"
          :length="totalPages"
          :total-visible="5"
          @update:model-value="onPageChange"
        ></v-pagination>
        <div>
          {{ showResultsCount() }}
        </div>
      </div>
    </div>
    <v-overlay v-model="isLoading" class="tw-flex tw-justify-center tw-items-center">
      <v-progress-circular
        :size="50"
        color="amber"
        indeterminate
      ></v-progress-circular>
    </v-overlay>
  </div>
</template>

<script lang="ts" setup>
import { useAppStore } from '@/store/app';
import { supabase } from '@/supabase';
import { usePagination } from '@/utils';
import { computed } from 'vue';
import { Ref, ref, onMounted, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';

const isLoading = ref(false);
const store = useAppStore();
const route = useRoute();
const router = useRouter();
const search = ref('');
const productsList: Ref<any[]> = ref([]);
const page = ref(1);
const itemsPerPage = ref(50);
const totalPages = ref(1);
const totalItems = ref(0);
const fromLimit = ref(0);
const toLimit = ref(0);
const itemsToShow = ref(0);
const sortBy = ref('DESC');
const attributes: Ref<{ [key: string ]: any }> = ref({});
const attributesFilter: Ref<{ [key: string ]: any }> = ref({});

const colorAttributes = computed(() => {
  const colorAttributes = attributes.value?.color?.attribute_value.filter((val:any) => val.material_id === attributesFilter.value?.material?.material_id)
  colorAttributes.unshift({ value: 'All', value_id: null, attribute_id: null, material_id: null });
  return colorAttributes;
});

onMounted(async () => {
  store.pageTitle = 'Search Products';
  await loadAttributes();
  if (route.query.s) {
    search.value = String(route.query.s);
    page.value = Number(route?.query?.page || 1);
  }
  await loadProductsList();
})

watch(
  () => sortBy.value,
  async () => {
    await loadProductsList();
  }
);

const loadProductsList = async () => {
  try {
    isLoading.value = true;
    const valuesIds = Object.values(attributesFilter.value)
      .map((attr) => attr.value_id)
      .filter((value) => value);
    const attributeIds = Object.values(attributesFilter.value)
      .map((attr) => attr.attribute_id)
      .filter((value) => value);
    const { from, to } = usePagination(page.value - 1, itemsPerPage.value);
    if (search.value) {
      const { data, error } = await supabase
        .rpc('search_products_or_variations', {
          search_term: search.value,
          sort_term: 'name',
          sort_order: sortBy.value,
          from_limit: from,
          to_limit: to,
          value_id: valuesIds,
        });
      if (error) throw error;
      productsList.value = data.map((prod: any) => ({
        ...prod,
        image_url: replaceDropboxLink(prod.image_url, 'raw=1'),
      }));
      totalPages.value = Math.ceil((data?.[0]?.count || 0) / itemsPerPage.value);
      itemsToShow.value = data.length;
      fromLimit.value = from;
      toLimit.value = to;
      totalItems.value = data?.[0]?.count || 0;
    } else {
      const { data, error } = await supabase
        .rpc('filter_all_products_or_variations', {
          sort_term: 'name',
          sort_order: sortBy.value,
          from_limit: from,
          to_limit: to,
          value_id: valuesIds,
          attribute_id: attributeIds,
        });
      if (error) throw error;
      productsList.value = data.map((prod: any) => ({
        ...prod,
        image_url: replaceDropboxLink(prod.image_url, 'raw=1'),
      }));
      totalPages.value = Math.ceil((data?.[0]?.count || 0) / itemsPerPage.value);
      itemsToShow.value = data.length;
      fromLimit.value = from;
      toLimit.value = to;
      totalItems.value = data?.[0]?.count || 0;
    }
  } catch (e: any) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}

const onEnterSearch = async () => {
  if (search.value) {
    await loadProductsList();
    router.push(`/search-products?s=${search.value}&page=${page.value}`);
  } else {
    router.push('/search-products');
  }
}

const showResultsCount = () => {
  let fromEdge = 0;
  let toEdge = 0;
  if (totalItems.value > itemsToShow.value) {
    fromEdge = fromLimit.value + 1;
    toEdge = (toLimit.value - fromLimit.value) * (page.value) + 1;
  } else {
    fromEdge = fromLimit.value + 1;
    toEdge = totalItems.value;
  }
  if (productsList.value.length && totalItems.value > 0)
    return `Showing ${fromEdge} - ${toEdge} of ${totalItems.value}`;
  return '';
}

const onPageChange = async () => {
  try {
    await loadProductsList();
    router.push(`/search-products?s=${search.value}&page=${page.value}`);
  } catch (e: any) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}

const getProductLink = (sku: string, isVariation: boolean) => {
  if (isVariation)
    return `/?sku=${sku.toUpperCase()}`;
  else
    return `/`
}

const replaceDropboxLink = (url: string | undefined, queryParam: string) => {
  if (url) {
    const withoutQueryParam = url.replace(/[?&](dl|raw)=\d/g, '');

    const separator = withoutQueryParam.includes('?') ? '&' : '?';
    return `${withoutQueryParam}${separator}${queryParam}`;
  }
  return url || '';
}

const updateAttributeFilter = async(attributeSlug: string, attributeValue: any) => {
  try {
    attributesFilter.value[attributeSlug] = attributeValue;
    await loadProductsList();
  } catch (e: any) {
    console.error(e);
  }
}

const loadAttributes = async () => {
  try {
    isLoading.value = true;
    const { data, error } = await supabase
      .from('attributes')
      .select(`*, attribute_value(
        id,
        attribute_id,
        value,
        material:material_id(
          id,
          name
        ),
        color:color_id(
          id,
          name,
          material_id
        ),
        gas:gas_id(
          id,
          name
        ),
        ignition:ignition_id(
          id,
          name
        )
      )`);
    if (error) throw error;
    data.forEach((attr: any) => {
      console.log(attr)
      const values = attr.attribute_value.map((attrVal: any) => {
        console.log('AttrVal', attrVal);
        let value = null;
        value = attrVal?.value ??
          attrVal?.color?.name ??
          attrVal?.material?.name ??
          attrVal?.gas?.name ??
          attrVal?.ignition?.name ??
          null;
        return {
          value,
          value_id: attrVal.id,
          attribute_id: attrVal.attribute_id,
          material_id: attrVal?.color?.material_id || attrVal?.material?.id || null
        }
      });
      values.unshift({ value: 'All', value_id: null, attribute_id: null, material_id: null });
      const attribute = {
        ...attr,
        attribute_value: values,
      }
      attributes.value[attr.slug] = attribute;
      attributesFilter.value[attr.slug] = { value: 'All', value_id: null, attribute_id: null, material_id: null };
    });
    console.log(attributes.value);
  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}

const showAttributes = (attribute: any) => {
  if (attribute.slug === 'color') {
    if (attributesFilter?.value?.material?.value_id === null) {
      return false;
    }
    if (!attribute.attribute_value.filter((val: any) => val?.material_id === attributesFilter.value?.material?.material_id).length) {
      return false;
    }
    return true;
  }
  return true;
}
</script>

