<template>
  <div class="tw-w-full">
    <v-card
      class="py-12 px-10 tw-mb-60"
      :loading="isLoading"
    >
      <v-btn
        class="-tw-mt-6 tw-mb-6 -tw-ml-4"
        icon="mdi-arrow-left"
        flat
        @click="$router.push('/attributes')"
      >
      </v-btn>
      <form @submit.prevent="submit">
        <div class="tw-w-full">
          <h1 class="tw-text-base tw-font-semibold">{{ title }}</h1>
          <div class="tw-text-sm">{{ subtitle }}</div>
        </div>
        <v-divider class="border-opacity-100 tw-my-6"></v-divider>
        <div class="tw-w-full tw-flex tw-flex-col lg:tw-flex-row">
          <div class="tw-w-full lg:tw-w-3/12">
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Name</h3>
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
            <h3 class="tw-text-base tw-font-semibold tw-mt-1">Values</h3>
          </div>
          <div class="tw-w-full tw-mt-3 lg:tw-mt-0 lg:tw-w-7/12 ">
            <div class="tw-flex tw-flex-wrap tw-flex-col lg:tw-flex-row lg:tw-gap-8">
              <div class="tw-w-full lg:tw-w-8/12">
                <v-text-field
                  v-if="!readonly"
                  v-model="tempValue"
                  class="tw-w-full"
                  variant="outlined"
                  density="compact"
                  name="AttributeValue"
                  placeholder="Attribute Value"
                  :readonly="readonly"
                  @keydown.enter.prevent="addTempValue"
                ></v-text-field>
                <v-btn
                  v-if="!readonly"
                  class="tw-mb-4"
                  color="red-darken-2"
                  density="comfortable"
                  @click="openImportValuesDialog"
                >
                  Import Values
                </v-btn>
              </div>

              <v-btn
                v-if="!readonly"
                append-icon="mdi-plus"
                class="lg:tw-w-3/12 lg:tw-mt-1"
                color="blue-darken-3"
                :disabled="!tempValue"
                @click.prevent="addTempValue"
              >
                Add Value
              </v-btn>
            </div>
            <div
              class="tw-w-9/12 tw-mt-3 lg:tw-mt-0"
              :key="values.length"
            >
              <template
                v-if="!edit"
              >
                <v-chip
                  v-for="(value, i) in values"
                  class="tw-mr-4 tw-mb-4"
                  :key="i"
                  :ripple="false"
                  :closable="!readonly"
                  @click:close="removeValue(i)"
                >
                  {{ value }}
                </v-chip>
              </template>
              <template
                v-else
              >
                <v-chip
                  v-for="(value, i) in values"
                  class="tw-mr-4 tw-mb-4"
                  :key="i"
                  :ripple="false"
                  :closable="!readonly"
                  @click:close="removeValue(i)"
                >
                  {{ value.value }}
                </v-chip>
              </template>
            </div>
          </div>
        </div>
        <v-divider class="border-opacity-100 tw-mb-6 tw-mt-1"></v-divider>
        <div class="tw-w-full">
          <v-btn
            v-if="!readonly"
            type="submit"
            color="primary"
          >
            Submit
          </v-btn>
        </div>
      </form>
    </v-card>
    <v-dialog
      v-model="importValuesDialog"
      max-width="900"
    >
      <v-card title="Import Values" :loading="loadingAttributes">
        <v-card-text>
          <div>
            <p>
              Import values from another attribute
            </p>
            <div
             v-show="loadingAttributes"
             class="tw-w-full tw-flex tw-justify-center tw-items-center"
             >
              <v-progress-circular
                indeterminate
                color="primary"
              ></v-progress-circular>
            </div>
            <template
              v-if="!loadingAttributes"
            >
              <v-select
                v-model="attributeToLoad"
                class="tw-mt-6"
                :items="attributes"
                item-title="name"
                item-value="id"
                variant="outlined"
                density="compact"
                placeholder="Source Attribute"
                label="Source Attribute"
              ></v-select>
              <h3 v-if="selectedAttributeValues.length" class="tw-font-semibold -tw-mt-1 tw-mb-3">Values</h3>
              <v-chip
                v-for="(attr, i) in selectedAttributeValues"
                class="tw-mr-4 tw-mb-4"
                :key="i"
                :ripple="false"
              >
                {{ attr }}
              </v-chip>
            </template>
          </div>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="green-darken-1" :disabled="!selectedAttributeValues.length" @click="importValues">Import</v-btn>
          <v-btn color="red-lighten-1"  @click="importValuesDialog = false">Close</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>
