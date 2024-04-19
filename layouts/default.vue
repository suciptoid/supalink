<script setup lang="ts">
const route = useRoute();

useHead({
  title: `SupaLink - ${route.meta.title}`,
  meta: [{ property: "og:title", content: `SupaLink - ${route.meta.title}` }],
});
</script>

<template>
  <main>
    <slot />
  </main>
</template>
