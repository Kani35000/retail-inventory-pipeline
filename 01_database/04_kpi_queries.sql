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