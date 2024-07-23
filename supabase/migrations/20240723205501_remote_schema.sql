
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";

CREATE SCHEMA IF NOT EXISTS "public";

ALTER SCHEMA "public" OWNER TO "pg_database_owner";

CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";

CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pg_trgm" WITH SCHEMA "public";

CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";

CREATE EXTENSION IF NOT EXISTS "unaccent" WITH SCHEMA "public";

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";

CREATE TYPE "public"."certification_type" AS ENUM (
    'CSA',
    'LC',
    'UL'
);

ALTER TYPE "public"."certification_type" OWNER TO "postgres";

CREATE TYPE "public"."product_type" AS ENUM (
    'VARIABLE',
    'SIMPLE'
);

ALTER TYPE "public"."product_type" OWNER TO "postgres";

CREATE TYPE "public"."relation_type" AS ENUM (
    'PARENT',
    'CHILD',
    'PARENT_GROUP'
);

ALTER TYPE "public"."relation_type" OWNER TO "postgres";

CREATE TYPE "public"."user_role" AS ENUM (
    'USER',
    'GUEST',
    'DEALER',
    'DISTRIBUTOR',
    'MANAGER',
    'ADMIN',
    'MASTER_DISTRIBUTOR',
    'GROUP',
    'LANDSCAPE',
    'INTERNET',
    'ECOMMERCE',
    'SALES'
);

ALTER TYPE "public"."user_role" OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."auto_confirm_account"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  NEW.email_confirmed_at = NOW();
  New.confirmed_at = NOW();
  RETURN NEW;
END $$;

ALTER FUNCTION "public"."auto_confirm_account"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."check_user_role"("user_id" "uuid", "role" "public"."user_role") RETURNS boolean
    LANGUAGE "sql" SECURITY DEFINER
    AS $_$
  SELECT EXISTS (SELECT users.id
  FROM users
  WHERE ((users.id = $1) AND ($2 = users.role)))
$_$;

ALTER FUNCTION "public"."check_user_role"("user_id" "uuid", "role" "public"."user_role") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."create_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  role_name public.user_role;
  company_id int;
BEGIN
  IF NEW.raw_user_meta_data->>'role' = 'role' OR NEW.raw_user_meta_data->>'role' IS NULL THEN
    -- NEW.raw_user_meta_data = jsonb_set(NEW.raw_user_meta_data, '{role}', 'USER'::jsonb);
    role_name := 'USER'::text::public.user_role;
  ELSE
    role_name := NEW.raw_user_meta_data->>'role';
  END IF;

  IF NEW.raw_user_meta_data->>'company' IS NULL THEN
    company_id := NULL;
  ELSE
    company_id := NEW.raw_user_meta_data->>'company';
  END IF;

  INSERT INTO public.users (id, first_name, email, last_name, role, company)
  VALUES (NEW.id, NEW.raw_user_meta_data->>'first_name', NEW.email, NEW.raw_user_meta_data->>'last_name', role_name,  company_id);

  RETURN NEW;
END $$;

ALTER FUNCTION "public"."create_user"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."delete_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  DELETE FROM auth.users WHERE auth.users.id = OLD.id;
  RETURN OLD;
END $$;

ALTER FUNCTION "public"."delete_user"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."filter_all_products"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[]) RETURNS TABLE("id" integer, "name" character varying, "sku" character varying, "enabled" boolean, "product_type" "public"."product_type", "parent_id" "text", "image_url" character varying, "count" bigint)
    LANGUAGE "plpgsql"
    AS $_$
  begin
    return query execute
    '
      SELECT p.id, p.name, p.sku, p.enabled, p.product_type, NULL as parent_id, img.url as image_url, count(*) OVER () AS count
      FROM product p
      LEFT JOIN LATERAL (
        SELECT pi.image_id, image.url
        FROM product_image pi
        JOIN image ON pi.image_id = image.id
        WHERE
          pi.product_id = p.id AND
          pi.is_primary = TRUE
        LIMIT 1
      ) img ON TRUE
      LEFT JOIN product_attribute pa ON p.id = pa.product_id AND pa.attribute_id = ANY($4)
      LEFT JOIN product_configuration pc ON p.id = pc.product_id AND pc.value_id = ANY($3) 
      GROUP BY
        p.id, p.name, p.sku, p.enabled, p.product_type, img.url
      HAVING
        (
          array_length($4, 1) IS NULL OR 
          array_length(ARRAY_REMOVE($4, NULL), 1) = COUNT(pa.product_id) AND
          (COUNT(pa.product_id) > 0 AND bool_or(pa.fill_values) OR COUNT(pa.product_id) = 0)
        )
        OR
        -- New condition for fill_values = FALSE
        (
            COUNT(pa.product_id) > 0 AND NOT bool_or(pa.fill_values)
            AND
            (
                array_length($3, 1) IS NULL OR 
                array_length(ARRAY_REMOVE($3, NULL), 1) = COUNT(pc.product_id)
            )
        )
      ORDER BY ' || sort_term || ' ' || sort_order || '
      LIMIT $1 OFFSET $2;'
    USING (to_limit - from_limit + 1), from_limit, value_id, attribute_id;
  end;
$_$;

ALTER FUNCTION "public"."filter_all_products"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[]) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."filter_all_products_or_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[]) RETURNS TABLE("id" integer, "name" character varying, "sku" character varying, "enabled" boolean, "product_type" "public"."product_type", "parent_id" integer, "image_url" character varying, "count" bigint)
    LANGUAGE "plpgsql"
    AS $_$
  begin
    return query execute
    '
      SELECT id, name, sku, enabled, product_type, parent_id, image_url, count(*) OVER () AS count
      FROM (
        SELECT p.id, p.name, p.sku, p.enabled, p.product_type, NULL as parent_id, img.url as image_url
        FROM product p
        LEFT JOIN LATERAL (
          SELECT pi.image_id, image.url
          FROM product_image pi
          JOIN image ON pi.image_id = image.id
          WHERE
            pi.product_id = p.id AND
            pi.is_primary = TRUE
          LIMIT 1
        ) img ON TRUE

        UNION

        SELECT v.id, v.name, v.sku, v.enabled, NULL as product_type, v.parent_id AS parent_id, COALESCE(variation_img.url, parent_img.url) as image_url
        FROM variation v
        LEFT JOIN LATERAL (
          SELECT vi.image_id, image.url
          FROM variation_image vi
          JOIN image ON vi.image_id = image.id
          WHERE
            vi.variation_id = v.id AND
            vi.is_primary = TRUE
          LIMIT 1
        ) variation_img ON TRUE
        LEFT JOIN LATERAL (
          SELECT pi.image_id, image.url
          FROM product_image pi
          JOIN image ON pi.image_id = image.id
          WHERE
            pi.product_id = v.parent_id AND
            pi.is_primary = TRUE
          LIMIT 1
        ) parent_img ON TRUE
        LEFT JOIN variation_configuration vc ON v.id = vc.variation_id AND vc.value_id = ANY($3)
        GROUP BY
          v.id, v.name, v.sku, v.enabled, v.parent_id, variation_img.url, parent_img.url
        HAVING
          array_length($3, 1) IS NULL OR 
          array_length(ARRAY_REMOVE($3, NULL), 1) = COUNT(vc.variation_id)
      ) AS combined
      ORDER BY ' || sort_term || ' ' || sort_order || '
      LIMIT $1 OFFSET $2;'
    USING (to_limit - from_limit + 1), from_limit, value_id;
  end;
$_$;

ALTER FUNCTION "public"."filter_all_products_or_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[]) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."filter_all_products_or_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[]) RETURNS TABLE("id" integer, "name" character varying, "sku" character varying, "enabled" boolean, "product_type" "public"."product_type", "parent_id" integer, "image_url" character varying, "count" bigint)
    LANGUAGE "plpgsql"
    AS $_$
  begin
    return query execute
    '
      SELECT id, name, sku, enabled, product_type, parent_id, image_url, count(*) OVER () AS count
      FROM (
        SELECT p.id, p.name, p.sku, p.enabled, p.product_type, NULL as parent_id, img.url as image_url
        FROM product p
        LEFT JOIN LATERAL (
          SELECT pi.image_id, image.url
          FROM product_image pi
          JOIN image ON pi.image_id = image.id
          WHERE
            pi.product_id = p.id AND
            pi.is_primary = TRUE
          LIMIT 1
        ) img ON TRUE
        LEFT JOIN product_attribute pa ON p.id = pa.product_id AND pa.attribute_id = ANY($4)
        LEFT JOIN product_configuration pc ON p.id = pc.product_id AND pc.value_id = ANY($3) 
        GROUP BY
          p.id, p.name, p.sku, p.enabled, p.product_type, img.url
        HAVING
          (
            array_length($4, 1) IS NULL OR 
            array_length(ARRAY_REMOVE($4, NULL), 1) = COUNT(pa.product_id) AND
            (COUNT(pa.product_id) > 0 AND bool_or(pa.fill_values) OR COUNT(pa.product_id) = 0)
          )
          OR
          -- New condition for fill_values = FALSE
          (
              COUNT(pa.product_id) > 0 AND NOT bool_or(pa.fill_values)
              AND
              (
                  array_length($3, 1) IS NULL OR 
                  array_length(ARRAY_REMOVE($3, NULL), 1) = COUNT(pc.product_id)
              )
          )

        UNION

        SELECT v.id, v.name, v.sku, v.enabled, NULL as product_type, v.parent_id AS parent_id, COALESCE(variation_img.url, parent_img.url) as image_url
        FROM variation v
        LEFT JOIN LATERAL (
          SELECT vi.image_id, image.url
          FROM variation_image vi
          JOIN image ON vi.image_id = image.id
          WHERE
            vi.variation_id = v.id AND
            vi.is_primary = TRUE
          LIMIT 1
        ) variation_img ON TRUE
        LEFT JOIN LATERAL (
          SELECT pi.image_id, image.url
          FROM product_image pi
          JOIN image ON pi.image_id = image.id
          WHERE
            pi.product_id = v.parent_id AND
            pi.is_primary = TRUE
          LIMIT 1
        ) parent_img ON TRUE
        LEFT JOIN variation_configuration vc ON v.id = vc.variation_id AND vc.value_id = ANY($3)
        GROUP BY
          v.id, v.name, v.sku, v.enabled, v.parent_id, variation_img.url, parent_img.url
        HAVING
          array_length($3, 1) IS NULL OR 
          array_length(ARRAY_REMOVE($3, NULL), 1) = COUNT(vc.variation_id)
      ) AS combined
      ORDER BY ' || sort_term || ' ' || sort_order || '
      LIMIT $1 OFFSET $2;'
    USING (to_limit - from_limit + 1), from_limit, value_id, attribute_id;
  end;
$_$;

ALTER FUNCTION "public"."filter_all_products_or_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[]) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."filter_all_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[]) RETURNS TABLE("id" integer, "name" character varying, "sku" character varying, "enabled" boolean, "product_type" "text", "parent_id" integer, "image_url" character varying, "count" bigint)
    LANGUAGE "plpgsql"
    AS $_$
  begin
    return query execute
    '
    SELECT v.id, v.name, v.sku, v.enabled, NULL as product_type, v.parent_id AS parent_id, COALESCE(variation_img.url, parent_img.url) as image_url, count(*) OVER () AS count
      FROM variation v
      LEFT JOIN LATERAL (
        SELECT vi.image_id, image.url
        FROM variation_image vi
        JOIN image ON vi.image_id = image.id
        WHERE
          vi.variation_id = v.id AND
          vi.is_primary = TRUE
        LIMIT 1
      ) variation_img ON TRUE
      LEFT JOIN LATERAL (
        SELECT pi.image_id, image.url
        FROM product_image pi
        JOIN image ON pi.image_id = image.id
        WHERE
          pi.product_id = v.parent_id AND
          pi.is_primary = TRUE
        LIMIT 1
      ) parent_img ON TRUE
      LEFT JOIN variation_configuration vc ON v.id = vc.variation_id AND vc.value_id = ANY($3)
      GROUP BY
        v.id, v.name, v.sku, v.enabled, v.parent_id, variation_img.url, parent_img.url
      HAVING
        array_length($3, 1) IS NULL OR 
        array_length(ARRAY_REMOVE($3, NULL), 1) = COUNT(vc.variation_id)
    ORDER BY ' || sort_term || ' ' || sort_order || '
    LIMIT $1 OFFSET $2;'
    USING (to_limit - from_limit + 1), from_limit, value_id, attribute_id;
  end;
$_$;

ALTER FUNCTION "public"."filter_all_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[]) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."filter_all_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[], "parentid" integer) RETURNS TABLE("id" integer, "name" character varying, "sku" character varying, "enabled" boolean, "product_type" "text", "parent_id" integer, "image_url" character varying, "count" bigint)
    LANGUAGE "plpgsql"
    AS $_$
  begin
    return query execute
    '
    SELECT v.id, v.name, v.sku, v.enabled, NULL as product_type, v.parent_id AS parent_id, COALESCE(variation_img.url, parent_img.url) as image_url, count(*) OVER () AS count
      FROM variation v
      LEFT JOIN LATERAL (
        SELECT vi.image_id, image.url
        FROM variation_image vi
        JOIN image ON vi.image_id = image.id
        WHERE
          vi.variation_id = v.id AND
          vi.is_primary = TRUE
        LIMIT 1
      ) variation_img ON TRUE
      LEFT JOIN LATERAL (
        SELECT pi.image_id, image.url
        FROM product_image pi
        JOIN image ON pi.image_id = image.id
        WHERE
          pi.product_id = v.parent_id AND
          pi.is_primary = TRUE
        LIMIT 1
      ) parent_img ON TRUE
      LEFT JOIN variation_configuration vc ON v.id = vc.variation_id AND vc.value_id = ANY($3)
      WHERE v.parent_id = $5
      GROUP BY
        v.id, v.name, v.sku, v.enabled, v.parent_id, variation_img.url, parent_img.url
      HAVING
        array_length($3, 1) IS NULL OR 
        array_length(ARRAY_REMOVE($3, NULL), 1) = COUNT(vc.variation_id)
    ORDER BY ' || sort_term || ' ' || sort_order || '
    LIMIT $1 OFFSET $2;'
    USING (to_limit - from_limit + 1), from_limit, value_id, attribute_id, parentid;
  end;
