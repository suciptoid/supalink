<template>
  <div id="app">
    <AppHeader />
    <UContainer>Welcome</UContainer>
  </div>
</template>

<script setup lang="ts">
definePageMeta({
  middleware: ["auth"],
});
</script>
