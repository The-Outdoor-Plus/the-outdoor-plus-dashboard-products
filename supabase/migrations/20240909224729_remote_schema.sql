set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.auto_confirm_account()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  NEW.email_confirmed_at = NOW();
  New.confirmed_at = NOW();
  RETURN NEW;
END $function$
;

CREATE OR REPLACE FUNCTION public.check_user_role(user_id uuid, role user_role)
 RETURNS boolean
 LANGUAGE sql
 SECURITY DEFINER
AS $function$
  SELECT EXISTS (SELECT users.id
  FROM users
  WHERE ((users.id = $1) AND ($2 = users.role)))
$function$
;

CREATE OR REPLACE FUNCTION public.create_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
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
END $function$
;

CREATE OR REPLACE FUNCTION public.delete_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  DELETE FROM auth.users WHERE auth.users.id = OLD.id;
  RETURN OLD;
END $function$
;

CREATE OR REPLACE FUNCTION public.filter_all_products(sort_term character varying, sort_order character varying, from_limit integer, to_limit integer, value_id integer[], attribute_id integer[])
 RETURNS TABLE(id integer, name character varying, sku character varying, enabled boolean, product_type product_type, parent_id text, image_url character varying, count bigint)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.filter_all_products_or_variations(sort_term character varying, sort_order character varying, from_limit integer, to_limit integer, value_id integer[])
 RETURNS TABLE(id integer, name character varying, sku character varying, enabled boolean, product_type product_type, parent_id integer, image_url character varying, count bigint)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.filter_all_products_or_variations(sort_term character varying, sort_order character varying, from_limit integer, to_limit integer, value_id integer[], attribute_id integer[])
 RETURNS TABLE(id integer, name character varying, sku character varying, enabled boolean, product_type product_type, parent_id integer, image_url character varying, count bigint)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.filter_all_variations(sort_term character varying, sort_order character varying, from_limit integer, to_limit integer, value_id integer[], attribute_id integer[])
 RETURNS TABLE(id integer, name character varying, sku character varying, enabled boolean, product_type text, parent_id integer, image_url character varying, count bigint)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.filter_all_variations(sort_term character varying, sort_order character varying, from_limit integer, to_limit integer, value_id integer[], attribute_id integer[], parentid integer)
 RETURNS TABLE(id integer, name character varying, sku character varying, enabled boolean, product_type text, parent_id integer, image_url character varying, count bigint)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.get_category_tree()
 RETURNS SETOF jsonb
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.get_category_tree_search(search_term character varying, sort_term character varying, sort_order character varying, from_limit integer, to_limit integer)
 RETURNS TABLE(category_id integer, category_name character varying, category_slug text, parent_category_id integer, child_categories jsonb, total_count bigint)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.get_category_tree_search_test()
 RETURNS jsonb
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.get_nested_categories()
 RETURNS json
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.json_tree()
 RETURNS jsonb
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.search_attributes(search_term character varying, sort_term character varying, sort_order character varying, from_limit integer, to_limit integer)
 RETURNS TABLE(id integer, name text, slug text, count bigint)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.search_categories(search_term character varying, sort_term character varying, sort_order character varying, from_limit integer, to_limit integer)
 RETURNS TABLE(id integer, name character varying, slug text, parent_id integer, count bigint)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.search_collections(search_term character varying, sort_term character varying, sort_order character varying, from_limit integer, to_limit integer)
 RETURNS TABLE(id integer, name character varying, slug text, count bigint)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.search_colors(search_term character varying, sort_term character varying, sort_order character varying, from_limit integer, to_limit integer)
 RETURNS SETOF json
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.search_gas_types(search_term character varying, sort_term character varying, sort_order character varying, from_limit integer, to_limit integer)
 RETURNS TABLE(id integer, name character varying, slug text, count bigint)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.search_ignition_types(search_term character varying, sort_term character varying, sort_order character varying, from_limit integer, to_limit integer)
 RETURNS TABLE(id integer, name character varying, slug text, count bigint)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.search_materials(search_term character varying, sort_term character varying, sort_order character varying, from_limit integer, to_limit integer)
 RETURNS TABLE(id integer, name character varying, slug text, image_url text, count bigint)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.search_parent_products(search_term character varying, sort_term character varying, sort_order character varying, from_limit integer, to_limit integer)
 RETURNS TABLE(id integer, name character varying, sku character varying, product_type product_type, enabled boolean, published boolean, collection character varying, category character varying, material character varying, count bigint)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.search_products(search_term character varying, sort_term character varying, sort_order character varying, from_limit integer, to_limit integer, VARIADIC value_id integer[])
 RETURNS TABLE(id integer, name character varying, sku character varying, enabled boolean, product_type product_type, parent_id text, image_url character varying, count bigint)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.search_products_or_variations(search_term character varying, sort_term character varying, sort_order character varying, from_limit integer, to_limit integer, VARIADIC value_id integer[])
 RETURNS TABLE(id integer, name character varying, sku character varying, enabled boolean, product_type product_type, parent_id integer, image_url character varying, count bigint)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.search_shapes(search_term character varying, sort_term character varying, sort_order character varying, from_limit integer, to_limit integer)
 RETURNS TABLE(id integer, name character varying, slug text, count bigint)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.search_users(search_term character varying, sort_term character varying, sort_order character varying, from_limit integer, to_limit integer)
 RETURNS TABLE(id uuid, first_name character varying, email character varying, last_name character varying, role user_role, company text, count bigint)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.search_variations(search_term character varying, sort_term character varying, sort_order character varying, from_limit integer, to_limit integer, VARIADIC value_id integer[])
 RETURNS TABLE(id integer, name character varying, sku character varying, enabled boolean, product_type text, parent_id integer, image_url character varying, count bigint)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.search_variations(search_term character varying, sort_term character varying, sort_order character varying, from_limit integer, to_limit integer, parentid integer, VARIADIC value_id integer[])
 RETURNS TABLE(id integer, name character varying, sku character varying, enabled boolean, product_type text, parent_id integer, image_url character varying, count bigint)
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.set_distributor_price()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  NEW.distributor_price := CEIL(NEW.dealer_price * 0.85);
  RETURN NEW;
