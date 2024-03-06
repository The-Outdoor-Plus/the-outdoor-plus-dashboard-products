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
              <v-checkbox
                v-model="enabled.value.value"
                color="green-darken-1"
                label="Enable Product"
                :readonly="readonly"
              ></v-checkbox>
            </v-col>
            <v-col
              cols="12"
              sm="6"
              md="5"
              lg="3"
              xl="2"
            >
              <v-checkbox
                v-model="published.value.value"
                color="blue-darken-1"
                label="Publish Product"
                :readonly="readonly"
              ></v-checkbox>
            </v-col>
          </v-row>
          <span class="tw-text-sm tw-text-gray-500"><b>Enable product: </b>If checked, it means that the product is enabled for display on the dashboard and on the quick view pricing tool. This will allow dealers and sales to see the details about the product.</span>
          <br>
          <span class="tw-text-sm tw-text-gray-500"><b>Publish product: </b>If checked, it means the product is ready to be published on the website and ready to start selling.</span>
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
        <!-- <v-divider v-if="isVariation" class="border-opacity-100 tw-my-6"></v-divider> -->
        <!-- <div v-if="isVariation" class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
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
        </div> -->
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Product Type</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-select
              v-model="productType.value.value"
              variant="outlined"
              density="compact"
              name="ProductType"
              placeholder="Product Type"
              :items="productStore.productTypes"
              :readonly="readonly"
              :error-messages="productType.errorMessage.value"
            >
            </v-select>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12 tw-pr-4">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Company Division</h3>
            <span class="tw-text-sm tw-text-gray-500">This defines which company division is the product from. The Outdoor Plus, Diamond Grills BBQ, TOP Flames, TFL, etc.</span>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-text-field
              v-model="companyDivision.value.value"
              variant="outlined"
              density="compact"
              name="Division"
              placeholder="The Outdoor Plus"
              :error-messages="companyDivision.errorMessage.value"
              :readonly="readonly"
            >
            </v-text-field>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12 tw-pr-4">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Product Serial Base</h3>
            <span class="tw-text-sm tw-text-gray-500">This will define the starting text part of the serial. E.g: E110-23</span>
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
            >
            </v-text-field>
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
                  :items="yearToShowList(priceType.key as keyof PriceData)"
                  :readonly="readonly"
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
                  :readonly="readonly"
                ></v-text-field>
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
              :clearable="!readonly"
              :items="itemsList.collection"
              :error-messages="collectionId.errorMessage.value"
              :loading="itemsLoading.collectionLoading"
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
              :clearable="!readonly"
              :items="itemsList.category"
              :error-messages="categoryId.errorMessage.value"
              :loading="itemsLoading.categoryLoading"
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
              :clearable="!readonly"
              :items="itemsList.shape"
              :error-messages="shapeId.errorMessage.value"
              :loading="itemsLoading.shapeLoading"
              :readonly="readonly"
            >
            </v-autocomplete>
          </div>
        </div>
        <!-- <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12 tw-pr-4">
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
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Colors</h3>
            <span class="tw-text-sm tw-text-gray-500"></span>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-autocomplete
              v-model="productAttrs.colors.value"
              variant="outlined"
              density="compact"
              name="Colors"
              placeholder="Colors"
              item-title="name"
              item-value="id"
              :clearable="!readonly"
              :closable-chips="!readonly"
              :multiple="isParent || isParentGroup"
              :chips="isParent || isParentGroup"
              :items="itemsList.color"
              :error-messages="colorId.errorMessage.value"
              :loading="itemsLoading.colorLoading"
              :readonly="readonly"
            >
            </v-autocomplete>
          </div>
        </div> -->
        <!-- <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Ignition Types</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-autocomplete
              v-model="productAttrs.ignitionTypes.value"
              variant="outlined"
              density="compact"
              name="Ignition"
              placeholder="Ignition Type"
              item-title="name"
              item-value="id"
              :clearable="!readonly"
              :closable-chips="!readonly"
              multiple
              chips
              :items="itemsList.ignition"
              :error-messages="ignitionId.errorMessage.value"
              :loading="itemsLoading.ignitionLoading"
              :readonly="readonly"
            >
            </v-autocomplete>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Gas Types</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-autocomplete
              v-model="productAttrs.gasTypes.value"
              variant="outlined"
              density="compact"
              name="Gas"
              placeholder="Gas Type"
              item-title="name"
              item-value="id"
              :clearable="!readonly"
              :closable-chips="!readonly"
              multiple
              chips
              :items="itemsList.gas"
              :error-messages="gasId.errorMessage.value"
              :loading="itemsLoading.gasLoading"
              :readonly="readonly"
            >
            </v-autocomplete>
          </div>
        </div> -->
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Images</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12">
            <h3 class="tw-text-base tw-font-semibold"></h3>
            <div
              v-for="(image, i) in images"
              :key="i"
              class="tw-mb-10"
            >
              <div
                class="tw-flex tw-items-center tw-w-full tw-mt-4 tw-mb-2"
              >
                <v-text-field
                  v-model="image.name"
                  class="tw-w-4/12 tw-mr-6"
                  label="Name"
                  variant="outlined"
                  density="compact"
                  hide-details
                  :readonly="readonly"
                >
                </v-text-field>
                <v-text-field
                  v-model="image.url"
                  class="tw-w-6/12 tw-mr-6"
                  label="Url"
                  variant="outlined"
                  density="compact"
                  hide-details
                  :readonly="readonly"
                ></v-text-field>
                <v-btn
                  v-if="!readonly"
                  size="small"
                  class="ml-2"
                  icon="mdi-close"
                  variant="text"
                  @click="removeImageFromList(image)"
                ></v-btn>
              </div>
              <div
                class="tw-flex tw-items-center tw-10/12 lg:tw-w-8/12 tw-mt-4 tw-mb-2"
              >
                <v-select
                  v-model="image.display_order"
                  :items="[...Array(images.length).keys()]"
                  class="tw-w-2/12 2xl:tw-w-1/12"
                  label="Position"
                  variant="outlined"
                  density="compact"
                  hide-details
                  :readonly="readonly"
                ></v-select>
                <v-checkbox
                  v-model="image.is_primary"
                  color="blue-darken-1"
                  label="Is Primary?"
                  class="-tw-mb-5 tw-ml-6"
                  :readonly="readonly"
                  @click="toggleImageIsPrimary(image.id, image.is_primary)"
                ></v-checkbox>
              </div>
            </div>
            <v-btn
              v-if="!readonly"
              color="teal-darken-2"
              class="px-2 tw-mt-2 tw-mb-5"
              size="small"
              @click="addImage"
            >
              Add Image
              <v-icon icon="mdi-plus" class="ml-2"></v-icon>
            </v-btn>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Specification Sheets</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12">
            <h3 class="tw-text-base tw-font-semibold"></h3>
            <div
              v-for="(specSheet, i) in specificationSheets"
              :key="`spec-${i}`"
              class="tw-mb-4"
            >
              <div
                class="tw-flex tw-items-center tw-w-full tw-mt-4 tw-mb-2"
              >
                <v-text-field
                  v-model="specSheet.name"
                  class="tw-w-4/12 tw-mr-6"
                  label="Name"
                  variant="outlined"
                  density="compact"
                  hide-details
                  :readonly="readonly"
                >
                </v-text-field>
                <v-text-field
                  v-model="specSheet.url"
                  class="tw-w-6/12 tw-mr-6"
                  label="Url"
                  variant="outlined"
                  density="compact"
                  hide-details
                  :readonly="readonly"
                ></v-text-field>
                <v-btn
                  v-if="!readonly"
                  size="small"
                  class="ml-2"
                  icon="mdi-close"
                  variant="text"
                  @click="removeSpecSheetFromList(specSheet)"
                ></v-btn>
              </div>
            </div>
            <v-btn
              v-if="!readonly"
              color="teal-darken-2"
              class="px-2 tw-mt-2 tw-mb-5"
              size="small"
              @click="addSpecificationSheet"
            >
              Add Spec Sheet
              <v-icon icon="mdi-plus" class="ml-2"></v-icon>
            </v-btn>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Documents</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12">
            <h3 class="tw-text-base tw-font-semibold"></h3>
            <div
              v-for="(doc, i) in documents"
              :key="`doc-${i}`"
              class="tw-mb-4"
            >
              <div
                class="tw-flex tw-items-center tw-w-full tw-mt-4 tw-mb-2"
              >
                <v-text-field
                  v-model="doc.name"
                  class="tw-w-4/12 tw-mr-6"
                  label="Name"
                  variant="outlined"
                  density="compact"
                  hide-details
                  :readonly="readonly"
                >
                </v-text-field>
                <v-text-field
                  v-model="doc.url"
                  class="tw-w-6/12 tw-mr-6"
                  label="Url"
                  variant="outlined"
                  density="compact"
                  hide-details
                  :readonly="readonly"
                ></v-text-field>
                <v-btn
                  v-if="!readonly"
                  size="small"
                  class="ml-2"
                  icon="mdi-close"
                  variant="text"
                  @click="removeDocFromList(doc)"
                ></v-btn>
              </div>
            </div>
            <v-btn
              v-if="!readonly"
              color="teal-darken-2"
              class="px-2 tw-mt-2 tw-mb-5"
              size="small"
              @click="addDocuments"
            >
              Add Document
              <v-icon icon="mdi-plus" class="ml-2"></v-icon>
            </v-btn>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Attributes</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-8/12">
            <div class="tw-flex lg:tw-w-7/12">
              <h3 class="tw-text-base tw-font-semibold"></h3>
              <div class="md:tw-w-8/12">
                <v-autocomplete
                  v-if="!readonly"
                  v-model="attributeId"
                  variant="outlined"
                  density="compact"
                  name="Attribute"
                  placeholder="Attribute"
                  item-title="name"
                  item-value="id"
                  :clearable="!readonly"
                  :items="availableAttributesList"
                  :loading="attributesLoading"
                  :readonly="readonly"
                ></v-autocomplete>
              </div>
              <div class="md:tw-w-4/12 md:tw-ml-6">
                <v-btn
                  v-if="!readonly"
                  color="teal-darken-2"
                  class="px-2 tw-mt-2 tw-mb-5"
                  size="small"
                  :disabled="!attributeId"
                  @click="addAttribute"
                >
                  Add Attribute
                  <v-icon icon="mdi-plus" class="ml-2"></v-icon>
                </v-btn>
              </div>
            </div>
            <v-expansion-panels v-if="attributes.length" variant="accordion" class="tw-mb-6 tw-mt-4 tw-w-full">
              <v-expansion-panel v-for="(attribute, i) in attributes" :key="`attribute-${i}`" elevation="0">
                <v-expansion-panel-title color="grey-lighten-4">{{ attribute.name }}</v-expansion-panel-title>
                <v-expansion-panel-text>
                  <div class="tw-flex">
                    <div class="tw-w-4/12">
                      <div class="tw-ml-3">
                        Name: <br>
                        <span class="tw-font-bold">{{ attribute.name }}</span>
                      </div>
                      <v-checkbox
                        v-model="attribute.fill_values"
                        color="blue-darken-1"
                        label="Fill with all values"
                        :readonly="readonly"
                        hide-details
                        @update:model-value="onFillValueChange($event, attribute.id as number)"
                      ></v-checkbox>
                      <!-- <div v-if="attribute.table_name === 'color'" class="tw-ml-3 tw-text-sm">
                        By selecting fill with all values, it will only include all color values associated with the selected material.
                      </div> -->
                    </div>
                    <div class="tw-w-7/12">
                      <v-autocomplete
                        v-if="!attribute.fill_values"
                        v-model="attributes[i].attribute_value"
                        variant="outlined"
                        :name="`Attribute${attribute.name}`"
                        multiple
                        chips
                        :clearable="!readonly"
                        :closable-chips="!readonly"
                        :item-title="getAttributeItemValue(attribute.table_name)"
                        item-value="id"
                        :loading="isAttributeValuesLoading"
                        :items="attributeValuesList[attribute.id as number]"
                        :readonly="readonly"
                        @update:model-value="onAttributeValueChange($event, attribute.id as number)"
                      ></v-autocomplete>
                      <div
                        v-else
                        class=""
                      >
                        By selecting fill with all values the product will automatically populate with all values created for the attribute. This means adding a value
                        to the attribute in the future will also be a part of the product.
                        <template v-if="attribute.table_name === 'color'">For color attributes, it will only include all color values associated with the selected material(s).</template>
                        <template v-else>
                          This is hepfull mostly for color attributes, for when we add a a new color,
                          we don't have to update every product by adding the new color value.
                        </template>
                      </div>
                    </div>
                    <div v-if="!readonly" class="tw-w-1/12 tw-flex tw-justify-center tw-items-center">
                      <v-btn
                        size="small"
                        icon="mdi-delete"
                        variant="text"
                        color="red"
                        @click="removeAttribute(attribute.id as number)"
                      >
                      </v-btn>
                    </div>
                  </div>
                </v-expansion-panel-text>
              </v-expansion-panel>
            </v-expansion-panels>
            <div v-else>
              No attributes set for this product.
            </div>
          </div>
        </div>
        <v-expansion-panels variant="accordion" class="tw-mb-6 tw-mt-4 tw-w-full">
          <v-expansion-panel elevation="0">
            <v-expansion-panel-title color="grey-lighten-4">More Information</v-expansion-panel-title>
            <v-expansion-panel-text>
              <!-- <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row tw-mt-4">
                <div class="tw-w-full lg:tw-w-3/12">
                  <h3 class="tw-text-base tw-font-semibold tw-mt-1">Base Material</h3>
                  <span class="tw-text-sm tw-text-gray-500">If applicable.</span>
                </div>
                <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
                  <v-autocomplete
                    v-model="baseMaterialId.value.value"
                    variant="outlined"
                    density="compact"
                    name="Material"
                    placeholder="Material"
                    item-title="name"
                    item-value="id"
                    :clearable="!readonly"
                    :items="itemsList.material"
                    :error-messages="baseMaterialId.errorMessage.value"
                    :loading="itemsLoading.materialLoading"
                    :readonly="readonly"
                  >
                  </v-autocomplete>
                </div>
              </div>
              <v-divider class="border-opacity-100 tw-my-6"></v-divider>
              <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
                <div class="tw-w-full lg:tw-w-3/12">
                  <h3 class="tw-text-base tw-font-semibold tw-mt-1">Base Colors</h3>
                  <span class="tw-text-sm tw-text-gray-500">If applicable.</span>
                </div>
                <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
                  <v-autocomplete
                    v-model="productAttrs.baseColors.value"
                    variant="outlined"
                    density="compact"
                    name="Colors"
                    placeholder="Colors"
                    item-title="name"
                    item-value="id"
                    :clearable="!readonly"
                    :closable-chips="!readonly"
                    :multiple="isParent || isParentGroup"
                    :chips="isParent || isParentGroup"
                    :items="itemsList.baseColor"
                    :error-messages="baseColorId.errorMessage.value"
                    :loading="itemsLoading.baseColorLoading"
                    :readonly="readonly"
                  >
                  </v-autocomplete>
                </div>
              </div>
              <v-divider class="border-opacity-100 tw-my-6"></v-divider> -->
              <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
                <div class="tw-w-full lg:tw-w-3/12">
                  <h3 class="tw-text-base tw-font-semibold tw-mt-1">Certifications</h3>
                </div>
                <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-9/12 tw-flex">
                  <v-checkbox
                    v-model="certifications"
                    color="blue-darken-1"
                    label="CSA Certified"
                    value="CSA"
                    :readonly="readonly"
                  ></v-checkbox>
                  <v-checkbox
                    v-model="certifications"
                    color="green-darken-2"
                    label="LC Certified"
                    value="LC"
                    :readonly="readonly"
                  ></v-checkbox>
                  <v-checkbox
                    v-model="certifications"
                    color="indigo"
                    label="UL Certified"
                    value="UL"
                    :readonly="readonly"
                  ></v-checkbox>
                </div>
              </div>
              <v-divider class="border-opacity-100 tw-my-6"></v-divider>
              <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
                <div class="tw-w-full lg:tw-w-3/12">
                  <h3 class="tw-text-base tw-font-semibold tw-mt-1">Short Description</h3>
                </div>
                <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
                  <v-textarea
                    v-model="shortDescription.value.value"
                    variant="outlined"
                    density="compact"
                    name="SDescription"
                    placeholder="Short Description"
                    :error-messages="shortDescription.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-textarea>
                </div>
              </div>
              <v-divider class="border-opacity-100 tw-my-6"></v-divider>
              <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
                <div class="tw-w-full lg:tw-w-3/12">
                  <h3 class="tw-text-base tw-font-semibold tw-mt-1">Description</h3>
                </div>
                <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-9/12 xl:tw-w-6/12">
                  <v-textarea
                    v-model="description.value.value"
                    variant="outlined"
                    density="compact"
                    name="Description"
                    placeholder="Description"
                    :error-messages="description.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-textarea>
                </div>
              </div>
              <v-divider class="border-opacity-100 tw-my-6"></v-divider>
              <!-- <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
                <div class="tw-w-full lg:tw-w-3/12 tw-pr-4">
                  <h3 class="tw-text-base tw-font-semibold tw-mt-1">Product Dimensions</h3>
                </div>
                <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 tw-flex tw-flex-wrap tw-flex-col lg:tw-flex-row lg:tw-gap-8">
                  <v-combobox
                    v-model="length"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="PLength"
                    placeholder="Product Length"
                    :clearable="!readonly"
                    :closable-chips="!readonly"
                    :multiple="isParent"
                    :chips="isParent"
                    :items="productStore.sizes"
                    :error-messages="productLength.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-combobox>
                  <v-combobox
                    v-model="diameter"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="PDiameter"
                    placeholder="Product Diameter"
                    :clearable="!readonly"
                    :closable-chips="!readonly"
                    :multiple="isParent"
                    :chips="isParent"
                    :items="productStore.sizes"
                    :error-messages="productDiameter.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-combobox>
                  <v-text-field
                    v-model="productWidth.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="PWidth"
                    placeholder="Product Width"
                    label="Product Width"
                    :error-messages="productWidth.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                  <v-text-field
                    v-model="productHeight.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="PHeight"
                    placeholder="Product Height"
                    label="Prodcut Height"
                    :error-messages="productHeight.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                </div>
              </div>
              <v-divider class="border-opacity-100 tw-my-6"></v-divider>
              <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
                <div class="tw-w-full lg:tw-w-3/12 tw-pr-4">
                  <h3 class="tw-text-base tw-font-semibold tw-mt-1">Base Dimensions</h3>
                </div>
                <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 tw-flex tw-flex-wrap tw-flex-col lg:tw-flex-row lg:tw-gap-8">
                  <v-text-field
                    v-model="baseLength.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="BLength"
                    placeholder="Base Length"
                    label="Base Length"
                    :error-messages="baseLength.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                  <v-text-field
                    v-model="baseDiameter.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="BDiameter"
                    placeholder="Base Diameter"
                    label="Base Diamater"
                    :error-messages="baseDiameter.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                  <v-text-field
                    v-model="baseWidth.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="BWidth"
                    placeholder="Base Width"
                    label="Base Width"
                    :error-messages="baseWidth.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                  <v-text-field
                    v-model="baseOpening.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="BOpening"
                    placeholder="Base Opening"
                    label="Base Opening"
                    :error-messages="baseOpening.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                </div>
              </div>
              <v-divider class="border-opacity-100 tw-my-6"></v-divider>
              <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
                <div class="tw-w-full lg:tw-w-3/12 tw-pr-4">
                  <h3 class="tw-text-base tw-font-semibold tw-mt-1">Scupper Attributes</h3>
                </div>
                <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 tw-flex tw-flex-wrap tw-flex-col lg:tw-flex-row lg:tw-gap-8">
                  <v-text-field
                    v-model="scupperWidth.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="SWidth"
                    placeholder="Scupper Width"
                    label="Scupper Width"
                    :error-messages="scupperWidth.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                  <v-text-field
                    v-model="scupperInletOpening.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="SInlet"
                    placeholder="Scupper Inlet Opening"
                    label="Scupper Inlet Opening"
                    :error-messages="scupperInletOpening.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                  <v-text-field
                    v-model="gpm.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="SGpm"
                    placeholder="GPM"
                    label="GPM"
                    :error-messages="gpm.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                </div>
              </div>
              <v-divider class="border-opacity-100 tw-my-6"></v-divider>
              <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
                <div class="tw-w-full lg:tw-w-3/12 tw-pr-4">
                  <h3 class="tw-text-base tw-font-semibold tw-mt-1">BA Dimensions</h3>
                </div>
                <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 tw-flex tw-flex-wrap tw-flex-col lg:tw-flex-row lg:tw-gap-8">
                  <v-text-field
                    v-model="baLength.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="BALength"
                    placeholder="BA Length"
                    label="BA Length"
                    :error-messages="baLength.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                  <v-text-field
                    v-model="baDiameter.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="BADiameter"
                    placeholder="BA Diameter"
                    label="BA Diamater"
                    :error-messages="baDiameter.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                  <v-text-field
                    v-model="baWidth.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="BAWidth"
                    placeholder="BA Width"
                    label="BA Width"
                    :error-messages="baWidth.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                  <v-text-field
                    v-model="baDepth.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="BADepth"
                    placeholder="BA Depth"
                    label="BA Depth"
                    :error-messages="baDepth.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                </div>
              </div>
              <v-divider class="border-opacity-100 tw-my-6"></v-divider> -->
              <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
                <div class="tw-w-full lg:tw-w-3/12 tw-pr-4">
                  <h3 class="tw-text-base tw-font-semibold tw-mt-1">Burner Dimensions</h3>
                </div>
                <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 tw-flex tw-flex-wrap tw-flex-col lg:tw-flex-row lg:tw-gap-8">
                  <!-- <v-text-field
                    v-model="burnerLength.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="BurnerLength"
                    placeholder="Burner Length"
                    label="Burner Length"
                    :error-messages="burnerLength.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                  <v-text-field
                    v-model="burnerDiameter.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="BurnerDiameter"
                    placeholder="Burner Diameter"
                    label="Burner Diameter"
                    :error-messages="burnerDiameter.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field> -->
                  <v-text-field
                    v-model="burnerShape.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="BurnerShape"
                    placeholder="Burner Shape"
                    label="Burner Shape"
                    :error-messages="burnerShape.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                </div>
              </div>
              <v-divider class="border-opacity-100 tw-my-6"></v-divider>
              <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
                <div class="tw-w-full lg:tw-w-3/12 tw-pr-4">
                  <h3 class="tw-text-base tw-font-semibold tw-mt-1">Accessories</h3>
                  <span class="tw-text-sm tw-text-gray-500">The value of a compatible accessory <i>must</i> be the SKU from that accessory.</span>
                </div>
                <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 tw-flex tw-flex-wrap tw-flex-col lg:tw-flex-row lg:tw-gap-8">
                  <v-text-field
                    v-model="compatibleCanvasCover.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="CanvasCover"
                    placeholder="Compatible Canvas Cover"
                    label="Compatible Canvas Cover"
                    :error-messages="compatibleCanvasCover.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                  <v-text-field
                    v-model="compatibleBulletBurner.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="BulletBurner"
                    placeholder="Compatible Bullet Burner"
                    label="Compatible Bullet Burner"
                    :error-messages="compatibleBulletBurner.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                  <v-text-field
                    v-model="compatibleGlassWindGuard.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="GlassWindGuard"
                    placeholder="Compatible Glass Wind Guard"
                    label="Compatible Glass Wind Guard"
                    :error-messages="compatibleGlassWindGuard.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                  <v-checkbox
                    v-model="accessDoor.value.value"
                    class="tw-w-full lg:tw-w-5/12 -tw-mt-1"
                    color="green-darken-1"
                    label="Has Access Door?"
                    :readonly="readonly"
                  ></v-checkbox>
                </div>
              </div>
              <!-- <v-divider class="border-opacity-100 tw-my-6"></v-divider>
              <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
                <div class="tw-w-full lg:tw-w-3/12 tw-pr-4">
                  <h3 class="tw-text-base tw-font-semibold tw-mt-1">Extra Attributes</h3>
                </div>
                <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 tw-flex tw-flex-wrap tw-flex-col lg:tw-flex-row lg:tw-gap-8">
                  <v-text-field
                    v-model="toeKick.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="ToeKick"
                    placeholder="Toe Kick"
                    label="Toe Kick"
                    :error-messages="toeKick.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                  <v-text-field
                    v-model="fireGlass.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="FireGlass"
                    placeholder="Fire Glass"
                    label="Fire Glass"
                    :error-messages="fireGlass.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                  <v-text-field
                    v-model="soilUsage.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="SoilUsage"
                    placeholder="Soil Usage"
                    label="Soil Usage"
                    :error-messages="soilUsage.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-text-field>
                </div>
              </div> -->
            </v-expansion-panel-text>
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
  Image,
  ItemsList,
  Price,
  PriceData,
  Product,
  Props,
  SpecificationSheet,
  Documents,
  Attribute,
  AttributeValue,
  AttributeValues
} from '@/types/product';

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

