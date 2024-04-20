<script setup lang="ts">
import type { Database } from "~/supabase/types";

definePageMeta({
  title: "Select Org",
  middleware: ["auth", "org"],
});

const user = useSupabaseUser();
const db = useSupabaseClient<Database>();

const org = await db
  .from("orgs")
  .select("id,name,org_users!inner(id,role)")
  .eq("org_users.user_id", user.value!.id)
  .limit(1)
  .single();

if (org.data) {
  navigateTo(`/org/${org.data.id}`);
} else {
  navigateTo("/org/create");
}
</script>

<template>
  <div id="orgs" class="flex items-center justify-center min-h-screen flex-col">
    Redirecting...
    <!-- Select an org
    <div class="w-full max-w-lg border rounded-md shadow-sm flex flex-col">
      <ULink
        v-for="org in orgs.data"
        :key="org.id"
        class="px-3 py-2 hover:bg-gray-100"
        :to="`/org/${org.id}`"
      >
        {{ org.name }}
      </ULink>
    </div> -->
  </div>
</template>
