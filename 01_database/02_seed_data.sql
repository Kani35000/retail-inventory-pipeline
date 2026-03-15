-- ============================================
-- RETAIL INVENTORY PIPELINE
-- File: 02_seed_data.sql
-- Description: Seed data for warehouses, 
-- products, and inventory transactions
-- Author: Kani Okorji
-- Date: March 2026
-- ============================================


-- ============================================
-- WAREHOUSESgit
-- ============================================
UPDATE retail.warehouses SET warehouse_name = 'Dallas Distribution Center',      region = 'Southwest' WHERE warehouse_id = 1;
UPDATE retail.warehouses SET warehouse_name = 'Atlanta Distribution Center',     region = 'Southeast' WHERE warehouse_id = 2;
UPDATE retail.warehouses SET warehouse_name = 'New Jersey Distribution Center',  region = 'Northeast' WHERE warehouse_id = 3;
UPDATE retail.warehouses SET warehouse_name = 'Chicago Distribution Center',     region = 'Midwest'   WHERE warehouse_id = 4;
UPDATE retail.warehouses SET warehouse_name = 'Los Angeles Distribution Center', region = 'West'      WHERE warehouse_id = 5;


-- ============================================
-- PRODUCTS
-- ============================================
ALTER TABLE retail.products
ADD COLUMN IF NOT EXISTS product_name VARCHAR(100),
ADD COLUMN IF NOT EXISTS gross_margin NUMERIC(5,2);

UPDATE retail.products
SET
    product_name = category || ' Product ' || product_id,
    gross_margin = ROUND(((unit_price - unit_cost) / unit_price * 100)::numeric, 2);


-- ============================================
-- INVENTORY TRANSACTIONS
-- ============================================
TRUNCATE retail.inventory_transactions;

INSERT INTO retail.inventory_transactions
(transaction_date, product_id, warehouse_id, units_received, units_sold, units_returned, units_damaged)
SELECT
    d::date,
    p.product_id,
    w.warehouse_id,
    (RANDOM() * 50 + 20)::int,
    CASE
        WHEN EXTRACT(MONTH FROM d) IN (11,12)
        THEN (RANDOM() * 70 + 40)::int
        ELSE (RANDOM() * 40 + 20)::int
    END,
    (RANDOM() * 5)::int,
    (RANDOM() * 3)::int
FROM generate_series(
    CURRENT_DATE - INTERVAL '12 months',
    CURRENT_DATE,
    INTERVAL '1 day'
) d
CROSS JOIN retail.products p
CROSS JOIN retail.warehouses w;