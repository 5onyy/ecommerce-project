CREATE OR REPLACE FUNCTION goalbox_override_product_image()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
  v_sku TEXT;
BEGIN
  SELECT sku INTO v_sku
  FROM product
  WHERE product_id = NEW.product_image_product_id;

  CASE v_sku
    WHEN 'BAL-001' THEN NEW.origin_image := 'catalog/custom/bal-001_chicken-veggie.jpg';
    WHEN 'BAL-002' THEN NEW.origin_image := 'catalog/custom/bal-002_salmon-brown-rice.jpg';
    WHEN 'BAL-003' THEN NEW.origin_image := 'catalog/custom/bal-003_veggie-delight.jpg';
    WHEN 'BAL-004' THEN NEW.origin_image := 'catalog/custom/bal-004_tuna-wholegrain.jpg';
    WHEN 'BAL-005' THEN NEW.origin_image := 'catalog/custom/bal-005_beef-and-veg.jpg';
    WHEN 'BAL-006' THEN NEW.origin_image := 'catalog/custom/bal-006_egg-and-avocado.jpg';
    WHEN 'BAL-007' THEN NEW.origin_image := 'catalog/custom/bal-007_shrimp-quinoa.jpg';
    WHEN 'BAL-008' THEN NEW.origin_image := 'catalog/custom/bal-008_family-bento.jpg';
    WHEN 'FLB-001' THEN NEW.origin_image := 'catalog/custom/flb-001_grilled-chicken-quinoa.jpg';
    WHEN 'FLB-002' THEN NEW.origin_image := 'catalog/custom/flb-002_tuna-avocado-salad.jpg';
    WHEN 'FLB-003' THEN NEW.origin_image := 'catalog/custom/flb-003_tofu-veggie-protein.jpg';
    WHEN 'FLB-004' THEN NEW.origin_image := 'catalog/custom/flb-004_turkey-brown-rice.jpg';
    WHEN 'FLB-005' THEN NEW.origin_image := 'catalog/custom/flb-005_shrimp-zucchini-noodle.jpg';
    WHEN 'FLB-006' THEN NEW.origin_image := 'catalog/custom/flb-006_lean-beef-broccoli.jpg';
    WHEN 'FLB-007' THEN NEW.origin_image := 'catalog/custom/flb-007_egg-white-breakfast.jpg';
    WHEN 'FLB-008' THEN NEW.origin_image := 'catalog/custom/flb-008_salmon-greens.jpg';
    WHEN 'FLB-009' THEN NEW.origin_image := 'catalog/custom/flb-009_chicken-teriyaki-lite.jpg';
    WHEN 'FLB-010' THEN NEW.origin_image := 'catalog/custom/flb-010_mediterranean-chickpea.jpg';
    WHEN 'FLB-011' THEN NEW.origin_image := 'catalog/custom/flb-011_yogurt-berry-fit.jpg';
    WHEN 'FLB-012' THEN NEW.origin_image := 'catalog/custom/flb-012_low-carb-bento.jpg';
    WHEN 'MGB-001' THEN NEW.origin_image := 'catalog/custom/mgb-001_double-chicken-rice.jpg';
    WHEN 'MGB-002' THEN NEW.origin_image := 'catalog/custom/mgb-002_beef-steak-power.jpg';
    WHEN 'MGB-003' THEN NEW.origin_image := 'catalog/custom/mgb-003_salmon-sweet-potato.jpg';
    WHEN 'MGB-004' THEN NEW.origin_image := 'catalog/custom/mgb-004_turkey-pasta-protein.jpg';
    WHEN 'MGB-005' THEN NEW.origin_image := 'catalog/custom/mgb-005_peanut-butter-oat.jpg';
    WHEN 'MGB-006' THEN NEW.origin_image := 'catalog/custom/mgb-006_tuna-rice-power.jpg';
    WHEN 'MGB-007' THEN NEW.origin_image := 'catalog/custom/mgb-007_tofu-tempeh-gain.jpg';
    WHEN 'MGB-008' THEN NEW.origin_image := 'catalog/custom/mgb-008_greek-yogurt-granola.jpg';
    WHEN 'MGB-009' THEN NEW.origin_image := 'catalog/custom/mgb-009_chicken-avocado.jpg';
    WHEN 'MGB-010' THEN NEW.origin_image := 'catalog/custom/mgb-010_high-protein-bento.jpg';
    ELSE NULL;  -- leave origin_image as-is for unknown SKUs
  END CASE;

  IF NEW.origin_image LIKE 'catalog/custom/%' THEN
    NEW.origin_image := CONCAT('/assets/', NEW.origin_image);
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_goalbox_override_product_image ON product_image;

CREATE TRIGGER trg_goalbox_override_product_image
BEFORE INSERT OR UPDATE ON product_image
FOR EACH ROW
EXECUTE FUNCTION goalbox_override_product_image();
