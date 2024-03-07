import { defineStore } from "pinia";
import { toTypedSchema } from "@vee-validate/yup";
import * as yup from 'yup';

interface State<T> {
  priceTypeList: { value: string, key: string }[];
  formValidation: T;
  initialValues: any;
  variationKeys: string[];
  pricesByRole: { [key: string]: string[] }
}

export const useVariationStore = defineStore('variation', {
  state: (): State<typeof formValidation> => {
    const formValidation = toTypedSchema(
      yup.object({
        name: yup.string().min(2).required(),
        sku: yup.string().min(2).required(),
        enabled: yup.boolean(),
        upc_codes: yup.string().nullable(),
        encoded_upc_codes: yup.string().nullable(),
        short_description: yup.string().nullable(),
        description: yup.string().nullable(),
        product_length: yup.string().nullable(),
        product_diameter: yup.string().nullable(),
        product_width: yup.string().nullable(),
        product_height: yup.string().nullable(),
        base_length: yup.string().nullable(),
        base_diameter: yup.string().nullable(),
        base_width: yup.string().nullable(),
        base_opening: yup.string().nullable(),
        toe_kick: yup.string().nullable(),
        soil_usage: yup.string().nullable(),
        scupper_width: yup.string().nullable(),
        scupper_inlet_opening: yup.string().nullable(),
        gpm: yup.string().nullable(),
        fire_glass: yup.string().nullable(),
        ba_length: yup.string().nullable(),
        ba_diameter: yup.string().nullable(),
        ba_width: yup.string().nullable(),
        ba_depth: yup.string().nullable(),
        burner_shape: yup.string().nullable(),
        burner_length: yup.string().nullable(),
        burner_diameter: yup.string().nullable(),
        compatible_canvas_cover: yup.string().nullable(),
        compatible_bullet_burner: yup.string().nullable(),
        compatible_glass_wind_guard: yup.string().nullable(),
        product_serial_base: yup.string().nullable(),
        website_link: yup.string().nullable(),
      }),
    );

    const initialValues = {
      name: '',
      sku: '',
      enabled: false,
      upc_codes: '',
      encoded_upc_codes: '',
      short_description: '',
      description: '',
      product_length: '',
      product_diameter: '',
      product_width: '',
      product_height: '',
      base_length: '',
      base_diameter: '',
      base_width: '',
      base_opening: '',
      toe_kick: '',
      soil_usage: '',
      scupper_width: '',
      scupper_inlet_opening: '',
      gpm: '',
      fire_glass: '',
      ba_length: '',
      ba_diameter: '',
      ba_width: '',
      ba_depth: '',
      burner_shape: '',
      burner_length: '',
      burner_diameter: '',
      compatible_canvas_cover: '',
      compatible_bullet_burner: '',
      compatible_glass_wind_guard: '',
      product_serial_base: '',
      website_link: '',
    }

    const priceTypeList = [
      { value: 'Internet', key: 'internet' },
      { value: 'MAP', key: 'map' },
      { value: 'MSRP', key: 'msrp' },
      { value: 'Group', key: 'group' },
      { value: 'Dealer', key: 'dealer' },
      { value: 'Distributor', key: 'distributor' },
      { value: 'Landscape', key: 'landscape' },
      { value: 'Master Distributor', key: 'master_distributor' },
    ];

    const pricesByRole = {
      USER: ['msrp'],
      GUEST: ['msrp'],
      GROUP: ['group', 'map', 'msrp'],
      LANDSCAPE: ['landscape', 'map', 'msrp'],
      INTERNET: ['internet', 'map', 'msrp'],
      ECOMMERCE: ['map', 'msrp'],
      DEALER: ['dealer', 'map', 'msrp'],
      DISTRIBUTOR: ['distributor', 'map', 'msrp'],
      MASTER_DISTRIBUTOR: ['master_distributor', 'msrp', 'map'],
      MANAGER: ['msrp', 'map', 'internet', 'dealer', 'distributor', 'group', 'landscape', 'master_distributor'],
      ADMIN: ['msrp', 'map', 'internet', 'dealer', 'distributor', 'group', 'landscape', 'master_distributor'],
    }

    const variationKeys = [
      'enabled',
      'name',
      'sku',
      'upc_codes',
      'encoded_upc_codes',
      'short_description',
      'description',
      'product_length',
      'product_diameter',
      'product_width',
      'product_height',
      'base_length',
      'base_diameter',
      'base_width',
      'base_opening',
      'toe_kick',
      'soil_usage',
      'scupper_width',
      'scupper_inlet_opening',
      'gpm',
      'fire_glass',
      'ba_length',
      'ba_diameter',
      'ba_width',
      'ba_depth',
      'burner_shape',
      'burner_length',
      'burner_diameter',
      'compatible_canvas_cover',
      'compatible_bullet_burner',
      'compatible_glass_wind_guard',
      'product_serial_base',
      'website_link',
    ]

    return {
      formValidation,
      initialValues,
      priceTypeList,
      pricesByRole,
      variationKeys,
    }
  },
  actions: {
    allowedPrices(userRole: string) {
      return this.pricesByRole[userRole];
    }
  },
  getters: {
  },
});