$_$;

ALTER FUNCTION "public"."filter_all_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[], "parentid" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."get_category_tree"() RETURNS SETOF "jsonb"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN QUERY
  WITH RECURSIVE category_tree AS (
    SELECT
      id,
      name,
      slug,
      parent_id,
      NULL::jsonb AS child_categories
    FROM
      category
    WHERE
      parent_id IS NULL

    UNION ALL

    SELECT
      c.id,
      c.name,
      c.slug,
      c.parent_id,
      jsonb_agg(
        jsonb_build_object(
          'name', cc.name,
          'id', cc.id,
          'slug', cc.slug,
          'child_categories', cc.child_categories
        )
      ) FILTER (WHERE cc.id IS NOT NULL) AS child_categories
    FROM
      category c
    LEFT JOIN LATERAL (
      SELECT DISTINCT
        id,
        name,
        slug,
        parent_id,
        NULL::jsonb AS child_categories
      FROM
        category
      WHERE
        parent_id = c.id

      UNION ALL

      SELECT
        c3.id,
        c3.name,
        c3.slug,
        c3.parent_id,
        jsonb_agg(
          jsonb_build_object(
            'name', cc3.name,
            'id', cc3.id,
            'slug', cc3.slug,
            'child_categories', cc3.child_categories
          )
        ) FILTER (WHERE cc3.id IS NOT NULL) AS child_categories
      FROM
        category c3
      LEFT JOIN LATERAL (
        SELECT DISTINCT
          id,
          name,
          slug,
          parent_id,
          NULL::jsonb AS child_categories
        FROM
          category
        WHERE
          parent_id = c3.id
      ) cc3 ON true
      WHERE
        c3.parent_id = c.id
      GROUP BY
        c3.id, c3.name, c3.slug, c3.parent_id
    ) cc ON true
    GROUP BY
      c.id, c.name, c.slug, c.parent_id
  )
  SELECT
    jsonb_build_object(
      'name', name,
      'id', id,
      'slug', slug,
      'child_categories', child_categories
    ) AS category_structure
  FROM
    category_tree
  WHERE
    parent_id IS NULL;
END;
$$;

ALTER FUNCTION "public"."get_category_tree"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."get_category_tree_search"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) RETURNS TABLE("category_id" integer, "category_name" character varying, "category_slug" "text", "parent_category_id" integer, "child_categories" "jsonb", "total_count" bigint)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN QUERY
  WITH RECURSIVE category_tree AS (
    SELECT
      c.id AS category_id,
      c.name AS category_name,
      c.slug AS category_slug,
      c.parent_id AS parent_category_id,  -- Specify the table alias for parent_category_id
      '[]'::jsonb AS child_categories,
      1 AS level
    FROM
      category c
    WHERE
      c.parent_id IS NULL
      AND (search_term IS NULL OR c.name ILIKE '%' || search_term || '%')

    UNION ALL

    SELECT
      c.id AS category_id,
      c.name AS category_name,
      c.slug AS category_slug,
      c.parent_id AS parent_category_id,  -- Specify the table alias for parent_category_id
      '[]'::jsonb AS child_categories,
      ct.level + 1 AS level
    FROM
      category c
    INNER JOIN category_tree ct ON c.parent_id = ct.category_id
    WHERE
      (search_term IS NULL OR c.name ILIKE '%' || search_term || '%')
  ),
  get_child_categories AS (
    SELECT
      parent_category_id,
      JSONB_AGG(
        JSONB_BUILD_OBJECT(
          'category_id', ct.category_id,
          'category_name', ct.category_name,
          'category_slug', ct.category_slug
        )
      ) AS child_categories
    FROM
      category_tree ct
    GROUP BY
      parent_category_id
  )
  SELECT
    ct.category_id,
    ct.category_name,
    ct.category_slug,
    ct.parent_category_id,  -- Specify the table alias for parent_category_id
    gc.child_categories,
    COUNT(*) OVER () AS total_count
  FROM
    category_tree ct
  LEFT JOIN
    get_child_categories gc ON ct.category_id = gc.parent_category_id
  ORDER BY
    CASE
      WHEN sort_term = 'category_name' THEN ct.category_name
      WHEN sort_term = 'category_id' THEN ct.category_id::varchar
      WHEN sort_term = 'category_slug' THEN ct.category_slug
    END
  FETCH FIRST (to_limit - from_limit + 1) ROWS ONLY
  OFFSET from_limit;
END;
$$;

ALTER FUNCTION "public"."get_category_tree_search"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."get_category_tree_search_test"() RETURNS "jsonb"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _json_output jsonb;
    _temprow record;
BEGIN
    SELECT 
        jsonb_build_object('id', id, 'name', name, 'slug', slug, 'child_categories', array_to_json(ARRAY[]::int[])) 
    INTO _json_output 
    FROM category 
    WHERE parent_id IS NULL;
    
    FOR _temprow IN
        WITH RECURSIVE tree(id, ancestor, child, path, json) AS  (
          SELECT 
              c1.id, 
              NULL::int, 
              c2.id,
              '{child_categories}'::text[] || (row_number() OVER (PARTITION BY c1.id ORDER BY c2.id) - 1)::text,
              jsonb_build_object('id', c2.id, 'name', c2.name, 'slug', c2.slug, 'child_categories', array_to_json(ARRAY[]::int[]))
          FROM category c1
          LEFT JOIN category c2 ON c1.id = c2.parent_id
          WHERE c1.parent_id IS NULL

          UNION

          SELECT
              c1.id, 
              c1.parent_id, 
              c2.id,
              tree.path || '{child_categories}' || (row_number() OVER (PARTITION BY c1.id ORDER BY c2.id) - 1)::text, 
              jsonb_build_object('id', c2.id, 'name', c2.name, 'slug', c2.slug, 'child_categories', array_to_json(ARRAY[]::int[]))
          FROM category c1
          LEFT JOIN category c2 ON c1.id = c2.parent_id
          INNER JOIN tree ON (c1.id = tree.child)
          WHERE c1.parent_id = tree.id
        )
        SELECT 
            child as id, path, json 
        FROM tree 
        WHERE child IS NOT NULL ORDER BY path
    LOOP
        SELECT jsonb_insert(_json_output, _temprow.path, _temprow.json) INTO _json_output;
    END LOOP;
    
    RETURN _json_output;
END;
$$;

ALTER FUNCTION "public"."get_category_tree_search_test"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."get_nested_categories"() RETURNS "json"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    result json;
BEGIN
    SELECT json_agg(parent_category)
    INTO result
    FROM (
        SELECT 
            jsonb_build_object(
                'category_id', parent.id,
                'category_name', parent.name,
                'category_slug', parent.slug,
                'parent_category_id', parent.parent_id,
                'child_categories', COALESCE(json_agg(child_category), '[]'::jsonb),
                'total_count', COALESCE(count(child_category.*), 0)
            ) AS parent_category
        FROM 
            public.category AS parent
            LEFT JOIN (
                SELECT 
                    id,
                    name,
                    slug,
                    parent_id
                FROM 
                    public.category
            ) AS child_category ON parent.id = child_category.parent_id
        WHERE 
            parent.parent_id IS NULL
        GROUP BY 
            parent.id, parent.name, parent.slug, parent.parent_id
    ) AS result_query;

    RETURN result;
END;
$$;

ALTER FUNCTION "public"."get_nested_categories"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."json_tree"() RETURNS "jsonb"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    _json_output jsonb;
    _temprow record;
BEGIN
    SELECT 
        jsonb_build_object('id', id, 'name', name, 'slug', slug, 'children', array_to_json(ARRAY[]::int[])) 
    INTO _json_output 
    FROM category 
    WHERE parent_id IS NULL;
    
    FOR _temprow IN
        WITH RECURSIVE tree(id, ancestor, child, path, json) AS  (
          SELECT 
              t1.id, 
              NULL::int, 
              t2.id,
              '{children}'::text[] || (row_number() OVER (PARTITION BY t1.id ORDER BY t2.id) - 1)::text,
              jsonb_build_object('id', t2.id, 'name', t2.name, 'slug', t2.slug, 'children', array_to_json(ARRAY[]::int[]))
          FROM category t1
          LEFT JOIN category t2 ON t1.id = t2.parent_id
          WHERE t1.parent_id IS NULL

          UNION

          SELECT
              t1.id, 
              t1.parent_id, 
              t2.id,
              tree.path || '{children}' || (row_number() OVER (PARTITION BY t1.id ORDER BY t2.id) - 1)::text, 
              jsonb_build_object('id', t2.id, 'name', t2.name, 'slug', t2.slug, 'children', array_to_json(ARRAY[]::int[]))
          FROM category t1
          LEFT JOIN category t2 ON t1.id = t2.parent_id
          INNER JOIN tree ON (t1.id = tree.child)
          WHERE t1.parent_id = tree.id
        )
        SELECT 
            child as id, path, json 
        FROM tree 
        WHERE child IS NOT NULL ORDER BY path
    LOOP
        SELECT jsonb_insert(_json_output, _temprow.path, _temprow.json) INTO _json_output;
    END LOOP;
    
    RETURN _json_output;
END;
$$;

ALTER FUNCTION "public"."json_tree"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."search_attributes"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) RETURNS TABLE("id" integer, "name" "text", "slug" "text", "count" bigint)
    LANGUAGE "plpgsql"
    AS $_$
	begin
		return query execute
		'
			SELECT a.id, a.name, a.slug, count(*) OVER () AS count 
			FROM attributes a
			WHERE 
				$3 % ANY(STRING_TO_ARRAY(a.name, '' ''))
				OR
				$3 % ANY(STRING_TO_ARRAY(a.slug, '' ''))
			ORDER BY ' || sort_term || ' ' || sort_order || '
			LIMIT $1 OFFSET $2;'
			USING (to_limit - from_limit + 1), from_limit, search_term;
	end;
$_$;

ALTER FUNCTION "public"."search_attributes"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."search_categories"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) RETURNS TABLE("id" integer, "name" character varying, "slug" "text", "parent_id" integer, "count" bigint)
    LANGUAGE "plpgsql"
    AS $_$
	begin
		return query execute
		'
			SELECT *, count(*) OVER () AS count 
			FROM category c
			WHERE 
				c.parent_id is NULL AND
				($3 % ANY(STRING_TO_ARRAY(c.name, '' ''))
				OR
				$3 % ANY(STRING_TO_ARRAY(c.slug, '' '')))				
			ORDER BY ' || sort_term || ' ' || sort_order || '
			LIMIT $1 OFFSET $2;'
			USING (to_limit - from_limit + 1), from_limit, search_term;
	end;
$_$;

ALTER FUNCTION "public"."search_categories"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."search_collections"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) RETURNS TABLE("id" integer, "name" character varying, "slug" "text", "count" bigint)
    LANGUAGE "plpgsql"
    AS $_$
	begin
		return query execute
		'
			SELECT *, count(*) OVER () AS count 
			FROM collection c
			WHERE 
				$3 % ANY(STRING_TO_ARRAY(c.name, '' ''))
				OR
				$3 % ANY(STRING_TO_ARRAY(c.slug, '' ''))
			ORDER BY ' || sort_term || ' ' || sort_order || '
			LIMIT $1 OFFSET $2;'
			USING (to_limit - from_limit + 1), from_limit, search_term;
	end;
$_$;

ALTER FUNCTION "public"."search_collections"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."search_colors"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) RETURNS SETOF "json"
    LANGUAGE "plpgsql"
    AS $_$
	begin
		return query execute
		'
			SELECT JSON_BUILD_OBJECT(
				''id'', c.id,
				''name'', c.name,
				''slug'', c.slug,
				''material'', (
					SELECT JSON_BUILD_OBJECT(
						''name'', m.name
					) FROM material m WHERE m.id = c.material_id
				),
				''count'', count(*) OVER ()
			) 
			FROM color c
			WHERE 
				$3 % ANY(STRING_TO_ARRAY(c.name, '' ''))
				OR
				$3 % ANY(STRING_TO_ARRAY(c.slug, '' ''))
			ORDER BY ' || sort_term || ' ' || sort_order || '
			LIMIT $1 OFFSET $2;'
			USING (to_limit - from_limit + 1), from_limit, search_term;
	end;
$_$;

ALTER FUNCTION "public"."search_colors"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."search_gas_types"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) RETURNS TABLE("id" integer, "name" character varying, "slug" "text", "count" bigint)
    LANGUAGE "plpgsql"
    AS $_$
	begin
		return query execute
		'
			SELECT *, count(*) OVER () AS count 
			FROM gas g
			WHERE 
				$3 % ANY(STRING_TO_ARRAY(g.name, '' ''))
				OR
				$3 % ANY(STRING_TO_ARRAY(g.slug, '' ''))
			ORDER BY ' || sort_term || ' ' || sort_order || '
			LIMIT $1 OFFSET $2;'
			USING (to_limit - from_limit + 1), from_limit, search_term;
	end;
$_$;

ALTER FUNCTION "public"."search_gas_types"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."search_ignition_types"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) RETURNS TABLE("id" integer, "name" character varying, "slug" "text", "count" bigint)
    LANGUAGE "plpgsql"
    AS $_$
	begin
		return query execute
		'
			SELECT *, count(*) OVER () AS count 
			FROM ignition i
			WHERE 
				$3 % ANY(STRING_TO_ARRAY(i.name, '' ''))
				OR
				$3 % ANY(STRING_TO_ARRAY(i.slug, '' ''))
			ORDER BY ' || sort_term || ' ' || sort_order || '
			LIMIT $1 OFFSET $2;'
			USING (to_limit - from_limit + 1), from_limit, search_term;
	end;
$_$;

