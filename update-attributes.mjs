import pkg from 'pg';
const { Pool } = pkg;

async function updateProductAttributes() {
  const pool = new Pool({
    connectionString: 'postgresql://postgres:postgres@localhost:5432/evershop'
  });

  try {
    const adjustments = [
      { sku: 'FLB-011', protein_value: 'Medium' },
      { sku: 'FLB-012', protein_value: 'Medium' },
      { sku: 'MGB-005', protein_value: 'Medium' },
      { sku: 'BAL-001', protein_value: 'High' },
      { sku: 'BAL-005', protein_value: 'High' },
      { sku: 'BAL-002', protein_value: 'High' },
      { sku: 'BAL-004', protein_value: 'High' },
    ];

    let updatedCount = 0;

    for (const adj of adjustments) {
      const result = await pool.query(`
        UPDATE product_attribute_value_index
        SET option_id = (
          SELECT id FROM attribute_option 
          WHERE attribute_id = (
            SELECT id FROM attribute WHERE attribute_code = 'protein_level'
          ) AND option_text = $1
        )
        WHERE product_id = (
          SELECT id FROM product WHERE sku = $2
        ) AND attribute_id = (
          SELECT id FROM attribute WHERE attribute_code = 'protein_level'
        )
      `, [adj.protein_value, adj.sku]);

      if (result.rowCount > 0) {
        console.log(`Updated ${adj.sku}: protein_level -> ${adj.protein_value}`);
        updatedCount += result.rowCount;
      }
    }

    console.log(`\nTotal updated: ${updatedCount} attribute values`);

    // Verify new distribution
    const verify = await pool.query(`
      SELECT 
        p.sku,
        STRING_AGG(DISTINCT a.attribute_code || '=' || ao.option_text, ', ') as attributes
      FROM product p
      JOIN product_attribute_value_index pav ON p.id = pav.product_id
      JOIN attribute a ON pav.attribute_id = a.id
      JOIN attribute_option ao ON pav.option_id = ao.id
      WHERE p.sku IN ('FLB-011', 'FLB-012', 'MGB-005', 'BAL-001', 'BAL-005', 'BAL-002', 'BAL-004')
      GROUP BY p.sku
      ORDER BY p.sku
    `);

    console.log('\nVerified changes:');
    verify.rows.forEach(row => {
      console.log(`${row.sku}: ${row.attributes}`);
    });

    await pool.end();
  } catch (error) {
    console.error('Error:', error.message);
    await pool.end();
    process.exit(1);
  }
}

await updateProductAttributes();
