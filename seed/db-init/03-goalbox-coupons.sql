-- GoalBox coupon seeds
-- Runs after EverShop migrations create the coupon table.
-- Uses an event trigger approach identical to 01-goalbox-product-image-trigger.sql
-- so that coupons are (re-)inserted whenever the coupon table is created.

-- ── Helper function ──────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION goalbox_seed_coupons()
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
  -- GOALBOX10 : 10% off first order (no minimum, expires 2027-12-31)
  INSERT INTO coupon (
    status, description, discount_amount, free_shipping,
    discount_type, coupon,
    max_uses_time_per_customer,
    condition, user_condition,
    start_date, end_date
  ) VALUES (
    TRUE,
    '10% off your first order — welcome to GoalBox!',
    10,
    FALSE,
    'percentage_discount_to_entire_order',
    'GOALBOX10',
    1,
    '{"order_total": null, "order_qty": null, "required_products": []}'::jsonb,
    '{"groups": [], "emails": [], "purchased": null}'::jsonb,
    '2026-01-01 00:00:00+00',
    '2027-12-31 23:59:59+00'
  )
  ON CONFLICT (coupon) DO NOTHING;

  -- REORDER5 : 5% off + free shipping for returning customers (reorder within 14 days)
  INSERT INTO coupon (
    status, description, discount_amount, free_shipping,
    discount_type, coupon,
    condition, user_condition,
    start_date, end_date
  ) VALUES (
    TRUE,
    '5% loyalty discount + free shipping for returning GoalBox customers',
    5,
    TRUE,
    'percentage_discount_to_entire_order',
    'REORDER5',
    '{"order_total": null, "order_qty": null, "required_products": []}'::jsonb,
    '{"groups": [], "emails": [], "purchased": null}'::jsonb,
    '2026-01-01 00:00:00+00',
    '2027-12-31 23:59:59+00'
  )
  ON CONFLICT (coupon) DO NOTHING;

  -- FREESHIP200 : Free shipping on orders >= 200,000 VND
  INSERT INTO coupon (
    status, description, discount_amount, free_shipping,
    discount_type, coupon,
    condition, user_condition,
    start_date, end_date
  ) VALUES (
    TRUE,
    'Free shipping on orders 200,000 VND and above',
    0,
    TRUE,
    'percentage_discount_to_entire_order',
    'FREESHIP200',
    '{"order_total": 200000, "order_qty": null, "required_products": []}'::jsonb,
    '{"groups": [], "emails": [], "purchased": null}'::jsonb,
    '2026-01-01 00:00:00+00',
    '2027-12-31 23:59:59+00'
  )
  ON CONFLICT (coupon) DO NOTHING;
END;
$$;

-- ── Attach via event trigger (fires on CREATE TABLE) ─────────────────────────
CREATE OR REPLACE FUNCTION goalbox_attach_coupon_seed_trigger()
RETURNS event_trigger
LANGUAGE plpgsql
AS $$
DECLARE
  cmd RECORD;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.object_type = 'table' AND cmd.object_identity = 'public.coupon' THEN
      PERFORM goalbox_seed_coupons();
    END IF;
  END LOOP;
END;
$$;

DROP EVENT TRIGGER IF EXISTS trg_goalbox_seed_coupons;

CREATE EVENT TRIGGER trg_goalbox_seed_coupons
ON ddl_command_end
WHEN TAG IN ('CREATE TABLE')
EXECUTE FUNCTION goalbox_attach_coupon_seed_trigger();

-- ── Also run immediately if coupon table already exists ──────────────────────
DO $$
BEGIN
  IF to_regclass('public.coupon') IS NOT NULL THEN
    PERFORM goalbox_seed_coupons();
  END IF;
END;
$$;
