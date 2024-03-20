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
              >
              </v-checkbox>
            </v-col>
          </v-row>
          <span class="tw-text-sm tw-text-gray-500"><b>Enable variation: </b>If checked, it means that the variation is enable for display on the dashboard and on the quick view pricing tool. This will allow dealers and sales to see the details about the product.</span>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Variation Name</h3>
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
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Attributes</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12">
            <template
              v-for="(prodAttr, key) in prodAttributesList"
              :key="key"
            >
              <h3 class="tw-text-base tw-font-semibold">{{ prodAttr.attribute?.name }}</h3>
              <v-autocomplete
                v-model="attributes[prodAttr.attribute?.id || 0]"
                variant="outlined"
                density="compact"
                :name="`Attribute${prodAttr.attribute?.name}`"
                :clearable="!readonly"
                :closable-chips="!readonly"
                :item-title="getAttributeItemValue(prodAttr.attribute?.table_name)"
                item-value="id"
                :loading="isAttributeValuesLoading"
                :items="attributeValuesList[prodAttr.attribute?.id || 0]"
                :readonly="readonly"
              ></v-autocomplete>
            </template>
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
              v-for="(priceType, key) in variationStore.priceTypeList"
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
                ></v-select>
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
        <v-expansion-panels variant="accordion" class="tw-mb-6 tw-mt-4 tw-w-full">
          <v-expansion-panel elevation="0">
            <v-expansion-panel-title color="grey-lighten-4">More Information</v-expansion-panel-title>
            <v-expansion-panel-text>
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
                    v-model="productLength.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="PLength"
                    placeholder="Product Length"
                    chips
                    :clearable="!readonly"
                    :items="productStore.sizes"
                    :error-messages="productLength.errorMessage.value"
                    :readonly="readonly"
                  >
                  </v-combobox>
                  <v-combobox
                    v-model="productDiameter.value.value"
                    class="tw-w-full lg:tw-w-5/12"
                    variant="outlined"
                    density="compact"
                    name="PDiameter"
                    placeholder="Product Diameter"
                    chips
                    :clearable="!readonly"
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
import { useVariationStore } from '@/store/variation';
import { Ref } from 'vue';
import {
  AttributeValue,
  AttributeValues,
  Image,
  Price,
  PriceData,
  ProductAttribute,
} from '@/types/product';
import {
  Props, Variation
} from '@/types/variation';
import { useProductImage } from '@/composables/productImage';
import { useProductSpecificationSheet } from '@/composables/productSpecificationSheet';
import { useProductDocument } from '@/composables/productDocuments';
import { useProductPrice } from '@/composables/productPrices';
import { useProductStore } from '@/store/product';
import { toRaw } from 'vue';

/**
 *
 * General Definitions
 *
 */

const router = useRouter();
const route = useRoute();
const variationStore = useVariationStore();
const productStore = useProductStore();
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

watch(
  () => props.variationAttributes,
  (variationAttributes) => {
    if (variationAttributes) {
      attributes.value = structuredClone(toRaw(variationAttributes));
      oldVariationAttributes.value = structuredClone(toRaw(variationAttributes));
    }
  },
  { deep: true }
)


watch(
  () => props.variation,
  () => {
    fillVariationInformation();
  },
  { deep: true }
)

const fillVariationInformation = async () => {
  certifications.value = props.variation?.certifications || [];
  resetForm({
    values: {
      ...props.variation,
    }
  })
}

const variationImagesRef = computed(() => props.variationImages);
const variationSpecSheetsRef = computed(() => props.variationSpecSheets);
const variationDocumentsRef = computed(() => props.variationDocuments);
const variationPricesRef = computed(() => props.variationPrices);

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
  fillVariationInformation();
  yearList.value = generateYearList(new Date().getFullYear());
  await loadParentAttributes();
});

