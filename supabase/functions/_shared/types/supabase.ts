export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  graphql_public: {
    Tables: {
      [_ in never]: never
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      graphql: {
        Args: {
          operationName?: string
          query?: string
          variables?: Json
          extensions?: Json
        }
        Returns: Json
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  pgbouncer: {
    Tables: {
      [_ in never]: never
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      get_auth: {
        Args: {
          p_usename: string
        }
        Returns: {
          username: string
          password: string
        }[]
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  public: {
    Tables: {
      attribute_value: {
        Row: {
          attribute_id: number
          color_id: number | null
          gas_id: number | null
          id: number
          ignition_id: number | null
          material_id: number | null
          sku_code: string | null
          slug: string | null
          value: string | null
        }
        Insert: {
          attribute_id: number
          color_id?: number | null
          gas_id?: number | null
          id?: number
          ignition_id?: number | null
          material_id?: number | null
          sku_code?: string | null
          slug?: string | null
          value?: string | null
        }
        Update: {
          attribute_id?: number
          color_id?: number | null
          gas_id?: number | null
          id?: number
          ignition_id?: number | null
          material_id?: number | null
          sku_code?: string | null
          slug?: string | null
          value?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "attribute_value_attribute_id_fkey"
            columns: ["attribute_id"]
            referencedRelation: "attributes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "attribute_value_color_id_fkey"
            columns: ["color_id"]
            referencedRelation: "color"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "attribute_value_gas_id_fkey"
            columns: ["gas_id"]
            referencedRelation: "gas"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "attribute_value_ignition_id_fkey"
            columns: ["ignition_id"]
            referencedRelation: "ignition"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "attribute_value_material_id_fkey"
            columns: ["material_id"]
            referencedRelation: "material"
            referencedColumns: ["id"]
          },
        ]
      }
      attributes: {
        Row: {
          id: number
          name: string | null
          sku_var: string | null
          slug: string | null
          table_name: string | null
        }
        Insert: {
          id?: number
          name?: string | null
          sku_var?: string | null
          slug?: string | null
          table_name?: string | null
        }
        Update: {
          id?: number
          name?: string | null
          sku_var?: string | null
          slug?: string | null
          table_name?: string | null
        }
        Relationships: []
      }
      category: {
        Row: {
          id: number
          name: string | null
          parent_id: number | null
          slug: string | null
        }
        Insert: {
          id?: number
          name?: string | null
          parent_id?: number | null
          slug?: string | null
        }
        Update: {
          id?: number
          name?: string | null
          parent_id?: number | null
          slug?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "category_parent_id_fkey"
            columns: ["parent_id"]
            referencedRelation: "category"
            referencedColumns: ["id"]
          },
        ]
      }
      collection: {
        Row: {
          id: number
          name: string | null
          slug: string | null
        }
        Insert: {
          id?: number
          name?: string | null
          slug?: string | null
        }
        Update: {
          id?: number
          name?: string | null
          slug?: string | null
        }
        Relationships: []
      }
      color: {
        Row: {
          id: number
          image_url: string | null
          material_id: number | null
          name: string | null
          sku_code: string | null
          slug: string | null
        }
        Insert: {
          id?: number
          image_url?: string | null
          material_id?: number | null
          name?: string | null
          sku_code?: string | null
          slug?: string | null
        }
        Update: {
          id?: number
          image_url?: string | null
          material_id?: number | null
          name?: string | null
          sku_code?: string | null
          slug?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "color_material_id_fkey"
            columns: ["material_id"]
            referencedRelation: "material"
            referencedColumns: ["id"]
          },
        ]
      }
      company: {
        Row: {
          created_at: string
          id: number
          logo_url: string | null
          name: string
          role: Database["public"]["Enums"]["user_role"] | null
          slug: string | null
        }
        Insert: {
          created_at?: string
          id?: number
          logo_url?: string | null
          name: string
          role?: Database["public"]["Enums"]["user_role"] | null
          slug?: string | null
        }
        Update: {
          created_at?: string
          id?: number
          logo_url?: string | null
          name?: string
          role?: Database["public"]["Enums"]["user_role"] | null
          slug?: string | null
        }
        Relationships: []
      }
      dealer_price: {
        Row: {
          id: number
          price: number
          product_id: number | null
          variation_id: number | null
          year: number
        }
        Insert: {
          id?: number
          price: number
          product_id?: number | null
          variation_id?: number | null
          year: number
        }
        Update: {
          id?: number
          price?: number
          product_id?: number | null
          variation_id?: number | null
          year?: number
        }
        Relationships: [
          {
            foreignKeyName: "dealer_price_product_id_fkey"
            columns: ["product_id"]
            referencedRelation: "product"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "dealer_price_variation_id_fkey"
            columns: ["variation_id"]
            referencedRelation: "variation"
            referencedColumns: ["id"]
          },
        ]
      }
      distributor_price: {
        Row: {
          id: number
          price: number
          product_id: number | null
          variation_id: number | null
          year: number
        }
        Insert: {
          id?: number
          price: number
          product_id?: number | null
          variation_id?: number | null
          year: number
        }
        Update: {
          id?: number
          price?: number
          product_id?: number | null
          variation_id?: number | null
          year?: number
        }
        Relationships: [
          {
            foreignKeyName: "distributor_price_product_id_fkey"
            columns: ["product_id"]
            referencedRelation: "product"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "distributor_price_variation_id_fkey"
            columns: ["variation_id"]
            referencedRelation: "variation"
            referencedColumns: ["id"]
          },
        ]
      }
      documents: {
        Row: {
          id: number
          name: string | null
          url: string
        }
        Insert: {
          id?: number
          name?: string | null
          url: string
        }
        Update: {
          id?: number
          name?: string | null
          url?: string
        }
        Relationships: []
      }
      gas: {
        Row: {
          id: number
          name: string | null
          sku_code: string | null
          slug: string | null
        }
        Insert: {
          id?: number
          name?: string | null
          sku_code?: string | null
          slug?: string | null
        }
        Update: {
          id?: number
          name?: string | null
          sku_code?: string | null
          slug?: string | null
        }
        Relationships: []
      }
      group_price: {
        Row: {
          id: number
          price: number
          product_id: number | null
          variation_id: number | null
          year: number
        }
        Insert: {
          id?: number
          price: number
          product_id?: number | null
          variation_id?: number | null
          year: number
        }
        Update: {
          id?: number
          price?: number
          product_id?: number | null
          variation_id?: number | null
          year?: number
        }
        Relationships: [
          {
            foreignKeyName: "group_price_product_id_fkey"
            columns: ["product_id"]
            referencedRelation: "product"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "group_price_variation_id_fkey"
            columns: ["variation_id"]
            referencedRelation: "variation"
            referencedColumns: ["id"]
          },
        ]
      }
      ignition: {
        Row: {
          id: number
          name: string | null
          sku_code: string | null
          slug: string | null
        }
        Insert: {
          id?: number
          name?: string | null
          sku_code?: string | null
          slug?: string | null
        }
        Update: {
          id?: number
          name?: string | null
          sku_code?: string | null
          slug?: string | null
        }
        Relationships: []
      }
      image: {
        Row: {
          id: number
          name: string | null
          url: string | null
        }
        Insert: {
          id?: number
          name?: string | null
          url?: string | null
        }
        Update: {
          id?: number
          name?: string | null
          url?: string | null
        }
        Relationships: []
      }
      internet_price: {
        Row: {
          id: number
          price: number
          product_id: number | null
          variation_id: number | null
          year: number
        }
        Insert: {
          id?: number
          price: number
          product_id?: number | null
          variation_id?: number | null
          year: number
        }
        Update: {
          id?: number
          price?: number
          product_id?: number | null
          variation_id?: number | null
          year?: number
        }
        Relationships: [
          {
            foreignKeyName: "internet_price_product_id_fkey"
            columns: ["product_id"]
            referencedRelation: "product"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "internet_price_variation_id_fkey"
            columns: ["variation_id"]
            referencedRelation: "variation"
            referencedColumns: ["id"]
          },
        ]
      }
      landscape_price: {
        Row: {
          id: number
          price: number
          product_id: number | null
          variation_id: number | null
          year: number
        }
        Insert: {
          id?: number
          price: number
          product_id?: number | null
          variation_id?: number | null
          year: number
        }
        Update: {
          id?: number
          price?: number
          product_id?: number | null
          variation_id?: number | null
          year?: number
        }
        Relationships: [
          {
            foreignKeyName: "landscape_price_product_id_fkey"
            columns: ["product_id"]
            referencedRelation: "product"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "landscape_price_variation_id_fkey"
            columns: ["variation_id"]
            referencedRelation: "variation"
            referencedColumns: ["id"]
          },
        ]
      }
      map_price: {
        Row: {
          id: number
          price: number
          product_id: number | null
          variation_id: number | null
          year: number
        }
        Insert: {
          id?: number
          price: number
          product_id?: number | null
          variation_id?: number | null
          year: number
        }
        Update: {
          id?: number
          price?: number
          product_id?: number | null
          variation_id?: number | null
          year?: number
        }
        Relationships: [
          {
            foreignKeyName: "map_price_product_id_fkey"
            columns: ["product_id"]
            referencedRelation: "product"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "map_price_variation_id_fkey"
            columns: ["variation_id"]
            referencedRelation: "variation"
            referencedColumns: ["id"]
          },
        ]
      }
      master_distributor_price: {
        Row: {
          id: number
          price: number
          product_id: number | null
          variation_id: number | null
          year: number
        }
        Insert: {
          id?: number
          price: number
          product_id?: number | null
          variation_id?: number | null
          year: number
        }
        Update: {
          id?: number
          price?: number
          product_id?: number | null
          variation_id?: number | null
          year?: number
        }
        Relationships: [
          {
            foreignKeyName: "master_distributor_price_product_id_fkey"
            columns: ["product_id"]
            referencedRelation: "product"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "master_distributor_price_variation_id_fkey"
            columns: ["variation_id"]
            referencedRelation: "variation"
            referencedColumns: ["id"]
          },
        ]
      }
      material: {
        Row: {
          id: number
          image_url: string | null
          name: string | null
          sku_code: string | null
          slug: string | null
        }
        Insert: {
          id?: number
          image_url?: string | null
          name?: string | null
          sku_code?: string | null
          slug?: string | null
        }
        Update: {
          id?: number
          image_url?: string | null
          name?: string | null
          sku_code?: string | null
          slug?: string | null
        }
        Relationships: []
      }
      msrp_price: {
        Row: {
          id: number
          price: number
          product_id: number | null
          variation_id: number | null
          year: number
        }
        Insert: {
          id?: number
          price: number
          product_id?: number | null
          variation_id?: number | null
          year: number
        }
        Update: {
          id?: number
          price?: number
          product_id?: number | null
          variation_id?: number | null
          year?: number
        }
        Relationships: [
          {
            foreignKeyName: "msrp_price_product_id_fkey"
            columns: ["product_id"]
            referencedRelation: "product"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "msrp_price_variation_id_fkey"
            columns: ["variation_id"]
            referencedRelation: "variation"
            referencedColumns: ["id"]
          },
        ]
      }
      product: {
        Row: {
          access_door: boolean | null
          burner_shape: string | null
          category_id: number | null
          certifications:
            | Database["public"]["Enums"]["certification_type"][]
            | null
          collection_id: number | null
          company_division: string | null
          compatible_bullet_burner: string | null
          compatible_canvas_cover: string | null
          compatible_glass_wind_guard: string | null
          created_at: string
          created_by: string | null
          dealer_price: number | null
          description: string | null
          distributor_price: number | null
          enabled: boolean | null
          group_price: number | null
          id: number
          internet_price: number | null
          landscape_price: number | null
          map_price: number | null
          master_distributor_price: number | null
          material_id: number | null
          meta: Json | null
          msrp_price: number | null
          name: string | null
          product_meta: Json | null
          product_serial_base: string | null
          product_type: Database["public"]["Enums"]["product_type"] | null
          published: boolean | null
          shape_id: number | null
          short_description: string | null
          sku: string | null
          updated_at: string
          updated_by: string | null
          website_link: string | null
        }
        Insert: {
          access_door?: boolean | null
          burner_shape?: string | null
          category_id?: number | null
          certifications?:
            | Database["public"]["Enums"]["certification_type"][]
            | null
          collection_id?: number | null
          company_division?: string | null
          compatible_bullet_burner?: string | null
          compatible_canvas_cover?: string | null
          compatible_glass_wind_guard?: string | null
          created_at?: string
          created_by?: string | null
          dealer_price?: number | null
          description?: string | null
          distributor_price?: number | null
          enabled?: boolean | null
          group_price?: number | null
          id?: number
          internet_price?: number | null
          landscape_price?: number | null
          map_price?: number | null
          master_distributor_price?: number | null
          material_id?: number | null
          meta?: Json | null
          msrp_price?: number | null
          name?: string | null
          product_meta?: Json | null
          product_serial_base?: string | null
          product_type?: Database["public"]["Enums"]["product_type"] | null
          published?: boolean | null
          shape_id?: number | null
          short_description?: string | null
          sku?: string | null
          updated_at?: string
          updated_by?: string | null
          website_link?: string | null
        }
        Update: {
          access_door?: boolean | null
          burner_shape?: string | null
          category_id?: number | null
          certifications?:
            | Database["public"]["Enums"]["certification_type"][]
            | null
          collection_id?: number | null
          company_division?: string | null
          compatible_bullet_burner?: string | null
          compatible_canvas_cover?: string | null
          compatible_glass_wind_guard?: string | null
          created_at?: string
          created_by?: string | null
          dealer_price?: number | null
          description?: string | null
          distributor_price?: number | null
          enabled?: boolean | null
          group_price?: number | null
          id?: number
          internet_price?: number | null
          landscape_price?: number | null
          map_price?: number | null
          master_distributor_price?: number | null
          material_id?: number | null
          meta?: Json | null
          msrp_price?: number | null
          name?: string | null
          product_meta?: Json | null
          product_serial_base?: string | null
          product_type?: Database["public"]["Enums"]["product_type"] | null
          published?: boolean | null
          shape_id?: number | null
          short_description?: string | null
          sku?: string | null
          updated_at?: string
          updated_by?: string | null
          website_link?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "product_category_id_fkey"
            columns: ["category_id"]
            referencedRelation: "category"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "product_collection_id_fkey"
            columns: ["collection_id"]
            referencedRelation: "collection"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "product_compatible_bullet_burner_fkey"
            columns: ["compatible_bullet_burner"]
            referencedRelation: "product"
            referencedColumns: ["sku"]
          },
          {
            foreignKeyName: "product_compatible_canvas_cover_fkey"
            columns: ["compatible_canvas_cover"]
            referencedRelation: "product"
            referencedColumns: ["sku"]
          },
          {
            foreignKeyName: "product_compatible_glass_wind_guard_fkey"
            columns: ["compatible_glass_wind_guard"]
            referencedRelation: "product"
            referencedColumns: ["sku"]
          },
          {
            foreignKeyName: "product_created_by_fkey"
            columns: ["created_by"]
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "product_material_id_fkey"
            columns: ["material_id"]
            referencedRelation: "material"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "product_shape_id_fkey"
            columns: ["shape_id"]
            referencedRelation: "shape"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "product_updated_by_fkey"
            columns: ["updated_by"]
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      product_attribute: {
        Row: {
          attribute_id: number
          fill_values: boolean | null
          id: number
          product_id: number
        }
        Insert: {
          attribute_id: number
          fill_values?: boolean | null
          id?: number
          product_id: number
        }
        Update: {
          attribute_id?: number
          fill_values?: boolean | null
          id?: number
          product_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "product_attribute_attribute_id_fkey"
            columns: ["attribute_id"]
            referencedRelation: "attributes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "product_attribute_product_id_fkey"
            columns: ["product_id"]
            referencedRelation: "product"
            referencedColumns: ["id"]
          },
        ]
      }
      product_color: {
        Row: {
          color_id: number
          product_id: number
          type: string | null
        }
        Insert: {
          color_id: number
          product_id: number
          type?: string | null
        }
        Update: {
          color_id?: number
          product_id?: number
          type?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "product_color_color_id_fkey"
            columns: ["color_id"]
            referencedRelation: "color"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "product_color_product_id_fkey"
            columns: ["product_id"]
            referencedRelation: "product"
            referencedColumns: ["id"]
          },
        ]
      }
      product_configuration: {
        Row: {
          product_id: number
          value_id: number
        }
        Insert: {
          product_id: number
          value_id: number
        }
        Update: {
          product_id?: number
          value_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "product_configuration_product_id_fkey"
            columns: ["product_id"]
            referencedRelation: "product"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "product_configuration_value_id_fkey"
            columns: ["value_id"]
            referencedRelation: "attribute_value"
            referencedColumns: ["id"]
          },
        ]
      }
      product_documents: {
        Row: {
          document_id: number
          product_id: number
        }
        Insert: {
          document_id: number
          product_id: number
        }
        Update: {
          document_id?: number
          product_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "product_documents_document_id_fkey"
            columns: ["document_id"]
            referencedRelation: "documents"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "product_documents_product_id_fkey"
            columns: ["product_id"]
            referencedRelation: "product"
            referencedColumns: ["id"]
          },
        ]
      }
      product_gas: {
        Row: {
          gas_id: number
          product_id: number
        }
        Insert: {
          gas_id: number
          product_id: number
        }
        Update: {
          gas_id?: number
          product_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "product_gas_gas_id_fkey"
            columns: ["gas_id"]
            referencedRelation: "gas"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "product_gas_product_id_fkey"
            columns: ["product_id"]
            referencedRelation: "product"
            referencedColumns: ["id"]
          },
        ]
      }
      product_ignition: {
        Row: {
          ignition_id: number
          product_id: number
        }
        Insert: {
          ignition_id: number
          product_id: number
        }
        Update: {
          ignition_id?: number
          product_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "product_ignition_ignition_id_fkey"
            columns: ["ignition_id"]
            referencedRelation: "ignition"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "product_ignition_product_id_fkey"
            columns: ["product_id"]
            referencedRelation: "product"
            referencedColumns: ["id"]
          },
        ]
      }
      product_image: {
        Row: {
          display_order: number
          image_id: number
          is_primary: boolean | null
          product_id: number
        }
        Insert: {
          display_order?: number
          image_id: number
          is_primary?: boolean | null
          product_id: number
        }
        Update: {
          display_order?: number
          image_id?: number
          is_primary?: boolean | null
          product_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "image_id_fkey"
            columns: ["image_id"]
            referencedRelation: "image"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "product_id_fkey"
            columns: ["product_id"]
            referencedRelation: "product"
            referencedColumns: ["id"]
          },
        ]
      }
      product_material: {
        Row: {
          material_id: number
          product_id: number
        }
        Insert: {
          material_id: number
          product_id: number
        }
        Update: {
          material_id?: number
          product_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "product_material_material_id_fkey"
            columns: ["material_id"]
            referencedRelation: "material"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "product_material_product_id_fkey"
            columns: ["product_id"]
            referencedRelation: "product"
            referencedColumns: ["id"]
          },
        ]
      }
      product_specification_sheet: {
        Row: {
          product_id: number
          specification_sheet_id: number
        }
        Insert: {
          product_id?: number
          specification_sheet_id: number
        }
        Update: {
          product_id?: number
          specification_sheet_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "product_specification_sheet_product_id_fkey"
            columns: ["product_id"]
            referencedRelation: "product"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "product_specification_sheet_specification_sheet_id_fkey"
            columns: ["specification_sheet_id"]
            referencedRelation: "specification_sheet"
            referencedColumns: ["id"]
          },
        ]
      }
      shape: {
        Row: {
          id: number
          name: string | null
          slug: string | null
        }
        Insert: {
          id?: number
          name?: string | null
          slug?: string | null
        }
        Update: {
          id?: number
          name?: string | null
          slug?: string | null
        }
        Relationships: []
      }
      specification_sheet: {
        Row: {
          id: number
          name: string | null
          url: string
        }
        Insert: {
          id?: number
          name?: string | null
          url: string
        }
        Update: {
          id?: number
          name?: string | null
          url?: string
        }
        Relationships: []
      }
      users: {
        Row: {
          company: number | null
          email: string | null
          first_name: string | null
          id: string
          last_name: string | null
          role: Database["public"]["Enums"]["user_role"] | null
        }
        Insert: {
          company?: number | null
          email?: string | null
          first_name?: string | null
          id: string
          last_name?: string | null
          role?: Database["public"]["Enums"]["user_role"] | null
        }
        Update: {
          company?: number | null
          email?: string | null
          first_name?: string | null
          id?: string
          last_name?: string | null
          role?: Database["public"]["Enums"]["user_role"] | null
        }
        Relationships: [
          {
            foreignKeyName: "public_users_company_fkey"
            columns: ["company"]
            referencedRelation: "company"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "users_id_fkey"
            columns: ["id"]
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
      variation: {
        Row: {
          ba_depth: string | null
          ba_diameter: string | null
          ba_length: string | null
          ba_width: string | null
          base_diameter: string | null
          base_length: string | null
          base_opening: string | null
          base_width: string | null
          btu: number | null
          burner_diameter: string | null
          burner_length: string | null
          burner_shape: string | null
          certifications:
            | Database["public"]["Enums"]["certification_type"][]
            | null
          compatible_bullet_burner: string | null
          compatible_canvas_cover: string | null
          compatible_glass_wind_guard: string | null
          created_at: string
          created_by: string | null
          dealer_price: number | null
          description: string | null
          distributor_price: number | null
          enabled: boolean | null
          encoded_upc_codes: string | null
          fire_glass: string | null
          gpm: string | null
          group_price: number | null
          id: number
          internet_price: number | null
          landscape_price: number | null
          map_price: number | null
          master_distributor_price: number | null
          meta: Json | null
          msrp_price: number | null
          name: string | null
          parent_id: number
          product_diameter: string | null
          product_height: string | null
          product_length: string | null
          product_meta: Json | null
          product_serial_base: string | null
          product_width: string | null
          scupper_inlet_opening: string | null
          scupper_width: string | null
          short_description: string | null
          sku: string
          soil_usage: string | null
          toe_kick: string | null
          upc_codes: string | null
          updated_at: string
          updated_by: string | null
          website_link: string | null
        }
        Insert: {
          ba_depth?: string | null
          ba_diameter?: string | null
          ba_length?: string | null
          ba_width?: string | null
          base_diameter?: string | null
          base_length?: string | null
          base_opening?: string | null
          base_width?: string | null
          btu?: number | null
          burner_diameter?: string | null
          burner_length?: string | null
          burner_shape?: string | null
          certifications?:
            | Database["public"]["Enums"]["certification_type"][]
            | null
          compatible_bullet_burner?: string | null
          compatible_canvas_cover?: string | null
          compatible_glass_wind_guard?: string | null
          created_at?: string
          created_by?: string | null
          dealer_price?: number | null
          description?: string | null
          distributor_price?: number | null
          enabled?: boolean | null
          encoded_upc_codes?: string | null
          fire_glass?: string | null
          gpm?: string | null
          group_price?: number | null
          id?: number
          internet_price?: number | null
          landscape_price?: number | null
          map_price?: number | null
          master_distributor_price?: number | null
          meta?: Json | null
          msrp_price?: number | null
          name?: string | null
          parent_id: number
          product_diameter?: string | null
          product_height?: string | null
          product_length?: string | null
          product_meta?: Json | null
          product_serial_base?: string | null
          product_width?: string | null
          scupper_inlet_opening?: string | null
          scupper_width?: string | null
          short_description?: string | null
          sku: string
          soil_usage?: string | null
          toe_kick?: string | null
          upc_codes?: string | null
          updated_at?: string
          updated_by?: string | null
          website_link?: string | null
        }
        Update: {
          ba_depth?: string | null
          ba_diameter?: string | null
          ba_length?: string | null
          ba_width?: string | null
          base_diameter?: string | null
          base_length?: string | null
          base_opening?: string | null
          base_width?: string | null
          btu?: number | null
          burner_diameter?: string | null
          burner_length?: string | null
          burner_shape?: string | null
          certifications?:
            | Database["public"]["Enums"]["certification_type"][]
            | null
          compatible_bullet_burner?: string | null
          compatible_canvas_cover?: string | null
          compatible_glass_wind_guard?: string | null
          created_at?: string
          created_by?: string | null
          dealer_price?: number | null
          description?: string | null
          distributor_price?: number | null
          enabled?: boolean | null
          encoded_upc_codes?: string | null
          fire_glass?: string | null
          gpm?: string | null
          group_price?: number | null
          id?: number
          internet_price?: number | null
          landscape_price?: number | null
          map_price?: number | null
          master_distributor_price?: number | null
          meta?: Json | null
          msrp_price?: number | null
          name?: string | null
          parent_id?: number
          product_diameter?: string | null
          product_height?: string | null
          product_length?: string | null
          product_meta?: Json | null
          product_serial_base?: string | null
          product_width?: string | null
          scupper_inlet_opening?: string | null
          scupper_width?: string | null
          short_description?: string | null
          sku?: string
          soil_usage?: string | null
          toe_kick?: string | null
          upc_codes?: string | null
          updated_at?: string
          updated_by?: string | null
          website_link?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "variation_parent_id_fkey"
            columns: ["parent_id"]
            referencedRelation: "product"
            referencedColumns: ["id"]
          },
        ]
      }
      variation_configuration: {
        Row: {
          attribute_id: number | null
          value_id: number
          variation_id: number
        }
        Insert: {
          attribute_id?: number | null
          value_id: number
          variation_id: number
        }
        Update: {
          attribute_id?: number | null
          value_id?: number
          variation_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "public_variation_configuration_attribute_id_fkey"
            columns: ["attribute_id"]
            referencedRelation: "attributes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "variation_configuration_value_id_fkey"
            columns: ["value_id"]
            referencedRelation: "attribute_value"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "variation_configuration_variation_id_fkey"
            columns: ["variation_id"]
            referencedRelation: "variation"
            referencedColumns: ["id"]
          },
        ]
      }
      variation_documents: {
        Row: {
          document_id: number
          variation_id: number
        }
        Insert: {
          document_id: number
          variation_id: number
        }
        Update: {
          document_id?: number
          variation_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "variation_documents_document_id_fkey"
            columns: ["document_id"]
            referencedRelation: "documents"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "variation_documents_variation_id_fkey"
            columns: ["variation_id"]
            referencedRelation: "variation"
            referencedColumns: ["id"]
          },
        ]
      }
      variation_image: {
        Row: {
          display_order: number
          image_id: number
          is_primary: boolean | null
          variation_id: number
        }
        Insert: {
          display_order?: number
          image_id: number
          is_primary?: boolean | null
          variation_id: number
        }
        Update: {
          display_order?: number
          image_id?: number
          is_primary?: boolean | null
          variation_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "variation_image_image_id_fkey"
            columns: ["image_id"]
            referencedRelation: "image"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "variation_image_variation_id_fkey"
            columns: ["variation_id"]
            referencedRelation: "variation"
            referencedColumns: ["id"]
          },
        ]
      }
      variation_specification_sheet: {
        Row: {
          specification_sheet_id: number
          variation_id: number
        }
        Insert: {
          specification_sheet_id: number
          variation_id: number
        }
        Update: {
          specification_sheet_id?: number
          variation_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "variation_specification_sheet_specification_sheet_id_fkey"
            columns: ["specification_sheet_id"]
            referencedRelation: "specification_sheet"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "variation_specification_sheet_variation_id_fkey"
            columns: ["variation_id"]
            referencedRelation: "variation"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      check_user_role: {
        Args: {
          user_id: string
          role: Database["public"]["Enums"]["user_role"]
        }
        Returns: boolean
      }
      filter_all_products: {
        Args: {
          sort_term: string
          sort_order: string
          from_limit: number
          to_limit: number
          value_id: number[]
          attribute_id: number[]
        }
        Returns: {
          id: number
          name: string
          sku: string
          enabled: boolean
          product_type: Database["public"]["Enums"]["product_type"]
          parent_id: string
          image_url: string
          count: number
        }[]
      }
      filter_all_products_or_variations:
        | {
            Args: {
              sort_term: string
              sort_order: string
              from_limit: number
              to_limit: number
              value_id: number[]
            }
            Returns: {
              id: number
              name: string
              sku: string
              enabled: boolean
              product_type: Database["public"]["Enums"]["product_type"]
              parent_id: number
              image_url: string
              count: number
            }[]
          }
        | {
            Args: {
              sort_term: string
              sort_order: string
              from_limit: number
              to_limit: number
              value_id: number[]
              attribute_id: number[]
            }
            Returns: {
              id: number
              name: string
              sku: string
              enabled: boolean
              product_type: Database["public"]["Enums"]["product_type"]
              parent_id: number
              image_url: string
              count: number
            }[]
          }
      filter_all_variations:
        | {
            Args: {
              sort_term: string
              sort_order: string
              from_limit: number
              to_limit: number
              value_id: number[]
              attribute_id: number[]
            }
            Returns: {
              id: number
              name: string
              sku: string
              enabled: boolean
              product_type: string
              parent_id: number
              image_url: string
              count: number
            }[]
          }
        | {
            Args: {
              sort_term: string
              sort_order: string
              from_limit: number
              to_limit: number
              value_id: number[]
              attribute_id: number[]
              parentid: number
            }
            Returns: {
              id: number
              name: string
              sku: string
              enabled: boolean
              product_type: string
              parent_id: number
              image_url: string
              count: number
            }[]
          }
      get_category_tree: {
        Args: Record<PropertyKey, never>
        Returns: Json[]
      }
      get_category_tree_search: {
        Args: {
          search_term: string
          sort_term: string
          sort_order: string
          from_limit: number
          to_limit: number
        }
        Returns: {
          category_id: number
          category_name: string
          category_slug: string
          parent_category_id: number
          child_categories: Json
          total_count: number
        }[]
      }
      get_category_tree_search_test: {
        Args: Record<PropertyKey, never>
        Returns: Json
      }
      get_nested_categories: {
        Args: Record<PropertyKey, never>
        Returns: Json
      }
      gtrgm_compress: {
        Args: {
          "": unknown
        }
        Returns: unknown
      }
      gtrgm_decompress: {
        Args: {
          "": unknown
        }
        Returns: unknown
      }
      gtrgm_in: {
        Args: {
          "": unknown
        }
        Returns: unknown
      }
      gtrgm_options: {
        Args: {
          "": unknown
        }
        Returns: undefined
      }
      gtrgm_out: {
        Args: {
          "": unknown
        }
        Returns: unknown
      }
      json_tree: {
        Args: Record<PropertyKey, never>
        Returns: Json
      }
      search_attributes: {
        Args: {
          search_term: string
          sort_term: string
          sort_order: string
          from_limit: number
          to_limit: number
        }
        Returns: {
          id: number
          name: string
          slug: string
          count: number
        }[]
      }
      search_categories: {
        Args: {
          search_term: string
          sort_term: string
          sort_order: string
          from_limit: number
          to_limit: number
        }
        Returns: {
          id: number
          name: string
          slug: string
          parent_id: number
          count: number
        }[]
      }
      search_collections: {
        Args: {
          search_term: string
          sort_term: string
          sort_order: string
          from_limit: number
          to_limit: number
        }
        Returns: {
          id: number
          name: string
          slug: string
          count: number
        }[]
      }
      search_colors: {
        Args: {
          search_term: string
          sort_term: string
          sort_order: string
          from_limit: number
          to_limit: number
        }
        Returns: Json[]
      }
      search_gas_types: {
        Args: {
          search_term: string
          sort_term: string
          sort_order: string
          from_limit: number
          to_limit: number
        }
        Returns: {
          id: number
          name: string
          slug: string
          count: number
        }[]
      }
      search_ignition_types: {
        Args: {
          search_term: string
          sort_term: string
          sort_order: string
          from_limit: number
          to_limit: number
        }
        Returns: {
          id: number
          name: string
          slug: string
          count: number
        }[]
      }
      search_materials: {
        Args: {
          search_term: string
          sort_term: string
          sort_order: string
          from_limit: number
          to_limit: number
        }
        Returns: {
          id: number
          name: string
          slug: string
          image_url: string
          count: number
        }[]
      }
      search_parent_products: {
        Args: {
          search_term: string
          sort_term: string
          sort_order: string
          from_limit: number
          to_limit: number
        }
        Returns: {
          id: number
          name: string
          sku: string
          product_type: Database["public"]["Enums"]["product_type"]
          enabled: boolean
          published: boolean
          collection: string
          category: string
          material: string
          count: number
        }[]
      }
      search_products: {
        Args: {
          search_term: string
          sort_term: string
          sort_order: string
          from_limit: number
          to_limit: number
        }
        Returns: {
          id: number
          name: string
          sku: string
          enabled: boolean
          product_type: Database["public"]["Enums"]["product_type"]
          parent_id: string
          image_url: string
          count: number
        }[]
      }
      search_products_or_variations: {
        Args: {
          search_term: string
          sort_term: string
          sort_order: string
          from_limit: number
          to_limit: number
        }
        Returns: {
          id: number
          name: string
          sku: string
          enabled: boolean
          product_type: Database["public"]["Enums"]["product_type"]
          parent_id: number
          image_url: string
          count: number
        }[]
      }
      search_shapes: {
        Args: {
          search_term: string
          sort_term: string
          sort_order: string
          from_limit: number
          to_limit: number
        }
        Returns: {
          id: number
          name: string
          slug: string
          count: number
        }[]
      }
      search_users: {
        Args: {
          search_term: string
          sort_term: string
          sort_order: string
          from_limit: number
          to_limit: number
        }
        Returns: {
          id: string
          first_name: string
          email: string
          last_name: string
          role: Database["public"]["Enums"]["user_role"]
          company: string
          count: number
        }[]
      }
      search_variations:
        | {
            Args: {
              search_term: string
              sort_term: string
              sort_order: string
              from_limit: number
              to_limit: number
            }
            Returns: {
              id: number
              name: string
              sku: string
              enabled: boolean
              product_type: string
              parent_id: number
              image_url: string
              count: number
            }[]
          }
        | {
            Args: {
              search_term: string
              sort_term: string
              sort_order: string
              from_limit: number
              to_limit: number
              parentid: number
            }
            Returns: {
              id: number
              name: string
              sku: string
              enabled: boolean
              product_type: string
              parent_id: number
              image_url: string
              count: number
            }[]
          }
      set_limit: {
        Args: {
          "": number
        }
        Returns: number
      }
      show_limit: {
        Args: Record<PropertyKey, never>
        Returns: number
      }
      show_trgm: {
        Args: {
          "": string
        }
        Returns: unknown
      }
      slugify: {
        Args: {
          value: string
        }
        Returns: string
      }
      unaccent: {
        Args: {
          "": string
        }
        Returns: string
      }
      unaccent_init: {
        Args: {
          "": unknown
        }
        Returns: unknown
      }
    }
    Enums: {
      certification_type: "CSA" | "LC" | "UL"
      product_type: "VARIABLE" | "SIMPLE"
      relation_type: "PARENT" | "CHILD" | "PARENT_GROUP"
      user_role:
        | "USER"
        | "GUEST"
        | "DEALER"
        | "DISTRIBUTOR"
        | "MANAGER"
        | "ADMIN"
        | "MASTER_DISTRIBUTOR"
        | "GROUP"
        | "LANDSCAPE"
        | "INTERNET"
        | "ECOMMERCE"
        | "SALES"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  storage: {
    Tables: {
      buckets: {
        Row: {
          allowed_mime_types: string[] | null
          avif_autodetection: boolean | null
          created_at: string | null
          file_size_limit: number | null
          id: string
          name: string
          owner: string | null
          owner_id: string | null
          public: boolean | null
          updated_at: string | null
        }
        Insert: {
          allowed_mime_types?: string[] | null
          avif_autodetection?: boolean | null
          created_at?: string | null
          file_size_limit?: number | null
          id: string
          name: string
          owner?: string | null
          owner_id?: string | null
          public?: boolean | null
          updated_at?: string | null
        }
        Update: {
          allowed_mime_types?: string[] | null
          avif_autodetection?: boolean | null
          created_at?: string | null
          file_size_limit?: number | null
          id?: string
          name?: string
          owner?: string | null
          owner_id?: string | null
          public?: boolean | null
          updated_at?: string | null
        }
        Relationships: []
      }
      migrations: {
        Row: {
          executed_at: string | null
          hash: string
          id: number
          name: string
        }
        Insert: {
          executed_at?: string | null
          hash: string
          id: number
          name: string
        }
        Update: {
          executed_at?: string | null
          hash?: string
          id?: number
          name?: string
        }
        Relationships: []
      }
      objects: {
        Row: {
          bucket_id: string | null
          created_at: string | null
          id: string
          last_accessed_at: string | null
          metadata: Json | null
          name: string | null
          owner: string | null
          owner_id: string | null
          path_tokens: string[] | null
          updated_at: string | null
          version: string | null
        }
        Insert: {
          bucket_id?: string | null
          created_at?: string | null
          id?: string
          last_accessed_at?: string | null
          metadata?: Json | null
          name?: string | null
          owner?: string | null
          owner_id?: string | null
          path_tokens?: string[] | null
          updated_at?: string | null
          version?: string | null
        }
        Update: {
          bucket_id?: string | null
          created_at?: string | null
          id?: string
          last_accessed_at?: string | null
          metadata?: Json | null
          name?: string | null
          owner?: string | null
          owner_id?: string | null
          path_tokens?: string[] | null
          updated_at?: string | null
          version?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "objects_bucketId_fkey"
            columns: ["bucket_id"]
            referencedRelation: "buckets"
            referencedColumns: ["id"]
          },
        ]
      }
      s3_multipart_uploads: {
        Row: {
          bucket_id: string
          created_at: string
          id: string
          in_progress_size: number
          key: string
          owner_id: string | null
          upload_signature: string
          version: string
        }
        Insert: {
          bucket_id: string
          created_at?: string
          id: string
          in_progress_size?: number
          key: string
          owner_id?: string | null
          upload_signature: string
          version: string
        }
        Update: {
          bucket_id?: string
          created_at?: string
          id?: string
          in_progress_size?: number
          key?: string
          owner_id?: string | null
          upload_signature?: string
          version?: string
        }
        Relationships: [
          {
            foreignKeyName: "s3_multipart_uploads_bucket_id_fkey"
            columns: ["bucket_id"]
            referencedRelation: "buckets"
            referencedColumns: ["id"]
          },
        ]
      }
      s3_multipart_uploads_parts: {
        Row: {
          bucket_id: string
          created_at: string
          etag: string
          id: string
          key: string
          owner_id: string | null
          part_number: number
          size: number
          upload_id: string
          version: string
        }
        Insert: {
          bucket_id: string
          created_at?: string
          etag: string
          id?: string
          key: string
          owner_id?: string | null
          part_number: number
          size?: number
          upload_id: string
          version: string
        }
        Update: {
          bucket_id?: string
          created_at?: string
          etag?: string
          id?: string
          key?: string
          owner_id?: string | null
          part_number?: number
          size?: number
          upload_id?: string
          version?: string
        }
        Relationships: [
          {
            foreignKeyName: "s3_multipart_uploads_parts_bucket_id_fkey"
            columns: ["bucket_id"]
            referencedRelation: "buckets"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "s3_multipart_uploads_parts_upload_id_fkey"
            columns: ["upload_id"]
            referencedRelation: "s3_multipart_uploads"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      can_insert_object: {
        Args: {
          bucketid: string
          name: string
          owner: string
          metadata: Json
        }
        Returns: undefined
      }
      extension: {
        Args: {
          name: string
        }
        Returns: string
      }
      filename: {
        Args: {
          name: string
        }
        Returns: string
      }
      foldername: {
        Args: {
          name: string
        }
        Returns: unknown
      }
      get_size_by_bucket: {
        Args: Record<PropertyKey, never>
        Returns: {
          size: number
          bucket_id: string
        }[]
      }
      list_multipart_uploads_with_delimiter: {
        Args: {
          bucket_id: string
          prefix_param: string
          delimiter_param: string
          max_keys?: number
          next_key_token?: string
          next_upload_token?: string
        }
        Returns: {
          key: string
          id: string
          created_at: string
        }[]
      }
      list_objects_with_delimiter: {
        Args: {
          bucket_id: string
          prefix_param: string
          delimiter_param: string
          max_keys?: number
          start_after?: string
          next_token?: string
        }
        Returns: {
          name: string
          id: string
          metadata: Json
          updated_at: string
        }[]
      }
      operation: {
        Args: Record<PropertyKey, never>
        Returns: string
      }
      search: {
        Args: {
          prefix: string
          bucketname: string
          limits?: number
          levels?: number
          offsets?: number
          search?: string
          sortcolumn?: string
          sortorder?: string
        }
        Returns: {
          name: string
          id: string
          updated_at: string
          created_at: string
          last_accessed_at: string
          metadata: Json
        }[]
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type PublicSchema = Database[Extract<keyof Database, "public">]

export type Tables<
  PublicTableNameOrOptions extends
    | keyof (PublicSchema["Tables"] & PublicSchema["Views"])
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
        Database[PublicTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
      Database[PublicTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : PublicTableNameOrOptions extends keyof (PublicSchema["Tables"] &
        PublicSchema["Views"])
    ? (PublicSchema["Tables"] &
        PublicSchema["Views"])[PublicTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  PublicTableNameOrOptions extends
    | keyof PublicSchema["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : PublicTableNameOrOptions extends keyof PublicSchema["Tables"]
    ? PublicSchema["Tables"][PublicTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  PublicTableNameOrOptions extends
    | keyof PublicSchema["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : PublicTableNameOrOptions extends keyof PublicSchema["Tables"]
    ? PublicSchema["Tables"][PublicTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  PublicEnumNameOrOptions extends
    | keyof PublicSchema["Enums"]
    | { schema: keyof Database },
  EnumName extends PublicEnumNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = PublicEnumNameOrOptions extends { schema: keyof Database }
  ? Database[PublicEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : PublicEnumNameOrOptions extends keyof PublicSchema["Enums"]
    ? PublicSchema["Enums"][PublicEnumNameOrOptions]
    : never
