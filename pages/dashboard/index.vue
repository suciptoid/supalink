<template>
  <div id="app">
    <!-- <AppHeader /> -->
    <UContainer>Welcome</UContainer>
  </div>
</template>

<script setup lang="ts">
definePageMeta({
  title: "Dashboard",
  layout: "dashboard",
  middleware: ["auth"],
});
</script>
