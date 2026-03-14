-- ============================================
-- RETAIL INVENTORY PIPELINE
-- File: 04_kpi_queries.sql
-- Description: Executive KPI queries
-- Author: Kani Okorji
-- Date: March 2026
-- ============================================

-- ============================================
-- KPI 1: TOTAL REVENUE PER WAREHOUSE
-- ============================================
WITH revenue_units AS (
	SELECT t.warehouse_id, (t.units_sold - t.units_returned) AS net_units,
	((t.units_sold - t.units_returned) * p.unit_price) AS revenue_per_unit
	FROM retail.inventory_transactions t
	JOIN retail.products p
	ON t.product_id = p.product_id
)
SELECT w.warehouse_name,
	SUM(r.revenue_per_unit) AS warehouse_revenue
	FROM revenue_units r
	JOIN retail.warehouses w
	ON r.warehouse_id = w.warehouse_id
	GROUP BY  warehouse_name
	ORDER BY warehouse_revenue DESC
;
	
-- Alternatively Without CTE
SELECT 
    w.warehouse_name,
    SUM((t.units_sold - t.units_returned) * p.unit_price) AS warehouse_revenue
FROM retail.inventory_transactions t
JOIN retail.products p ON t.product_id = p.product_id
JOIN retail.warehouses w ON t.warehouse_id = w.warehouse_id
GROUP BY w.warehouse_name

-- ============================================
-- KPI 2: TOTAL COGS PER WAREHOUSE
-- ============================================
SELECT 
    w.warehouse_name,
    SUM((t.units_sold - t.units_returned) * p.unit_cost) AS cogs
FROM retail.inventory_transactions t
JOIN retail.products p ON t.product_id = p.product_id
JOIN retail.warehouses w ON t.warehouse_id = w.warehouse_id
GROUP BY w.warehouse_name
ORDER BY cogs DESC;

-- ============================================
-- KPI 3: GROSS MARGIN PER WAREHOUSE
-- ============================================
WITH total_cogs AS (
    SELECT 
        w.warehouse_name,
        SUM((t.units_sold - t.units_returned) * p.unit_cost) AS cogs
    FROM retail.inventory_transactions t
    JOIN retail.products p ON t.product_id = p.product_id
    JOIN retail.warehouses w ON t.warehouse_id = w.warehouse_id
    GROUP BY w.warehouse_name
),
revenue AS (
    SELECT 
        w.warehouse_name,
        SUM((t.units_sold - t.units_returned) * p.unit_price) AS warehouse_revenue
    FROM retail.inventory_transactions t
    JOIN retail.products p ON t.product_id = p.product_id
    JOIN retail.warehouses w ON t.warehouse_id = w.warehouse_id
    GROUP BY w.warehouse_name;
)
SELECT 
    r.warehouse_name,
    r.warehouse_revenue,
    tc.cogs,
    (r.warehouse_revenue - tc.cogs) AS gross_profit,
    ROUND(((r.warehouse_revenue - tc.cogs) / r.warehouse_revenue) * 100, 2) AS gross_margin_pct
FROM revenue r
JOIN total_cogs tc ON r.warehouse_name = tc.warehouse_name
ORDER BY gross_margin_pct DESC;

-- ============================================
-- KPI 4: SHRINKAGE % PER WAREHOUSE
-- ============================================
SELECT 
    w.warehouse_id, 
    w.warehouse_name, 
    ROUND(COALESCE((
        (SUM(c.system_inventory) - SUM(c.physical_count))::numeric
        / SUM(c.system_inventory)) * 100, 0), 2) AS perc_shrinkage
FROM retail.cycle_counts c
LEFT JOIN retail.warehouses w ON w.warehouse_id = c.warehouse_id
GROUP BY w.warehouse_id, w.warehouse_name
ORDER BY perc_shrinkage DESC;

-- ============================================
-- KPI 5: SHRINKAGE FINANCIAL LOSS PER WAREHOUSE
-- ============================================
WITH cycle_product AS (
    SELECT 
        c.product_id, 
        p.unit_cost, 
        c.warehouse_id
    FROM retail.cycle_counts c
    JOIN retail.products p ON c.product_id = p.product_id
)
SELECT 
    w.warehouse_id, 
    w.warehouse_name, 
    ROUND(COALESCE((
        SUM(c.system_inventory * cp.unit_cost) - 
        SUM(c.physical_count * cp.unit_cost)
    ), 0), 2) AS dollar_shrinkage
