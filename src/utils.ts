import { supabase } from "./supabase";

export const usePagination = (page: number, size: number) => {
  const limit = size ? +size : 3;
  const from = page ? page * limit : 0;
  const to = page ? from + size - 1: size - 1;
  return { from, to };
}

export const useAttributeValue = () => {
  const createAttributeValue = async (attributeName: string, attributeValue?: string, attributeTable?:string, attributeRecordId?: number) => {
    let attributeId = 1;

    const { data: attributeExists, error: attributeExistsError } = await supabase
      .from('attributes')
      .select('id, name')
      .eq('name', attributeName);
    if (attributeExistsError) throw attributeExistsError;
    if (attributeExists.length) attributeId = attributeExists[0].id;
    if (attributeExists.length === 0) {
      const { data: lastAttribute, error: lastAttributeError } = await supabase
        .from('attributes')
        .select('id')
        .order('id', { ascending: false })
        .limit(1);
      if (lastAttributeError) throw lastAttributeError;
      if (lastAttribute.length) attributeId = lastAttribute[0].id + 1;

      const attributeForm = {
        id: attributeId,
        name: attributeName,
        table_name: attributeTable,
      }
      const { data: attribute, error: attributeError } = await supabase
        .from('attributes')
        .upsert(attributeForm, { onConflict: 'name, table_name' })
        .select();
      if (attributeError) throw attributeError;
      if (attribute.length) attributeId = attribute[0].id;
    }

    const attributeValueForm = {
      attribute_id: attributeId,
      value: attributeValue ?? null,
      material_id: attributeTable === 'material' ? attributeRecordId : null,
      color_id: attributeTable === 'color' ? attributeRecordId : null,
      gas_id: attributeTable === 'gas' ? attributeRecordId : null,
      ignition_id: attributeTable === 'ignition' ? attributeRecordId : null,
    }

    const { error: attributeValueError } = await supabase
      .from('attribute_value')
      .insert(attributeValueForm);
    if (attributeValueError) throw attributeValueError;
  }

  return { createAttributeValue };
}
