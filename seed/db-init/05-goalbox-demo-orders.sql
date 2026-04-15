-- GoalBox Demo Orders Seed
-- Creates 20 realistic demo orders for admin dashboard demonstration.
-- Auto-runs via event trigger when "order" table is created (fresh install).
-- Also runs immediately if "order" table already exists.
-- Skips if >= 20 demo orders already exist. Cleans up partial runs.

CREATE OR REPLACE FUNCTION goalbox_seed_demo_orders()
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
  addr_id1  INTEGER; addr_id2  INTEGER; addr_id3  INTEGER; addr_id4  INTEGER;
  addr_id5  INTEGER; addr_id6  INTEGER; addr_id7  INTEGER; addr_id8  INTEGER;
  addr_id9  INTEGER; addr_id10 INTEGER; addr_id11 INTEGER; addr_id12 INTEGER;
  addr_id13 INTEGER; addr_id14 INTEGER; addr_id15 INTEGER; addr_id16 INTEGER;
  addr_id17 INTEGER; addr_id18 INTEGER; addr_id19 INTEGER; addr_id20 INTEGER;

  cart_id1  INTEGER; cart_id2  INTEGER; cart_id3  INTEGER; cart_id4  INTEGER;
  cart_id5  INTEGER; cart_id6  INTEGER; cart_id7  INTEGER; cart_id8  INTEGER;
  cart_id9  INTEGER; cart_id10 INTEGER; cart_id11 INTEGER; cart_id12 INTEGER;
  cart_id13 INTEGER; cart_id14 INTEGER; cart_id15 INTEGER; cart_id16 INTEGER;
  cart_id17 INTEGER; cart_id18 INTEGER; cart_id19 INTEGER; cart_id20 INTEGER;

  ord_id1   INTEGER; ord_id2   INTEGER; ord_id3   INTEGER; ord_id4   INTEGER;
  ord_id5   INTEGER; ord_id6   INTEGER; ord_id7   INTEGER; ord_id8   INTEGER;
  ord_id9   INTEGER; ord_id10  INTEGER; ord_id11  INTEGER; ord_id12  INTEGER;
  ord_id13  INTEGER; ord_id14  INTEGER; ord_id15  INTEGER; ord_id16  INTEGER;
  ord_id17  INTEGER; ord_id18  INTEGER; ord_id19  INTEGER; ord_id20  INTEGER;