FROM retail.cycle_counts c
LEFT JOIN retail.warehouses w ON w.warehouse_id = c.warehouse_id
JOIN cycle_product cp ON c.product_id = cp.product_id
GROUP BY w.warehouse_id, w.warehouse_name
ORDER BY dollar_shrinkage DESC;

-- ============================================
-- KPI 6: ESTIMATED LOST REVENUE FROM STOCKOUTS
-- ============================================
WITH running_inventory AS (
    SELECT
        transaction_date,
        warehouse_id,
        product_id,
        units_sold,
        units_damaged,
        units_received,
        units_returned,
        SUM(units_received + units_returned 
            - units_sold - units_damaged)
        OVER (
            PARTITION BY warehouse_id, product_id
            ORDER BY transaction_date
            ROWS UNBOUNDED PRECEDING
        ) AS running_inventory
    FROM retail.inventory_transactions
),
stockout_days AS (
    SELECT
        transaction_date,
        warehouse_id,
        product_id,
        ABS(running_inventory) AS unmet_demand
    FROM running_inventory
    WHERE running_inventory < 0
)
SELECT
    w.warehouse_name,
    COUNT(*) AS stockout_days,
    SUM(s.unmet_demand * p.unit_price) AS lost_revenue
FROM stockout_days s
JOIN retail.products p ON s.product_id = p.product_id
JOIN retail.warehouses w ON s.warehouse_id = w.warehouse_id
GROUP BY w.warehouse_name
ORDER BY lost_revenue DESC;



-- ========================================================
-- KPI 7: QUARTERLY INVENTORY TURNOVER RATIO BY WAREHOUSE
-- ========================================================

WITH running_inventory AS (
    SELECT
        transaction_date,
        warehouse_id,
        product_id,
        units_sold,
        units_damaged,
        units_received,
        units_returned,
        SUM(units_received + units_returned 
            - units_sold - units_damaged)
        OVER (
            PARTITION BY warehouse_id, product_id
            ORDER BY transaction_date
            ROWS UNBOUNDED PRECEDING
        ) AS running_inventory
    FROM retail.inventory_transactions
),
qtr_cogs AS (
    SELECT 
        r.warehouse_id AS warehouse_id,
        DATE_TRUNC('quarter', r.transaction_date) AS quarter,
        SUM(r.units_sold * p.unit_cost) AS cogs
    FROM running_inventory r
    JOIN retail.products p ON r.product_id = p.product_id
    GROUP BY r.warehouse_id, DATE_TRUNC('quarter', r.transaction_date)
),
first_day_qtr_inv AS (SELECT 
    transaction_date,
    warehouse_id,
    product_id,
    running_inventory
FROM running_inventory
WHERE transaction_date = DATE_TRUNC('quarter', transaction_date)
ORDER BY warehouse_id, product_id, transaction_date),
last_day_qtr_inv AS (SELECT 
    transaction_date,
    warehouse_id,
    product_id,
    running_inventory
FROM running_inventory
WHERE transaction_date = DATE_TRUNC('quarter', transaction_date) 
                       + INTERVAL '3 months' 
                       - INTERVAL '1 day'),
avg_inventory AS (
SELECT 
    f.warehouse_id,
    DATE_TRUNC('quarter', f.transaction_date) AS quarter,
	SUM(qc.cogs) AS total_cogs,
	SUM((f.running_inventory + l.running_inventory) / 2 * p.unit_cost) AS avg_inventory_dollars
FROM first_day_qtr_inv f
JOIN retail.products p ON f.product_id = p.product_id
JOIN last_day_qtr_inv l 
    ON f.product_id = l.product_id
    AND f.warehouse_id = l.warehouse_id
    AND DATE_TRUNC('quarter', f.transaction_date) = 
        DATE_TRUNC('quarter', l.transaction_date)
	JOIN qtr_cogs qc ON f.warehouse_id = qc.warehouse_id
	AND DATE_TRUNC('quarter', f.transaction_date) = qc.quarter
	GROUP BY 
        f.warehouse_id,
        DATE_TRUNC('quarter', f.transaction_date)
	ORDER BY f.warehouse_id, quarter
	)
SELECT 
    w.warehouse_name,
    a.quarter,
    ROUND(a.total_cogs / 
          NULLIF(a.avg_inventory_dollars, 0), 2) AS turnover_ratio
FROM avg_inventory a
JOIN retail.warehouses w ON a.warehouse_id = w.warehouse_id
ORDER BY w.warehouse_name, a.quarter;