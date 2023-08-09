<template>
  <div>
    <div class="tw-w-full tw-text-center">
      <h1 class="tw-text-3xl tw-font-bold">Quick View Pricing Tool</h1>
      <span class="tw-text-base">Enter SKU in the search bar below</span>
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

      </div>
      <div class="tw-w-full lg:tw-w-5/12">
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
        <h3 v-show="product && allSpecSheets.length" class="tw-text-xl tw-font-bold tw-my-8">Specification Sheets:</h3>
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
                color="green-darken-2"
                text="PREVIEW"
                @click="previewPdf(specSheet?.previewUrl || '')"
              ></v-btn>
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
          <div v-if="showPDF && showPDF.pages && showPDF.pages">
            <div v-if="showPDF.pages > 1">
              <v-btn
                @click="page = page > 1 ? page - 1 : page"
              >
                Prev
              </v-btn>
              <span>{{ page }} / {{ showPDF.pages }}</span>
              <v-btn
                @click="page = page < showPDF.pages ? page + 1 : page"
              >
                Prev
              </v-btn>
            </div>
            <VuePDF :pdf="showPDF.pdf" :page="page"></VuePDF>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { supabase } from '@/supabase';
import { ref, computed, Ref } from 'vue';
import { Product as BaseProduct, Image } from '@/types/product';
import { VuePDF, usePDF } from '@tato30/vue-pdf';

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

const skuSearch = ref('');
const isLoading = ref(false);
const page = ref(1);
const product: Ref<Product | undefined> = ref<Product | undefined>({});
const images: Ref<Img[]> = ref<Img[]>([]);
const parentImages: Ref<Img[]> = ref<Img[]>([]);
const specSheets: Ref<SpecSheet[]> = ref<SpecSheet[]>([]);
const parentSpecSheets: Ref<SpecSheet[]> = ref<SpecSheet[]>([]);
const pdfToPreview: Ref<{ url?: string | null }> = ref<{ url?: string | null}>({
  url: null,
});

const showPDF: Ref<{
  pdf: any,
  pages: any,
}> = ref({
  pdf: null,
  pages: null,
})

const previewPdf = (url: string) => {
  pdfToPreview.value.url = url;
  let pdf = null;
  let pages = null;
  if (pdfToPreview.value && pdfToPreview.value.url) {
    const { pdf: pdfFile, pages: pagesCount } = usePDF(pdfToPreview.value.url);
    pdf = pdfFile;
    pages = pagesCount;
  }

  showPDF.value.pages = pages;
  showPDF.value.pdf = pdf;
};

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
}

const loadProductInformation = async () => {
  try {
    isLoading.value = true;
    product.value = await loadProduct();
    console.log(product.value);
    if (product.value) {
      images.value = await loadImages(product.value?.id!) || [];
      specSheets.value = await loadSpecificationSheets(product.value?.id!) || [];
      if (product.value.parent_id) {
        parentImages.value = await loadImages(product.value.parent_id) || [];
        parentSpecSheets.value = await loadSpecificationSheets(product.value.parent_id) || [];
      }
    }
  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}

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
      .eq(`sku`, skuSearch.value)
      .limit(1)
      .single();
    if (error) throw error;
    return product as unknown as Product;
  } catch(e: any) {
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
</script>
