import pkg from 'pg';
const { Pool } = pkg;

const pool = new Pool({
  connectionString: 'postgresql://postgres:postgres@localhost:5432/evershop'
});

async function verifyProducts() {
  try {
    // Get all GoalBox products with their attributes
    const result = await pool.query(`
      SELECT 
        p.id, p.sku, p.name, p.price, 
        COUNT(DISTINCT pav.id) as total_attrs,
        json_agg(DISTINCT json_build_object('attr_code', a.attribute_code, 'option_id', pav.option_id))::text as attribute_details
      FROM product p
      LEFT JOIN product_attribute_value_index pav ON p.id = pav.product_id
      LEFT JOIN attribute a ON pav.attribute_id = a.id
      WHERE p.sku LIKE 'FLB-%' OR p.sku LIKE 'MGB-%' OR p.sku LIKE 'BAL-%'
      GROUP BY p.id, p.sku, p.name, p.price
      ORDER BY p.sku
    `);

    console.log('=== PRODUCT VERIFICATION ===');
    console.log(`Total products: ${result.rows.length}`);
    console.log('\nProducts by category:');
    
    const categories = {
      'FLB': 0,
      'MGB': 0,
      'BAL': 0
    };
    
    result.rows.forEach(row => {
      const prefix = row.sku.substring(0, 3);
      categories[prefix]++;
      console.log(`\n[${row.sku}] ${row.name}`);
      console.log(`  Price: ${row.price} VND | Attributes: ${row.total_attrs}`);
    });
    
    console.log('\n=== CATEGORY SUMMARY ===');
    console.log(`Fat Loss (FLB): ${categories['FLB']} products`);
    console.log(`Muscle Gain (MGB): ${categories['MGB']} products`);
    console.log(`Balanced (BAL): ${categories['BAL']} products`);
    console.log(`TOTAL: ${categories['FLB'] + categories['MGB'] + categories['BAL']} products`);
    
    // Check for missing attributes
    console.log('\n=== ATTRIBUTE COVERAGE ===');
    const missingAttrs = result.rows.filter(r => r.total_attrs < 3);
    if (missingAttrs.length > 0) {
      console.log('⚠️  Products missing attributes:');
      missingAttrs.forEach(p => console.log(`  - ${p.sku}: only ${p.total_attrs} attributes`));
    } else {
      console.log('✓ All products have 3 attributes');
    }
    
    // Check price range
    console.log('\n=== PRICE ANALYSIS ===');
    const prices = result.rows.map(r => r.price);
    const minPrice = Math.min(...prices);
    const maxPrice = Math.max(...prices);
    const avgPrice = (prices.reduce((a, b) => a + b, 0) / prices.length).toFixed(0);
    console.log(`Price range: ${minPrice} - ${maxPrice} VND`);
    console.log(`Average price: ${avgPrice} VND`);
    
    await pool.end();
    
  } catch (error) {
    console.error('Error:', error.message);
    await pool.end();
    process.exit(1);
  }
}

await verifyProducts();
