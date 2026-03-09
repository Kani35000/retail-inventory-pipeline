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
	