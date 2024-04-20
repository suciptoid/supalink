<script setup lang="ts">
const route = useRoute();

useHead({
  title: `SupaLink - ${route.meta.title}`,
  meta: [{ property: "og:title", content: `SupaLink - ${route.meta.title}` }],
});
</script>
<template>
  <main class="flex h-screen inset-0 overflow-hidden">
    <AppSidebar />
    <div class="flex-1 flex flex-col">
      <AppHeader />
      <slot />
    </div>
  </main>
</template>
