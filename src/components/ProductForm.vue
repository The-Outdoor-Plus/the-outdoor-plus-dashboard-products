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
                  <h3 class="tw-text-base tw-font-semibold tw-mt-1">Burner Dimensions</h3>
                </div>
                <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 tw-flex tw-flex-wrap tw-flex-col lg:tw-flex-row lg:tw-gap-8">
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
import { useProductImage } from '@/composables/productImage';
import { useProductSpecificationSheet } from '@/composables/productSpecificationSheet';
import { useProductDocument } from '@/composables/productDocuments';
import { useProductPrice } from '@/composables/productPrices';

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

const productImagesRef = computed(() => props.productImages);
const productSpecSheetsRef = computed(() => props.productSpectSheets);
const productDocumentsRef = computed(() => props.productDocuments);
const productPricesRef = computed(() => props.productPrices);

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

onMounted(async () => {
  fillProductInformation();
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

const {
  yearList,
  prices,
  generateYearList,
  yearToShowList,
  removeYearFromList,
  addPrice,
  setPrices
} = useProductPrice(productPricesRef);

const {
  images,
  addImage,
  removeImageFromList,
  toggleImageIsPrimary,
  setImages,
} = useProductImage(productImagesRef);

const {
  specificationSheets,
  addSpecificationSheet,
  removeSpecSheetFromList,
  setSpecSheets,
} = useProductSpecificationSheet(productSpecSheetsRef);

const {
  documents,
  addDocuments,
  removeDocFromList,
  setDocuments,
} = useProductDocument(productDocumentsRef);

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
const productSerialBase = useField<string>('product_serial_base');
const websiteLink = useField<string>('website_link')
const certifications: Ref<string[]> = ref<string[]>([]);
const published = useField<boolean>('published');
const enabled = useField<boolean>('enabled');
const companyDivision = useField<string>('company_division');
const shortDescription = useField<string>('short_description');
const description = useField<string>('description');

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

watch(
  () => props.product,
  () => {
    fillProductInformation();
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
        await setPrices(product[0].id);
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
