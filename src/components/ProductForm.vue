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
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Product Type</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 xl:tw-w-4/12">
            <v-text-field
              v-model="relation.value.value"
              variant="outlined"
              density="compact"
              name="Relation"
              placeholder="Product Type"
              readonly
              :error-messages="relation.errorMessage.value"
            >
            </v-text-field>
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
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
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
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
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
              :multiple="isParent || isParentGroup"
              :chips="isParent || isParentGroup"
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
              :multiple="isParent || isParentGroup"
              :chips="isParent || isParentGroup"
              :items="itemsList.gas"
              :error-messages="gasId.errorMessage.value"
              :loading="itemsLoading.gasLoading"
              :readonly="readonly"
            >
            </v-autocomplete>
          </div>
        </div>
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
              :key="i"
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
              :key="i"
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
        <v-expansion-panels variant="accordion" class="tw-mb-6 tw-mt-4 tw-w-full">
          <v-expansion-panel elevation="0">
            <v-expansion-panel-title color="grey-lighten-4">More Information</v-expansion-panel-title>
            <v-expansion-panel-text>
              <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row tw-mt-4">
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
              <v-divider class="border-opacity-100 tw-my-6"></v-divider>
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
              <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
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
              <v-divider class="border-opacity-100 tw-my-6"></v-divider>
              <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
                <div class="tw-w-full lg:tw-w-3/12 tw-pr-4">
                  <h3 class="tw-text-base tw-font-semibold tw-mt-1">Burner Dimensions</h3>
                </div>
                <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 tw-flex tw-flex-wrap tw-flex-col lg:tw-flex-row lg:tw-gap-8">
                  <v-text-field
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
                  </v-text-field>
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
              <v-divider class="border-opacity-100 tw-my-6"></v-divider>
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
              </div>
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
import { Attrs, Image, ItemsList, Price, PriceData, Product, Props, SpecificationSheet, Documents } from '@/types/product';

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

const isParent = computed(() => {
  if (route.query.relation_type === 'parent') return true;
  return false;
});

const isParentGroup = computed(() => {
  if (route.query.relation_type === 'parent_group') return true;
  return false;
});

