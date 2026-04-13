-- GoalBox: shipping zone for Vietnam + clean up default EverShop categories
-- Runs after EverShop migrations via docker-entrypoint-initdb.d (alphabetical order).
-- Uses event trigger pattern to handle cases where tables don't exist yet.

-- ── 1. Remove default EverShop demo categories (Men, Women, Kids) ──────────
CREATE OR REPLACE FUNCTION goalbox_cleanup_default_categories()
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
  DELETE FROM category_description
  WHERE url_key IN ('men', 'women', 'kids');

  DELETE FROM category
  WHERE category_id IN (
    SELECT category_description_category_id
    FROM category_description
    WHERE url_key IN ('men', 'women', 'kids')
  );

  -- Safer: cascade-safe delete using a subquery
  DELETE FROM category
  WHERE category_id NOT IN (
    SELECT category_description_category_id FROM category_description
  );
END;
$$;

-- ── 2. Seed Vietnam shipping zone ─────────────────────────────────────────
CREATE OR REPLACE FUNCTION goalbox_seed_shipping()
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
  v_zone_id INT;
  v_method_id INT;
BEGIN
  -- Insert shipping zone for Vietnam (skip if already exists)
  IF NOT EXISTS (SELECT 1 FROM shipping_zone WHERE name = 'Ho Chi Minh City') THEN
    INSERT INTO shipping_zone (name, country)
    VALUES ('Ho Chi Minh City', 'VN')
    RETURNING shipping_zone_id INTO v_zone_id;

    -- Ho Chi Minh City only
    INSERT INTO shipping_zone_province (zone_id, province) VALUES
      (v_zone_id, 'VN-SG')
    ON CONFLICT (province) DO NOTHING;

    -- Create Standard Delivery shipping method
    INSERT INTO shipping_method (name)
    VALUES ('Standard Delivery')
    ON CONFLICT (name) DO NOTHING;

    SELECT shipping_method_id INTO v_method_id
    FROM shipping_method WHERE name = 'Standard Delivery';

    -- Link method to Vietnam zone: flat rate 20,000 VND
    INSERT INTO shipping_zone_method (method_id, zone_id, is_enabled, cost)
    VALUES (v_method_id, v_zone_id, TRUE, 20000)
    ON CONFLICT (zone_id, method_id) DO NOTHING;

    -- Create Express Delivery shipping method
    INSERT INTO shipping_method (name)
    VALUES ('Express Delivery')
    ON CONFLICT (name) DO NOTHING;

    SELECT shipping_method_id INTO v_method_id
    FROM shipping_method WHERE name = 'Express Delivery';

    -- Link express method: flat rate 35,000 VND
    INSERT INTO shipping_zone_method (method_id, zone_id, is_enabled, cost)
    VALUES (v_method_id, v_zone_id, TRUE, 35000)
    ON CONFLICT (zone_id, method_id) DO NOTHING;
  END IF;
END;
$$;

-- ── Event trigger: fires on every CREATE TABLE ──────────────────────────────
CREATE OR REPLACE FUNCTION goalbox_setup_on_table_create()
RETURNS event_trigger
LANGUAGE plpgsql
AS $$
DECLARE
  cmd RECORD;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    -- Shipping zone: seed when shipping_zone_method table is ready
    IF cmd.object_type = 'table' AND cmd.object_identity = 'public.shipping_zone_method' THEN
      PERFORM goalbox_seed_shipping();
    END IF;
    -- Categories cleanup: seed when category_description table is ready
    -- (will be called by npm run seed -- --categories after this)
    IF cmd.object_type = 'table' AND cmd.object_identity = 'public.category_description' THEN
      PERFORM goalbox_cleanup_default_categories();
    END IF;
  END LOOP;
END;
$$;

DROP EVENT TRIGGER IF EXISTS trg_goalbox_setup_on_table_create;

CREATE EVENT TRIGGER trg_goalbox_setup_on_table_create
ON ddl_command_end
WHEN TAG IN ('CREATE TABLE')
EXECUTE FUNCTION goalbox_setup_on_table_create();

-- ── Run immediately if tables already exist ─────────────────────────────────
DO $$
BEGIN
  IF to_regclass('public.shipping_zone_method') IS NOT NULL THEN
    PERFORM goalbox_seed_shipping();
  END IF;

  IF to_regclass('public.category_description') IS NOT NULL THEN
    PERFORM goalbox_cleanup_default_categories();
  END IF;
END;
$$;
