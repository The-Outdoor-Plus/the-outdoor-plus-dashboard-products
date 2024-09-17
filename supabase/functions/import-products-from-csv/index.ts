// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { corsHeaders } from "../_shared/cors.ts";
import { parse } from "jsr:@std/csv";
// import { readCSV } from "https://deno.land/std@0.203.0/csv/mod.ts";
import { createClient, SupabaseClient } from "https://esm.sh/@supabase/supabase-js@2";
import { Database } from "../_shared/types/supabase.ts";
import { Product, RecordData, Variation } from "../_shared/types/products.ts";
import { extractProducts, filterFormPayload, handleCreateProduct, handleFiles, transformRecordData, handleProductAttributes, handleVariationAttributes, handleCreateVariation } from "./methods.ts";

Deno.serve(async (req: Request) => {
  if (req.method === 'OPTIONS') {
    return new Response(null, { status: 204, headers: { ...corsHeaders } });
  }

  const supabaseClient = createClient<Database>(
    Deno.env.get('SUPABASE_URL') ?? '',
    Deno.env.get('SUPABASE_ANON_KEY') ?? '',
    { global: { headers: { ...corsHeaders, Authorization: req.headers.get('Authorization')! } } }
  )

  if (req.method === 'POST') {
    if (req.headers.get('Content-Type')?.includes('multipart/form-data')) {
      const formData = await req.formData();
      const file = formData.get('file') as File;

      if (!file) {
        return new Response(JSON.stringify({ message: 'No File Uploaded' }), { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json'} });
      }

      const mimeType = file.type;
      const fileName = file.name;

      if (mimeType !== 'text/csv' || !fileName.endsWith('.csv')) {
        return new Response(JSON.stringify({ message: 'Invalid file type. Please upload a CSV File.'}), { status: 415, headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
      }

      const fileContent = await file.text();
      const importData = await parse(fileContent, {
        skipFirstRow: true,
        strip: true,
      });

      const recordData: RecordData[] = transformRecordData(importData);

      const products: Product[] = extractProducts(recordData);

      const results = {};

      products.forEach(async (product: Product) => {
        try {
          const productForm = filterFormPayload<Product>(product, 'productKeys');
          const newProduct = await handleCreateProduct(productForm, supabaseClient);

          const variationsPromise: Promise<any>[] = [];

          if (newProduct && newProduct[0].id) {
            await handleFiles(newProduct[0].id || 0, newProduct[0].name, 'product', product.images, supabaseClient, 'image');
            await handleFiles(newProduct[0].id || 0, newProduct[0].name, 'product', product.specification_sheets, supabaseClient, 'specification_sheet');
            await handleFiles(newProduct[0].id || 0, newProduct[0].name, 'product', product.documents, supabaseClient, 'documents');
            const { attributesResponse, configurationResponse } = await handleProductAttributes(product, newProduct[0].id, supabaseClient);

            product.variations?.forEach(async (variation: Variation) => {
              variationsPromise.push(handleCreateVariation({ ...variation, parent_id: newProduct[0].id }, supabaseClient));
              // await handleCreateVariation({ ...variation, parent_id: newProduct[0].id }, supabaseClient);
            })
          }

          const variationsResult = await Promise.allSettled(variationsPromise);
        } catch (e) {
          console.error(e);
          return;
        }
      });

      return new Response(
        JSON.stringify({ message: 'Working', results, products }),
        { status: 200, headers: { "Content-Type": "application/json", ...corsHeaders } },
      )
    }

    return new Response(JSON.stringify({ message: 'Content Type not supported' }), { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
  }

  return new Response(JSON.stringify({ message: 'Method Not Allowed' }), { status: 405, headers: { ...corsHeaders, 'Content-Type': 'application/json' } })
})

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/import-products-from-csv' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