BEGIN
  -- Skip if already have 20 demo orders
  IF (SELECT COUNT(*) FROM "order" WHERE order_number LIKE 'DEMO-%') >= 20 THEN
    RETURN;
  END IF;

  -- Clean up any partial demo data before re-seeding
  DELETE FROM order_item WHERE order_item_order_id IN (
    SELECT order_id FROM "order" WHERE order_number LIKE 'DEMO-%'
  );
  DELETE FROM "order" WHERE order_number LIKE 'DEMO-%';

  -- ── Shipping addresses ──────────────────────────────────────────
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Tran Minh Duc',       '0901 111 001', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '12 Nguyen Hue, Ben Nghe, Q.1',            '700000') RETURNING order_address_id INTO addr_id1;
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Le Thi Bich Ngoc',    '0902 222 002', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '45 Pham Ngu Lao, Pham Ngu Lao, Q.1',     '700000') RETURNING order_address_id INTO addr_id2;
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Nguyen Quoc Bao',     '0903 333 003', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '88 Le Van Sy, Phuong 11, Q.3',            '700000') RETURNING order_address_id INTO addr_id3;
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Pham Thi Thu Hien',   '0904 444 004', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '27 Vo Thi Sau, Phuong 6, Q.3',            '700000') RETURNING order_address_id INTO addr_id4;
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Hoang Van Long',      '0905 555 005', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '99 Cach Mang Thang 8, Phuong 5, Q.3',    '700000') RETURNING order_address_id INTO addr_id5;
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Vo Thi Lan Anh',      '0906 666 006', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '33 Dien Bien Phu, Phuong 15, BT',        '700000') RETURNING order_address_id INTO addr_id6;
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Do Thanh Tung',       '0907 777 007', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '156 Nguyen Van Cu, Phuong 2, Q.5',        '700000') RETURNING order_address_id INTO addr_id7;
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Bui Phuong Linh',     '0908 888 008', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '78 Tran Hung Dao, Phuong 7, Q.5',        '700000') RETURNING order_address_id INTO addr_id8;
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Dang Huu Nghia',      '0909 999 009', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '22 Ly Thuong Kiet, Phuong 14, Q.10',     '700000') RETURNING order_address_id INTO addr_id9;
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Ngo Thi Kim Chi',     '0910 000 010', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '64 Su Van Hanh, Phuong 9, Q.10',         '700000') RETURNING order_address_id INTO addr_id10;
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Nguyen Thi Mai',      '0911 001 011', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '15 Truong Dinh, Phuong 9, Q.3',          '700000') RETURNING order_address_id INTO addr_id11;
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Tran Quang Khai',     '0912 002 012', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '203 Hai Ba Trung, Da Kao, Q.1',          '700000') RETURNING order_address_id INTO addr_id12;
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Le Thi Phuong',       '0913 003 013', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '45 Nguyen Tat Thanh, Phuong 13, Q.4',   '700000') RETURNING order_address_id INTO addr_id13;
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Pham Minh Tuan',      '0914 004 014', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '87 Tran Quoc Toan, Phuong 8, Q.3',      '700000') RETURNING order_address_id INTO addr_id14;
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Nguyen Thi Hoa',      '0915 005 015', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '120 Ba Thang Hai, Phuong 12, Q.10',     '700000') RETURNING order_address_id INTO addr_id15;
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Do Van Thanh',        '0916 006 016', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '56 Nguyen Thi Minh Khai, Ben Thanh, Q.1','700000') RETURNING order_address_id INTO addr_id16;
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Bui Thi Ngan',        '0917 007 017', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '34 Hoang Dieu, Phuong 10, Q.4',         '700000') RETURNING order_address_id INTO addr_id17;
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Hoang Thi Thu',       '0918 008 018', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '91 Ngo Gia Tu, Phuong 3, Q.10',         '700000') RETURNING order_address_id INTO addr_id18;
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Nguyen Van Cuong',    '0919 009 019', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '17 Le Quoc Hung, Phuong 12, Q.4',       '700000') RETURNING order_address_id INTO addr_id19;
  INSERT INTO order_address (full_name, telephone, country, province, city, address_1, postcode)
  VALUES ('Tran Thi Thu Suong',  '0920 010 020', 'VN', 'Ho Chi Minh', 'Ho Chi Minh', '265 Dien Bien Phu, Phuong 7, Q.3',      '700000') RETURNING order_address_id INTO addr_id20;

  -- ── Carts (status=false = converted to order) ───────────────────
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','duc.tran@demo.vn',      'Tran Minh Duc',      false, 94000, 94000, 94000, 94000,1,0,0,0,114000) RETURNING cart_id INTO cart_id1;
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','ngoc.le@demo.vn',       'Le Thi Bich Ngoc',   false,218000,218000,218000,218000,2,0,0,0,218000) RETURNING cart_id INTO cart_id2;
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','bao.nguyen@demo.vn',    'Nguyen Quoc Bao',    false,129000,129000,129000,129000,1,0,0,0,149000) RETURNING cart_id INTO cart_id3;
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','hien.pham@demo.vn',     'Pham Thi Thu Hien',  false,109000,109000, 98100, 98100,1,0,0,0,118100) RETURNING cart_id INTO cart_id4;
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','long.hoang@demo.vn',    'Hoang Van Long',     false,238000,238000,238000,238000,2,0,0,0,258000) RETURNING cart_id INTO cart_id5;
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','anh.vo@demo.vn',        'Vo Thi Lan Anh',     false, 89000, 89000, 80100, 80100,1,0,0,0,100100) RETURNING cart_id INTO cart_id6;
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','tung.do@demo.vn',       'Do Thanh Tung',      false,351000,351000,333450,333450,3,0,0,0,333450) RETURNING cart_id INTO cart_id7;
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','linh.bui@demo.vn',      'Bui Phuong Linh',    false,122000,122000,122000,122000,1,0,0,0,142000) RETURNING cart_id INTO cart_id8;
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','nghia.dang@demo.vn',    'Dang Huu Nghia',     false,188000,188000,188000,188000,2,0,0,0,188000) RETURNING cart_id INTO cart_id9;
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','chi.ngo@demo.vn',       'Ngo Thi Kim Chi',    false,273000,273000,273000,273000,3,0,0,0,293000) RETURNING cart_id INTO cart_id10;
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','mai.nguyen@demo.vn',    'Nguyen Thi Mai',     false,253000,253000,253000,253000,3,0,0,0,273000) RETURNING cart_id INTO cart_id11;
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','khai.tran@demo.vn',     'Tran Quang Khai',    false, 89000, 89000, 89000, 89000,1,0,0,0,109000) RETURNING cart_id INTO cart_id12;
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','phuong.le@demo.vn',     'Le Thi Phuong',      false,244000,244000,244000,244000,2,0,0,0,244000) RETURNING cart_id INTO cart_id13;
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','tuan.pham@demo.vn',     'Pham Minh Tuan',     false,253000,253000,253000,253000,1,0,0,0,273000) RETURNING cart_id INTO cart_id14;
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','hoa.nguyen@demo.vn',    'Nguyen Thi Hoa',     false,137000,137000,123300,123300,2,0,0,0,143300) RETURNING cart_id INTO cart_id15;
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','thanh.do@demo.vn',      'Do Van Thanh',       false,357000,357000,339150,339150,3,0,0,0,339150) RETURNING cart_id INTO cart_id16;
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','ngan.bui@demo.vn',      'Bui Thi Ngan',       false, 99000, 99000, 99000, 99000,1,0,0,0,119000) RETURNING cart_id INTO cart_id17;
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','thu.hoang@demo.vn',     'Hoang Thi Thu',      false,224000,224000,224000,224000,2,0,0,0,224000) RETURNING cart_id INTO cart_id18;
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','cuong.nguyen@demo.vn',  'Nguyen Van Cuong',   false,199000,199000,199000,199000,3,0,0,0,219000) RETURNING cart_id INTO cart_id19;
  INSERT INTO cart (currency,customer_email,customer_full_name,status,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,grand_total)
  VALUES ('VND','suong.tran@demo.vn',    'Tran Thi Thu Suong', false,366000,366000,329400,329400,1,0,0,0,349400) RETURNING cart_id INTO cart_id20;

  -- ── Orders ─────────────────────────────────────────────────────
  -- Order 1: FLB-009 x1 | Pending | No coupon | -1 day
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10001','pending',cart_id1,'VND','duc.tran@demo.vn','Tran Minh Duc',NULL,94000,94000,94000,94000,1,0,0,0,0,114000,20000,20000,0,'standard','Standard Delivery','cod','Cash on Delivery','pending','pending',addr_id1,addr_id1,NOW()-INTERVAL '1 day') RETURNING order_id INTO ord_id1;

  -- Order 2: BAL-001+BAL-002 x1 each | Processing | FREESHIP200 | -2 days
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10002','processing',cart_id2,'VND','ngoc.le@demo.vn','Le Thi Bich Ngoc','FREESHIP200',218000,218000,218000,218000,2,0,0,0,0,218000,0,0,0,'standard','Standard Delivery','cod','Cash on Delivery','not_shipped','pending',addr_id2,addr_id2,NOW()-INTERVAL '2 days') RETURNING order_id INTO ord_id2;

  -- Order 3: MGB-002 x1 | Complete | No coupon | -5 days
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10003','complete',cart_id3,'VND','bao.nguyen@demo.vn','Nguyen Quoc Bao',NULL,129000,129000,129000,129000,1,0,0,0,0,149000,20000,20000,0,'standard','Standard Delivery','cod','Cash on Delivery','delivered','paid',addr_id3,addr_id3,NOW()-INTERVAL '5 days') RETURNING order_id INTO ord_id3;

  -- Order 4: BAL-003 x1 | Processing | GOALBOX10 (10%) | -3 days
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10004','processing',cart_id4,'VND','hien.pham@demo.vn','Pham Thi Thu Hien','GOALBOX10',109000,109000,98100,98100,1,0,0,0,0,118100,20000,20000,10900,'standard','Standard Delivery','cod','Cash on Delivery','not_shipped','pending',addr_id4,addr_id4,NOW()-INTERVAL '3 days') RETURNING order_id INTO ord_id4;

  -- Order 5: FLB-008 + MGB-003 x1 each | Processing (shipped) | No coupon | -4 days
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10005','processing',cart_id5,'VND','long.hoang@demo.vn','Hoang Van Long',NULL,238000,238000,238000,238000,2,0,0,0,0,258000,20000,20000,0,'standard','Standard Delivery','cod','Cash on Delivery','shipped','pending',addr_id5,addr_id5,NOW()-INTERVAL '4 days') RETURNING order_id INTO ord_id5;

  -- Order 6: FLB-001 x1 | Pending | GOALBOX10 | -6 hours
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10006','pending',cart_id6,'VND','anh.vo@demo.vn','Vo Thi Lan Anh','GOALBOX10',89000,89000,80100,80100,1,0,0,0,0,100100,20000,20000,8900,'standard','Standard Delivery','cod','Cash on Delivery','pending','pending',addr_id6,addr_id6,NOW()-INTERVAL '6 hours') RETURNING order_id INTO ord_id6;

  -- Order 7: MGB-010 x2 + ADD-NUT-001 x1 | Complete | REORDER5 | -7 days
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10007','complete',cart_id7,'VND','tung.do@demo.vn','Do Thanh Tung','REORDER5',351000,351000,333450,333450,3,0,0,0,0,333450,0,0,17550,'standard','Standard Delivery','cod','Cash on Delivery','delivered','paid',addr_id7,addr_id7,NOW()-INTERVAL '7 days') RETURNING order_id INTO ord_id7;

  -- Order 8: MGB-009 x1 | Processing | No coupon | -1 day
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10008','processing',cart_id8,'VND','linh.bui@demo.vn','Bui Phuong Linh',NULL,122000,122000,122000,122000,1,0,0,0,0,142000,20000,20000,0,'standard','Standard Delivery','cod','Cash on Delivery','not_shipped','pending',addr_id8,addr_id8,NOW()-INTERVAL '1 day') RETURNING order_id INTO ord_id8;

  -- Order 9: BAL-001 + FLB-003 x1 each | Processing (shipped) | FREESHIP200 | -2 days
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10009','processing',cart_id9,'VND','nghia.dang@demo.vn','Dang Huu Nghia','FREESHIP200',188000,188000,188000,188000,2,0,0,0,0,188000,0,0,0,'standard','Standard Delivery','cod','Cash on Delivery','shipped','pending',addr_id9,addr_id9,NOW()-INTERVAL '2 days') RETURNING order_id INTO ord_id9;

  -- Order 10: MGB-001 x2 + ADD-DRK-001 x1 | Pending | No coupon | -30 min
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10010','pending',cart_id10,'VND','chi.ngo@demo.vn','Ngo Thi Kim Chi',NULL,273000,273000,273000,273000,3,0,0,0,0,293000,20000,20000,0,'standard','Standard Delivery','cod','Cash on Delivery','pending','pending',addr_id10,addr_id10,NOW()-INTERVAL '30 minutes') RETURNING order_id INTO ord_id10;

  -- Order 11: BAL-001 x2 + ADD-BAR-001 x1 | Processing | No coupon | -3 days
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10011','processing',cart_id11,'VND','mai.nguyen@demo.vn','Nguyen Thi Mai',NULL,253000,253000,253000,253000,3,0,0,0,0,273000,20000,20000,0,'standard','Standard Delivery','cod','Cash on Delivery','not_shipped','pending',addr_id11,addr_id11,NOW()-INTERVAL '3 days') RETURNING order_id INTO ord_id11;

  -- Order 12: FLB-003 x1 | Complete | No coupon | -7 days
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10012','complete',cart_id12,'VND','khai.tran@demo.vn','Tran Quang Khai',NULL,89000,89000,89000,89000,1,0,0,0,0,109000,20000,20000,0,'standard','Standard Delivery','cod','Cash on Delivery','delivered','paid',addr_id12,addr_id12,NOW()-INTERVAL '7 days') RETURNING order_id INTO ord_id12;

  -- Order 13: MGB-003 + MGB-004 x1 each | Processing | FREESHIP200 | -2 days
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10013','processing',cart_id13,'VND','phuong.le@demo.vn','Le Thi Phuong','FREESHIP200',244000,244000,244000,244000,2,0,0,0,0,244000,0,0,0,'standard','Standard Delivery','cod','Cash on Delivery','not_shipped','pending',addr_id13,addr_id13,NOW()-INTERVAL '2 days') RETURNING order_id INTO ord_id13;

  -- Order 14: FL-3D-001 x1 (bundle) | Complete | No coupon | -10 days
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10014','complete',cart_id14,'VND','tuan.pham@demo.vn','Pham Minh Tuan',NULL,253000,253000,253000,253000,1,0,0,0,0,273000,20000,20000,0,'standard','Standard Delivery','cod','Cash on Delivery','delivered','paid',addr_id14,addr_id14,NOW()-INTERVAL '10 days') RETURNING order_id INTO ord_id14;

  -- Order 15: BAL-003 + ADD-NUT-001 x1 each | Pending | GOALBOX10 | -1 hour
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10015','pending',cart_id15,'VND','hoa.nguyen@demo.vn','Nguyen Thi Hoa','GOALBOX10',137000,137000,123300,123300,2,0,0,0,0,143300,20000,20000,13700,'standard','Standard Delivery','cod','Cash on Delivery','pending','pending',addr_id15,addr_id15,NOW()-INTERVAL '1 hour') RETURNING order_id INTO ord_id15;

  -- Order 16: MGB-001 x3 | Complete | REORDER5 (5%+free ship) | -8 days
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10016','complete',cart_id16,'VND','thanh.do@demo.vn','Do Van Thanh','REORDER5',357000,357000,339150,339150,3,0,0,0,0,339150,0,0,17850,'standard','Standard Delivery','cod','Cash on Delivery','delivered','paid',addr_id16,addr_id16,NOW()-INTERVAL '8 days') RETURNING order_id INTO ord_id16;

  -- Order 17: FLB-006 x1 | Pending | No coupon | -30 min (brand new)
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10017','pending',cart_id17,'VND','ngan.bui@demo.vn','Bui Thi Ngan',NULL,99000,99000,99000,99000,1,0,0,0,0,119000,20000,20000,0,'standard','Standard Delivery','cod','Cash on Delivery','pending','pending',addr_id17,addr_id17,NOW()-INTERVAL '30 minutes') RETURNING order_id INTO ord_id17;

  -- Order 18: BAL-005 x2 | Processing | FREESHIP200 | -4 days
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10018','processing',cart_id18,'VND','thu.hoang@demo.vn','Hoang Thi Thu','FREESHIP200',224000,224000,224000,224000,2,0,0,0,0,224000,0,0,0,'standard','Standard Delivery','cod','Cash on Delivery','not_shipped','pending',addr_id18,addr_id18,NOW()-INTERVAL '4 days') RETURNING order_id INTO ord_id18;

  -- Order 19: MGB-002 x1 + ADD-BAR-001 x2 | Complete | No coupon | -6 days
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10019','complete',cart_id19,'VND','cuong.nguyen@demo.vn','Nguyen Van Cuong',NULL,199000,199000,199000,199000,3,0,0,0,0,219000,20000,20000,0,'standard','Standard Delivery','cod','Cash on Delivery','delivered','paid',addr_id19,addr_id19,NOW()-INTERVAL '6 days') RETURNING order_id INTO ord_id19;

  -- Order 20: MG-3D-001 x1 (bundle) | Processing | GOALBOX10 | -2 days
  INSERT INTO "order" (order_number,status,cart_id,currency,customer_email,customer_full_name,coupon,sub_total,sub_total_incl_tax,sub_total_with_discount,sub_total_with_discount_incl_tax,total_qty,tax_amount,tax_amount_before_discount,shipping_tax_amount,total_tax_amount,grand_total,shipping_fee_excl_tax,shipping_fee_incl_tax,discount_amount,shipping_method,shipping_method_name,payment_method,payment_method_name,shipment_status,payment_status,shipping_address_id,billing_address_id,created_at)
  VALUES ('DEMO-10020','processing',cart_id20,'VND','suong.tran@demo.vn','Tran Thi Thu Suong','GOALBOX10',366000,366000,329400,329400,1,0,0,0,0,349400,20000,20000,36600,'standard','Standard Delivery','cod','Cash on Delivery','not_shipped','pending',addr_id20,addr_id20,NOW()-INTERVAL '2 days') RETURNING order_id INTO ord_id20;

  -- ── Order items ─────────────────────────────────────────────────
  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id1, 9,'FLB-009','Fat Loss Box - Chicken Teriyaki Lite',94000,94000,1,94000,94000,0,0,0,0,94000,94000,94000,94000);

  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id2,23,'BAL-001','Balanced Box - Chicken Veggie',109000,109000,1,109000,109000,0,0,0,0,109000,109000,109000,109000);
  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id2,24,'BAL-002','Balanced Box - Salmon Brown Rice',109000,109000,1,109000,109000,0,0,0,0,109000,109000,109000,109000);

  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id3,14,'MGB-002','Muscle Gain Box - Beef Steak Power',129000,129000,1,129000,129000,0,0,0,0,129000,129000,129000,129000);

  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id4,25,'BAL-003','Balanced Box - Veggie Delight',109000,109000,1,98100,98100,0,0,0,10900,109000,98100,109000,98100);

  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id5, 8,'FLB-008','Fat Loss Box - Salmon Greens',99000,99000,1,99000,99000,0,0,0,0,99000,99000,99000,99000);
  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id5,15,'MGB-003','Muscle Gain Box - Salmon Sweet Potato',125000,125000,1,125000,125000,0,0,0,0,125000,125000,125000,125000);

  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id6, 1,'FLB-001','Fat Loss Box - Grilled Chicken & Quinoa',89000,89000,1,80100,80100,0,0,0,8900,89000,80100,89000,80100);

  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id7,22,'MGB-010','Muscle Gain Box - High-Protein Bento',129000,129000,2,122550,122550,0,0,0,12900,258000,245100,258000,245100);
  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id7,37,'ADD-NUT-001','Healthy Snack Pack (30g)',32000,32000,1,30400,30400,0,0,0,1600,32000,30400,32000,30400);

  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id8,21,'MGB-009','Muscle Gain Box - Chicken Avocado',122000,122000,1,122000,122000,0,0,0,0,122000,122000,122000,122000);

  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id9,23,'BAL-001','Balanced Box - Chicken Veggie',109000,109000,1,109000,109000,0,0,0,0,109000,109000,109000,109000);
  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id9, 3,'FLB-003','Fat Loss Box - Tofu Veggie Protein',89000,89000,1,89000,89000,0,0,0,0,89000,89000,89000,89000);

  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id10,13,'MGB-001','Muscle Gain Box - Double Chicken Rice',119000,119000,2,119000,119000,0,0,0,0,238000,238000,238000,238000);
  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id10,36,'ADD-DRK-001','Detox Drink 500ml',28000,28000,1,28000,28000,0,0,0,0,28000,28000,28000,28000);

  -- Orders 11-20
  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id11,23,'BAL-001','Balanced Box - Chicken Veggie',109000,109000,2,109000,109000,0,0,0,0,218000,218000,218000,218000);
  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id11,35,'ADD-BAR-001','Protein Bar (45g)',35000,35000,1,35000,35000,0,0,0,0,35000,35000,35000,35000);

  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id12, 3,'FLB-003','Fat Loss Box - Tofu Veggie Protein',89000,89000,1,89000,89000,0,0,0,0,89000,89000,89000,89000);

  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id13,15,'MGB-003','Muscle Gain Box - Salmon Sweet Potato',125000,125000,1,125000,125000,0,0,0,0,125000,125000,125000,125000);
  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id13,16,'MGB-004','Muscle Gain Box - Turkey Pasta Protein',119000,119000,1,119000,119000,0,0,0,0,119000,119000,119000,119000);

  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id14,31,'FL-3D-001','3-Day Fat Loss Plan',253000,253000,1,253000,253000,0,0,0,0,253000,253000,253000,253000);

  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id15,25,'BAL-003','Balanced Box - Veggie Delight',105000,105000,1,94500,94500,0,0,0,10500,105000,94500,105000,94500);
  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id15,37,'ADD-NUT-001','Healthy Snack Pack (30g)',32000,32000,1,28800,28800,0,0,0,3200,32000,28800,32000,28800);

  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id16,13,'MGB-001','Muscle Gain Box - Double Chicken Rice',119000,119000,3,113050,113050,0,0,0,17850,357000,339150,357000,339150);

  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id17, 6,'FLB-006','Fat Loss Box - Lean Beef Broccoli',99000,99000,1,99000,99000,0,0,0,0,99000,99000,99000,99000);

  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id18,27,'BAL-005','Balanced Box - Beef & Veg',112000,112000,2,112000,112000,0,0,0,0,224000,224000,224000,224000);

  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id19,14,'MGB-002','Muscle Gain Box - Beef Steak Power',129000,129000,1,129000,129000,0,0,0,0,129000,129000,129000,129000);
  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id19,35,'ADD-BAR-001','Protein Bar (45g)',35000,35000,2,35000,35000,0,0,0,0,70000,70000,70000,70000);

  INSERT INTO order_item (order_item_order_id,product_id,product_sku,product_name,product_price,product_price_incl_tax,qty,final_price,final_price_incl_tax,tax_percent,tax_amount,tax_amount_before_discount,discount_amount,line_total,line_total_with_discount,line_total_incl_tax,line_total_with_discount_incl_tax)
  VALUES (ord_id20,32,'MG-3D-001','3-Day Muscle Gain Plan',366000,366000,1,329400,329400,0,0,0,36600,366000,329400,366000,329400);

  RAISE NOTICE 'GoalBox: 20 demo orders seeded successfully.';