const itemsLoading = ref({
  categoryLoading: false,
  collectionLoading: false,
  shapeLoading: false,
  // colorLoading: false,
  // materialLoading: false,
  // baseColorLoading: false,
  // -------------------------------
  // TODO: Change to attribute
  gasLoading: false,
  // TODO: Change to attribute
  ignitionLoading: false,
});

const itemsList: Ref<ItemsList> = ref<ItemsList>({
  category: [],
  collection: [],
  shape: [],
  // gas: [],
  // ignition: [],
});

const loadItemsList = async (itemType: keyof ItemsList) => {
  try {
    itemsLoading.value[`${itemType}Loading`] = true;
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
    itemsLoading.value[`${itemType}Loading`] = false;
  }
}

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
};

const removeYearFromList = (priceType: keyof PriceData, item: Price) => {
  prices.value[priceType] = prices.value[priceType].filter((priceItem) => priceItem.year !== item.year);
}

onMounted(async () => {
  await loadItemsList('category');
  await loadItemsList('collection');
  await loadItemsList('shape');
  await loadAttributesList();
  // await loadItemsList('gas');
  // await loadItemsList('ignition');
  // await loadItemsList('material');

  yearList.value = generateYearList(new Date().getFullYear());
});

const loadAttributesList = async () => {
  try {
    attributesLoading.value = true;
    const { data, error } = await supabase
      .from('attributes')
      .select('id, name');
    if (error) throw error;
    attributesList.value = data;
  } catch (e: any) {
    console.error(e);
    notify({
      title: `Error loading attributes list`,
      text: e?.message || `An error occurred trying to load attributes list. Please contact TOP Support.`,
      type: 'error',
      duration: 6000,
    });
  } finally {
    attributesLoading.value = false;
  }
}