ALTER FUNCTION "public"."search_ignition_types"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."search_materials"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) RETURNS TABLE("id" integer, "name" character varying, "slug" "text", "image_url" "text", "count" bigint)
    LANGUAGE "plpgsql"
    AS $_$
	begin
		return query execute
		'
			SELECT *, count(*) OVER () AS count 
			FROM material m
			WHERE 
				$3 % ANY(STRING_TO_ARRAY(m.name, '' ''))
				OR
				$3 % ANY(STRING_TO_ARRAY(m.slug, '' ''))
			ORDER BY ' || sort_term || ' ' || sort_order || '
			LIMIT $1 OFFSET $2;'
			USING (to_limit - from_limit + 1), from_limit, search_term;
	end;
$_$;

ALTER FUNCTION "public"."search_materials"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."search_parent_products"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) RETURNS TABLE("id" integer, "name" character varying, "sku" character varying, "product_type" "public"."product_type", "enabled" boolean, "published" boolean, "collection" character varying, "category" character varying, "material" character varying, "count" bigint)
    LANGUAGE "plpgsql"
    AS $_$
	begin
		return query execute
		'
			SELECT p.id, p.name, p.sku, p.product_type, p.enabled, p.published, collection.name AS collection, category.name AS category, material.name AS material, count(*) OVER () AS count 
			FROM product p
			LEFT JOIN collection ON p.collection_id = collection.id
			LEFT JOIN category ON p.category_id = category.id
      LEFT JOIN product_material ON p.id = product_material.product_id
      LEFT JOIN material ON product_material.material_id = material.id
			WHERE 
				($3 % ANY(STRING_TO_ARRAY(p.name, '' ''))
				OR
				$3 % ANY(STRING_TO_ARRAY(p.sku, '' '')))				
			ORDER BY ' || sort_term || ' ' || sort_order || '
			LIMIT $1 OFFSET $2;'
			USING (to_limit - from_limit + 1), from_limit, search_term;
	end;
$_$;

ALTER FUNCTION "public"."search_parent_products"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."search_products"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, VARIADIC "value_id" integer[]) RETURNS TABLE("id" integer, "name" character varying, "sku" character varying, "enabled" boolean, "product_type" "public"."product_type", "parent_id" "text", "image_url" character varying, "count" bigint)
    LANGUAGE "plpgsql"
    AS $_$
  begin
    return query execute
    '
      SELECT id, name, sku, enabled, product_type, NULL as parent_id, image_url, count(*) OVER () AS count
      FROM (
        SELECT p.id, p.name, p.sku, p.enabled, p.product_type, img.url as image_url
        FROM product p
        LEFT JOIN LATERAL (
          SELECT pi.image_id, image.url
          FROM product_image pi
          JOIN image ON pi.image_id = image.id
          WHERE
            pi.product_id = p.id AND
            pi.is_primary = TRUE
          LIMIT 1
        ) img ON TRUE
        WHERE
          ($3 % ANY(STRING_TO_ARRAY(p.name, '' ''))
          OR
          $3 % ANY(STRING_TO_ARRAY(p.sku, '' '')))

        UNION

        SELECT p.id, p.name, p.sku, p.enabled, p.product_type, parent_img.url AS image_url
        FROM product p
        JOIN variation v ON p.id = v.parent_id
        LEFT JOIN LATERAL (
            SELECT pi.image_id, image.url
            FROM product_image pi
            JOIN image ON pi.image_id = image.id
            WHERE
                pi.product_id = p.id AND
                pi.is_primary = TRUE
            LIMIT 1
        ) parent_img ON TRUE
        WHERE
            ($3 % ANY(STRING_TO_ARRAY(v.name, '' ''))
            OR
            $3 % ANY(STRING_TO_ARRAY(v.sku, '' '')))
        GROUP BY
            p.id, p.name, p.sku, p.enabled, p.product_type, parent_img.url
      ) AS combined
      ORDER BY ' || sort_term || ' ' || sort_order || '
      LIMIT $1 OFFSET $2;'
    USING (to_limit - from_limit + 1), from_limit, search_term, value_id;
  end;
$_$;

ALTER FUNCTION "public"."search_products"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, VARIADIC "value_id" integer[]) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."search_products_or_variations"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, VARIADIC "value_id" integer[]) RETURNS TABLE("id" integer, "name" character varying, "sku" character varying, "enabled" boolean, "product_type" "public"."product_type", "parent_id" integer, "image_url" character varying, "count" bigint)
    LANGUAGE "plpgsql"
    AS $_$
  begin
    return query execute
    '
      SELECT id, name, sku, enabled, product_type, parent_id, image_url, count(*) OVER () AS count
      FROM (
        SELECT p.id, p.name, p.sku, p.enabled, p.product_type, NULL as parent_id, img.url as image_url
        FROM product p
        LEFT JOIN LATERAL (
          SELECT pi.image_id, image.url
          FROM product_image pi
          JOIN image ON pi.image_id = image.id
          WHERE
            pi.product_id = p.id AND
            pi.is_primary = TRUE
          LIMIT 1
        ) img ON TRUE
        WHERE
          ($3 % ANY(STRING_TO_ARRAY(p.name, '' ''))
          OR
          $3 % ANY(STRING_TO_ARRAY(p.sku, '' '')))
        UNION
        SELECT v.id, v.name, v.sku, v.enabled, NULL as product_type, v.parent_id AS parent_id, COALESCE(variation_img.url, parent_img.url) as image_url
        FROM variation v
        LEFT JOIN LATERAL (
          SELECT vi.image_id, image.url
          FROM variation_image vi
          JOIN image ON vi.image_id = image.id
          WHERE
            vi.variation_id = v.id AND
            vi.is_primary = TRUE
          LIMIT 1
        ) variation_img ON TRUE
        LEFT JOIN LATERAL (
          SELECT pi.image_id, image.url
          FROM product_image pi
          JOIN image ON pi.image_id = image.id
          WHERE
            pi.product_id = v.parent_id AND
            pi.is_primary = TRUE
          LIMIT 1
        ) parent_img ON TRUE
        LEFT JOIN variation_configuration vc ON v.id = vc.variation_id AND vc.value_id = ANY($4)
        WHERE
          ($3 % ANY(STRING_TO_ARRAY(v.name, '' ''))
          OR
          $3 % ANY(STRING_TO_ARRAY(v.sku, '' '')))
        GROUP BY
          v.id, v.name, v.sku, v.enabled, v.parent_id, variation_img.url, parent_img.url
        HAVING
          array_length($4, 1) IS NULL OR 
          array_length(ARRAY_REMOVE($4, NULL), 1) = COUNT(vc.variation_id)
      ) AS combined
      ORDER BY ' || sort_term || ' ' || sort_order || '
      LIMIT $1 OFFSET $2;'
    USING (to_limit - from_limit + 1), from_limit, search_term, value_id;
  end;
$_$;

ALTER FUNCTION "public"."search_products_or_variations"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, VARIADIC "value_id" integer[]) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."search_shapes"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) RETURNS TABLE("id" integer, "name" character varying, "slug" "text", "count" bigint)
    LANGUAGE "plpgsql"
    AS $_$
	begin
		return query execute
		'
			SELECT *, count(*) OVER () AS count 
			FROM shape s
			WHERE 
				$3 % ANY(STRING_TO_ARRAY(s.name, '' ''))
				OR
				$3 % ANY(STRING_TO_ARRAY(s.slug, '' ''))
			ORDER BY ' || sort_term || ' ' || sort_order || '
			LIMIT $1 OFFSET $2;'
			USING (to_limit - from_limit + 1), from_limit, search_term;
	end;
$_$;

ALTER FUNCTION "public"."search_shapes"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."search_users"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) RETURNS TABLE("id" "uuid", "first_name" character varying, "email" character varying, "last_name" character varying, "role" "public"."user_role", "company" "text", "count" bigint)
    LANGUAGE "plpgsql"
    AS $_$
	begin
		return query execute
		'
			SELECT *, count(*) OVER () AS count 
			FROM users u
			WHERE 
				$3 % ANY(STRING_TO_ARRAY(u.first_name, '' ''))
				OR
				$3 % ANY(STRING_TO_ARRAY(u.last_name, '' ''))
				OR
				$3 % ANY(STRING_TO_ARRAY(u.email, '' ''))
				OR
				$3 % ANY(STRING_TO_ARRAY(u.company, '' ''))
			ORDER BY ' || sort_term || ' ' || sort_order || '
			LIMIT $1 OFFSET $2;'
			USING (to_limit - from_limit + 1), from_limit, search_term;
	end;
$_$;

ALTER FUNCTION "public"."search_users"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."search_variations"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, VARIADIC "value_id" integer[]) RETURNS TABLE("id" integer, "name" character varying, "sku" character varying, "enabled" boolean, "product_type" "text", "parent_id" integer, "image_url" character varying, "count" bigint)
    LANGUAGE "plpgsql"
    AS $_$
  begin
    return query execute
    '
    SELECT v.id, v.name, v.sku, v.enabled, NULL as product_type, v.parent_id AS parent_id, COALESCE(variation_img.url, parent_img.url) as image_url, count(*) OVER () AS count
      FROM variation v
      LEFT JOIN LATERAL (
        SELECT vi.image_id, image.url
        FROM variation_image vi
        JOIN image ON vi.image_id = image.id
        WHERE
          vi.variation_id = v.id AND
          vi.is_primary = TRUE
        LIMIT 1
      ) variation_img ON TRUE
      LEFT JOIN LATERAL (
        SELECT pi.image_id, image.url
        FROM product_image pi
        JOIN image ON pi.image_id = image.id
        WHERE
          pi.product_id = v.parent_id AND
          pi.is_primary = TRUE
        LIMIT 1
      ) parent_img ON TRUE
      LEFT JOIN variation_configuration vc ON v.id = vc.variation_id AND vc.value_id = ANY($4)
      WHERE
        ($3 % ANY(STRING_TO_ARRAY(v.name, '' ''))
        OR
        $3 % ANY(STRING_TO_ARRAY(v.sku, '' '')))
      GROUP BY
        v.id, v.name, v.sku, v.enabled, v.parent_id, variation_img.url, parent_img.url
      HAVING
        array_length($4, 1) IS NULL OR 
        array_length(ARRAY_REMOVE($4, NULL), 1) = COUNT(vc.variation_id)
    ORDER BY ' || sort_term || ' ' || sort_order || '
    LIMIT $1 OFFSET $2;'
    USING (to_limit - from_limit + 1), from_limit, search_term, value_id;
  end;
$_$;

ALTER FUNCTION "public"."search_variations"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, VARIADIC "value_id" integer[]) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."search_variations"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "parentid" integer, VARIADIC "value_id" integer[]) RETURNS TABLE("id" integer, "name" character varying, "sku" character varying, "enabled" boolean, "product_type" "text", "parent_id" integer, "image_url" character varying, "count" bigint)
    LANGUAGE "plpgsql"
    AS $_$
  begin
    return query execute
    '
    SELECT v.id, v.name, v.sku, v.enabled, NULL as product_type, v.parent_id AS parent_id, COALESCE(variation_img.url, parent_img.url) as image_url, count(*) OVER () AS count
      FROM variation v
      LEFT JOIN LATERAL (
        SELECT vi.image_id, image.url
        FROM variation_image vi
        JOIN image ON vi.image_id = image.id
        WHERE
          vi.variation_id = v.id AND
          vi.is_primary = TRUE
        LIMIT 1
      ) variation_img ON TRUE
      LEFT JOIN LATERAL (
        SELECT pi.image_id, image.url
        FROM product_image pi
        JOIN image ON pi.image_id = image.id
        WHERE
          pi.product_id = v.parent_id AND
          pi.is_primary = TRUE
        LIMIT 1
      ) parent_img ON TRUE
      LEFT JOIN variation_configuration vc ON v.id = vc.variation_id AND vc.value_id = ANY($4)
      WHERE
        (v.parent_id = $5) AND
        ($3 % ANY(STRING_TO_ARRAY(v.name, '' ''))
        OR
        $3 % ANY(STRING_TO_ARRAY(v.sku, '' '')))
      GROUP BY
        v.id, v.name, v.sku, v.enabled, v.parent_id, variation_img.url, parent_img.url
      HAVING
        array_length($4, 1) IS NULL OR 
        array_length(ARRAY_REMOVE($4, NULL), 1) = COUNT(vc.variation_id)
    ORDER BY ' || sort_term || ' ' || sort_order || '
    LIMIT $1 OFFSET $2;'
    USING (to_limit - from_limit + 1), from_limit, search_term, value_id, parentid;
  end;
$_$;

ALTER FUNCTION "public"."search_variations"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "parentid" integer, VARIADIC "value_id" integer[]) OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."set_distributor_price"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  NEW.distributor_price := CEIL(NEW.dealer_price * 0.85);
  RETURN NEW;
END $$;

ALTER FUNCTION "public"."set_distributor_price"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."set_group_price"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  NEW.group_price := CEIL(NEW.dealer_price * 0.92);
  RETURN NEW;
END $$;

ALTER FUNCTION "public"."set_group_price"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."set_internet_price"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  NEW.internet_price := CEIL(NEW.dealer_price * 1.10);
  RETURN NEW;
END $$;

ALTER FUNCTION "public"."set_internet_price"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."set_landscape_price"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  NEW.landscape_price := CEIL(NEW.dealer_price * 1.20);
  RETURN NEW;
END $$;

ALTER FUNCTION "public"."set_landscape_price"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."set_map_price"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  NEW.map_price := CEIL(CEIL(NEW.dealer_price * 0.92) * 2);
  RETURN NEW;
END $$;

ALTER FUNCTION "public"."set_map_price"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."set_master_distributor_price"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  NEW.master_distributor_price := CEIL(NEW.dealer_price * 0.80);
  RETURN NEW;
END $$;

ALTER FUNCTION "public"."set_master_distributor_price"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."set_msrp_price"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  NEW.msrp_price := CEIL(CEIL(NEW.dealer_price * 0.92) * 2.2);
  RETURN NEW;
END $$;

ALTER FUNCTION "public"."set_msrp_price"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."set_slug_from_name"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  NEW.slug := slugify(NEW.name);
  RETURN NEW;
END $$;

