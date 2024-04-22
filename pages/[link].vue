<script setup lang="ts">
import type { Database } from "~/supabase/types";

const route = useRoute();

const supabase = useSupabaseClient<Database>();
const link = await supabase
  .from("links")
  .select("id,org_id,slug,url")
  .eq("slug", route.params.link)
  .single();

if (link.data) {
  // Navigating to link
  const track = await supabase.rpc("track_link", { link_id: link.data.id });
  console.log("tracked", track);
  await navigateTo(link.data.url, { external: true });
} else {
  await navigateTo("/");
}
</script>

<template>
  <div>Redirecting...</div>
</template>