const attributesLoading = ref(false);
const attributeId: Ref<number | null> = ref<number | null>(null);
const attributesList: Ref<Attribute[]> = ref<Attribute[]>([]);
const attributeValuesList: Ref<AttributeValues> = ref<AttributeValues>({});
const attributesIds: Ref<number[]> = ref<number[]>([0]);
const attributes: Ref<Attribute[]> = ref<Attribute[]>([]);
const attributesToRemove: Ref<number[]> = ref<number[]>([]);
const attributesToAdd: Ref<number[]> = ref<number[]>([]);
const attributeValuesToRemove: Ref<number[]> = ref<number[]>([]);
const currentAttributes: Ref<number[]> = ref<number[]>([]);
const attributeValuesToAdd: Ref<{ [key: number]: number[]}> = ref<{ [key: number]: number[]}>({});
const attributeValuesToDelete: Ref<{ [key: number]: number[]}> = ref<{ [key: number]: number[]}>({});

const availableAttributesList = computed(() => {
  return attributesList.value.filter((attr) => !attributesIds.value.some((id) => attr.id === id));
})

const loadAttribute = async (attrId: number) => {
  try {
    isLoading.value = true;
    const { data, error } = await supabase
      .from('attributes')
      .select('id, name, table_name')
      .eq('id', attrId);
    if (error) throw error;
    if (data) return {
      ...data[0],
      fill_values: true,
    }
  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}

const isAttributeValuesLoading = ref(false);

const isAttributeTable = (tableName: string) => {
  return tableName
    && (tableName === 'gas'
    || tableName === 'color'
    || tableName === 'material'
    || tableName === 'ignition'
    );
}

const getAttributeItemValue = (tableName: string | undefined) => {
  if (tableName) {
    if (isAttributeTable(tableName)) return `${tableName}.name`;
    return 'value';
  }
  return 'value';
}

const loadAttributeValues = async (attrId: number) => {
  try {
    isAttributeValuesLoading.value = true;
    const { data, error } = await supabase
      .from('attribute_value')
      .select('id, attribute_id, value, material(id, name), color(id, name), gas(id, name), ignition(id, name)')
      .eq('attribute_id', attrId);
    if (error) throw error;
    if (data)
      attributeValuesList.value[attrId] = (data as unknown as AttributeValue[]);
  } catch (e) {
    console.error(e);
  } finally {
    isAttributeValuesLoading.value = false;
  }
}

const addAttribute = async () => {
  try {
    isLoading.value = true;
    if (attributeId.value) {
      const attribute = await loadAttribute(attributeId.value);
      if (attribute) {
        attributes.value.push(attribute as unknown as Attribute);
        attributesIds.value.push(attributeId.value);
        await loadAttributeValues(attributeId.value);
      }
      attributeId.value = null;
    }
  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}

const onFillValueChange = (e: any, attributeId: number) => {
  const attribute = props.productAttributes?.find((attr) => attr.id === attributeId);
  const currAttribute = attributes.value.find((attr) => attr.id === attributeId);
  if (attribute) {
    if (!e && attribute.fill_values) {
      if (currAttribute)
        onAttributeValueChange(currAttribute?.attribute_value || [], attributeId);
    }
    if (e && attribute.fill_values) {
      attributeValuesToAdd.value[attributeId] = [];
      attributeValuesToDelete.value[attributeId] = [];
    }
    if (e && !attribute.fill_values) {
      attributeValuesToDelete.value[attributeId] = attribute.attribute_value as number[];
      if (currAttribute) {
        currAttribute?.attribute_value?.forEach((attr) => {
          if (attributeValuesToAdd.value[attributeId] && attributeValuesToAdd.value[attributeId].length)
            attributeValuesToAdd.value[attributeId] = attributeValuesToAdd.value[attributeId].filter((id) => id !== attr);
        });
      }
    }
    if (!e && !attribute.fill_values) {
      if (attributeValuesToAdd.value[attributeId] && attributeValuesToAdd.value[attributeId].length) {
        attributeValuesToAdd.value[attributeId] = attributeValuesToAdd.value[attributeId].filter((attr) => {
          return (attribute.attribute_value as number[])?.includes(attr);
        });
      }
      if (attributeValuesToDelete.value[attributeId] && attributeValuesToDelete.value[attributeId].length) {
        attributeValuesToDelete.value[attributeId] = attributeValuesToDelete.value[attributeId].filter((attr) => {
          return !(attribute.attribute_value as number[])?.includes(attr);
        });
      }
      if (currAttribute) {
        onAttributeValueChange(currAttribute?.attribute_value || [], attributeId);
      }
    }
  } else {
    if (e)
        attributeValuesToAdd.value[attributeId] = [];
      if (!e)
        if (currAttribute)
          onAttributeValueChange(currAttribute?.attribute_value || [], attributeId);
  }

}

const onAttributeValueChange = (e: any, attributeId: number) => {
  const attrValues = props.productAttributes?.find((attr) => attr.id === attributeId)?.attribute_value as number[] || [];
  const { addedIds, deletedIds } = compareAttributes(attrValues, e);
  attributeValuesToAdd.value[attributeId] = addedIds;
  attributeValuesToDelete.value[attributeId] = deletedIds;
  console.log('Added', addedIds);
  console.log('Deleted', deletedIds);
  // attributesToRemove.value.filter((attr))
}

const compareAttributes = (currentIds: number[], newIds: number[]) => {
  const addedIds = [];
  const deletedIds = [];

  addedIds.push(...newIds.filter(id => !currentIds.includes(id)));
  deletedIds.push(...currentIds.filter((id) => !newIds.includes(id)));

  return { addedIds, deletedIds };
}

const setAttributes = async (productId: number) => {
  try {
    isLoading.value = true;
    const saveProductAttributes: Promise<any>[] = [];
    const saveProductConfigurations: Promise<any>[] = [];
    const deleteProductAttributes: Promise<any>[] = [];
    const deleteProductConfigurations: Promise<any>[] = [];
    let attributeValues: number[] = [];
    // let attributeValuesToAdd: number[] = [];
    // let attributeValuesToDelete: number[] = [];

    if (props.edit) {
      const attrs = JSON.parse(JSON.stringify(attributes.value.map((attr) => attr?.id)));

      // attributesToAdd.value = JSON.parse(JSON.stringify(attributes.value.map((attr) => attr?.id || 0)));
      attributesToAdd.value = attrs.filter((attrToAdd: number) => !currentAttributes.value?.includes(attrToAdd));
      // attributesToRemove.value = attributesToRemove.value.filter((attrToRemove) => !attributesToAdd.value.includes(attrToRemove));
      attributesToRemove.value = JSON.parse(JSON.stringify((currentAttributes.value)));
      attributesToRemove.value = attributesToRemove.value.filter((attrToRemove: number) => !attrs.includes(attrToRemove));
      attributesToRemove.value.forEach((attr) => {
        deleteProductAttributes.push(deleteProductAttribute(productId, attr));
      });
      attributes.value.forEach((attribute: Attribute) => {
        if (attributesToAdd.value.includes(attribute?.id || 0)) {
          saveProductAttributes.push(saveProductAttribute(productId, attribute));
        }
      });
      const valuesToDelete = Object.values(attributeValuesToDelete.value).flatMap(value => value);
      const valuesToAdd = Object.values(attributeValuesToAdd.value).flatMap(value => value);

      valuesToAdd.forEach((valueId) => saveProductConfigurations.push(saveProductConfiguration(productId, valueId)));
      valuesToDelete.forEach((valueId) => deleteProductConfigurations.push(deleteProductConfiguration(productId, valueId)));
    } else {
      attributes.value.forEach((attribute: Attribute) => {
        saveProductAttributes.push(saveProductAttribute(productId, attribute));
        if (!attribute.fill_values) {
          attributeValues.push(...(attribute.attribute_value as number[]));
        }
      });
      attributeValues.forEach((attributeValue) => {
        saveProductConfigurations.push(saveProductConfiguration(productId, attributeValue));
      });
    }

    const deleteAttributePromiseResult = await Promise.allSettled(deleteProductAttributes);
    const deleteConfigurationPromiseResult = await Promise.allSettled(deleteProductConfigurations);
    const attributePromiseResult = await Promise.allSettled(saveProductAttributes);
    const configurationPromiseResult = await Promise.allSettled(saveProductConfigurations);
  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}

const saveProductAttribute = async (productId: number, payload: Attribute) => {
  try {
    isLoading.value = true;
    const form = {
      product_id: productId,
      attribute_id: payload.id,
      fill_values: payload.fill_values,
    };
    const { error } = await supabase
      .from('product_attribute')
      .insert(form);
    if (error) throw error;
  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}

const saveProductConfiguration = async (productId: number, valueId: number) => {
  try {
    isLoading.value = true;
    const form = {
      product_id: productId,
      value_id: valueId
    };
    const { error } = await supabase
      .from('product_configuration')
      .insert(form);
    if (error) throw error;
  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}

const deleteProductAttribute = async (productId: number, valueId: number) => {
  try {
    isLoading.value = true;
    const { error } = await supabase
      .from('product_attribute')
      .delete()
      .match({ product_id: productId, attribute_id: valueId });
    if (error) throw error;
  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}

const deleteProductConfiguration = async (productId: number, valueId: number) => {
  try {
    isLoading.value = true;
    const { error } = await supabase
      .from('product_configuration')
      .delete()
      .match({ product_id: productId, value_id: valueId });
    if (error) throw error;
  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}

const removeAttribute = async (attributeId: number) => {
  attributesToRemove.value.push(attributeId);
  attributesToRemove.value = [...new Set(attributesToRemove.value)];
  const attrToRemove = attributes.value.find((attr) => attr.id === attributeId);
  if (attrToRemove?.attribute_value?.length) {
    const attribute = props.productAttributes?.find((attr) => attr.id === attributeId);
    attributeValuesToAdd.value[attributeId] = [];
    if (attribute) {
      if (!attributeValuesToDelete.value[attributeId])
        attributeValuesToDelete.value[attributeId] = [];
      attributeValuesToDelete.value[attributeId].push(...(attribute.attribute_value as number[]));
      attributeValuesToDelete.value[attributeId] = [...new Set(attributeValuesToDelete.value[attributeId])];
    }
    attributeValuesToRemove.value.push(...(attrToRemove.attribute_value as number[]));
    attributeValuesToRemove.value = [...new Set(attributeValuesToRemove.value)];
  }
  attributes.value = attributes.value.filter((attr) => attr.id !== attributeId);
  attributesIds.value = attributesIds.value.filter((attrIds) => attributeId !== attrIds);
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

const addPrice = (priceType: keyof PriceData) => {
  const lastElement = yearToShowList(priceType)?.slice(-1)?.[0] || new Date().getFullYear();
  const newPrice = { year: lastElement, price: 0 };
  prices.value[priceType].push(newPrice);
}

const images: Ref<Image[]> = ref<Image[]>([]);

const addImage = () => {
  let imagesTemp: Image[] = JSON.parse(JSON.stringify(images.value));
  imagesTemp = imagesTemp.sort((a: Image, b: Image) => (a?.id || 0) - (b?.id || 0))
  const id = imagesTemp.length ? (imagesTemp[imagesTemp.length - 1]?.id || 0) + 1 : 0
  const newImage: Image = {
    id,
    url: '',
    name: '',
    display_order: (images.value.length - 1) + 1,
    is_primary: false,
  }
  images.value.push(newImage);
}

const removeImageFromList = (item: Image) => {
  images.value = images.value.filter((imageItem) => imageItem.id !== item.id);
}

const toggleImageIsPrimary = (imageId?: number | null, value?: boolean) => {
  const valueToSet = !value;
  images.value = images.value.map((img) => ({
    ...img,
    is_primary: img.id === imageId ? valueToSet : false
  }))
}

const specificationSheets: Ref<SpecificationSheet[]> = ref<SpecificationSheet[]>([]);

const addSpecificationSheet = () => {
  let specSheetTemp: SpecificationSheet[] = JSON.parse(JSON.stringify(specificationSheets.value));
  specSheetTemp = specSheetTemp.sort((a: SpecificationSheet, b: SpecificationSheet) => (a?.id || 0) - (b?.id || 0));
  const id = specSheetTemp.length ? (specSheetTemp[specSheetTemp.length - 1]?.id || 0) + 1 : 0;
  const newSpecSheet: SpecificationSheet = {
    id,
    url: '',
    name: '',
  }
  specificationSheets.value.push(newSpecSheet);
}

const removeSpecSheetFromList = (item: SpecificationSheet) => {
  specificationSheets.value = specificationSheets.value.filter((specSheetItem) => specSheetItem.id !== item.id);
}

const documents: Ref<Documents[]> = ref<Documents[]>([]);

const addDocuments = () => {
  let documentsTemp: Documents[] = JSON.parse(JSON.stringify(documents.value));
  documentsTemp = documentsTemp.sort((a: Documents, b: Documents) => (a?.id || 0) - (b?.id || 0));
  const id = documentsTemp.length ? (documentsTemp[documentsTemp.length - 1]?.id || 0) + 1 : 0;
  const newDocument: Documents = {
    id,
    url: '',
    name: '',
  }
  documents.value.push(newDocument);
}

const removeDocFromList = (item: Documents) => {
  documents.value = documents.value.filter((docItem) => docItem.id !== item.id);
}
/**
 *
 * Handle Form
 *
 */

const { handleSubmit, resetForm } = useForm({
  validationSchema: productStore.formValidation,
  initialValues: productStore.initialValues,
});

const name = useField<string>('name');
const sku = useField<string>('sku');
const productType = useField<string>('product_type');
const burnerShape = useField<string>('burner_shape');
const compatibleCanvasCover = useField<string>('compatible_canvas_cover');
const compatibleBulletBurner = useField<string>('compatible_bullet_burner');
const compatibleGlassWindGuard = useField<string>('compatible_glass_wind_guard');
const accessDoor = useField<boolean>('access_door');
const collectionId = useField<number>('collection_id');
const categoryId = useField<number>('category_id');
const shapeId = useField<number>('shape_id');
// const productAttrs: {
//   colors: Ref<number[] | number | null>
//   baseColors: Ref<number[] | number | null>
//   ignitionTypes: Ref<number[] | null>
//   gasTypes: Ref<number[] | null>
// } = {
//   colors: ref<number[] | number>([]),
//   baseColors: ref<number[] | number>([]),
//   ignitionTypes: ref<number[]>([]),
//   gasTypes: ref<number[]>([]),
// }
const productSerialBase = useField<string>('product_serial_base');
const websiteLink = useField<string>('website_link')
const certifications: Ref<string[]> = ref<string[]>([]);
const published = useField<boolean>('published');
const enabled = useField<boolean>('enabled');
const companyDivision = useField<string>('company_division');
const shortDescription = useField<string>('short_description');
const description = useField<string>('description');
// -----------------------------------------------------------------------------
// const materialId = useField<number | null>('material_id');
// const colorId = useField<number>('color_id');
// const length: Ref<string[]> = ref<string[]>([]);
// const diameter: Ref<string[]> = ref<string[]>([]);
// const ignitionId = useField<number>('ignition_id');
// const gasId = useField<number>('gas_id');
// const baseColorId = useField<number>('base_color_id');
// const baseMaterialId = useField<number | null>('base_material_id');
// -----------------------------------------------------------------------------
// const upcCodes = useField<string>('upc_codes');
// const encodedUpcCodes = useField<string>('encoded_upc_codes');
// const productLength = useField<string>('product_length');
// const productDiameter = useField<string>('product_diameter');
// const productWidth = useField<string>('product_width');
// const productHeight = useField<string>('product_height');
// const baseLength = useField<string>('base_length');
// const baseDiameter = useField<string>('base_diameter');
// const baseWidth = useField<string>('base_width');
// const baseOpening = useField<string>('base_opening');
// const toeKick = useField<string>('toe_kick');
// const soilUsage = useField<string>('soil_usage');
// const scupperWidth = useField<string>('scupper_width');
// const scupperInletOpening = useField<string>('scupper_inlet_opening');
// const gpm = useField<string>('gpm');
// const fireGlass = useField<string>('fire_glass');
// const baLength = useField<string>('ba_length');
// const baDiameter = useField<string>('ba_diameter');
// const baWidth = useField<string>('ba_width');
// const baDepth = useField<string>('ba_depth');
// const burnerLength = useField<string>('burner_length');
// const burnerDiameter = useField<string>('burner_diameter');

const fillProductInformation = async () => {
  if (props.edit || props.readonly) {
    // baseMaterialId.value.value = props.product?.base_material_id ?? null;
    // materialId.value.value = props.product?.material_id ?? null;

    // if (props.product?.relation === 'PARENT' || props.product?.relation === 'PARENT_GROUP') {
      // diameter.value = props.product?.product_diameter?.split(',') || [];
      // length.value = props.product?.product_length?.split(',') || [];
    // } else {
      // productAttrs.colors.value = props.product?.color_id || null;
      // productAttrs.baseColors.value = props.product?.base_color_id || null;
      // productAttrs.gasTypes.value = props.product?.gas_id || null;
      // productAttrs.ignitionTypes.value = props.product?.ignition_id || null;
    // }
    certifications.value = props.product?.certifications || [];
    resetForm({
      values: {
        ...props.product,
      }
    });
  }
}

// const loadMaterialColors = async (colorType: keyof ItemsList, id: number) => {
//   try {
//     itemsLoading.value[`${colorType}Loading`] = true;
//     const { data, error } = await supabase
//       .from('color')
//       .select('id, name')
//       .eq(`material_id`, id);
//     if (error) throw error;
//     itemsList.value[colorType] = data;
//   } catch (e: any) {
//     console.error(e);
//     notify({
//       title: `Error loading color list`,
//       text: e?.message || `An error occurred trying to load color list. Please contact TOP Support.`,
//       type: 'error',
//       duration: 6000,
//     });
//   } finally {
//     itemsLoading.value[`${colorType}Loading`] = false;
//   }
// }

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

watch(
  () => props.productPrices,
  () => {
    if (props.productPrices)
      prices.value = props.productPrices;
  },
  { deep: true }
);

watch(
  () => props.productAttributes,
  async () => {
    if (props.productAttributes) {
      const attributeValuesPromise: Promise<void>[] = [];
      props.productAttributes.forEach((attr) => {
        attributeValuesPromise.push(loadAttributeValues(attr.id || 0));
      });
      await Promise.allSettled(attributeValuesPromise);
      attributes.value = JSON.parse(JSON.stringify(props.productAttributes));
      currentAttributes.value = props.productAttributes.map((attr) => attr?.id || 0);
      attributesIds.value.push(...currentAttributes.value);
    }
  },
  { deep: true }
)

// watch(
//   () => props.productAttributes,
//   () => {
//     if (props.productAttributes) {
//       productAttrs.colors = props.productAttributes?.colors;
//       productAttrs.baseColors = props.productAttributes?.baseColors;
//       productAttrs.gasTypes = props.productAttributes?.gasTypes;
//       productAttrs.ignitionTypes = props.productAttributes?.ignitionTypes;
//     }
//   },
//   { deep: true }
// );

watch(
  () => props.productImages,
  () => {
    if (props.productImages)
      images.value = props.productImages;
  },
  { deep: true },
);

watch(
  () => props.productSpectSheets,
  () => {
    if (props.productSpectSheets)
      specificationSheets.value = props.productSpectSheets;
  },
  { deep: true },
);

watch(
  () => props.productDocuments,
  () => {
    if (props.productDocuments)
      documents.value = props.productDocuments;
  },
  { deep: true },
);

// watch(
//   () => materialId.value.value,
//   async () => {
//     productAttrs.colors.value = [];
//     if (materialId.value.value)
//       await loadMaterialColors('color', materialId.value.value);
//     else {
//       itemsList.value.color = [];
//       colorId.value.value = 0;
//     }
//   },
// );

// watch(
//   () => baseMaterialId.value.value,
//   async () => {
//     productAttrs.baseColors.value = [];
//     if (baseMaterialId.value.value)
//       await loadMaterialColors('baseColor', baseMaterialId.value.value);
//     else {
//       itemsList.value.baseColor = [];
//       baseColorId.value.value = 0;
//     }
//   },
// );

/**
 *
 * Handle Data
 *
 */

const filterFormPayload = (form: Product) => (
  Object.fromEntries(Object.entries(form).filter(([key, value]) => {
    return productStore.productKeys.includes(key);
  }))
)

const savePrice = async (type: string, priceForm: {
  year: number,
  price: number,
  product_id: number
}) => {
  try {
    isLoading.value = true;
    const { data, error } = await supabase
      .from(`${type}_price`)
      .insert(priceForm)
      .select();
    if (error) throw error;
    return data;
  } catch (e: any) {
    console.error(e);
    notify({
      title: `Error saving ${type} price.`,
      text: e?.message || `An error ocurred trying to save ${type} price. Please contact TOP support.`,
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const setPrices = async (productId: number) => {
  try {
    const availablePrices = Object.fromEntries(
      Object.entries(prices.value).filter(([key, value]) => value.length > 0)
    );
    const savePrices: Promise<any>[] = [];
    Object.entries(availablePrices).forEach(([key, value]) => {
      value.forEach(({ year, price }: any) => {
        const priceForm = {
          year: year,
          price: +price,
          product_id: productId,
        };
      savePrices.push(savePrice(key, priceForm));
      });
    });
    isLoading.value = true;
    const promiseResult = await Promise.allSettled(savePrices);
  } catch (e: any) {
    notify({
      title: `Error saving  prices.`,
      text: e?.message || `An error ocurred trying to save prices. Please contact TOP support.`,
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

// const saveAttribute = async (form: Attrs, attrType: string) => {
//   try {
//     isLoading.value = true;
//     const { data, error } = await supabase
//       .from(`product_${attrType}`)
//       .insert(form)
//       .select();
//     if (error) throw error;
//     return data;
//   } catch (e: any) {
//     console.error(e);
//     notify({
//       title: `Error saving ${attrType}`,
//       text: e?.message || `An error ocurred trying to save ${attrType}. Please contact TOP support.`,
//       type: 'error',
//       duration: 6000,
//     });
//   } finally {
//     isLoading.value = false;
//   }
// }

// const setAttributes = async (
//   productId: number,
//   attrType: keyof (typeof productAttrs),
//   type?: 'default' | 'base'
// ) => {
//   try {
//     const saveAttributes: Promise<any>[] = [];
//     const keys = {
//       colors: 'color',
//       baseColors: 'color',
//       ignitionTypes: 'ignition',
//       gasTypes: 'gas',
//     };

//     (productAttrs[attrType].value as number[]).forEach((id) => {
//       const form = {
//         product_id: +productId,
//         [`${keys[attrType]}_id`]: +id,
//         type,
//       }
//       if (!form.type) delete form.type;
//       saveAttributes.push(saveAttribute(form, keys[attrType]));
//     });

//     isLoading.value = true;
//     const promiseResult = await Promise.allSettled(saveAttributes);
//   } catch (e: any)  {
//     notify({
//       title: `Error saving ${attrType}`,
//       text: e?.message || `An error occurred trying to save ${attrType}. Please contact TOP suppport.`,
//       type: 'error',
//       duration: 6000,
//     });
//     console.error(e);
//   } finally {
//     isLoading.value = false;
//   }
// }

const saveDocument = async (documentsForm: Documents, productDocumentsForm: Documents) => {
  try {
    isLoading.value = true;
    const { data: docs, error } = await supabase
      .from('documents')
      .upsert(documentsForm)
      .select(`id`);
    if (error) throw error;
    const { data, error: e } = await supabase
      .from('product_documents')
      .upsert({
        ...productDocumentsForm,
        document_id: docs[0].id,
      })
      .select();
    if (e) throw e;
    return data;
  } catch (e: any) {
    notify({
      title: `Error saving Documents`,
      text: e?.message || `An error ocurred trying to save Documents. Please contact TOP support.`,
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const setDocuments = async (productId: number) => {
  try {
    const saveDocuments: Promise<any>[] = [];

    documents.value.forEach((doc) => {
      const documentsForm = {
        id: doc.id === 0 ? undefined : doc.id,
        url: doc.url,
        name: doc.name,
      }
      const productDocumentsForm = {
        document_id: doc.id === 0 ? undefined : doc.id,
        product_id: productId,
      }
      saveDocuments.push(saveDocument(documentsForm, productDocumentsForm));
    });
    isLoading.value = true;
    const promiseResult = await Promise.allSettled(saveDocuments);
  } catch(e: any) {
    console.error(e);
    notify({
      title: `Error saving documents`,
      text: e?.message || `An error occurred trying to save documents. Please contact TOP suppport.`,
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const saveSpecSheet = async (specSheetForm: SpecificationSheet, productSpecSheetForm: SpecificationSheet) => {
  try {
    isLoading.value = true;
    const { data: specSheet, error } = await supabase
      .from('specification_sheet')
      .upsert(specSheetForm)
      .select(`id`);
    if (error) throw error;
    const { data, error: e } = await supabase
      .from('product_specification_sheet')
      .upsert({
        ...productSpecSheetForm,
        specification_sheet_id: specSheet[0].id,
      })
      .select();
    if (e) throw e;
    return data;
  } catch (e: any) {
    notify({
      title: `Error saving Specification Sheets`,
      text: e?.message || `An error ocurred trying to save Specification Sheets. Please contact TOP support.`,
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const setSpecSheets = async (productId: number) => {
  try {
    const saveSpecSheets: Promise<any>[] = [];

    specificationSheets.value.forEach((specSheet) => {
      const specSheetForm = {
        id: specSheet.id === 0 ? undefined : specSheet.id,
        url: specSheet.url,
        name: specSheet.name,
      }
      const productSpecSheetForm = {
        specification_sheet_id: specSheet.id === 0 ? undefined : specSheet.id,
        product_id: productId,
      }
      saveSpecSheets.push(saveSpecSheet(specSheetForm, productSpecSheetForm));
    });
    isLoading.value = true;
    const promiseResult = await Promise.allSettled(saveSpecSheets);
  } catch(e: any) {
    console.error(e);
    notify({
      title: `Error saving specification sheets`,
      text: e?.message || `An error occurred trying to save specification sheets. Please contact TOP suppport.`,
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const saveImage = async (imageForm: Image, productImgForm: Image) => {
  try {
    isLoading.value = true;
    const { data: image, error } = await supabase
      .from('image')
      .upsert(imageForm)
      .select(`id`);
    if (error) throw error;
    const { data, error: e } = await supabase
      .from('product_image')
      .upsert({
        ...productImgForm,
        image_id: image[0].id,
      })
      .select();
    if (e) throw e;
    return data;
  } catch (e: any) {
    notify({
      title: `Error saving images`,
      text: e?.message || `An error ocurred trying to save image. Please contact TOP support.`,
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const setImages = async (productId: number) => {
  try {
    const saveImages: Promise<any>[] = [];

    images.value.forEach((img) => {
      const imageForm = {
        id: img.id === 0 ? undefined : img.id,
        url: img.url,
        name: img.name,
      }
      const productImageForm = {
        image_id: img.id === 0 ? undefined : img.id,
        product_id: productId,
        display_order: img.display_order,
        is_primary: img.is_primary,
      }
      saveImages.push(saveImage(imageForm, productImageForm));
    });
    isLoading.value = true;
    const promiseResult = await Promise.allSettled(saveImages);
  } catch(e: any) {
    console.error(e);
    notify({
      title: `Error saving images`,
      text: e?.message || `An error occurred trying to save images. Please contact TOP suppport.`,
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const handleCreate = async (values: Product) => {
  try {
    isLoading.value = true;
    const form = JSON.parse(JSON.stringify(values));
    const { data: product , error } = await supabase
      .from('product')
      .insert(form)
      .select();
    if (error) throw error;
    notify({
      title: 'Product created successfully',
      type: 'success',
      duration: 6000,
    });
    return product;
  } catch (e: any) {
    console.error(e);
    const errorMsg = displayErrorMessage(e?.message || '');
    notify({
      title: 'Error creating product',
      text: errorMsg || 'An error occurred trying to create a product. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const displayErrorMessage = (errorMessage: string) => {
  const substring = 'violates foreign key constraint';
  const bulletBurnerSubstr = 'compatible_bullet_burner';
  const canvasCoverSubstr = 'compatible_canvas_cover';
  const windGuardSubstr = 'compatible_glass_wind_guard';

  if (errorMessage.includes(substring) && errorMessage.includes(bulletBurnerSubstr))
    errorMessage = 'Bullet Burner SKU Not Found. Please ensure that the SKU is from a valid product';
  if (errorMessage.includes(substring) && errorMessage.includes(canvasCoverSubstr))
    errorMessage = 'Canvas Cover SKU Not Found. Please ensure that the SKU is from a valid product';
  if (errorMessage.includes(substring) && errorMessage.includes(windGuardSubstr))
    errorMessage = 'Glass Wind Guard SKU Not Found. Please ensure that the SKU is from a valid product';

  return errorMessage;
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
    notify({
      title: 'Product updated successfully',
      type: 'success',
      duration: 6000,
    });
    return product;
  } catch (e: any) {
    console.error(e);
    const errorMsg = displayErrorMessage(e?.message || '');
    notify({
      title: 'Error updating product',
      text: errorMsg || 'An error ocurred trying to update the product. Please contact TOP support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const submit = handleSubmit(async (values) => {
  let form: Product = JSON.parse(JSON.stringify(values)) as typeof values;
  // if (!isParent.value || !isParentGroup.value) {
    // const color_id = typeof productAttrs.colors.value === 'number' ? productAttrs.colors.value : null;
    // const base_color_id = typeof productAttrs.baseColors.value === 'number' ? productAttrs.baseColors.value : null;
    // const ignition_id = typeof productAttrs.ignitionTypes.value === 'number' ? productAttrs.ignitionTypes.value : null;
    // const gas_id = typeof productAttrs.gasTypes.value === 'number' ? productAttrs.gasTypes.value : null;
    // form = {
    //   ...form,
    //   color_id,
    //   base_color_id,
    //   ignition_id,
    //   gas_id,
    //   product_length: (length.value as unknown as string) ?? null,
    //   product_diameter: (diameter.value as unknown as string) ?? null,
    // };
  // } else {
    // form = {
    //   ...form,
    //   product_length: length.value.join(', ') ?? null,
    //   product_diameter: diameter.value.join(', ') ?? null,
    // }
  // }

  form = {
    ...form,
    certifications: certifications.value,
    compatible_bullet_burner: compatibleBulletBurner.value.value ? compatibleBulletBurner.value.value : null,
    compatible_canvas_cover: compatibleCanvasCover.value.value ? compatibleCanvasCover.value.value : null,
    compatible_glass_wind_guard: compatibleGlassWindGuard.value.value ? compatibleGlassWindGuard.value.value : null,
    access_door: accessDoor.value.value ? accessDoor.value.value : false,
  }

  form = filterFormPayload(form);
  try {
    isLoading.value = true;
    if (props.new) {
      const product = await handleCreate(form);

      if (product && product.length) {
        await setPrices(product[0].id);

        // if (isParent.value || isParentGroup.value) {
        //   if (Array.isArray(productAttrs.colors.value) && productAttrs.colors.value.length)
        //     await setAttributes(product[0].id, 'colors', 'default');
        //   if (Array.isArray(productAttrs.baseColors.value) && productAttrs.baseColors.value.length)
        //     await setAttributes(product[0].id, 'baseColors', 'base');
        //   if (Array.isArray(productAttrs.gasTypes.value) && productAttrs.gasTypes.value.length)
        //     await setAttributes(product[0].id, 'gasTypes');
        //   if (Array.isArray(productAttrs.ignitionTypes.value) && productAttrs.ignitionTypes.value.length)
        //     await setAttributes(product[0].id, 'ignitionTypes');
        // }

        await setImages(product[0].id);
        await setSpecSheets(product[0].id);
        await setDocuments(product[0].id);
        await setAttributes(product[0].id);

        router.push(`/products/${product[0].id}`);
      }
    } else if (props.edit) {
      const product = await handleUpdate(form);

      if (product && product.length) {
        await setImages(product[0].id);
        await setSpecSheets(product[0].id);
        await setDocuments(product[0].id);
        await setAttributes(product[0].id);
      }
    }
  } catch (e: any) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
})

</script>
