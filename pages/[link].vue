<script setup lang="ts">
const route = useRoute();
console.log("redirecting to", route.params.link);
await navigateTo("https://github.com", { external: true });
</script>

<template>
  <div>Redirecting...</div>
</template>