ALTER FUNCTION "public"."set_slug_from_name"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."set_slug_from_value"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  NEW.slug := slugify(NEW.value);
  RETURN NEW;
END $$;

ALTER FUNCTION "public"."set_slug_from_value"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."slugify"("value" "text") RETURNS "text"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $_$
BEGIN
  -- -- Remove any accent (any diacritic signs) from the given string --
  -- WITH "unaccented" AS (
  --   SELECT unaccent("value") AS "value"
  -- ),
  -- -- String to lowercase --
  -- "lowercase" AS (
  --   SELECT lower("value") AS "value"
  --   FROM "unaccented"
  -- ),
  -- -- Replace anything that's not a letter, number, hyphen or underscore with a hyphen
  -- "hyphenated" AS (
  --   SELECT regexp_replace("value", '[^a-z0-9\\-_]+', '-', 'gi') AS "value"
  --   FROM "lowercase"
  -- ),
  -- -- Trim hyphens (if they exist) from the head or tail of the string
  -- "trimmed" AS (
  --   SELECT regexp_replace(regexp_replace("value", '\\-+$', ''), '^\\-', '') AS "value"
  --   FROM "hyphenated"
  -- )
  -- SELECT "value" FROM "trimmed";
  RETURN (
    SELECT regexp_replace(
            regexp_replace(
              regexp_replace(
                lower(unaccent("value")),
                '[^a-z0-9\\-_]+',
                '-',
                'gi'
              ),
              '\\-+$',
              ''
            ),
            '^\\-',
            ''
          )
  );
END $_$;

ALTER FUNCTION "public"."slugify"("value" "text") OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."trigger_set_updated_at_timestamp"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END $$;

ALTER FUNCTION "public"."trigger_set_updated_at_timestamp"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."trigger_set_updated_by"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  NEW.updated_by = auth.uid();
  RETURN NEW;
END $$;

ALTER FUNCTION "public"."trigger_set_updated_by"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."update_users_meta"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  UPDATE auth.users
  SET raw_user_meta_data = 
    jsonb_build_object('last_name', NEW.last_name, 'first_name', NEW.first_name, 'role', NEW.role, 'company', NEW.company)
  WHERE id = NEW.id;
  
  RETURN NEW;
END $$;

ALTER FUNCTION "public"."update_users_meta"() OWNER TO "postgres";

CREATE OR REPLACE FUNCTION "public"."validate_product_or_variation"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  IF NEW.product_id IS NULL AND NEW.variation_id IS NULL THEN
    RAISE EXCEPTION 'At least one of product_id or variant_id must be provided.';
  ELSIF NEW.product_id IS NOT NULL AND NEW.variation_id IS NOT NULL THEN
    RAISE EXCEPTION 'Both product_id and variant_id cannot be provided at the same time.';
  END IF;
  RETURN NEW;
END;
$$;

ALTER FUNCTION "public"."validate_product_or_variation"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";

CREATE TABLE IF NOT EXISTS "public"."attribute_value" (
    "id" integer NOT NULL,
    "attribute_id" integer NOT NULL,
    "value" "text",
    "material_id" integer,
    "color_id" integer,
    "gas_id" integer,
    "ignition_id" integer,
    "slug" "text"
);

ALTER TABLE "public"."attribute_value" OWNER TO "postgres";

ALTER TABLE "public"."attribute_value" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."attribute_value_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."attributes" (
    "id" integer NOT NULL,
    "name" "text",
    "table_name" "text",
    "slug" "text"
);

ALTER TABLE "public"."attributes" OWNER TO "postgres";

ALTER TABLE "public"."attributes" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."attributes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."category" (
    "id" integer NOT NULL,
    "name" character varying,
    "slug" "text",
    "parent_id" integer
);

ALTER TABLE "public"."category" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."category_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."category_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."category_id_seq" OWNED BY "public"."category"."id";

CREATE TABLE IF NOT EXISTS "public"."collection" (
    "id" integer NOT NULL,
    "name" character varying,
    "slug" "text"
);

ALTER TABLE "public"."collection" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."collection_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."collection_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."collection_id_seq" OWNED BY "public"."collection"."id";

CREATE TABLE IF NOT EXISTS "public"."color" (
    "id" integer NOT NULL,
    "name" character varying,
    "slug" "text",
    "material_id" integer,
    "image_url" "text"
);

ALTER TABLE "public"."color" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."color_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."color_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."color_id_seq" OWNED BY "public"."color"."id";

CREATE TABLE IF NOT EXISTS "public"."company" (
    "id" integer NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "name" "text" NOT NULL,
    "slug" "text",
    "logo_url" "text",
    "role" "public"."user_role"
);

ALTER TABLE "public"."company" OWNER TO "postgres";

ALTER TABLE "public"."company" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."company_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."dealer_price" (
    "id" integer NOT NULL,
    "product_id" integer,
    "price" numeric NOT NULL,
    "year" integer NOT NULL,
    "variation_id" integer
);

ALTER TABLE "public"."dealer_price" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."dealer_price_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."dealer_price_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."dealer_price_id_seq" OWNED BY "public"."dealer_price"."id";

CREATE TABLE IF NOT EXISTS "public"."distributor_price" (
    "id" integer NOT NULL,
    "product_id" integer,
    "price" numeric NOT NULL,
    "year" integer NOT NULL,
    "variation_id" integer
);

ALTER TABLE "public"."distributor_price" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."distributor_price_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."distributor_price_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."distributor_price_id_seq" OWNED BY "public"."distributor_price"."id";

CREATE TABLE IF NOT EXISTS "public"."documents" (
    "id" integer NOT NULL,
    "url" character varying NOT NULL,
    "name" "text"
);

ALTER TABLE "public"."documents" OWNER TO "postgres";

ALTER TABLE "public"."documents" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."documents_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."gas" (
    "id" integer NOT NULL,
    "name" character varying,
    "slug" "text"
);

ALTER TABLE "public"."gas" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."gas_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."gas_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."gas_id_seq" OWNED BY "public"."gas"."id";

CREATE TABLE IF NOT EXISTS "public"."group_price" (
    "id" integer NOT NULL,
    "product_id" integer,
    "price" numeric NOT NULL,
    "year" integer NOT NULL,
    "variation_id" integer
);

ALTER TABLE "public"."group_price" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."group_price_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."group_price_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."group_price_id_seq" OWNED BY "public"."group_price"."id";

CREATE TABLE IF NOT EXISTS "public"."ignition" (
    "id" integer NOT NULL,
    "name" character varying,
    "slug" "text"
);

ALTER TABLE "public"."ignition" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."ignition_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."ignition_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."ignition_id_seq" OWNED BY "public"."ignition"."id";

CREATE TABLE IF NOT EXISTS "public"."image" (
    "id" integer NOT NULL,
    "url" character varying,
    "name" "text"
);

ALTER TABLE "public"."image" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."image_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."image_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."image_id_seq" OWNED BY "public"."image"."id";

CREATE TABLE IF NOT EXISTS "public"."internet_price" (
    "id" integer NOT NULL,
    "product_id" integer,
    "price" numeric NOT NULL,
    "year" integer NOT NULL,
    "variation_id" integer
);

ALTER TABLE "public"."internet_price" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."internet_price_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."internet_price_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."internet_price_id_seq" OWNED BY "public"."internet_price"."id";

CREATE TABLE IF NOT EXISTS "public"."landscape_price" (
    "id" integer NOT NULL,
    "product_id" integer,
    "price" numeric NOT NULL,
    "year" integer NOT NULL,
    "variation_id" integer
);

ALTER TABLE "public"."landscape_price" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."landscape_price_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."landscape_price_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."landscape_price_id_seq" OWNED BY "public"."landscape_price"."id";

CREATE TABLE IF NOT EXISTS "public"."map_price" (
    "id" integer NOT NULL,
    "product_id" integer,
    "price" numeric NOT NULL,
    "year" integer NOT NULL,
    "variation_id" integer
);

ALTER TABLE "public"."map_price" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."map_price_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."map_price_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."map_price_id_seq" OWNED BY "public"."map_price"."id";

CREATE TABLE IF NOT EXISTS "public"."master_distributor_price" (
    "id" integer NOT NULL,
    "product_id" integer,
    "price" numeric NOT NULL,
    "year" integer NOT NULL,
    "variation_id" integer
);

ALTER TABLE "public"."master_distributor_price" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."master_distributor_price_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."master_distributor_price_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."master_distributor_price_id_seq" OWNED BY "public"."master_distributor_price"."id";

CREATE TABLE IF NOT EXISTS "public"."material" (
    "id" integer NOT NULL,
    "name" character varying,
    "slug" "text",
    "image_url" "text"
);

ALTER TABLE "public"."material" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."material_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."material_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."material_id_seq" OWNED BY "public"."material"."id";

CREATE TABLE IF NOT EXISTS "public"."msrp_price" (
    "id" integer NOT NULL,
    "product_id" integer,
    "price" numeric NOT NULL,
    "year" integer NOT NULL,
    "variation_id" integer
);

ALTER TABLE "public"."msrp_price" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."msrp_price_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."msrp_price_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."msrp_price_id_seq" OWNED BY "public"."msrp_price"."id";

CREATE TABLE IF NOT EXISTS "public"."product" (
    "id" integer NOT NULL,
    "sku" character varying,
    "burner_shape" character varying(60),
    "compatible_canvas_cover" character varying,
    "compatible_bullet_burner" character varying,
    "compatible_glass_wind_guard" character varying,
    "access_door" boolean,
    "collection_id" integer,
    "category_id" integer,
    "shape_id" integer,
    "product_serial_base" character varying,
    "certifications" "public"."certification_type"[],
    "published" boolean DEFAULT false,
    "enabled" boolean DEFAULT false,
    "created_by" "uuid" DEFAULT "auth"."uid"(),
    "updated_by" "uuid",
    "company_division" "text" DEFAULT 'The Outdoor Plus'::"text",
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "name" character varying,
    "short_description" "text",
    "description" "text",
    "product_type" "public"."product_type" DEFAULT 'VARIABLE'::"public"."product_type",
    "website_link" "text",
    "meta" "jsonb",
    "product_meta" "jsonb",
    "material_id" integer,
    "dealer_price" numeric,
    "distributor_price" numeric,
    "group_price" numeric,
    "internet_price" numeric,
    "landscape_price" numeric,
    "map_price" numeric,
    "master_distributor_price" numeric,
    "msrp_price" numeric
);

ALTER TABLE "public"."product" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."product_attribute" (
    "id" integer NOT NULL,
    "product_id" integer NOT NULL,
    "attribute_id" integer NOT NULL,
    "fill_values" boolean DEFAULT false
);

ALTER TABLE "public"."product_attribute" OWNER TO "postgres";

ALTER TABLE "public"."product_attribute" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."product_attribute_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."product_color" (
    "product_id" integer NOT NULL,
    "color_id" integer NOT NULL,
    "type" "text" DEFAULT 'default'::"text"
);

ALTER TABLE "public"."product_color" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."product_configuration" (
    "product_id" integer NOT NULL,
    "value_id" integer NOT NULL
);

ALTER TABLE "public"."product_configuration" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."product_documents" (
    "product_id" integer NOT NULL,
    "document_id" integer NOT NULL
);

ALTER TABLE "public"."product_documents" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."product_gas" (
    "product_id" integer NOT NULL,
    "gas_id" integer NOT NULL
);

ALTER TABLE "public"."product_gas" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."product_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."product_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."product_id_seq" OWNED BY "public"."product"."id";

CREATE TABLE IF NOT EXISTS "public"."product_ignition" (
    "product_id" integer NOT NULL,
    "ignition_id" integer NOT NULL
);

ALTER TABLE "public"."product_ignition" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."product_image" (
    "product_id" integer NOT NULL,
    "image_id" integer NOT NULL,
    "display_order" integer DEFAULT 0 NOT NULL,
    "is_primary" boolean DEFAULT false
);

ALTER TABLE "public"."product_image" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."product_material" (
    "product_id" integer NOT NULL,
    "material_id" integer NOT NULL
);

ALTER TABLE "public"."product_material" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."product_specification_sheet" (
    "product_id" integer NOT NULL,
    "specification_sheet_id" integer NOT NULL
);

ALTER TABLE "public"."product_specification_sheet" OWNER TO "postgres";

ALTER TABLE "public"."product_specification_sheet" ALTER COLUMN "product_id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."product_specification_sheet_product_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."shape" (
    "id" integer NOT NULL,
    "name" character varying,
    "slug" "text"
);

ALTER TABLE "public"."shape" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."shape_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."shape_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."shape_id_seq" OWNED BY "public"."shape"."id";

CREATE TABLE IF NOT EXISTS "public"."specification_sheet" (
    "id" integer NOT NULL,
    "url" character varying NOT NULL,
    "name" "text"
);

ALTER TABLE "public"."specification_sheet" OWNER TO "postgres";

ALTER TABLE "public"."specification_sheet" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."specification_sheet_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."users" (
    "id" "uuid" NOT NULL,
    "first_name" character varying,
    "email" character varying,
    "last_name" character varying,
    "role" "public"."user_role" DEFAULT 'USER'::"public"."user_role",
    "company" integer
);

