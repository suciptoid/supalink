<script setup lang="ts">
definePageMeta({
  title: "Dashboard",
  layout: "dashboard",
  middleware: ["auth", "org"],
});
</script>

<template>
  <div id="app">
    <!-- <AppHeader /> -->
    <UContainer>Welcome</UContainer>
  </div>
</template>
