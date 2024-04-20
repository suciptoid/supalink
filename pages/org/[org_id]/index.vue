<script setup lang="ts">
import type { Database } from "~/supabase/types";

definePageMeta({
  title: "Links",
  layout: "dashboard",
  middleware: ["auth", "org"],
});

const route = useRoute();
const supabase = useSupabaseClient<Database>();

const org = await supabase
  .from("links")
  .select()
  .eq("org_id", route.params.org_id);
</script>

<template>
  <div id="app">
    <UContainer class="py-4">
      <div id="link-lists" class="space-y-2">
        <UCard v-for="link in org.data" :key="link.id">
          {{ link.url }}
          {{ link.slug }}
        </UCard>
      </div>
    </UContainer>
  </div>
</template>
