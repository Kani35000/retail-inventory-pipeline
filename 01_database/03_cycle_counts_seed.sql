-- ============================================
-- RETAIL INVENTORY PIPELINE
-- File: 03_cycle_counts_seed.sql
-- Description: Seed cycle counts data with
-- realistic shrinkage rates by warehouse
-- Chicago & Dallas: 5-13% shrinkage
-- Atlanta, LA, New Jersey: 1-4% shrinkage
-- Author: Kani Okorji
-- Date: March 2026
-- ============================================

TRUNCATE retail.cycle_counts;

INSERT INTO retail.cycle_counts
(count_date, product_id, warehouse_id, system_inventory, physical_count)
WITH base AS (
    SELECT
        DATE_TRUNC('month', d)::date + (RANDOM() * 27)::int AS count_date,
        p.product_id,
        w.warehouse_id,
        (RANDOM() * 200 + 100)::int AS system_inventory,
        w.warehouse_id AS wid
    FROM generate_series(
        CURRENT_DATE - INTERVAL '12 months',
        CURRENT_DATE,
        INTERVAL '1 month'
    ) d
    CROSS JOIN retail.products p
    CROSS JOIN retail.warehouses w
),
with_shrinkage AS (
    SELECT
        count_date,
        product_id,
        warehouse_id,
        system_inventory,
        wid,
        CASE
            WHEN wid IN (1, 4) THEN ROUND((RANDOM() * 0.08 + 0.05)::numeric, 4)
            ELSE ROUND((RANDOM() * 0.03 + 0.01)::numeric, 4)
        END AS shrinkage_rate
    FROM base
)
SELECT
    count_date,
    product_id,
    warehouse_id,
    system_inventory,
    (system_inventory * (1 - shrinkage_rate))::int AS physical_count
FROM with_shrinkage;