import type { Database } from "~/supabase/types";

export default defineNuxtRouteMiddleware(async (to) => {
  // Check if user has an org, if not redirect to create org
  const user = useSupabaseUser();
  const supabase = useSupabaseClient<Database>();
  const orgs = await supabase
    .from("orgs")
    .select("id,name,org_users!inner(id,role)")
    .eq("org_users.user_id", user.value!.id);

  console.log("org middleware", orgs.data);

  if (orgs.data?.length === 0) {
    return navigateTo("/org/create");
  }
});
