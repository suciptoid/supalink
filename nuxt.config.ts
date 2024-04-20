// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },
  pages: true,
  ssr: true,
  modules: ["@nuxt/ui", "@nuxtjs/supabase"],
  // nitro: {
  //   preset: "cloudflare-pages",
  //   prerender: {
  //     autoSubfolderIndex: false,
  //   },
  // },
  supabase: {
    redirect: false,
  },
});
