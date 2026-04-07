import fs from 'fs';
import pg from 'pg';

const { Pool } = pg;

const products = JSON.parse(
  fs.readFileSync(
    '/app/node_modules/@evershop/evershop/dist/bin/seed/data/products.json',
    'utf8'
  )
);

const pool = new Pool({
  host: 'database',
  port: 5432,
  user: 'postgres',
  password: 'postgres',
  database: 'postgres'
});

let updated = 0;
for (const product of products) {
  const description = JSON.stringify(product.description);
  await pool.query(
    'UPDATE product_description SET description = $1 WHERE product_description_product_id = (SELECT product_id FROM product WHERE sku = $2)',
    [description, product.sku]
  );
  updated += 1;
}

await pool.end();
console.log(`Updated descriptions: ${updated}`);
