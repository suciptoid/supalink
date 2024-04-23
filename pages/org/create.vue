<script setup lang="ts">
import type { FormError, FormSubmitEvent } from "#ui/types";
import type { Database } from "~/supabase/types";

const user = useSupabaseUser();
const supabase = useSupabaseClient<Database>();
const toast = useToast();

definePageMeta({
  title: "Create Org",
  // middleware: ["auth"],
});

const state = reactive({
  name: "",
});

const validate = (state: any): FormError[] => {
  const errors = [];
  if (!state.name)
    errors.push({ path: "name", message: "Organization name is required" });
  return errors;
};

async function onSubmit(event: FormSubmitEvent<any>) {
  const org = await supabase
    .from("orgs")
    .insert({
      name: state.name,
    })
    .select("id,name")
    .single();

  if (org.error) {
    toast.add({
      id: "org_create_error",
      title: "Error create org",
      description: org.error.message,
    });
    return;
  }

  const link = await supabase
    .from("org_users")
    .insert({
      org_id: org.data!.id,
      user_id: user.value!.id,
      role: "owner",
    })
    .select("id")
    .single();

  if (link.error) {
    toast.add({
      id: "org_create_error",
      title: "Error create org",
      description: link.error.message,
    });
    return;
  } else {
    toast.add({
      id: "org_create_success",
      title: "Org created",
      description: org.data!.name,
    });

    navigateTo(`/org/${org.data!.id}`);
  }
}
</script>

<template>
  <div id="create-org" class="flex items-center justify-center min-h-screen">
    <UForm
      :validate="validate"
      :state="state"
      class="w-full max-w-sm p-8 shadow-sm border rounded-md"
      @submit="onSubmit"
    >
      <UFormGroup label="Organization Name" name="name" required>
        <UInput size="lg" placeholder="Acme Inc" v-model="state.name" />
      </UFormGroup>

      <UFormGroup class="mt-4">
        <UButton size="lg" type="submit" block> Create Org </UButton>
      </UFormGroup>
    </UForm>
  </div>
</template>
