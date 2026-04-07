INSERT INTO setting (name, value, is_json)
VALUES ('storeName', 'GoalBox', false)
ON CONFLICT (name) DO UPDATE SET value = EXCLUDED.value, is_json = EXCLUDED.is_json;