onMounted(() => {
  if (route.query.relation_type === 'parent_group') relation.value.value = 'PARENT_GROUP';
  else if (route.query.relation_type === 'parent') relation.value.value = 'PARENT';
  else if (!route.query.parent_id) relation.value.value = 'PARENT';
  else relation.value.value = 'CHILD';
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

const itemsLoading = ref({
  categoryLoading: false,
  collectionLoading: false,
  colorLoading: false,
  gasLoading: false,
  ignitionLoading: false,
  materialLoading: false,
  shapeLoading: false,
  baseColorLoading: false,
});

const itemsList: Ref<ItemsList> = ref<ItemsList>({
  category: [],
  collection: [],
  color: [],
  gas: [],
  ignition: [],
  material: [],
  shape: [],
  baseColor: [],
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
  const startYear = 2015;
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
  await loadItemsList('gas');
  await loadItemsList('ignition');
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

const toggleImageIsPrimary = (imageId?: number, value?: boolean) => {
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
  documents.value = documents.value.filter((docItem) => docItem !== item.id);
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
const upcCodes = useField<string>('upc_codes');
const encodedUpcCodes = useField<string>('encoded_upc_codes');
const relation = useField<string>('relation');
const productLength = useField<string>('product_length');
const length: Ref<string[]> = ref<string[]>([]);
const productDiameter = useField<string>('product_diameter');
const diameter: Ref<string[]> = ref<string[]>([]);
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
const accessDoor = useField<boolean>('access_door');
const collectionId = useField<number>('collection_id');
const categoryId = useField<number>('category_id');
const shapeId = useField<number>('shape_id');
const materialId = useField<number | null>('material_id');
const colorId = useField<number>('color_id');
const productAttrs: {
  colors: Ref<number[] | number | null>
  baseColors: Ref<number[] | number | null>
  ignitionTypes: Ref<number[] | number | null>
  gasTypes: Ref<number[] | number  | null>
} = {
  colors: ref<number[] | number>([]),
  baseColors: ref<number[] | number>([]),
  ignitionTypes: ref<number[] | number>([]),
  gasTypes: ref<number[] | number>([]),
}
const ignitionId = useField<number>('ignition_id');
const gasId = useField<number>('gas_id');
const productSerialBase = useField<string>('product_serial_base');
const websiteLink = useField<string>('website_link')
const certifications: Ref<string[]> = ref<string[]>([]);
const baseColorId = useField<number>('base_color_id');
const baseMaterialId = useField<number | null>('base_material_id');
const published = useField<boolean>('published');
const enabled = useField<boolean>('enabled');
const companyDivision = useField<string>('company_division');
const shortDescription = useField<string>('short_description');
const description = useField<string>('description');

const fillProductInformation = async () => {
  if (props.edit || props.readonly) {
    baseMaterialId.value.value = props.product?.base_material_id ?? null;
    materialId.value.value = props.product?.material_id ?? null;

    if (props.product?.relation === 'PARENT' || props.product?.relation === 'PARENT_GROUP') {
      diameter.value = props.product?.product_diameter?.split(',') || [];
      length.value = props.product?.product_length?.split(',') || [];
    } else {
      productAttrs.colors.value = props.product?.color_id || null;
      productAttrs.baseColors.value = props.product?.base_color_id || null;
      productAttrs.gasTypes.value = props.product?.gas_id || null;
      productAttrs.ignitionTypes.value = props.product?.ignition_id || null;
    }
    certifications.value = props.product?.certifications || [];
    resetForm({
      values: {
        ...props.product,
      }
    });
  }
}

const loadMaterialColors = async (colorType: keyof ItemsList, id: number) => {
  try {
    itemsLoading.value[`${colorType}Loading`] = true;
    const { data, error } = await supabase
      .from('color')
      .select('id, name')
      .eq(`material_id`, id);
    if (error) throw error;
    itemsList.value[colorType] = data;
  } catch (e: any) {
    console.error(e);
    notify({
      title: `Error loading color list`,
      text: e?.message || `An error occurred trying to load color list. Please contact TOP Support.`,
      type: 'error',
      duration: 6000,
    });
  } finally {
    itemsLoading.value[`${colorType}Loading`] = false;
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
  () => {
    if (props.productAttributes) {
      productAttrs.colors = props.productAttributes?.colors;
      productAttrs.baseColors = props.productAttributes?.baseColors;
      productAttrs.gasTypes = props.productAttributes?.gasTypes;
      productAttrs.ignitionTypes = props.productAttributes?.ignitionTypes;
    }
  },
  { deep: true }
);

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
  () => materialId.value.value,
  async () => {
    productAttrs.colors.value = [];
    if (materialId.value.value)
      await loadMaterialColors('color', materialId.value.value);
    else {
      itemsList.value.color = [];
      colorId.value.value = 0;
    }
  },
);

watch(
  () => baseMaterialId.value.value,
  async () => {
    productAttrs.baseColors.value = [];
    if (baseMaterialId.value.value)
      await loadMaterialColors('baseColor', baseMaterialId.value.value);
    else {
      itemsList.value.baseColor = [];
      baseColorId.value.value = 0;
    }
  },
);

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

const saveAttribute = async (form: Attrs, attrType: string) => {
  try {
    isLoading.value = true;
    const { data, error } = await supabase
      .from(`product_${attrType}`)
      .insert(form)
      .select();
    if (error) throw error;
    return data;
  } catch (e: any) {
    console.error(e);
    notify({
      title: `Error saving ${attrType}`,
      text: e?.message || `An error ocurred trying to save ${attrType}. Please contact TOP support.`,
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const setAttributes = async (
  productId: number,
  attrType: keyof (typeof productAttrs),
  type?: 'default' | 'base'
) => {
  try {
    const saveAttributes: Promise<any>[] = [];
    const keys = {
      colors: 'color',
      baseColors: 'color',
      ignitionTypes: 'ignition',
      gasTypes: 'gas',
    };

    (productAttrs[attrType].value as number[]).forEach((id) => {
      const form = {
        product_id: +productId,
        [`${keys[attrType]}_id`]: +id,
        type,
      }
      if (!form.type) delete form.type;
      saveAttributes.push(saveAttribute(form, keys[attrType]));
    });

    isLoading.value = true;
    const promiseResult = await Promise.allSettled(saveAttributes);
  } catch (e: any)  {
    notify({
      title: `Error saving ${attrType}`,
      text: e?.message || `An error occurred trying to save ${attrType}. Please contact TOP suppport.`,
      type: 'error',
      duration: 6000,
    });
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}

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
        specification_sheet_id: docs[0].id,
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
    notify({
      title: 'Product updated successfully',
      type: 'success',
      duration: 6000,
    });
    return product;
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
  console.log('Test');
  let form: Product = JSON.parse(JSON.stringify(values)) as typeof values;
  if (!isParent.value || !isParentGroup.value) {
    const color_id = typeof productAttrs.colors.value === 'number' ? productAttrs.colors.value : null;
    const base_color_id = typeof productAttrs.baseColors.value === 'number' ? productAttrs.baseColors.value : null;
    const ignition_id = typeof productAttrs.ignitionTypes.value === 'number' ? productAttrs.ignitionTypes.value : null;
    const gas_id = typeof productAttrs.gasTypes.value === 'number' ? productAttrs.gasTypes.value : null;
    form = {
      ...form,
      color_id,
      base_color_id,
      ignition_id,
      gas_id,
      product_length: (length.value as unknown as string) ?? null,
      product_diameter: (diameter.value as unknown as string) ?? null,
    };
  } else {
    form = {
      ...form,
      product_length: length.value.join(', ') ?? null,
      product_diameter: diameter.value.join(', ') ?? null,
    }
  }

  form = {
    ...form,
    certifications: certifications.value,
    parent_id: route?.query?.parent_id ? +route.query.parent_id : undefined,
  }

  form = filterFormPayload(form);
  console.log('Payload', form);
  try {
    isLoading.value = true;
    if (props.new) {
      const product = await handleCreate(form);

      if (product && product.length) {
        await setPrices(product[0].id);

        if (isParent.value || isParentGroup.value) {
          if (Array.isArray(productAttrs.colors.value) && productAttrs.colors.value.length)
            await setAttributes(product[0].id, 'colors', 'default');
          if (Array.isArray(productAttrs.baseColors.value) && productAttrs.baseColors.value.length)
            await setAttributes(product[0].id, 'baseColors', 'base');
          if (Array.isArray(productAttrs.gasTypes.value) && productAttrs.gasTypes.value.length)
            await setAttributes(product[0].id, 'gasTypes');
          if (Array.isArray(productAttrs.ignitionTypes.value) && productAttrs.ignitionTypes.value.length)
            await setAttributes(product[0].id, 'ignitionTypes');
        }

        await setImages(product[0].id);
        await setSpecSheets(product[0].id);

        notify({
          title: 'Product created successfully',
          type: 'success',
          duration: 6000,
        });

        router.push(`/products/${product[0].id}`);
      }
    } else if (props.edit) {
      const product = await handleUpdate(form);

      if (product && product.length) {
        await setImages(product[0].id);
        await setSpecSheets(product[0].id);
      }
    }
  } catch (e: any) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
})

</script>