<script lang="ts" setup>
import * as yup from 'yup';
import { toTypedSchema } from '@vee-validate/yup';
import { useField, useForm } from 'vee-validate';
import { ref, onMounted, watch, computed } from 'vue';
import { supabase } from '@/supabase';
import { useNotification } from '@kyvg/vue3-notification';
import { useRouter } from 'vue-router';
import { Ref } from 'vue';

/**
 *
 * Defining Interfaces
 *
 **/
interface Attribute {
  id?: number;
  name: string;
  slug?: string;
  table_name?: string;
  values?: string[] | AttributeValue[];
}

interface AttributeValue {
  id?: number;
  attribute_id?: number;
  value: string;
  material_id?: number;
  color_id?: number;
  gas_id?: number;
  ignition_id?: number;
}

interface Props {
  new?: boolean;
  edit?: boolean;
  readonly?: boolean;
  attribute?: Attribute | null;
  loading?: boolean;
}


/**
 *
 * General Definitions
 *
 **/

const router = useRouter();
const { notify } = useNotification();

const isLoading = ref(false);
const loadingAttributes = ref(false);
const importValuesDialog = ref(false);

const tempValue: Ref<string> = ref<string>('');
const values: Ref<string[] | AttributeValue[]> = ref<string[] | AttributeValue[]>([]);
const attributes: Ref<Attribute[]> = ref<Attribute[]>([]);
const attributeValues: Ref<AttributeValue[]> = ref<AttributeValue[]>([]);
const attributeToLoad: Ref<number|null> = ref<number|null>(null);
const valuesToDelete: Ref<AttributeValue[]> = ref<AttributeValue[]>([]);

const props = withDefaults(defineProps<Props>(), {
  new: false,
  edit: false,
  readonly: false,
  attribute: null,
  loading: false,
});

const fillAttributeInformation = () => {
  if (props.readonly) {
    name.value.value = JSON.parse(JSON.stringify(props.attribute?.name || ''));
    values.value = JSON.parse(JSON.stringify(props.attribute?.values || []));
  }
  if (props.edit) {
    name.value.value = JSON.parse(JSON.stringify(props.attribute?.name || ''));
    values.value = JSON.parse(JSON.stringify(props.attribute?.values || []));
  }
}

onMounted(() => {
  fillAttributeInformation();
});
watch(
  () => props.attribute,
  () => {
    fillAttributeInformation();
  },
  { deep: true },
)

watch(
  () => props.loading,
  (value) => {
    isLoading.value = value;
  }
);

const title = computed(() => {
  if (props.new) return 'Create Attribute';
  if (props.edit) return 'Edit Attribute';
  if (props.readonly) return 'View Attribute';
  return 'Attribute Form';
});

const subtitle = computed(() => {
  if (props.new) return 'Fill out the information below to create an attribute';
  if (props.edit) return 'Use the form below to edit an attribute';
  if (props.readonly) return 'View Attribute Information';
  return '';
});

const addTempValue = () => {
  if (props.new) {
    const valAlreadyExists = (values.value as string[]).find((item) => item === tempValue.value);
    if (!valAlreadyExists) {
      if (tempValue.value) (values.value as string[]).push(tempValue.value);
      tempValue.value = '';
    } else {
      notify({
        title: 'Value already exists',
        text: 'Can\'t assign a duplicate value.',
        type: 'error',
        duration: 5000,
      });
    }
  }
  if (props.edit) {
    if (tempValue.value) {
      const valAlreadyExists = (values.value as AttributeValue[]).find((item) => item.value === tempValue.value);
      if (!valAlreadyExists) {
        const valIsOnDeleteQueue = valuesToDelete.value.find((item) => item.value === tempValue.value);
        if (valIsOnDeleteQueue)
          (values.value as AttributeValue[]).push(valIsOnDeleteQueue);
        else
          (values.value as AttributeValue[]).push({ value: tempValue.value });
        tempValue.value = '';
      } else {
        notify({
          title: 'Value already exists',
          text: 'Can\'t assign a duplicate value.',
          type: 'error',
          duration: 5000,
        });
      }
    }
  }
}

const removeValue = (removeIndex: number) => {
  const valToDelete = values.value.splice(removeIndex, 1);
  if (props.edit) {
    valuesToDelete.value.push(valToDelete[0] as AttributeValue);
  }
}

const openImportValuesDialog = async () => {
  importValuesDialog.value = true;
  if (attributes.value.length === 0) {
    await loadItems();
  }
}

