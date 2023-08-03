<template>
  <div class="tw-w-full">
    <v-card class="py-12 px-10" :loading="isLoading">
      <v-btn
        class="-tw-mt-6 tw-mb-6 -tw-ml-4" 
        icon="mdi-arrow-left" 
        flat
        @click="$router.push('/products')"
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
                  :items="yearToShowList(priceType.key as keyof PriceData)"
                  hide-details
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
                ></v-text-field>
                <v-btn
                  size="small"
                  class="ml-2"
                  icon="mdi-close"
                  variant="text"
                  @click="removeYearFromList(priceType.key as keyof PriceData, price)"
                ></v-btn>
              </div>
              <v-btn
                v-if="yearToShowList(priceType.key as keyof PriceData).length"
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
              clearable
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
              clearable
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
              clearable
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
              clearable
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
              clearable
              closable-chips
              :multiple="isParent"
              :chips="isParent"
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
              clearable
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
              clearable
              closable-chips
              :multiple="isParent"
              :chips="isParent"
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
              clearable
              closable-chips
              :multiple="isParent"
              :chips="isParent"
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
              clearable
              closable-chips
              :multiple="isParent"
              :chips="isParent"
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
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Certifications</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-9/12 tw-flex">
            <v-checkbox
              v-model="certifications"
              color="blue-darken-1"
              label="CSA Certified"
              value="CSA"
            ></v-checkbox>
            <v-checkbox
              v-model="certifications"
              color="green-darken-2"
              label="LC Certified"
              value="LC"
            ></v-checkbox>
            <v-checkbox
              v-model="certifications"
              color="indigo"
              label="UL Certified"
              value="UL"
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
              clearable
              closable-chips
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
              clearable
              closable-chips
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
        <v-divider class="border-opacity-100 tw-mb-6 tw-mt-1"></v-divider>
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
import { Attrs, ItemsList, Price, PriceData, Product, Props } from '@/types/product';
import { valueToNode } from '@babel/types';

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
  if (!route.query.parent_id) return true
  if (route.query.relation_type === 'parent') return true
  return false;
});

onMounted(() => {
  if (!route.query.parent_id) relation.value.value = 'PARENT'
  else if (route.query.relation_type === 'parent') relation.value.value = 'PARENT'
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

/**
 * 
 * Handle Form
 * 
 */

const { handleSubmit } = useForm({
  validationSchema: productStore.formValidation,
  initialValues: productStore.initialValues,
});

const name = useField<string>('name');
const sku = useField<string>('sku');
const upcCodes = useField<string>('upc_codes');
const encodedUpcCodes = useField<string>('encoded_upc_codes');
const relation = useField<string>('relation');
const productLength = useField<string>('product_length');
const length = ref([]);
const productDiameter = useField<string>('product_diameter');
const diameter = ref([]);
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
const materialId = useField<number>('material_id');
const colorId = useField<number>('color_id');
const productAttrs: {
  colors: Ref<number[] | number>
  baseColors: Ref<number[] | number>
  ignitionTypes: Ref<number[] | number>
  gasTypes: Ref<number[] | number>
} = {
  colors: ref<number[] | number>([]),
  baseColors: ref<number[] | number>([]),
  ignitionTypes: ref<number[] | number>([]),
  gasTypes: ref<number[] | number>([]),
}
const ignitionId = useField<number>('ignition_id');
const gasId = useField<number>('gas_id');
const productSerialBase = useField<string>('product_serial_base');
const certifications = ref([]);
const baseColorId = useField<number>('base_color_id');
const baseMaterialId = useField<number>('base_material_id');
const published = useField<boolean>('published');
const enabled = useField<boolean>('enabled');
const companyDivision = useField<string>('company_division');
const shortDescription = useField<string>('short_description');
const description = useField<string>('description');

const fillProductInformation = () => {
  if (props.edit || props.readonly) {
    name.value.value = props.product?.name || '';
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

const handleCreate = async (values: Product) => {
  try {
    isLoading.value = true;
    const form = JSON.parse(JSON.stringify(values));
    const { data: product , error } = await supabase
      .from('product')
      .insert(form)
      .select();
    if (error) throw error;
    if (product.length) router.push(`/products/${product[0].id}`);
    notify({
      title: 'Product created successfully',
      type: 'success',
      duration: 6000,
    });
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
    if(product.length) {
      name.value.value = product[0].name;
    }
    notify({
      title: 'Product updated successfully',
      type: 'success',
      duration: 6000,
    });
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
  const availablePrices = Object.fromEntries(
    Object.entries(prices.value).filter(([key, value]) => value.length > 0)
  );
  const savePrices: Promise<any>[] = [];
  console.log('Available Prices', availablePrices);
  Object.entries(availablePrices).forEach(([key, value]) => {
    value.forEach(({ year, price }: any) => {
      const priceForm = {
        year: year,
        price: +price,
        product_id: productId,
      };
      console.log(key, priceForm);
    // savePrices.push(savePrice(key, priceForm));
    });
  });

  try {
    isLoading.value = true;
    console.log(savePrices);
    // const promiseResult = await Promise.allSettled(savePrices);
    // console.log(promiseResult);
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
  const saveAttributes: Promise<any>[] = [];
  const keys = {
    colors: 'color',
    baseColors: 'color',
    ignitionTypes: 'iginition',
    gasTypes: 'gas',
  };
  (productAttrs[attrType].value as number[]).forEach((id) => {
    const form = {
      product_id: +productId,
      [`${keys[attrType]}_id`]: +id,
      type,
    }
    if (!form.type) delete form.type;
    console.log(`${attrType}`, form);
    // saveAttributes.push(saveAttribute(form, keys[attrType]));
  });

  try {
    isLoading.value = true;
    console.log(saveAttributes);
    // const promiseResult = await Promise.allSettled(saveAttributes);
    // console.log(promiseResult);
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

const submit = handleSubmit(async (values) => {
  console.log('Values', values);
  let form: Product = JSON.parse(JSON.stringify(values)) as typeof values;
  console.log('Before form', values);
  await setPrices(0);
  if (isParent.value) {
    if (Array.isArray(productAttrs.colors.value) && productAttrs.colors.value.length)
      await setAttributes(0, 'colors', 'default');
    if (Array.isArray(productAttrs.baseColors.value) && productAttrs.baseColors.value.length)
      await setAttributes(0, 'baseColors', 'base');
    if (Array.isArray(productAttrs.gasTypes.value) && productAttrs.gasTypes.value.length)
      await setAttributes(0, 'gasTypes');
    if (Array.isArray(productAttrs.ignitionTypes.value) && productAttrs.ignitionTypes.value.length)
      await setAttributes(0, 'ignitionTypes');
    form = {
      ...form,
      product_length: length.value.join(', ') ?? null,
      product_diameter: diameter.value.join(', ') ?? null,
    }
  } else {
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

  }

  form = {
    ...form,
    certifications: certifications.value,
  }
  
  console.log('After Form', form);
  if (props.new) {
    // await handleCreate(values);
  } else if (props.edit) {
    // await handleUpdate(values);
  }
})

</script>