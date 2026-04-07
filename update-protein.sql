UPDATE product_attribute_value_index
SET option_id = (SELECT attribute_option_id FROM attribute_option WHERE attribute_id = (SELECT attribute_id FROM attribute WHERE attribute_code = 'protein_level') AND option_text = 'Medium')
WHERE product_id = (SELECT product_id FROM product WHERE sku = 'FLB-011')
AND attribute_id = (SELECT attribute_id FROM attribute WHERE attribute_code = 'protein_level');

UPDATE product_attribute_value_index
SET option_id = (SELECT attribute_option_id FROM attribute_option WHERE attribute_id = (SELECT attribute_id FROM attribute WHERE attribute_code = 'protein_level') AND option_text = 'Medium')
WHERE product_id = (SELECT product_id FROM product WHERE sku = 'FLB-012')
AND attribute_id = (SELECT attribute_id FROM attribute WHERE attribute_code = 'protein_level');

UPDATE product_attribute_value_index
SET option_id = (SELECT attribute_option_id FROM attribute_option WHERE attribute_id = (SELECT attribute_id FROM attribute WHERE attribute_code = 'protein_level') AND option_text = 'Medium')
WHERE product_id = (SELECT product_id FROM product WHERE sku = 'MGB-005')
AND attribute_id = (SELECT attribute_id FROM attribute WHERE attribute_code = 'protein_level');

UPDATE product_attribute_value_index
SET option_id = (SELECT attribute_option_id FROM attribute_option WHERE attribute_id = (SELECT attribute_id FROM attribute WHERE attribute_code = 'protein_level') AND option_text = 'High')
WHERE product_id = (SELECT product_id FROM product WHERE sku = 'BAL-001')
AND attribute_id = (SELECT attribute_id FROM attribute WHERE attribute_code = 'protein_level');

UPDATE product_attribute_value_index
SET option_id = (SELECT attribute_option_id FROM attribute_option WHERE attribute_id = (SELECT attribute_id FROM attribute WHERE attribute_code = 'protein_level') AND option_text = 'High')
WHERE product_id = (SELECT product_id FROM product WHERE sku = 'BAL-005')
AND attribute_id = (SELECT attribute_id FROM attribute WHERE attribute_code = 'protein_level');

UPDATE product_attribute_value_index
SET option_id = (SELECT attribute_option_id FROM attribute_option WHERE attribute_id = (SELECT attribute_id FROM attribute WHERE attribute_code = 'protein_level') AND option_text = 'High')
WHERE product_id = (SELECT product_id FROM product WHERE sku = 'BAL-002')
AND attribute_id = (SELECT attribute_id FROM attribute WHERE attribute_code = 'protein_level');

UPDATE product_attribute_value_index
SET option_id = (SELECT attribute_option_id FROM attribute_option WHERE attribute_id = (SELECT attribute_id FROM attribute WHERE attribute_code = 'protein_level') AND option_text = 'High')
WHERE product_id = (SELECT product_id FROM product WHERE sku = 'BAL-004')
AND attribute_id = (SELECT attribute_id FROM attribute WHERE attribute_code = 'protein_level');