ALTER TABLE "public"."users" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."variation" (
    "id" integer NOT NULL,
    "parent_id" integer NOT NULL,
    "sku" character varying NOT NULL,
    "upc_codes" character varying,
    "encoded_upc_codes" character varying,
    "product_length" character varying(60),
    "product_diameter" character varying(60),
    "product_width" character varying(60),
    "product_height" character varying(60),
    "base_length" character varying(60),
    "base_diameter" character varying(60),
    "base_width" character varying(60),
    "base_opening" character varying(60),
    "toe_kick" character varying(60),
    "soil_usage" character varying(60),
    "scupper_width" character varying(60),
    "scupper_inlet_opening" character varying(60),
    "gpm" character varying(60),
    "fire_glass" character varying(60),
    "ba_length" character varying(60),
    "ba_diameter" character varying(60),
    "ba_width" character varying(60),
    "ba_depth" character varying(60),
    "burner_shape" character varying(60),
    "burner_length" character varying(60),
    "burner_diameter" character varying(60),
    "compatible_canvas_cover" character varying,
    "compatible_bullet_burner" character varying,
    "compatible_glass_wind_guard" character varying,
    "product_serial_base" character varying,
    "certifications" "public"."certification_type"[],
    "enabled" boolean DEFAULT false,
    "created_by" "uuid" DEFAULT "auth"."uid"(),
    "updated_by" "uuid",
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "name" character varying,
    "short_description" "text",
    "description" "text",
    "website_link" "text",
    "meta" "jsonb" DEFAULT '{}'::"jsonb",
    "product_meta" "jsonb" DEFAULT '{}'::"jsonb",
    "dealer_price" numeric,
    "distributor_price" numeric,
    "group_price" numeric,
    "internet_price" numeric,
    "landscape_price" numeric,
    "map_price" numeric,
    "master_distributor_price" numeric,
    "msrp_price" numeric,
    "btu" numeric
);

ALTER TABLE "public"."variation" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."variation_configuration" (
    "variation_id" integer NOT NULL,
    "value_id" integer NOT NULL,
    "attribute_id" integer
);

ALTER TABLE "public"."variation_configuration" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."variation_documents" (
    "variation_id" integer NOT NULL,
    "document_id" integer NOT NULL
);

ALTER TABLE "public"."variation_documents" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."variation_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."variation_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."variation_id_seq" OWNED BY "public"."variation"."id";

CREATE TABLE IF NOT EXISTS "public"."variation_image" (
    "variation_id" integer NOT NULL,
    "image_id" integer NOT NULL,
    "display_order" integer DEFAULT 0 NOT NULL,
    "is_primary" boolean DEFAULT false
);

ALTER TABLE "public"."variation_image" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."variation_specification_sheet" (
    "variation_id" integer NOT NULL,
    "specification_sheet_id" integer NOT NULL
);

ALTER TABLE "public"."variation_specification_sheet" OWNER TO "postgres";

ALTER TABLE ONLY "public"."category" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."category_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."collection" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."collection_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."color" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."color_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."dealer_price" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."dealer_price_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."distributor_price" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."distributor_price_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."gas" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."gas_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."group_price" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."group_price_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."ignition" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."ignition_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."image" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."image_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."internet_price" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."internet_price_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."landscape_price" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."landscape_price_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."map_price" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."map_price_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."master_distributor_price" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."master_distributor_price_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."material" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."material_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."msrp_price" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."msrp_price_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."product" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."product_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."shape" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."shape_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."variation" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."variation_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."attributes"
    ADD CONSTRAINT "attribute_name_table_unique" UNIQUE ("name", "table_name");

ALTER TABLE ONLY "public"."attributes"
    ADD CONSTRAINT "attribute_name_unique" UNIQUE ("name");

ALTER TABLE ONLY "public"."attributes"
    ADD CONSTRAINT "attribute_table_name_unique" UNIQUE ("table_name");

ALTER TABLE ONLY "public"."attribute_value"
    ADD CONSTRAINT "attribute_value_id_key" UNIQUE ("id");

ALTER TABLE ONLY "public"."attribute_value"
    ADD CONSTRAINT "attribute_value_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."attributes"
    ADD CONSTRAINT "attributes_id_key" UNIQUE ("id");

ALTER TABLE ONLY "public"."attributes"
    ADD CONSTRAINT "attributes_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."category"
    ADD CONSTRAINT "category_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."category"
    ADD CONSTRAINT "category_slug_key" UNIQUE ("slug");

ALTER TABLE ONLY "public"."collection"
    ADD CONSTRAINT "collection_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."collection"
    ADD CONSTRAINT "collection_slug_key" UNIQUE ("slug");

ALTER TABLE ONLY "public"."color"
    ADD CONSTRAINT "color_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."company"
    ADD CONSTRAINT "company_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."dealer_price"
    ADD CONSTRAINT "dealer_price_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."distributor_price"
    ADD CONSTRAINT "distributor_price_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."documents"
    ADD CONSTRAINT "documents_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."gas"
    ADD CONSTRAINT "gas_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."gas"
    ADD CONSTRAINT "gas_slug_key" UNIQUE ("slug");

ALTER TABLE ONLY "public"."group_price"
    ADD CONSTRAINT "group_price_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."ignition"
    ADD CONSTRAINT "ignition_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."ignition"
    ADD CONSTRAINT "ignition_slug_key" UNIQUE ("slug");

ALTER TABLE ONLY "public"."image"
    ADD CONSTRAINT "image_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."internet_price"
    ADD CONSTRAINT "internet_price_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."landscape_price"
    ADD CONSTRAINT "landscape_price_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."map_price"
    ADD CONSTRAINT "map_price_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."master_distributor_price"
    ADD CONSTRAINT "master_distributor_price_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."material"
    ADD CONSTRAINT "material_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."material"
    ADD CONSTRAINT "material_slug_key" UNIQUE ("slug");

ALTER TABLE ONLY "public"."msrp_price"
    ADD CONSTRAINT "msrp_price_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."product_attribute"
    ADD CONSTRAINT "product_attribute_id_key" UNIQUE ("id");

ALTER TABLE ONLY "public"."product_attribute"
    ADD CONSTRAINT "product_attribute_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."product_color"
    ADD CONSTRAINT "product_color_pkey" PRIMARY KEY ("product_id", "color_id");

ALTER TABLE ONLY "public"."product_configuration"
    ADD CONSTRAINT "product_configuration_pkey" PRIMARY KEY ("product_id", "value_id");

ALTER TABLE ONLY "public"."product_documents"
    ADD CONSTRAINT "product_documents_pkey" PRIMARY KEY ("product_id", "document_id");

ALTER TABLE ONLY "public"."product_gas"
    ADD CONSTRAINT "product_gas_pkey" PRIMARY KEY ("product_id", "gas_id");

ALTER TABLE ONLY "public"."product_ignition"
    ADD CONSTRAINT "product_ignition_pkey" PRIMARY KEY ("product_id", "ignition_id");

ALTER TABLE ONLY "public"."product_image"
    ADD CONSTRAINT "product_image_pkey" PRIMARY KEY ("product_id", "image_id");

ALTER TABLE ONLY "public"."product_material"
    ADD CONSTRAINT "product_material_pkey" PRIMARY KEY ("product_id", "material_id");

ALTER TABLE ONLY "public"."product"
    ADD CONSTRAINT "product_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."product"
    ADD CONSTRAINT "product_sku_key" UNIQUE ("sku");

ALTER TABLE ONLY "public"."product_specification_sheet"
    ADD CONSTRAINT "product_specification_sheet_pkey" PRIMARY KEY ("product_id", "specification_sheet_id");

ALTER TABLE ONLY "public"."shape"
    ADD CONSTRAINT "shape_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."shape"
    ADD CONSTRAINT "shape_slug_key" UNIQUE ("slug");

ALTER TABLE ONLY "public"."specification_sheet"
    ADD CONSTRAINT "specification_sheet_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."variation_configuration"
    ADD CONSTRAINT "variation_configuration_pkey" PRIMARY KEY ("variation_id", "value_id");

ALTER TABLE ONLY "public"."variation_documents"
    ADD CONSTRAINT "variation_documents_pkey" PRIMARY KEY ("variation_id", "document_id");

ALTER TABLE ONLY "public"."variation_image"
    ADD CONSTRAINT "variation_image_pkey" PRIMARY KEY ("variation_id", "image_id");

ALTER TABLE ONLY "public"."variation"
    ADD CONSTRAINT "variation_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."variation"
    ADD CONSTRAINT "variation_sku_key" UNIQUE ("sku");

ALTER TABLE ONLY "public"."variation_specification_sheet"
    ADD CONSTRAINT "variation_specification_sheet_pkey" PRIMARY KEY ("variation_id", "specification_sheet_id");

CREATE INDEX "idx_product_and_variants_sku" ON "public"."product" USING "btree" ("sku");

CREATE INDEX "idx_products_and_variants_name" ON "public"."product" USING "btree" ("name");

CREATE OR REPLACE TRIGGER "attribute_slug_insert" BEFORE INSERT OR UPDATE ON "public"."attributes" FOR EACH ROW WHEN ((("new"."name" IS NOT NULL) AND ("new"."slug" IS NULL))) EXECUTE FUNCTION "public"."set_slug_from_name"();

CREATE OR REPLACE TRIGGER "attribute_value_slug_insert" BEFORE INSERT OR UPDATE ON "public"."attribute_value" FOR EACH ROW WHEN ((("new"."value" IS NOT NULL) AND ("new"."slug" IS NULL))) EXECUTE FUNCTION "public"."set_slug_from_value"();

CREATE OR REPLACE TRIGGER "calculate_distributor_price_product" BEFORE INSERT OR UPDATE ON "public"."product" FOR EACH ROW WHEN (("new"."dealer_price" IS NOT NULL)) EXECUTE FUNCTION "public"."set_distributor_price"();

CREATE OR REPLACE TRIGGER "calculate_distributor_price_variation" BEFORE INSERT OR UPDATE ON "public"."variation" FOR EACH ROW WHEN (("new"."dealer_price" IS NOT NULL)) EXECUTE FUNCTION "public"."set_distributor_price"();

CREATE OR REPLACE TRIGGER "calculate_group_price_product" BEFORE INSERT OR UPDATE ON "public"."product" FOR EACH ROW WHEN (("new"."dealer_price" IS NOT NULL)) EXECUTE FUNCTION "public"."set_group_price"();

CREATE OR REPLACE TRIGGER "calculate_group_price_variation" BEFORE INSERT OR UPDATE ON "public"."variation" FOR EACH ROW WHEN (("new"."dealer_price" IS NOT NULL)) EXECUTE FUNCTION "public"."set_group_price"();

CREATE OR REPLACE TRIGGER "calculate_internet_price_product" BEFORE INSERT OR UPDATE ON "public"."product" FOR EACH ROW WHEN (("new"."dealer_price" IS NOT NULL)) EXECUTE FUNCTION "public"."set_internet_price"();

CREATE OR REPLACE TRIGGER "calculate_internet_price_variation" BEFORE INSERT OR UPDATE ON "public"."variation" FOR EACH ROW WHEN (("new"."dealer_price" IS NOT NULL)) EXECUTE FUNCTION "public"."set_internet_price"();

CREATE OR REPLACE TRIGGER "calculate_landscape_price_product" BEFORE INSERT OR UPDATE ON "public"."product" FOR EACH ROW WHEN (("new"."dealer_price" IS NOT NULL)) EXECUTE FUNCTION "public"."set_landscape_price"();

CREATE OR REPLACE TRIGGER "calculate_landscape_price_variation" BEFORE INSERT OR UPDATE ON "public"."variation" FOR EACH ROW WHEN (("new"."dealer_price" IS NOT NULL)) EXECUTE FUNCTION "public"."set_landscape_price"();

CREATE OR REPLACE TRIGGER "calculate_map_price_product" BEFORE INSERT OR UPDATE ON "public"."product" FOR EACH ROW WHEN (("new"."dealer_price" IS NOT NULL)) EXECUTE FUNCTION "public"."set_map_price"();

CREATE OR REPLACE TRIGGER "calculate_map_price_variation" BEFORE INSERT OR UPDATE ON "public"."variation" FOR EACH ROW WHEN (("new"."dealer_price" IS NOT NULL)) EXECUTE FUNCTION "public"."set_map_price"();

CREATE OR REPLACE TRIGGER "calculate_master_distributor_price_product" BEFORE INSERT OR UPDATE ON "public"."product" FOR EACH ROW WHEN (("new"."dealer_price" IS NOT NULL)) EXECUTE FUNCTION "public"."set_master_distributor_price"();

CREATE OR REPLACE TRIGGER "calculate_master_distributor_price_variation" BEFORE INSERT OR UPDATE ON "public"."variation" FOR EACH ROW WHEN (("new"."dealer_price" IS NOT NULL)) EXECUTE FUNCTION "public"."set_master_distributor_price"();

CREATE OR REPLACE TRIGGER "calculate_msrp_price_product" BEFORE INSERT OR UPDATE ON "public"."product" FOR EACH ROW WHEN (("new"."dealer_price" IS NOT NULL)) EXECUTE FUNCTION "public"."set_msrp_price"();

CREATE OR REPLACE TRIGGER "calculate_msrp_price_variation" BEFORE INSERT OR UPDATE ON "public"."variation" FOR EACH ROW WHEN (("new"."dealer_price" IS NOT NULL)) EXECUTE FUNCTION "public"."set_msrp_price"();

CREATE OR REPLACE TRIGGER "category_slug_insert" BEFORE INSERT OR UPDATE ON "public"."category" FOR EACH ROW WHEN ((("new"."name" IS NOT NULL) AND ("new"."slug" IS NULL))) EXECUTE FUNCTION "public"."set_slug_from_name"();

CREATE OR REPLACE TRIGGER "collection_slug_insert" BEFORE INSERT OR UPDATE ON "public"."collection" FOR EACH ROW WHEN ((("new"."name" IS NOT NULL) AND ("new"."slug" IS NULL))) EXECUTE FUNCTION "public"."set_slug_from_name"();

CREATE OR REPLACE TRIGGER "color_slug_insert" BEFORE INSERT OR UPDATE ON "public"."color" FOR EACH ROW WHEN ((("new"."name" IS NOT NULL) AND ("new"."slug" IS NULL))) EXECUTE FUNCTION "public"."set_slug_from_name"();

CREATE OR REPLACE TRIGGER "delete_user_trigger" AFTER DELETE ON "public"."users" FOR EACH ROW EXECUTE FUNCTION "public"."delete_user"();

CREATE OR REPLACE TRIGGER "gas_slug_insert" BEFORE INSERT OR UPDATE ON "public"."gas" FOR EACH ROW WHEN ((("new"."name" IS NOT NULL) AND ("new"."slug" IS NULL))) EXECUTE FUNCTION "public"."set_slug_from_name"();

