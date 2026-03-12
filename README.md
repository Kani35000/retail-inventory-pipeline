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


## 🤖 Pipeline Automation
This project includes a Python automation layer that runs nightly to:

| Automation Feature | Tool | Status |
|---|---|---|
| Extract data from PostgreSQL | Python + SQLAlchemy | 🔨 In Progress |
| Calculate running inventory per SKU | Python + Pandas | 🔨 In Progress |
| Detect stockout events automatically | Python + Pandas | 🔨 Planned |
| Flag low stock alerts by warehouse | Python + Pandas | 🔨 Planned |
| Refresh Power BI dashboard data | Python + Power BI API | 🔨 Planned |
| Generate nightly stockout report | Python + Email | 🔨 Planned |

### Why Automation Matters
| Without Automation | With Automation |
|---|---|
| Analyst runs reports manually | System runs every night |
| Stockouts discovered weekly | Stockouts flagged next morning |
| Revenue already lost | Reorder triggered immediately |
| Reactive decision making | Proactive inventory management |

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

## 📊 Key Findings So Far

### 💰 Revenue & Profitability
| Warehouse | Revenue | COGS | Gross Margin % |
|---|---|---|---|
| Atlanta Distribution Center | $28.7M | $9.3M | 67.6% |
| Los Angeles Distribution Center | $28.7M | $9.3M | 67.5% |
| Dallas Distribution Center | $28.7M | $9.3M | 67.6% |
| New Jersey Distribution Center | $28.6M | $9.3M | 67.6% |
| Chicago Distribution Center | $28.6M | $9.2M | 67.6% |

### 🔍 Shrinkage Analysis
| Warehouse | Shrinkage % | Dollar Loss |
|---|---|---|
| Chicago Distribution Center | 9.01% | $8.9M |
| Dallas Distribution Center | 8.97% | $8.7M |
| Atlanta Distribution Center | 2.53% | $2.5M |
| New Jersey Distribution Center | 2.52% | $2.5M |
| Los Angeles Distribution Center | 2.51% | $2.5M |

### 📦 Stockout Revenue Loss
| Warehouse | Stockout Days | Lost Revenue |
|---|---|---|
| Atlanta Distribution Center | 5,902 | $38.3M |
| Los Angeles Distribution Center | 6,321 | $35.4M |
| New Jersey Distribution Center | 5,697 | $33.7M |
| Dallas Distribution Center | 5,531 | $29.9M |
| Chicago Distribution Center | 5,318 | $26.6M |

### 🚨 Executive Insights
| Metric | Value |
|---|---|
| Total Company Revenue | $143.2M |
| Total Shrinkage Loss | $25.1M |
| Chicago + Dallas Shrinkage | $17.6M (72% of total) |
| Total Stockout Lost Revenue | $163.9M |
| Atlanta + LA Stockout Loss | $73.7M (45% of total) |

### 💡 Key Finding
| Warehouse Group | Primary Problem | Recommended Action |
|---|---|---|
| Chicago + Dallas | High shrinkage 9%+ | Loss prevention, security |
| Atlanta + LA | High stockout loss | Better forecasting, faster reorder |


### 📌 KPI Progress
| KPI | Description | Status |
|-----|-------------|--------|
| KPI 1 | Total Revenue per Warehouse | ✅ Complete |
| KPI 2 | Total COGS per Warehouse | ✅ Complete |
| KPI 3 | Gross Margin per Warehouse | ✅ Complete |
| KPI 4 | Shrinkage % per Warehouse | ✅ Complete |
| KPI 5 | Shrinkage Financial Loss | ✅ Complete |
| KPI 6 | Stockout Revenue Loss | 🔨 ✅ Complete |
| KPI 7 | Inventory Turnover Ratio | 🔨 In Progress |
| KPI 8 | Days Inventory on Hand | 🔨 In Progress |
| KPI 9 | ROI Scenario Analysis | 🔨 In Progress |


## 🔬 Limitations & Further Investigation

### Current Model Limitations
Stockout detection identifies days where cumulative 
running inventory falls below zero per product per 
warehouse. Calculated as:

`Running Inventory = SUM(units_received + units_returned - units_sold - units_damaged)`

This captures demand-spike and damage driven stockouts 
but does not account for:

> **Note:** In a production environment using enterprise 
> WMS systems such as Manhattan Associates, exact inventory 
> positions and true stockout events would be tracked in 
> real time, providing more precise stockout detection 
> than this proxy formula.

| Limitation | Missing Data | Future Enhancement |
|---|---|---|
| Supply chain delays | No delivery date column | Add supplier lead time table |
| Poor forecasting | No forecast column | Add demand forecast table |
| Allocation errors | No transfer column | Add warehouse transfer table |
| Receiving errors | No receiving accuracy column | Add receiving audit table |
| Minimum order issues | No vendor column | Add vendor agreement table |

### Recommended Next Steps
| Priority | Enhancement | Business Impact |
|---|---|---|
| High | Add supplier lead time data | Identify delay-driven stockouts |
| High | Add demand forecasting | Improve inventory planning |
| Medium | Add vendor agreement table | Calculate true net shrinkage loss |
| Medium | Add warehouse transfer data | Identify allocation inefficiencies |
| Low | Add customer demand data | Calculate true lost revenue |


## Author
**kani okorji**  
Masters in Project Management (Analytics Concentration) | MBA  
Linkedin Profile URL: (https://www.linkedin.com/in/kani-okorji-20869666/) 
GitHub Profile URL: (https://github.com/Kani35000)
