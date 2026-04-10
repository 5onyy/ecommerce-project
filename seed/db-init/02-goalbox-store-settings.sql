DO $$
BEGIN
	IF to_regclass('public.setting') IS NOT NULL THEN
		INSERT INTO setting (name, value, is_json)
		VALUES ('storeName', 'GoalBox', false)
		ON CONFLICT (name) DO UPDATE
			SET value = EXCLUDED.value,
					is_json = EXCLUDED.is_json;
	ELSE
		RAISE NOTICE 'Skipping storeName seed in db-init: public.setting is not available yet.';
	END IF;
END $$;
