// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { corsHeaders } from "../_shared/cors.ts"
import { createClient, SupabaseClient } from "https://esm.sh/@supabase/supabase-js@2";
import { Database } from '../_shared/types/supabase.ts';

interface AttributeValue {
  id: number | null;
  attribute_id: number;
  value: string;
  sku_code: string | null;
}

interface ProductConfiguration {
  id: number;
  name: string;
  table_name: string | null;
  fill_values: boolean;
  sku_var: string;
  attribute_value: number[];
  attribute_values: AttributeValue[];
}

interface Configuration {
  attribute_id: number;
  value_id: number | null;
}

interface SkuCombination {
  sku: string;
  name: string;
  configurations: Configuration[];
  response?: any | null;
}

interface VariationForm extends Payload {
  parent_id: number;
  sku: string;
  name: string;

}

interface Payload {
  certifications?: string[] | null;
  dealer_price?: string | null;
  distributor_price?: string | null;
  group_price?: string | null;
  internet_price?: string | null;
  landscape_price?: string | null;
  map_price?: string | null;
  master_distributor_price?: string | null;
  msrp_price?: string | null;
}

interface variationConfigurationForm {
  variation_id: number;
  attribute_id: number;
  value_id: number | null;
}

Deno.serve(async (req: Request) => {
  if (req.method === 'OPTIONS') {
    return new Response(null, { status: 204, headers: { ...corsHeaders } });
  }

  const productConfiguration: ProductConfiguration[] = []

  const sanitizeValue = (value: string): string => {
    return value.replace(/\\/g, '');
  }

  async function generateCombinations (config: ProductConfiguration[], formula: string, baseName: string, parent_id: number, payload: Payload, supabaseClient: SupabaseClient<Database>): Promise<SkuCombination[]> {
    const regex = /\{([A-Z]+)\}/g;
    const skuVars = [...formula.matchAll(regex)].map(match => match[1]);

    const findAttributeBySkuVar = (skuVar: string): ProductConfiguration | undefined => {
      return config.find(attr => attr.sku_var === skuVar);
    }

    const replaceSkuVar = (currentFormula: string, skuVar: string, skuCode: string | null) => {
      return currentFormula.replace(`{${skuVar}}`, skuCode || '');
    }

    const generate = async (index = 0, currentFormula: string, currentName: string, payload: Payload, currentConfigurations: Configuration[], ): Promise<SkuCombination[]> => {
      if (index >= skuVars.length) {
        const result = await createVariation(supabaseClient, { name: currentName, parent_id, sku: currentFormula, ...payload }, currentConfigurations)
        return [{
          sku: currentFormula,
          name: currentName,
          configurations: currentConfigurations,
          response: result,
        }];
      }

      const skuVar = skuVars[index];
      const attribute = findAttributeBySkuVar(skuVar);

      if (!attribute || !attribute.attribute_values) {
        return [];
      }

      const combinations: SkuCombination[] = [];

      for (const value of attribute.attribute_values) {
        const updatedFormula = replaceSkuVar(currentFormula, skuVar, value.sku_code);
        const updatedName = `${currentName} - ${sanitizeValue(value.value)}`
        const newConfigurations = [...currentConfigurations, { attribute_id: value.attribute_id, value_id: value.id }];
        combinations.push(...await generate(index + 1, updatedFormula, updatedName, payload, newConfigurations));
      }

      return combinations;
    }

    return await generate(0, formula, baseName, payload, []);
  }

  const insertVariationConfiguration = async(supabaseClient: SupabaseClient, variationConfigurationForm: variationConfigurationForm) => {
    try {
      const { data, error } = await supabaseClient.from('variation_configuration')
        .insert(variationConfigurationForm).select();
      if (error) {
        throw new Error(error.message);
      }
      return data;
    } catch (e) {
      console.log('Insert Variation Configuration Catch', e);
    }
  }

  const insertVariation = async (supabaseClient: SupabaseClient, newVariationForm: VariationForm) => {
    try {
      const { data, error } = await supabaseClient.from('variation')
        .insert(newVariationForm)
        .select();
      if (error) {
        if (error.code === "23505") {
          return { sku: newVariationForm.sku, message: 'SKU Already in table' };
        } else {
          throw new Error(error.message);
        }
      }
      return data;
    } catch (e) {
      console.error(e);
      console.log('Insert Variation Catch', e);
    }
  }

  const createVariation = async (supabaseClient: SupabaseClient, newVariationForm: VariationForm, configurations: Configuration[]) => {
    try {
      const variation: any = await insertVariation(supabaseClient, newVariationForm);
      const variationConfigurationsPromise: Promise<any>[] = [];
      if (variation && variation[0] && variation[0].id && variation.message !== 'SKU Already in table') {
        configurations.forEach((conf) => {
          variationConfigurationsPromise.push(
            insertVariationConfiguration(supabaseClient, { variation_id: variation[0].id, attribute_id: conf.attribute_id, value_id: conf.value_id })
          );
        });
        const configurationsResult = await Promise.allSettled(variationConfigurationsPromise);
        return {
          variation: variation[0],
          configuration: configurationsResult
        };
      }
      return variation;
    } catch (e) {
      console.log('Create Variation Catch', e);
    }
  }

  if (req.method === 'POST') {
    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? '',
      { global: { headers: { Authorization: req.headers.get('Authorization')!, ...corsHeaders } } }
    )

    const body = await req.json();
    const productConf = body.product_configuration;
    const skuFormula = body.sku_formula;
    const baseName = body.product_name;
    const parent_id = body.product_id;
    const certifications = body.certifications || [];
    const dealer_price = body.dealer_price || null;
    const distributor_price = body.distributor_price || null;
    const group_price = body.group_price || null;
    const master_distributor_price = body.master_distributor_price || null;
    const internet_price = body.internet_price || null;
    const landscape_price = body.landscape_price || null;
    const map_price = body.map_price || null;
    const msrp_price = body.msrp_price || null;

    const allSkus = await generateCombinations(productConf, skuFormula, baseName, parent_id, {
      certifications,
      dealer_price,
      distributor_price,
      group_price,
      master_distributor_price,
      internet_price,
      landscape_price,
      map_price,
      msrp_price
    }, supabaseClient);
    const variationsCreated = allSkus.filter((skus) => skus.response?.variation?.id).length;
    const duplicateSkus = allSkus.filter((skus) => skus.response?.message === 'SKU Already in table').length;

    return new Response(JSON.stringify({ variationsCreated, possibleCombinations: allSkus.length, duplicateSkus, result: allSkus }), { status: 200, headers: { ...corsHeaders, 'Content-Type': 'application/json' }});

  }

  return new Response(JSON.stringify({ message: 'Method Not Allowed'}), { status: 405, headers: { ...corsHeaders, 'Content-Type': 'application/json' } });
})

// const skuFormula = 'OPT-TESTPR{MAT}{IGN}{SZE}-{CLR}-{GAS}';
// const baseName = 'Test Product';

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/generate-variations' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