const loadItems = async () => {
  try {
    loadingAttributes.value = true;
    const { data, error } = await supabase
      .from('attributes')
      .select(`
        id, name, table_name,
        values: attribute_value (
          value,
          material: material_id (
            name
          ),
          color: color_id (
            name
          ),
          gas: gas_id (
            name
          ),
          ignition: ignition_id (
            name
          )
        )
      `);
    if (error) throw error;
    const flattenedData = data.map((item) => {
      const values = item.values.map((value: any) => {
        const keys = Object.keys(value);
        for (const key of keys) {
          if (value[key] !== null && key !== 'value') {
            if (typeof value[key] === 'object') {
              return value[key].name;
            } else {
              return value[key];
            }
          } else if (key === 'value' && value[key] !== null) {
            return value[key];
          }
        }
      });

      const uniqueValues = Array.from(new Set(values)).filter(value => value !== null);

      return {
        id: item.id,
        name: item.name,
        table_name: item.table_name,
        values: uniqueValues,
      };
    });
    attributes.value = flattenedData;
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error loading attributes',
      text: e?.message || 'An error ocurred trying to load attributes. Please contact TOP Support',
      type: 'error',
      duration: 6000,
    })
  } finally {
    loadingAttributes.value = false;
  }
}

const selectedAttributeValues = computed(() => {
  return attributes.value.find(a => attributeToLoad.value === a.id)?.values || [];
});

const importValues = () => {
  if (props.new)
    values.value.push(...JSON.parse(JSON.stringify(selectedAttributeValues.value)));
  else if (props.edit) {
    const tempValues = selectedAttributeValues.value.map((val) => ({
      value: val,
    }));
    values.value.push(...JSON.parse(JSON.stringify(tempValues)));
  }
  importValuesDialog.value = false;
}

/**
 *
 * Handle Form
 *
 **/

const { handleSubmit } = useForm({
  validationSchema: toTypedSchema(
    yup.object({
      name: yup.string().min(2).required(),
      value: yup.string().min(1),
    })
  ),
});

const name = useField<string>('name');
const value = useField<string>('value');

const createAttributeValue = async (attributeId: number, value: string) => {
  try {
    isLoading.value = true;
    const { error } = await supabase
      .from('attribute_value')
      .insert({ attribute_id: attributeId, value });
    if (error) throw error;
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error creating attribute value.',
      text: e?.message || 'An error occurred trying to create attribute value. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const deleteAttributeValue = async (attributeIds: number[]) => {
  try {
    isLoading.value = true;
    const { error } = await supabase
      .from('attribute_value')
      .delete()
      .in('id', attributeIds);
    if (error) throw error;
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error deleting values.',
      text: e?.message || 'An error occurred trying to delete attribute values. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  }
}

const handleCreate = async (form: Attribute) => {
  try {
    isLoading.value = true;
    console.log(form);
    const { data: attr, error } = await supabase
      .from('attributes')
      .insert(form)
      .select();
    if (error) throw error;
    if (attr.length) {
      const attrValuesPromises: Promise<void>[] = [];
      (values.value as string[]).forEach((val) => {
        attrValuesPromises.push(createAttributeValue(attr[0].id, val));
      });

      await Promise.all(attrValuesPromises);
      router.push(`/attributes/${attr[0].id}`);
    }
    notify({
      title: 'Attribute created successfully',
      type: 'success',
      duration: 6000,
    });
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error creating attribute.',
      text: e?.message || 'An error occurred trying to create attribute. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const handleUpdate = async (form: Attribute) => {
  try {
    isLoading.value = true;
    const { data: attribute, error } = await supabase
      .from('attributes')
      .update(form)
      .eq('id', props?.attribute?.id || 0)
      .select();
    if (error) throw error;
    if (attribute.length) {
      name.value.value = attribute[0].name;
      const newValues = (values.value as AttributeValue[]).filter((val) => !val.id).map((val) => val.value);
      const idsToDelete = valuesToDelete.value.map((val) => val.id);

      const attrValuesPromises: Promise<void>[] = [];
      newValues.forEach((val) => {
        attrValuesPromises.push(createAttributeValue(attribute[0].id, val));
      });

      if (idsToDelete.length)
        await deleteAttributeValue(idsToDelete as number[]);
      await Promise.all(attrValuesPromises);
    }
    notify({
      title: 'Attribute updated successfully',
      type: 'success',
      duration: 6000,
    });
  } catch (e: any) {
    console.error(e);
    notify({
      title: 'Error editing attribute.',
      text: e?.message || 'An error ocurred trying to edit the attribute. Please contact TOP Support.',
      type: 'error',
      duration: 6000,
    });
  } finally {
    isLoading.value = false;
  }
}

const submit = handleSubmit(async (values) => {
  const form = JSON.parse(JSON.stringify(values));
  if (props.new) {
    await handleCreate(form);
  }
  if (props.edit) {
    await handleUpdate(form);
  }
});
</script>


