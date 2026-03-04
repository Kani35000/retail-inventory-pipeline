# Retail Inventory Optimization & Profitability Protection Pipeline

## Business Problem
Specialty retail companies lose significant margin every year due to shrinkage, 
stockouts, and inefficient inventory turnover. Leadership often lacks an integrated 
analytics system to quantify the financial impact and make data-driven inventory 
decisions across multiple warehouse locations.

## What This Project Solves
This pipeline answers five critical business questions:
1. How much money are we losing due to shrinkage?
2. How much revenue are we losing due to stockouts?
3. Which SKUs are tying up too much capital?
4. Which warehouses are underperforming?
5. What is the projected ROI if inventory accuracy improves by 5%?

## Project Architecture
```
retail-inventory-pipeline/
├── 01_database/        # Schema, seed data, and KPI SQL queries
├── 02_pipeline/        # Python automation scripts for data refresh
├── 03_powerbi/         # Power BI dashboard file
└── 04_presentation/    # Executive PowerPoint summary
```

## Tech Stack
| Layer | Tool |
|---|---|
| Database | PostgreSQL (pgAdmin) |
| Pipeline Automation | Python (pandas, psycopg2, sqlalchemy) |
| Dashboard | Power BI |
| Presentation | PowerPoint |
| Version Control | Git + GitHub |

## Business Scenario
A specialty retail company (modeled after operational realities in retail 
distribution) operates:
- 5 regional distribution warehouses across the US
- 100+ SKUs across multiple product categories
- 12 months of daily inventory transactions
- Monthly cycle counts for shrinkage detection

## Warehouses
| ID | Name | Region |
|---|---|---|
| 1 | Dallas Distribution Center | Southwest |
| 2 | Atlanta Distribution Center | Southeast |
| 3 | New Jersey Distribution Center | Northeast |
| 4 | Chicago Distribution Center | Midwest |
| 5 | Los Angeles Distribution Center | West |

## Executive KPIs
1. Total Revenue
2. Total COGS
3. Gross Margin
4. Shrinkage % 
5. Shrinkage Financial Loss
6. Estimated Lost Revenue from Stockouts
7. Inventory Turnover Ratio
8. Days of Inventory on Hand
9. Potential Savings from 5% Shrinkage Reduction

## Status
🔨 In Progress — Database layer complete, KPI queries in development

## Author
**kani okorji**  
Masters in Project Management (Analytics Concentration) | MBA  
Linkedin Profile URL: (https://www.linkedin.com/in/kani-okorji-20869666/) 
GitHub Profile URL: (https://github.com/Kani35000)
