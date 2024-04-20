<script setup lang="ts">
import type { Database } from "~/supabase/types";

const route = useRoute();
console.log("redirecting to", route.params.link);

const supabase = useSupabaseClient<Database>();
const link = await supabase
  .from("links")
  .select("id,org_id,slug,url")
  .eq("slug", route.params.link)
  .single();

if (link.data) {
  // Navigating to link
  // TODO: update stats
  await navigateTo(link.data.url, { external: true });
} else {
  await navigateTo("/");
}
</script>

<template>
  <div>Redirecting...</div>
</template>
