-- GoalBox store settings: store name + COD payment
-- Uses event trigger pattern so it works whether setting table exists or not.

CREATE OR REPLACE FUNCTION goalbox_seed_settings()
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
  INSERT INTO setting (name, value, is_json)
  VALUES ('storeName', 'GoalBox', false)
  ON CONFLICT (name) DO UPDATE
    SET value = EXCLUDED.value, is_json = EXCLUDED.is_json;

  INSERT INTO setting (name, value, is_json)
  VALUES ('codPaymentStatus', '1', false)
  ON CONFLICT (name) DO UPDATE
    SET value = '1', is_json = false;

  INSERT INTO setting (name, value, is_json)
  VALUES ('codDisplayName', 'Thanh toán khi nhận hàng (COD)', false)
  ON CONFLICT (name) DO UPDATE
    SET value = EXCLUDED.value, is_json = false;
END;
$$;

CREATE OR REPLACE FUNCTION goalbox_settings_on_table_create()
RETURNS event_trigger
LANGUAGE plpgsql
AS $$
DECLARE
  cmd RECORD;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.object_type = 'table' AND cmd.object_identity = 'public.setting' THEN
      PERFORM goalbox_seed_settings();
    END IF;
  END LOOP;
END;
$$;

DROP EVENT TRIGGER IF EXISTS trg_goalbox_settings_on_table_create;

CREATE EVENT TRIGGER trg_goalbox_settings_on_table_create
ON ddl_command_end
WHEN TAG IN ('CREATE TABLE')
EXECUTE FUNCTION goalbox_settings_on_table_create();

-- Run immediately if table already exists
DO $$
BEGIN
  IF to_regclass('public.setting') IS NOT NULL THEN
    PERFORM goalbox_seed_settings();
  END IF;
END;
$$;