CREATE OR REPLACE TRIGGER "ignition_slug_insert" BEFORE INSERT OR UPDATE ON "public"."ignition" FOR EACH ROW WHEN ((("new"."name" IS NOT NULL) AND ("new"."slug" IS NULL))) EXECUTE FUNCTION "public"."set_slug_from_name"();

CREATE OR REPLACE TRIGGER "material_slug_insert" BEFORE INSERT OR UPDATE ON "public"."material" FOR EACH ROW WHEN ((("new"."name" IS NOT NULL) AND ("new"."slug" IS NULL))) EXECUTE FUNCTION "public"."set_slug_from_name"();

CREATE OR REPLACE TRIGGER "set_updated_at_timestamp" BEFORE UPDATE ON "public"."product" FOR EACH ROW EXECUTE FUNCTION "public"."trigger_set_updated_at_timestamp"();

CREATE OR REPLACE TRIGGER "set_updated_at_variation_timestamp" BEFORE UPDATE ON "public"."variation" FOR EACH ROW EXECUTE FUNCTION "public"."trigger_set_updated_at_timestamp"();

CREATE OR REPLACE TRIGGER "set_updated_by" BEFORE UPDATE ON "public"."product" FOR EACH ROW EXECUTE FUNCTION "public"."trigger_set_updated_by"();

CREATE OR REPLACE TRIGGER "set_updated_by_variation" BEFORE UPDATE ON "public"."variation" FOR EACH ROW EXECUTE FUNCTION "public"."trigger_set_updated_by"();

CREATE OR REPLACE TRIGGER "shape_slug_insert" BEFORE INSERT OR UPDATE ON "public"."shape" FOR EACH ROW WHEN ((("new"."name" IS NOT NULL) AND ("new"."slug" IS NULL))) EXECUTE FUNCTION "public"."set_slug_from_name"();

CREATE OR REPLACE TRIGGER "update_users_meta" AFTER UPDATE ON "public"."users" FOR EACH ROW EXECUTE FUNCTION "public"."update_users_meta"();

CREATE OR REPLACE TRIGGER "validate_product_or_variation_dealer_trigger" BEFORE INSERT ON "public"."dealer_price" FOR EACH ROW EXECUTE FUNCTION "public"."validate_product_or_variation"();

CREATE OR REPLACE TRIGGER "validate_product_or_variation_distributor_trigger" BEFORE INSERT ON "public"."distributor_price" FOR EACH ROW EXECUTE FUNCTION "public"."validate_product_or_variation"();

CREATE OR REPLACE TRIGGER "validate_product_or_variation_group_trigger" BEFORE INSERT ON "public"."group_price" FOR EACH ROW EXECUTE FUNCTION "public"."validate_product_or_variation"();

CREATE OR REPLACE TRIGGER "validate_product_or_variation_internet_trigger" BEFORE INSERT ON "public"."internet_price" FOR EACH ROW EXECUTE FUNCTION "public"."validate_product_or_variation"();

CREATE OR REPLACE TRIGGER "validate_product_or_variation_landscape_trigger" BEFORE INSERT ON "public"."landscape_price" FOR EACH ROW EXECUTE FUNCTION "public"."validate_product_or_variation"();

CREATE OR REPLACE TRIGGER "validate_product_or_variation_map_trigger" BEFORE INSERT ON "public"."map_price" FOR EACH ROW EXECUTE FUNCTION "public"."validate_product_or_variation"();

CREATE OR REPLACE TRIGGER "validate_product_or_variation_master_distributor_trigger" BEFORE INSERT ON "public"."master_distributor_price" FOR EACH ROW EXECUTE FUNCTION "public"."validate_product_or_variation"();

CREATE OR REPLACE TRIGGER "validate_product_or_variation_msrp_trigger" BEFORE INSERT ON "public"."msrp_price" FOR EACH ROW EXECUTE FUNCTION "public"."validate_product_or_variation"();

ALTER TABLE ONLY "public"."attribute_value"
    ADD CONSTRAINT "attribute_value_attribute_id_fkey" FOREIGN KEY ("attribute_id") REFERENCES "public"."attributes"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."attribute_value"
    ADD CONSTRAINT "attribute_value_color_id_fkey" FOREIGN KEY ("color_id") REFERENCES "public"."color"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."attribute_value"
    ADD CONSTRAINT "attribute_value_gas_id_fkey" FOREIGN KEY ("gas_id") REFERENCES "public"."gas"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."attribute_value"
    ADD CONSTRAINT "attribute_value_ignition_id_fkey" FOREIGN KEY ("ignition_id") REFERENCES "public"."ignition"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."attribute_value"
    ADD CONSTRAINT "attribute_value_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "public"."material"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."category"
    ADD CONSTRAINT "category_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "public"."category"("id") ON DELETE SET NULL;

ALTER TABLE ONLY "public"."color"
    ADD CONSTRAINT "color_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "public"."material"("id") ON DELETE SET NULL;

ALTER TABLE ONLY "public"."dealer_price"
    ADD CONSTRAINT "dealer_price_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."dealer_price"
    ADD CONSTRAINT "dealer_price_variation_id_fkey" FOREIGN KEY ("variation_id") REFERENCES "public"."variation"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."distributor_price"
    ADD CONSTRAINT "distributor_price_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."distributor_price"
    ADD CONSTRAINT "distributor_price_variation_id_fkey" FOREIGN KEY ("variation_id") REFERENCES "public"."variation"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."group_price"
    ADD CONSTRAINT "group_price_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."group_price"
    ADD CONSTRAINT "group_price_variation_id_fkey" FOREIGN KEY ("variation_id") REFERENCES "public"."variation"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."product_image"
    ADD CONSTRAINT "image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "public"."image"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."internet_price"
    ADD CONSTRAINT "internet_price_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."internet_price"
    ADD CONSTRAINT "internet_price_variation_id_fkey" FOREIGN KEY ("variation_id") REFERENCES "public"."variation"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."landscape_price"
    ADD CONSTRAINT "landscape_price_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."landscape_price"
    ADD CONSTRAINT "landscape_price_variation_id_fkey" FOREIGN KEY ("variation_id") REFERENCES "public"."variation"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."map_price"
    ADD CONSTRAINT "map_price_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."map_price"
    ADD CONSTRAINT "map_price_variation_id_fkey" FOREIGN KEY ("variation_id") REFERENCES "public"."variation"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."master_distributor_price"
    ADD CONSTRAINT "master_distributor_price_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."master_distributor_price"
    ADD CONSTRAINT "master_distributor_price_variation_id_fkey" FOREIGN KEY ("variation_id") REFERENCES "public"."variation"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."msrp_price"
    ADD CONSTRAINT "msrp_price_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."msrp_price"
    ADD CONSTRAINT "msrp_price_variation_id_fkey" FOREIGN KEY ("variation_id") REFERENCES "public"."variation"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."product_attribute"
    ADD CONSTRAINT "product_attribute_attribute_id_fkey" FOREIGN KEY ("attribute_id") REFERENCES "public"."attributes"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."product_attribute"
    ADD CONSTRAINT "product_attribute_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."product"
    ADD CONSTRAINT "product_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "public"."category"("id") ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE ONLY "public"."product"
    ADD CONSTRAINT "product_collection_id_fkey" FOREIGN KEY ("collection_id") REFERENCES "public"."collection"("id") ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE ONLY "public"."product_color"
    ADD CONSTRAINT "product_color_color_id_fkey" FOREIGN KEY ("color_id") REFERENCES "public"."color"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."product_color"
    ADD CONSTRAINT "product_color_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."product"
    ADD CONSTRAINT "product_compatible_bullet_burner_fkey" FOREIGN KEY ("compatible_bullet_burner") REFERENCES "public"."product"("sku") ON DELETE SET NULL;

ALTER TABLE ONLY "public"."product"
    ADD CONSTRAINT "product_compatible_canvas_cover_fkey" FOREIGN KEY ("compatible_canvas_cover") REFERENCES "public"."product"("sku") ON DELETE SET NULL;

ALTER TABLE ONLY "public"."product"
    ADD CONSTRAINT "product_compatible_glass_wind_guard_fkey" FOREIGN KEY ("compatible_glass_wind_guard") REFERENCES "public"."product"("sku") ON DELETE SET NULL;

ALTER TABLE ONLY "public"."product_configuration"
    ADD CONSTRAINT "product_configuration_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."product_configuration"
    ADD CONSTRAINT "product_configuration_value_id_fkey" FOREIGN KEY ("value_id") REFERENCES "public"."attribute_value"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."product"
    ADD CONSTRAINT "product_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."users"("id") ON DELETE SET NULL;

ALTER TABLE ONLY "public"."product_documents"
    ADD CONSTRAINT "product_documents_document_id_fkey" FOREIGN KEY ("document_id") REFERENCES "public"."documents"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."product_documents"
    ADD CONSTRAINT "product_documents_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."product_gas"
    ADD CONSTRAINT "product_gas_gas_id_fkey" FOREIGN KEY ("gas_id") REFERENCES "public"."gas"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."product_gas"
    ADD CONSTRAINT "product_gas_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."product_image"
    ADD CONSTRAINT "product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."product_ignition"
    ADD CONSTRAINT "product_ignition_ignition_id_fkey" FOREIGN KEY ("ignition_id") REFERENCES "public"."ignition"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."product_ignition"
    ADD CONSTRAINT "product_ignition_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."product"
    ADD CONSTRAINT "product_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "public"."material"("id") ON DELETE SET NULL;

ALTER TABLE ONLY "public"."product_material"
    ADD CONSTRAINT "product_material_material_id_fkey" FOREIGN KEY ("material_id") REFERENCES "public"."material"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."product_material"
    ADD CONSTRAINT "product_material_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."product"
    ADD CONSTRAINT "product_shape_id_fkey" FOREIGN KEY ("shape_id") REFERENCES "public"."shape"("id") ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE ONLY "public"."product_specification_sheet"
    ADD CONSTRAINT "product_specification_sheet_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."product_specification_sheet"
    ADD CONSTRAINT "product_specification_sheet_specification_sheet_id_fkey" FOREIGN KEY ("specification_sheet_id") REFERENCES "public"."specification_sheet"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."product"
    ADD CONSTRAINT "product_updated_by_fkey" FOREIGN KEY ("updated_by") REFERENCES "public"."users"("id") ON DELETE SET NULL;

ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "public_users_company_fkey" FOREIGN KEY ("company") REFERENCES "public"."company"("id") ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE ONLY "public"."variation_configuration"
    ADD CONSTRAINT "public_variation_configuration_attribute_id_fkey" FOREIGN KEY ("attribute_id") REFERENCES "public"."attributes"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."variation_configuration"
    ADD CONSTRAINT "variation_configuration_value_id_fkey" FOREIGN KEY ("value_id") REFERENCES "public"."attribute_value"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."variation_configuration"
    ADD CONSTRAINT "variation_configuration_variation_id_fkey" FOREIGN KEY ("variation_id") REFERENCES "public"."variation"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."variation_documents"
    ADD CONSTRAINT "variation_documents_document_id_fkey" FOREIGN KEY ("document_id") REFERENCES "public"."documents"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."variation_documents"
    ADD CONSTRAINT "variation_documents_variation_id_fkey" FOREIGN KEY ("variation_id") REFERENCES "public"."variation"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."variation_image"
    ADD CONSTRAINT "variation_image_image_id_fkey" FOREIGN KEY ("image_id") REFERENCES "public"."image"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."variation_image"
    ADD CONSTRAINT "variation_image_variation_id_fkey" FOREIGN KEY ("variation_id") REFERENCES "public"."variation"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."variation"
    ADD CONSTRAINT "variation_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "public"."product"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."variation_specification_sheet"
    ADD CONSTRAINT "variation_specification_sheet_specification_sheet_id_fkey" FOREIGN KEY ("specification_sheet_id") REFERENCES "public"."specification_sheet"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."variation_specification_sheet"
    ADD CONSTRAINT "variation_specification_sheet_variation_id_fkey" FOREIGN KEY ("variation_id") REFERENCES "public"."variation"("id") ON UPDATE CASCADE ON DELETE CASCADE;

CREATE POLICY "Enable delete for ADMIN and ADMINISTRATOR when authenticated" ON "public"."product_gas" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and ADMINISTRATOR when authenticated" ON "public"."product_ignition" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."attribute_value" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."attributes" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."category" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."collection" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."color" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."company" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."dealer_price" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."distributor_price" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."documents" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."gas" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."group_price" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."ignition" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."image" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."internet_price" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."landscape_price" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."map_price" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."master_distributor_price" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."material" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."msrp_price" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."product" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."product_attribute" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."product_color" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."product_configuration" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."product_documents" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."product_image" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."product_material" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."product_specification_sheet" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."shape" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."specification_sheet" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."variation" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."variation_configuration" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."variation_documents" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."variation_image" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for ADMIN and MANAGER when authenticated" ON "public"."variation_specification_sheet" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable delete for authenticated users that are ADMIN or MANAGER" ON "public"."users" FOR DELETE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and ADMINISTRATOR when authenticated" ON "public"."product_ignition" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."attribute_value" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."attributes" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."category" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."collection" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."color" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."company" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."dealer_price" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."distributor_price" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."gas" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."group_price" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."ignition" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."image" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."internet_price" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."landscape_price" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."map_price" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."master_distributor_price" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."material" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."msrp_price" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."product" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."product_attribute" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."product_color" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."product_configuration" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."product_documents" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."product_gas" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."product_image" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."product_material" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."product_specification_sheet" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."shape" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."specification_sheet" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."variation" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."variation_configuration" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."variation_documents" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."variation_image" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIN and MANAGER when authenticated" ON "public"."variation_specification_sheet" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for ADMIn and MANAGER when authenticated" ON "public"."documents" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable insert for authenticated users that are ADMIN or MANAGER" ON "public"."users" FOR INSERT TO "authenticated" WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable select for authenticated " ON "public"."users" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authentciated" ON "public"."attribute_value" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."attributes" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."category" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."collection" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."color" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."company" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."dealer_price" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."distributor_price" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."documents" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."gas" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."group_price" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."ignition" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."image" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."internet_price" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."landscape_price" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."map_price" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."master_distributor_price" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."material" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."msrp_price" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."product" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."product_attribute" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."product_color" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."product_configuration" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."product_documents" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."product_gas" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."product_ignition" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."product_image" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."product_material" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."product_specification_sheet" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."shape" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."specification_sheet" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."variation" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."variation_configuration" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."variation_documents" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."variation_image" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable select when authenticated" ON "public"."variation_specification_sheet" FOR SELECT TO "authenticated" USING (true);

