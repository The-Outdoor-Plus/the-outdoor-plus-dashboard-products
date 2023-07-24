<template>
  <div class="tw-w-full">
    <v-text-field
      v-model="searchFilter"
      class="tw-mb-10"
      append-icon="mdi-magnify"
      label="Search"
      single-line
      hide-details
      variant="solo"
      density="comfortable"
      @keyup.enter="onEnterSearch"
    >
    </v-text-field>
  </div>
</template>
<script lang="ts" setup>
import { onMounted, reactive, ref, watch, Ref } from 'vue';
import { VDataTableServer } from 'vuetify/lib/labs/components.mjs';
import { supabase } from '@/supabase';
</script>