END $function$
;

CREATE OR REPLACE FUNCTION public.set_group_price()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  NEW.group_price := CEIL(NEW.dealer_price * 0.92);
  RETURN NEW;
END $function$
;

CREATE OR REPLACE FUNCTION public.set_internet_price()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  NEW.internet_price := CEIL(NEW.dealer_price * 1.10);
  RETURN NEW;
END $function$
;

CREATE OR REPLACE FUNCTION public.set_landscape_price()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  NEW.landscape_price := CEIL(NEW.dealer_price * 1.20);
  RETURN NEW;
END $function$
;

CREATE OR REPLACE FUNCTION public.set_map_price()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  NEW.map_price := CEIL(CEIL(NEW.dealer_price * 0.92) * 2);
  RETURN NEW;
END $function$
;

CREATE OR REPLACE FUNCTION public.set_master_distributor_price()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  NEW.master_distributor_price := CEIL(NEW.dealer_price * 0.80);
  RETURN NEW;
END $function$
;

CREATE OR REPLACE FUNCTION public.set_msrp_price()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  NEW.msrp_price := CEIL(CEIL(NEW.dealer_price * 0.92) * 2.2);
  RETURN NEW;
END $function$
;

CREATE OR REPLACE FUNCTION public.set_slug_from_name()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  NEW.slug := slugify(NEW.name);
  RETURN NEW;
END $function$
;

CREATE OR REPLACE FUNCTION public.set_slug_from_value()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  NEW.slug := slugify(NEW.value);
  RETURN NEW;
END $function$
;

CREATE OR REPLACE FUNCTION public.slugify(value text)
 RETURNS text
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
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
END $function$
;

CREATE OR REPLACE FUNCTION public.trigger_set_updated_at_timestamp()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END $function$
;

CREATE OR REPLACE FUNCTION public.trigger_set_updated_by()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  NEW.updated_by = auth.uid();
  RETURN NEW;
END $function$
;

CREATE OR REPLACE FUNCTION public.update_users_meta()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  UPDATE auth.users
  SET raw_user_meta_data = 
    jsonb_build_object('last_name', NEW.last_name, 'first_name', NEW.first_name, 'role', NEW.role, 'company', NEW.company)
  WHERE id = NEW.id;
  
  RETURN NEW;
END $function$
;

CREATE OR REPLACE FUNCTION public.validate_product_or_variation()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
  IF NEW.product_id IS NULL AND NEW.variation_id IS NULL THEN
    RAISE EXCEPTION 'At least one of product_id or variant_id must be provided.';
  ELSIF NEW.product_id IS NOT NULL AND NEW.variation_id IS NOT NULL THEN
    RAISE EXCEPTION 'Both product_id and variant_id cannot be provided at the same time.';
  END IF;
  RETURN NEW;
END;
$function$
;