const isAttributeValuesLoading = ref(false);
const prodAttributesList: Ref<ProductAttribute[]> = ref<ProductAttribute[]>([]);
const attributeValuesList: Ref<AttributeValues> = ref<AttributeValues>({});
const attributes: Ref<{ [key: number]: number | null }> = ref<{ [key: number]: number | null }>({});
const oldVariationAttributes: Ref<{ [key: number]: number | null }> = ref<{ [key: number]: number | null }>({});

const loadParentAttributes = async () => {
  try {
    isLoading.value = true;
    const parentId = +route.params?.id || 0;
    if (parentId) {
      const { data, error } = await supabase
        .from('product_attribute')
        .select('id, attribute:attribute_id(id, name, table_name), fill_values')
        .eq('product_id', parentId);
      if (error) throw error;
      prodAttributesList.value = data as ProductAttribute[];
      if (prodAttributesList.value.length) {
        const attributeValuesPromises: Promise<any>[] = []
        prodAttributesList.value.forEach((prod_attr) => {
          attributes.value[prod_attr.attribute?.id || 0] = null;
          attributeValuesPromises.push(loadAttributeValues(prod_attr.attribute?.id || 0, parentId, prod_attr?.fill_values));
        });
        await Promise.allSettled(attributeValuesPromises);
      }
    }
  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}

const loadAttributeValues = async (attrId: number, productId: number, fill_values: boolean = true) => {
  try {
    isAttributeValuesLoading.value = true;

    let attribute_values: AttributeValue[] = [];
    if (fill_values) {
      const { data, error } = await supabase
        .from('attribute_value')
        .select('id, attribute_id, value, material(id, name), color(id, name), gas(id, name), ignition(id, name)')
        .eq('attribute_id', attrId);
      if (error) throw error;
      attribute_values = data as unknown as AttributeValue[];
    } else {
      const { data, error } = await supabase
        .from('product_configuration')
        .select('attribute_value!inner (id, attribute_id, value, material(id, name), color(id, name), gas(id, name), ignition(id, name))')
        .eq('attribute_value.attribute_id', attrId)
        .eq('product_id', productId);
      if (error) throw error;
      attribute_values = data.map((prodConf) => {
        return (prodConf.attribute_value as AttributeValue)
      });
    }
    if (attribute_values && attribute_values.length)
      attributeValuesList.value[attrId] = attribute_values;
  } catch (e) {
    console.error(e);
  } finally {
    isAttributeValuesLoading.value = false;
  }
}

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

const saveAttributeValue = async (variationId: number, valueId: number, attributeId: number) => {
  try {
    isLoading.value = true;
    const form = {
      variation_id: variationId,
      value_id: valueId,
      attribute_id: attributeId,
    };
    if (oldVariationAttributes.value && oldVariationAttributes.value[attributeId]) {
      const { error } = await supabase
        .from('variation_configuration')
        .update(form)
        .eq('attribute_id', attributeId)
        .eq('variation_id', variationId);
      if (error) throw error;
    } else {
      const { error } = await supabase
        .from('variation_configuration')
        .upsert(form)
        .eq('attribute_id', attributeId)
        .eq('variation_id', variationId);
      if (error) throw error;
      oldVariationAttributes.value[attributeId] = valueId;
    }

  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}

const updateAttributeValue = async (variationId: number, valueId: number, attributeId: number) => {
  try {
    isLoading.value = true;
    const form = {
      variation_id: variationId,
      value_id: valueId,
      attribute_id: attributeId,
    };
    const { error } = await supabase
      .from('variation_configuration')
      .update(form)
      .eq('attribute_id', attributeId)
      .eq('variation_id', variationId);
    if (error) throw error;
  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}

const setAttributeValues = async (variationId: number) => {
  try {
    isLoading.value = true;
    const saveVariationConfigurations: Promise<any>[] = [];
    Object.entries(attributes.value).forEach(([attrKey, attrValue]) => {
      if (attrValue) {
        // if (props.edit)
        //   saveVariationConfigurations.push(updateAttributeValue(variationId, attrValue, +attrKey));
        // else
          saveVariationConfigurations.push(saveAttributeValue(variationId, attrValue, +attrKey));
      }
    });
    const promiseResult = await Promise.allSettled(saveVariationConfigurations);
  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
}

/**
 *
 * Prices & Year Definitions and Methods
 *
 */

const {
  yearList,
  prices,
  generateYearList,
  yearToShowList,
  removeYearFromList,
  addPrice,
  setPrices,
} = useProductPrice(variationPricesRef, 'variation');

/**
 *
 * Images Definitions and Methods
 *
 */
const {
  images,
  addImage,
  removeImageFromList,
  toggleImageIsPrimary,
  setImages,
} = useProductImage(variationImagesRef, 'variation');

/**
 *
 * Specification Sheets Definitions and Methods
 *
 */
const {
  specificationSheets,
  addSpecificationSheet,
  removeSpecSheetFromList,
  setSpecSheets,
} = useProductSpecificationSheet(variationSpecSheetsRef, 'variation');

/**
 *
 * Documents Definitions and Methods
 *
 */

const {
  documents,
  addDocuments,
  removeDocFromList,
  setDocuments,
} = useProductDocument(variationDocumentsRef, 'variation');

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

const handleCreate = async (values: Variation, parentId: number) => {
  try {
    isLoading.value = true;
    let form = JSON.parse(JSON.stringify(values));
    form = {
      ...form,
      parent_id: parentId
    }
    const { data: variation, error } = await supabase
      .from('variation')
      .insert(form)
      .select();
    if (error) throw error;
    notify({
      title: 'Variation created successfully',
      type: 'success',
      duration: 6000
    });
    return variation;
  } catch (e: any) {
    console.error(e);
    const errorMsg = displayErrorMessage(e?.message || '');
    notify({
      title: 'Error creating variation',
      text: errorMsg || 'An error ocurred trying to create a variation. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const handleUpdate = async (values: Variation) => {
  try {
    isLoading.value = true;
    const form = JSON.parse(JSON.stringify(values));
    const { data: variation, error } = await supabase
      .from('variation')
      .update(form)
      .eq('id', props?.variation?.id || 0)
      .select();
    if (error) throw error;
    notify({
      title: 'Variation updated successfully',
      type: 'success',
      duration: 6000
    });
    return variation;
  } catch (e: any) {
    console.error(e);
    const errorMsg = displayErrorMessage(e?.message || '');
    notify({
      title: 'Error updating variation',
      text: errorMsg || 'An error ocurred trying to update the variation. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

/**
 *
 * Form Submission
 *
 */

const submit = handleSubmit(async (values) => {
  let form: Variation = JSON.parse(JSON.stringify(values)) as typeof values;
  const parentId = +route.params?.id || 0;
  form = {
    ...form,
    certifications: certifications.value,
    compatible_bullet_burner: compatibleBulletBurner.value.value ? compatibleBulletBurner.value.value : null,
    compatible_canvas_cover: compatibleCanvasCover.value.value ? compatibleCanvasCover.value.value : null,
    compatible_glass_wind_guard: compatibleGlassWindGuard.value.value ? compatibleGlassWindGuard.value.value : null,
  }
  form = filterFormPayload(form);
  try {
    isLoading.value = true;
    let variation = null;
    if (props.new)
      variation = await handleCreate(form, parentId);
    else if (props.edit)
      variation = await handleUpdate(form);

    if (variation && variation.length) {
      await setPrices(variation[0].id);
      await setImages(variation[0].id);
      await setSpecSheets(variation[0].id);
      await setDocuments(variation[0].id);
      await setAttributeValues(variation[0].id);
      if (props.new) router.push(`/products/${route.params.id}/variant/${variation[0].id}`);
    }
  } catch (e: any) {
    console.error(e);
  } finally {
    isLoading.value = false;
  }
});

</script>
