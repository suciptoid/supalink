<script setup lang="ts">
import type { Database } from "~/supabase/types";

definePageMeta({
  title: "Analytics",
  layout: "dashboard",
  middleware: ["auth"],
});

const route = useRoute();

const supabase = useSupabaseClient<Database>();

const { pending, data: stats } = useAsyncData("stats", async () => {
  let query = supabase
    .from("analytics")
    .select("total:clicks.sum(), links!inner(org_id)")
    .eq("links.org_id", route.params.org_id);

  if (route.query.link) {
    query = query.eq("links.id", route.query.link);
  }

  return await query.single();
});

console.log("data stats", stats.value);
</script>

<template>
  <div id="stats">
    <!-- <AppHeader /> -->
    <UContainer>
      <div class="grid grid-cols-2 gap-4 mt-4">
        <UCard>
          <div class="flex items-center justify-between">
            <div>
              <div
                class="text-lg font-semibold text-gray-900 dark:text-gray-200"
              >
                Total Clicks
              </div>
              <div class="text-sm text-gray-500">
                Total clicks on all links on this org
              </div>
            </div>
            <div class="text-5xl font-bold">{{ stats?.data?.total }}</div>
          </div>
        </UCard>
      </div>
    </UContainer>
  </div>
</template>