CREATE POLICY "Enable update for ADMIN and ADMINISTRATOR when authenticated" ON "public"."product_ignition" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authentiated" ON "public"."variation_configuration" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."attribute_value" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."attributes" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."category" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."collection" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."color" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."company" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."dealer_price" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."distributor_price" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."documents" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."gas" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."group_price" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."ignition" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."image" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."internet_price" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."landscape_price" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."map_price" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."master_distributor_price" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."material" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."msrp_price" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."product" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."product_attribute" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."product_color" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."product_configuration" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."product_documents" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."product_gas" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."product_image" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."product_material" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."product_specification_sheet" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."shape" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."specification_sheet" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."variation" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."variation_documents" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."variation_image" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for ADMIN and MANAGER when authenticated" ON "public"."variation_specification_sheet" FOR UPDATE TO "authenticated" USING (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role"))) WITH CHECK (("public"."check_user_role"("auth"."uid"(), 'ADMIN'::"public"."user_role") OR "public"."check_user_role"("auth"."uid"(), 'MANAGER'::"public"."user_role")));

CREATE POLICY "Enable update for authenticated users that are ADMIN or MANAGER" ON "public"."users" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);

ALTER TABLE "public"."attribute_value" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."attributes" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."category" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."collection" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."color" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."company" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."dealer_price" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."distributor_price" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."documents" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."gas" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."group_price" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."ignition" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."image" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."internet_price" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."landscape_price" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."map_price" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."master_distributor_price" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."material" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."msrp_price" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."product" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."product_attribute" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."product_color" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."product_configuration" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."product_documents" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."product_gas" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."product_ignition" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."product_image" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."product_material" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."product_specification_sheet" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."shape" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."specification_sheet" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."users" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."variation" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."variation_configuration" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."variation_documents" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."variation_image" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."variation_specification_sheet" ENABLE ROW LEVEL SECURITY;

REVOKE USAGE ON SCHEMA "public" FROM PUBLIC;
GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

GRANT ALL ON FUNCTION "public"."gtrgm_in"("cstring") TO "postgres";
GRANT ALL ON FUNCTION "public"."gtrgm_in"("cstring") TO "anon";
GRANT ALL ON FUNCTION "public"."gtrgm_in"("cstring") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gtrgm_in"("cstring") TO "service_role";

GRANT ALL ON FUNCTION "public"."gtrgm_out"("public"."gtrgm") TO "postgres";
GRANT ALL ON FUNCTION "public"."gtrgm_out"("public"."gtrgm") TO "anon";
GRANT ALL ON FUNCTION "public"."gtrgm_out"("public"."gtrgm") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gtrgm_out"("public"."gtrgm") TO "service_role";

GRANT ALL ON FUNCTION "public"."auto_confirm_account"() TO "anon";
GRANT ALL ON FUNCTION "public"."auto_confirm_account"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."auto_confirm_account"() TO "service_role";

GRANT ALL ON FUNCTION "public"."check_user_role"("user_id" "uuid", "role" "public"."user_role") TO "anon";
GRANT ALL ON FUNCTION "public"."check_user_role"("user_id" "uuid", "role" "public"."user_role") TO "authenticated";
GRANT ALL ON FUNCTION "public"."check_user_role"("user_id" "uuid", "role" "public"."user_role") TO "service_role";

GRANT ALL ON FUNCTION "public"."create_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."create_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."create_user"() TO "service_role";

GRANT ALL ON FUNCTION "public"."delete_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."delete_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."delete_user"() TO "service_role";

GRANT ALL ON FUNCTION "public"."filter_all_products"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[]) TO "anon";
GRANT ALL ON FUNCTION "public"."filter_all_products"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."filter_all_products"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[]) TO "service_role";

GRANT ALL ON FUNCTION "public"."filter_all_products_or_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[]) TO "anon";
GRANT ALL ON FUNCTION "public"."filter_all_products_or_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."filter_all_products_or_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[]) TO "service_role";

GRANT ALL ON FUNCTION "public"."filter_all_products_or_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[]) TO "anon";
GRANT ALL ON FUNCTION "public"."filter_all_products_or_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."filter_all_products_or_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[]) TO "service_role";

GRANT ALL ON FUNCTION "public"."filter_all_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[]) TO "anon";
GRANT ALL ON FUNCTION "public"."filter_all_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."filter_all_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[]) TO "service_role";

