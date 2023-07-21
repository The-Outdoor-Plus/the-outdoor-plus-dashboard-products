<template>
  <v-app>
    <router-view></router-view>
    <notifications position="bottom right" width="400"/>
  </v-app>
</template>

<script setup lang="ts">
</script>

<style lang="scss" scoped>
:deep(.vue-notification-wrapper > .vue-notification-template) {
  font-size: 14px;
  & > .notification-title {
    font-size: 17px;
  }
}
</style>