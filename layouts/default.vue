<script setup lang="ts">
const route = useRoute();
const config = useRuntimeConfig();

useHead({
  title: `${config.public.appName}${
    route.meta.title ? ` - ${route.meta.title}` : ""
  }`,
  meta: [
    {
      property: "og:title",
      content: `${config.public.appName}${
        route.meta.title ? ` - ${route.meta.title}` : ""
      }`,
    },
  ],
});
</script>

<template>
  <main>
    <slot />
  </main>
</template>