GRANT ALL ON FUNCTION "public"."filter_all_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[], "parentid" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."filter_all_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[], "parentid" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."filter_all_variations"("sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "value_id" integer[], "attribute_id" integer[], "parentid" integer) TO "service_role";

GRANT ALL ON FUNCTION "public"."get_category_tree"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_category_tree"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_category_tree"() TO "service_role";

GRANT ALL ON FUNCTION "public"."get_category_tree_search"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."get_category_tree_search"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_category_tree_search"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "service_role";

GRANT ALL ON FUNCTION "public"."get_category_tree_search_test"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_category_tree_search_test"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_category_tree_search_test"() TO "service_role";

GRANT ALL ON FUNCTION "public"."get_nested_categories"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_nested_categories"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_nested_categories"() TO "service_role";

GRANT ALL ON FUNCTION "public"."gin_extract_query_trgm"("text", "internal", smallint, "internal", "internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gin_extract_query_trgm"("text", "internal", smallint, "internal", "internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gin_extract_query_trgm"("text", "internal", smallint, "internal", "internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gin_extract_query_trgm"("text", "internal", smallint, "internal", "internal", "internal", "internal") TO "service_role";

GRANT ALL ON FUNCTION "public"."gin_extract_value_trgm"("text", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gin_extract_value_trgm"("text", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gin_extract_value_trgm"("text", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gin_extract_value_trgm"("text", "internal") TO "service_role";

GRANT ALL ON FUNCTION "public"."gin_trgm_consistent"("internal", smallint, "text", integer, "internal", "internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gin_trgm_consistent"("internal", smallint, "text", integer, "internal", "internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gin_trgm_consistent"("internal", smallint, "text", integer, "internal", "internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gin_trgm_consistent"("internal", smallint, "text", integer, "internal", "internal", "internal", "internal") TO "service_role";

GRANT ALL ON FUNCTION "public"."gin_trgm_triconsistent"("internal", smallint, "text", integer, "internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gin_trgm_triconsistent"("internal", smallint, "text", integer, "internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gin_trgm_triconsistent"("internal", smallint, "text", integer, "internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gin_trgm_triconsistent"("internal", smallint, "text", integer, "internal", "internal", "internal") TO "service_role";

GRANT ALL ON FUNCTION "public"."gtrgm_compress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gtrgm_compress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gtrgm_compress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gtrgm_compress"("internal") TO "service_role";

GRANT ALL ON FUNCTION "public"."gtrgm_consistent"("internal", "text", smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gtrgm_consistent"("internal", "text", smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gtrgm_consistent"("internal", "text", smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gtrgm_consistent"("internal", "text", smallint, "oid", "internal") TO "service_role";

GRANT ALL ON FUNCTION "public"."gtrgm_decompress"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gtrgm_decompress"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gtrgm_decompress"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gtrgm_decompress"("internal") TO "service_role";

GRANT ALL ON FUNCTION "public"."gtrgm_distance"("internal", "text", smallint, "oid", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gtrgm_distance"("internal", "text", smallint, "oid", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gtrgm_distance"("internal", "text", smallint, "oid", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gtrgm_distance"("internal", "text", smallint, "oid", "internal") TO "service_role";

GRANT ALL ON FUNCTION "public"."gtrgm_options"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gtrgm_options"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gtrgm_options"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gtrgm_options"("internal") TO "service_role";

GRANT ALL ON FUNCTION "public"."gtrgm_penalty"("internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gtrgm_penalty"("internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gtrgm_penalty"("internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gtrgm_penalty"("internal", "internal", "internal") TO "service_role";

GRANT ALL ON FUNCTION "public"."gtrgm_picksplit"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gtrgm_picksplit"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gtrgm_picksplit"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gtrgm_picksplit"("internal", "internal") TO "service_role";

GRANT ALL ON FUNCTION "public"."gtrgm_same"("public"."gtrgm", "public"."gtrgm", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gtrgm_same"("public"."gtrgm", "public"."gtrgm", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gtrgm_same"("public"."gtrgm", "public"."gtrgm", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gtrgm_same"("public"."gtrgm", "public"."gtrgm", "internal") TO "service_role";

GRANT ALL ON FUNCTION "public"."gtrgm_union"("internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."gtrgm_union"("internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."gtrgm_union"("internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."gtrgm_union"("internal", "internal") TO "service_role";

GRANT ALL ON FUNCTION "public"."json_tree"() TO "anon";
GRANT ALL ON FUNCTION "public"."json_tree"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."json_tree"() TO "service_role";

GRANT ALL ON FUNCTION "public"."search_attributes"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."search_attributes"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."search_attributes"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "service_role";

GRANT ALL ON FUNCTION "public"."search_categories"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."search_categories"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."search_categories"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "service_role";

GRANT ALL ON FUNCTION "public"."search_collections"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."search_collections"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."search_collections"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "service_role";

GRANT ALL ON FUNCTION "public"."search_colors"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."search_colors"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."search_colors"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "service_role";

GRANT ALL ON FUNCTION "public"."search_gas_types"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."search_gas_types"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."search_gas_types"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "service_role";

GRANT ALL ON FUNCTION "public"."search_ignition_types"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."search_ignition_types"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."search_ignition_types"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "service_role";

GRANT ALL ON FUNCTION "public"."search_materials"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."search_materials"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."search_materials"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "service_role";

GRANT ALL ON FUNCTION "public"."search_parent_products"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."search_parent_products"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."search_parent_products"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "service_role";

GRANT ALL ON FUNCTION "public"."search_products"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, VARIADIC "value_id" integer[]) TO "anon";
GRANT ALL ON FUNCTION "public"."search_products"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, VARIADIC "value_id" integer[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."search_products"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, VARIADIC "value_id" integer[]) TO "service_role";

GRANT ALL ON FUNCTION "public"."search_products_or_variations"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, VARIADIC "value_id" integer[]) TO "anon";
GRANT ALL ON FUNCTION "public"."search_products_or_variations"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, VARIADIC "value_id" integer[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."search_products_or_variations"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, VARIADIC "value_id" integer[]) TO "service_role";

GRANT ALL ON FUNCTION "public"."search_shapes"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."search_shapes"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."search_shapes"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "service_role";

GRANT ALL ON FUNCTION "public"."search_users"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."search_users"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."search_users"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer) TO "service_role";

GRANT ALL ON FUNCTION "public"."search_variations"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, VARIADIC "value_id" integer[]) TO "anon";
GRANT ALL ON FUNCTION "public"."search_variations"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, VARIADIC "value_id" integer[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."search_variations"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, VARIADIC "value_id" integer[]) TO "service_role";

GRANT ALL ON FUNCTION "public"."search_variations"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "parentid" integer, VARIADIC "value_id" integer[]) TO "anon";
GRANT ALL ON FUNCTION "public"."search_variations"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "parentid" integer, VARIADIC "value_id" integer[]) TO "authenticated";
GRANT ALL ON FUNCTION "public"."search_variations"("search_term" character varying, "sort_term" character varying, "sort_order" character varying, "from_limit" integer, "to_limit" integer, "parentid" integer, VARIADIC "value_id" integer[]) TO "service_role";

GRANT ALL ON FUNCTION "public"."set_distributor_price"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_distributor_price"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_distributor_price"() TO "service_role";

GRANT ALL ON FUNCTION "public"."set_group_price"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_group_price"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_group_price"() TO "service_role";

GRANT ALL ON FUNCTION "public"."set_internet_price"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_internet_price"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_internet_price"() TO "service_role";

GRANT ALL ON FUNCTION "public"."set_landscape_price"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_landscape_price"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_landscape_price"() TO "service_role";

GRANT ALL ON FUNCTION "public"."set_limit"(real) TO "postgres";
GRANT ALL ON FUNCTION "public"."set_limit"(real) TO "anon";
GRANT ALL ON FUNCTION "public"."set_limit"(real) TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_limit"(real) TO "service_role";

GRANT ALL ON FUNCTION "public"."set_map_price"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_map_price"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_map_price"() TO "service_role";

GRANT ALL ON FUNCTION "public"."set_master_distributor_price"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_master_distributor_price"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_master_distributor_price"() TO "service_role";

GRANT ALL ON FUNCTION "public"."set_msrp_price"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_msrp_price"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_msrp_price"() TO "service_role";

GRANT ALL ON FUNCTION "public"."set_slug_from_name"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_slug_from_name"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_slug_from_name"() TO "service_role";

GRANT ALL ON FUNCTION "public"."set_slug_from_value"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_slug_from_value"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_slug_from_value"() TO "service_role";

GRANT ALL ON FUNCTION "public"."show_limit"() TO "postgres";
GRANT ALL ON FUNCTION "public"."show_limit"() TO "anon";
GRANT ALL ON FUNCTION "public"."show_limit"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."show_limit"() TO "service_role";

GRANT ALL ON FUNCTION "public"."show_trgm"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."show_trgm"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."show_trgm"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."show_trgm"("text") TO "service_role";

GRANT ALL ON FUNCTION "public"."similarity"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."similarity"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."similarity"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."similarity"("text", "text") TO "service_role";

GRANT ALL ON FUNCTION "public"."similarity_dist"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."similarity_dist"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."similarity_dist"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."similarity_dist"("text", "text") TO "service_role";

GRANT ALL ON FUNCTION "public"."similarity_op"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."similarity_op"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."similarity_op"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."similarity_op"("text", "text") TO "service_role";

GRANT ALL ON FUNCTION "public"."slugify"("value" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."slugify"("value" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."slugify"("value" "text") TO "service_role";

GRANT ALL ON FUNCTION "public"."strict_word_similarity"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."strict_word_similarity"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."strict_word_similarity"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."strict_word_similarity"("text", "text") TO "service_role";

GRANT ALL ON FUNCTION "public"."strict_word_similarity_commutator_op"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."strict_word_similarity_commutator_op"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."strict_word_similarity_commutator_op"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."strict_word_similarity_commutator_op"("text", "text") TO "service_role";

GRANT ALL ON FUNCTION "public"."strict_word_similarity_dist_commutator_op"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."strict_word_similarity_dist_commutator_op"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."strict_word_similarity_dist_commutator_op"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."strict_word_similarity_dist_commutator_op"("text", "text") TO "service_role";

GRANT ALL ON FUNCTION "public"."strict_word_similarity_dist_op"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."strict_word_similarity_dist_op"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."strict_word_similarity_dist_op"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."strict_word_similarity_dist_op"("text", "text") TO "service_role";

GRANT ALL ON FUNCTION "public"."strict_word_similarity_op"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."strict_word_similarity_op"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."strict_word_similarity_op"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."strict_word_similarity_op"("text", "text") TO "service_role";

GRANT ALL ON FUNCTION "public"."trigger_set_updated_at_timestamp"() TO "anon";
GRANT ALL ON FUNCTION "public"."trigger_set_updated_at_timestamp"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."trigger_set_updated_at_timestamp"() TO "service_role";

GRANT ALL ON FUNCTION "public"."trigger_set_updated_by"() TO "anon";
GRANT ALL ON FUNCTION "public"."trigger_set_updated_by"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."trigger_set_updated_by"() TO "service_role";

GRANT ALL ON FUNCTION "public"."unaccent"("text") TO "postgres";
GRANT ALL ON FUNCTION "public"."unaccent"("text") TO "anon";
GRANT ALL ON FUNCTION "public"."unaccent"("text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."unaccent"("text") TO "service_role";

GRANT ALL ON FUNCTION "public"."unaccent"("regdictionary", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."unaccent"("regdictionary", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."unaccent"("regdictionary", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."unaccent"("regdictionary", "text") TO "service_role";

GRANT ALL ON FUNCTION "public"."unaccent_init"("internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."unaccent_init"("internal") TO "anon";
GRANT ALL ON FUNCTION "public"."unaccent_init"("internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."unaccent_init"("internal") TO "service_role";

GRANT ALL ON FUNCTION "public"."unaccent_lexize"("internal", "internal", "internal", "internal") TO "postgres";
GRANT ALL ON FUNCTION "public"."unaccent_lexize"("internal", "internal", "internal", "internal") TO "anon";
GRANT ALL ON FUNCTION "public"."unaccent_lexize"("internal", "internal", "internal", "internal") TO "authenticated";
GRANT ALL ON FUNCTION "public"."unaccent_lexize"("internal", "internal", "internal", "internal") TO "service_role";

GRANT ALL ON FUNCTION "public"."update_users_meta"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_users_meta"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_users_meta"() TO "service_role";

GRANT ALL ON FUNCTION "public"."validate_product_or_variation"() TO "anon";
GRANT ALL ON FUNCTION "public"."validate_product_or_variation"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."validate_product_or_variation"() TO "service_role";

GRANT ALL ON FUNCTION "public"."word_similarity"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."word_similarity"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."word_similarity"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."word_similarity"("text", "text") TO "service_role";

GRANT ALL ON FUNCTION "public"."word_similarity_commutator_op"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."word_similarity_commutator_op"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."word_similarity_commutator_op"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."word_similarity_commutator_op"("text", "text") TO "service_role";

GRANT ALL ON FUNCTION "public"."word_similarity_dist_commutator_op"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."word_similarity_dist_commutator_op"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."word_similarity_dist_commutator_op"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."word_similarity_dist_commutator_op"("text", "text") TO "service_role";

GRANT ALL ON FUNCTION "public"."word_similarity_dist_op"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."word_similarity_dist_op"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."word_similarity_dist_op"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."word_similarity_dist_op"("text", "text") TO "service_role";

GRANT ALL ON FUNCTION "public"."word_similarity_op"("text", "text") TO "postgres";
GRANT ALL ON FUNCTION "public"."word_similarity_op"("text", "text") TO "anon";
GRANT ALL ON FUNCTION "public"."word_similarity_op"("text", "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."word_similarity_op"("text", "text") TO "service_role";

GRANT ALL ON TABLE "public"."attribute_value" TO "anon";
GRANT ALL ON TABLE "public"."attribute_value" TO "authenticated";
GRANT ALL ON TABLE "public"."attribute_value" TO "service_role";

GRANT ALL ON SEQUENCE "public"."attribute_value_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."attribute_value_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."attribute_value_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."attributes" TO "anon";
GRANT ALL ON TABLE "public"."attributes" TO "authenticated";
GRANT ALL ON TABLE "public"."attributes" TO "service_role";

GRANT ALL ON SEQUENCE "public"."attributes_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."attributes_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."attributes_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."category" TO "anon";
GRANT ALL ON TABLE "public"."category" TO "authenticated";
GRANT ALL ON TABLE "public"."category" TO "service_role";

GRANT ALL ON SEQUENCE "public"."category_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."category_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."category_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."collection" TO "anon";
GRANT ALL ON TABLE "public"."collection" TO "authenticated";
GRANT ALL ON TABLE "public"."collection" TO "service_role";

GRANT ALL ON SEQUENCE "public"."collection_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."collection_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."collection_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."color" TO "anon";
GRANT ALL ON TABLE "public"."color" TO "authenticated";
GRANT ALL ON TABLE "public"."color" TO "service_role";

GRANT ALL ON SEQUENCE "public"."color_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."color_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."color_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."company" TO "anon";
GRANT ALL ON TABLE "public"."company" TO "authenticated";
GRANT ALL ON TABLE "public"."company" TO "service_role";

GRANT ALL ON SEQUENCE "public"."company_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."company_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."company_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."dealer_price" TO "anon";
GRANT ALL ON TABLE "public"."dealer_price" TO "authenticated";
GRANT ALL ON TABLE "public"."dealer_price" TO "service_role";

GRANT ALL ON SEQUENCE "public"."dealer_price_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."dealer_price_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."dealer_price_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."distributor_price" TO "anon";
GRANT ALL ON TABLE "public"."distributor_price" TO "authenticated";
GRANT ALL ON TABLE "public"."distributor_price" TO "service_role";

GRANT ALL ON SEQUENCE "public"."distributor_price_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."distributor_price_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."distributor_price_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."documents" TO "anon";
GRANT ALL ON TABLE "public"."documents" TO "authenticated";
GRANT ALL ON TABLE "public"."documents" TO "service_role";

GRANT ALL ON SEQUENCE "public"."documents_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."documents_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."documents_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."gas" TO "anon";
GRANT ALL ON TABLE "public"."gas" TO "authenticated";
GRANT ALL ON TABLE "public"."gas" TO "service_role";

GRANT ALL ON SEQUENCE "public"."gas_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."gas_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."gas_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."group_price" TO "anon";
GRANT ALL ON TABLE "public"."group_price" TO "authenticated";
GRANT ALL ON TABLE "public"."group_price" TO "service_role";

GRANT ALL ON SEQUENCE "public"."group_price_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."group_price_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."group_price_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."ignition" TO "anon";
GRANT ALL ON TABLE "public"."ignition" TO "authenticated";
GRANT ALL ON TABLE "public"."ignition" TO "service_role";

GRANT ALL ON SEQUENCE "public"."ignition_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."ignition_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."ignition_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."image" TO "anon";
GRANT ALL ON TABLE "public"."image" TO "authenticated";
GRANT ALL ON TABLE "public"."image" TO "service_role";

GRANT ALL ON SEQUENCE "public"."image_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."image_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."image_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."internet_price" TO "anon";
GRANT ALL ON TABLE "public"."internet_price" TO "authenticated";
GRANT ALL ON TABLE "public"."internet_price" TO "service_role";

GRANT ALL ON SEQUENCE "public"."internet_price_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."internet_price_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."internet_price_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."landscape_price" TO "anon";
GRANT ALL ON TABLE "public"."landscape_price" TO "authenticated";
GRANT ALL ON TABLE "public"."landscape_price" TO "service_role";

GRANT ALL ON SEQUENCE "public"."landscape_price_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."landscape_price_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."landscape_price_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."map_price" TO "anon";
GRANT ALL ON TABLE "public"."map_price" TO "authenticated";
GRANT ALL ON TABLE "public"."map_price" TO "service_role";

GRANT ALL ON SEQUENCE "public"."map_price_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."map_price_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."map_price_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."master_distributor_price" TO "anon";
GRANT ALL ON TABLE "public"."master_distributor_price" TO "authenticated";
GRANT ALL ON TABLE "public"."master_distributor_price" TO "service_role";

GRANT ALL ON SEQUENCE "public"."master_distributor_price_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."master_distributor_price_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."master_distributor_price_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."material" TO "anon";
GRANT ALL ON TABLE "public"."material" TO "authenticated";
GRANT ALL ON TABLE "public"."material" TO "service_role";

GRANT ALL ON SEQUENCE "public"."material_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."material_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."material_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."msrp_price" TO "anon";
GRANT ALL ON TABLE "public"."msrp_price" TO "authenticated";
GRANT ALL ON TABLE "public"."msrp_price" TO "service_role";

GRANT ALL ON SEQUENCE "public"."msrp_price_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."msrp_price_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."msrp_price_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."product" TO "anon";
GRANT ALL ON TABLE "public"."product" TO "authenticated";
GRANT ALL ON TABLE "public"."product" TO "service_role";

GRANT ALL ON TABLE "public"."product_attribute" TO "anon";
GRANT ALL ON TABLE "public"."product_attribute" TO "authenticated";
GRANT ALL ON TABLE "public"."product_attribute" TO "service_role";

GRANT ALL ON SEQUENCE "public"."product_attribute_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."product_attribute_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."product_attribute_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."product_color" TO "anon";
GRANT ALL ON TABLE "public"."product_color" TO "authenticated";
GRANT ALL ON TABLE "public"."product_color" TO "service_role";

GRANT ALL ON TABLE "public"."product_configuration" TO "anon";
GRANT ALL ON TABLE "public"."product_configuration" TO "authenticated";
GRANT ALL ON TABLE "public"."product_configuration" TO "service_role";

GRANT ALL ON TABLE "public"."product_documents" TO "anon";
GRANT ALL ON TABLE "public"."product_documents" TO "authenticated";
GRANT ALL ON TABLE "public"."product_documents" TO "service_role";

GRANT ALL ON TABLE "public"."product_gas" TO "anon";
GRANT ALL ON TABLE "public"."product_gas" TO "authenticated";
GRANT ALL ON TABLE "public"."product_gas" TO "service_role";

GRANT ALL ON SEQUENCE "public"."product_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."product_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."product_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."product_ignition" TO "anon";
GRANT ALL ON TABLE "public"."product_ignition" TO "authenticated";
GRANT ALL ON TABLE "public"."product_ignition" TO "service_role";

GRANT ALL ON TABLE "public"."product_image" TO "anon";
GRANT ALL ON TABLE "public"."product_image" TO "authenticated";
GRANT ALL ON TABLE "public"."product_image" TO "service_role";

GRANT ALL ON TABLE "public"."product_material" TO "anon";
GRANT ALL ON TABLE "public"."product_material" TO "authenticated";
GRANT ALL ON TABLE "public"."product_material" TO "service_role";

GRANT ALL ON TABLE "public"."product_specification_sheet" TO "anon";
GRANT ALL ON TABLE "public"."product_specification_sheet" TO "authenticated";
GRANT ALL ON TABLE "public"."product_specification_sheet" TO "service_role";

GRANT ALL ON SEQUENCE "public"."product_specification_sheet_product_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."product_specification_sheet_product_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."product_specification_sheet_product_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."shape" TO "anon";
GRANT ALL ON TABLE "public"."shape" TO "authenticated";
GRANT ALL ON TABLE "public"."shape" TO "service_role";

GRANT ALL ON SEQUENCE "public"."shape_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."shape_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."shape_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."specification_sheet" TO "anon";
GRANT ALL ON TABLE "public"."specification_sheet" TO "authenticated";
GRANT ALL ON TABLE "public"."specification_sheet" TO "service_role";

GRANT ALL ON SEQUENCE "public"."specification_sheet_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."specification_sheet_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."specification_sheet_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."users" TO "anon";
GRANT ALL ON TABLE "public"."users" TO "authenticated";
GRANT ALL ON TABLE "public"."users" TO "service_role";

GRANT ALL ON TABLE "public"."variation" TO "anon";
GRANT ALL ON TABLE "public"."variation" TO "authenticated";
GRANT ALL ON TABLE "public"."variation" TO "service_role";

GRANT ALL ON TABLE "public"."variation_configuration" TO "anon";
GRANT ALL ON TABLE "public"."variation_configuration" TO "authenticated";
GRANT ALL ON TABLE "public"."variation_configuration" TO "service_role";

GRANT ALL ON TABLE "public"."variation_documents" TO "anon";
GRANT ALL ON TABLE "public"."variation_documents" TO "authenticated";
GRANT ALL ON TABLE "public"."variation_documents" TO "service_role";

GRANT ALL ON SEQUENCE "public"."variation_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."variation_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."variation_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."variation_image" TO "anon";
GRANT ALL ON TABLE "public"."variation_image" TO "authenticated";
GRANT ALL ON TABLE "public"."variation_image" TO "service_role";

GRANT ALL ON TABLE "public"."variation_specification_sheet" TO "anon";
GRANT ALL ON TABLE "public"."variation_specification_sheet" TO "authenticated";
GRANT ALL ON TABLE "public"."variation_specification_sheet" TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";

RESET ALL;