END;
$$;

-- ── Event trigger: khi CREATE TABLE product → tạo AFTER INSERT trigger ──────
-- Lý do: không dùng event trigger trên "order" table vì nó fire trước khi
-- products được seed, dẫn đến stock trigger lỗi (product_inventory rỗng).
-- Thay vào đó: khi product table được tạo (migration), ta tạo một row-level
-- trigger trên product. Trigger đó fire khi ADD-NUT-001 (product cuối cùng)
-- được insert → lúc này TẤT CẢ tables và products đã tồn tại → an toàn.

CREATE OR REPLACE FUNCTION goalbox_setup_product_seed_trigger()
RETURNS event_trigger
LANGUAGE plpgsql
AS $$
DECLARE cmd RECORD;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.object_type = 'table' AND cmd.object_identity = 'public.product' THEN
      -- Tạo trigger function (dùng $inner$ để tránh xung đột dollar-quoting)
      EXECUTE $trig$
        CREATE OR REPLACE FUNCTION goalbox_after_product_insert()
        RETURNS trigger LANGUAGE plpgsql AS $inner$
        BEGIN
          IF NEW.sku = 'ADD-NUT-001' THEN
            PERFORM goalbox_seed_demo_orders();
          END IF;
          RETURN NEW;
        END;
        $inner$
      $trig$;
      -- Gắn trigger vào product table
      EXECUTE 'DROP TRIGGER IF EXISTS trg_goalbox_seed_on_last_product ON product';
      EXECUTE $trig$
        CREATE TRIGGER trg_goalbox_seed_on_last_product
        AFTER INSERT ON product
        FOR EACH ROW EXECUTE FUNCTION goalbox_after_product_insert()
      $trig$;
    END IF;
  END LOOP;
END;
$$;

DROP EVENT TRIGGER IF EXISTS trg_goalbox_seed_demo_orders;
DROP EVENT TRIGGER IF EXISTS trg_goalbox_setup_product_trigger;
CREATE EVENT TRIGGER trg_goalbox_setup_product_trigger
ON ddl_command_end
WHEN TAG IN ('CREATE TABLE')
EXECUTE FUNCTION goalbox_setup_product_seed_trigger();

-- ── Run immediately nếu "order" table đã tồn tại (chạy thủ công / reload) ───
DO $$
BEGIN
  IF to_regclass('public.order') IS NOT NULL THEN
    PERFORM goalbox_seed_demo_orders();
  END IF;
END;
$$;
