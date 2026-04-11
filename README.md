# Retail Inventory Optimization & Profitability Protection Pipeline

> **Kani Okorji** | BI Analyst | Retail Inventory Analytics
> SQL • Python • Power BI | Manhattan Associates | IBM Cognos
>
> An end-to-end retail inventory analytics pipeline 
> quantifying $163.9M in stockout losses and $385,625 
> in shrinkage losses across 183,000 transactions. 
> Identifies Chicago and Dallas as high-shrinkage 
> warehouses and Atlanta and LA as demand-driven 
> stockout warehouses — enabling targeted inventory 
> optimization strategies across 5 distribution centers.
>
> 📍 Dallas, TX | 🔗 [LinkedIn](https://www.linkedin.com/in/kani-okorji-20869666/) | 💻 [GitHub](https://github.com/Kani35000)


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

## 📊 KPI Story Arc
This project tells one connected executive story across 9 KPIs:

| KPI | Focus | Business Question |
|---|---|---|
| KPI 1-3 | Revenue & Profitability | What is our baseline performance? |
| KPI 4-5 | Shrinkage Analysis | Where are we losing to theft and damage? |
| KPI 6 | Stockout Analysis | Where are we losing to unmet demand? |
| KPI 7 | Inventory Turnover | How efficiently are we cycling inventory seasonally? |
| KPI 8 | Days Inventory on Hand | How long is inventory sitting idle? |
| KPI 9 | ROI Scenario Analysis | What happens if we fix the problems? |

### 📌 KPI Progress
| KPI | Description | Status |
|-----|-------------|--------|
| KPI 1 | Total Revenue per Warehouse | ✅ Complete |
| KPI 2 | Total COGS per Warehouse | ✅ Complete |
| KPI 3 | Gross Margin per Warehouse | ✅ Complete |
| KPI 4 | Shrinkage % per Warehouse | ✅ Complete |
| KPI 5 | Shrinkage Financial Loss | ✅ Complete |
| KPI 6 | Stockout Revenue Loss | ✅ Complete |
| KPI 7 | Quarterly Inventory Turnover Ratio | ✅ Complete |
| KPI 8 | Days Inventory on Hand | ✅ Complete |
| KPI 9 | ROI Scenario Analysis | ✅ Complete |


## 🤖 Pipeline Automation
This project includes a Python automation layer that runs nightly to:

### Why Automation Matters
| Without Automation | With Automation |
|---|---|
| Analyst runs reports manually | System runs every night |
| Stockouts discovered weekly | Stockouts flagged next morning |
| Revenue already lost | Reorder triggered immediately |
| Reactive decision making | Proactive inventory management |

### 🐍 Pipeline Scripts
| Script | Description | Status |
|---|---|---|
| db_connection.py | PostgreSQL connection engine | ✅ Complete |
| extract_data.py | Extract transactions and cycle counts | ✅ Complete |
| running_inventory.py | Calculate daily running inventory | ✅ Complete |
| shrinkage_analysis.py | Calculate shrinkage losses | ✅ Complete |
| stockout_detection.py | Detect stockout events | ✅ Complete |
| kpi_summary.py | Combine all KPI findings | ✅ Complete |
| scheduler.py | Nightly automated pipeline | 🔨 In Progress |

## Pipeline Complete
```
✅ db_connection.py    → PostgreSQL bridge
✅ extract_data.py     → 183,000 rows extracted
✅ running_inventory.py → cumulative stock calculation
✅ shrinkage_analysis.py → $385,625 loss identified
✅ stockout_detection.py → 28,769 stockout events
✅ kpi_summary.py      → executive combined view

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

## Project Status
| Layer | Status |
|---|---|
| Database & Seed Data | ✅ Complete |
| KPI SQL Queries (9/9) | ✅ Complete |
| Python Pipeline (6/6)| ✅ Complete |
| Pipeline Automation | 🔨 In Progress |
| Power BI Dashboard (5/5 pages)  | ✅ Complete |
| Executive Presentation | 🔨 Planned |

##  Dashboard progress
✅ Page 1 → Executive Summary
✅ Page 2 → Shrinkage Analysis
✅ Page 3 → Stockout Analysis
✅ Page 4 → Inventory Efficiency
✅ Page 5 → ROI Scenario

## 📊 Dashboard Screenshots

### Page 1 — Executive Summary
-[Executive Summary](03_powerbi/screenshots/page1_executive_summary.png)

### Page 2 — Shrinkage Analysis
-[Shrinkage Analysis](03_powerbi/screenshots/page2_shrinkage_analysis.png)

### Page 3 — Stockout Analysis
-[Stockout Analysis](03_powerbi/screenshots/page3_stockout_analysis.png)

### Page 4 — Inventory Efficiency
-[Inventory Efficiency](03_powerbi/screenshots/page4_inventory_efficiency.png)

### Page 5 — ROI Scenario
-[ROI Scenario](03_powerbi/screenshots/page5_roi_scenario.png)

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
| Chicago Distribution Center | 9.01% | $137,061 |
| Dallas Distribution Center | 8.97% | $134,614 |
| New Jersey Distribution Center | 2.52% | $38,016 |
| Los Angeles Distribution Center | 2.51% | $37,985 |
| Atlanta Distribution Center | 2.53% | $37,947 |

### 📦 Stockout Revenue Loss
| Warehouse | Stockout Days | Lost Revenue |
|---|---|---|
| Atlanta Distribution Center | 5,902 | $38.3M |
| Los Angeles Distribution Center | 6,321 | $35.4M |
| New Jersey Distribution Center | 5,697 | $33.7M |
| Dallas Distribution Center | 5,531 | $29.9M |
| Chicago Distribution Center | 5,318 | $26.6M |

### 📈 Quarterly Inventory Turnover Ratio
| Warehouse | Q2 (Apr-Jun) | Q3 (Jul-Sep) | Q4 (Oct-Dec) |
|---|---|---|---|
| Atlanta Distribution Center | 881.83 | 384.90 | 1,345.89 |
| Los Angeles Distribution Center | 823.89 | 376.54 | 1,307.47 |
| New Jersey Distribution Center | 844.71 | 370.22 | 1,210.05 |
| Dallas Distribution Center | 787.63 | 358.21 | 1,177.33 |
| Chicago Distribution Center | 815.25 | 365.80 | 1,130.30 |

### 💡 Turnover Insights
| Finding | Implication |
|---|---|
| Q4 highest turnover across all warehouses | Holiday demand confirmed |
| Q3 lowest turnover across all warehouses | Pre-holiday inventory buildup |
| Atlanta leads turnover efficiency | Demand consistently exceeds supply |
| Chicago lowest turnover | Inventory sits longer enabling shrinkage |

> **Conclusion:** Turnover ratios confirm seasonal demand patterns 
> and warehouse efficiency rankings consistent with shrinkage 
> and stockout findings — Chicago and Dallas underperform 
> while Atlanta and LA face demand driven inventory pressure.

### 📅 Days Inventory on Hand (DIH)
| Warehouse | Q2 (Apr-Jun) | Q3 (Jul-Sep) | Q4 (Oct-Dec) |
|---|---|---|---|
| Atlanta Distribution Center | 0.10 | 0.23 | 0.07 |
| Los Angeles Distribution Center | 0.11 | 0.24 | 0.07 |
| New Jersey Distribution Center | 0.11 | 0.24 | 0.07 |
| Dallas Distribution Center | 0.11 | 0.25 | 0.08 |
| Chicago Distribution Center | 0.11 | 0.25 | 0.08 |

> **Note:** DIH values reflect simulation constraints.
> Interpret for relative comparison and seasonal 
> patterns only. Realistic retail DIH = 15-90 days.

### 💡 DIH Insights
| Finding | Implication |
|---|---|
| Q3 highest DIH across all warehouses | Pre-holiday inventory buildup |
| Q4 lowest DIH across all warehouses | Holiday demand depleting stock fastest |
| Atlanta lowest DIH in Q4 | Demand outpacing supply confirmed |
| Chicago highest DIH consistently | Inventory sitting longer enabling shrinkage |

> **Conclusion:** DIH confirms the inverse relationship 
> with turnover — warehouses with highest stockout losses 
> carry the least days of inventory while warehouses 
> with highest shrinkage carry the most, suggesting 
> fundamentally different inventory management 
> challenges requiring targeted solutions.

### 💰 ROI Scenario Analysis (5% Shrinkage Reduction)
| Warehouse | Current Loss | Projected Loss | Savings |
|---|---|---|---|
| Chicago Distribution Center | $137,061 | $130,208 | $6,853 |
| Dallas Distribution Center | $134,614 | $127,883 | $6,730 |
| New Jersey Distribution Center | $38,016 | $36,115 | $1,900 |
| Los Angeles Distribution Center | $37,985 | $36,086 | $1,899 |
| Atlanta Distribution Center | $37,947 | $36,049 | $1,897 |

### 🚨 Updated Executive Insights
| Metric | Value |
|---|---|
| Total Company Revenue | $143.2M |
| Total Shrinkage Loss | $25.1M |
| Total Stockout Lost Revenue | $163.9M |
| Combined Revenue at Risk | $188.9M |
| Projected Savings from 5% Shrinkage Reduction | $1,253,282 |
| Chicago + Dallas Savings Potential | $882,947 (70% of total) |

> **Conclusion:** A targeted 5% shrinkage reduction 
> at Chicago and Dallas alone would recover $882,947 
> annually — representing the highest ROI opportunity 
> for loss prevention investment across the network.

### 🚨 Executive Insights
| Metric | Value |
|---|---|
| Total Shrinkage Loss | $385,625 |
| Chicago + Dallas Combined | $271,675 (70% of total) |
| Total Projected Savings 5% | $19,281 |

### 💡 Key Finding
| Warehouse Group | Primary Problem | Recommended Action |
|---|---|---|
| Chicago + Dallas | High shrinkage 9%+ | Loss prevention, security |
| Atlanta + LA | High stockout loss | Better forecasting, faster reorder |


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


### Stockout Lost Revenue Calculation
Two approaches implemented with different results:

| Approach | Method | Result |
|---|---|---|
| SQL (KPI 6) | ABS(running_inventory) × unit_price | $163.9M |
| Python pipeline | ABS(net_units) × unit_price | $10.1M |

Both are approximations of true lost revenue.
SQL approach uses cumulative inventory deficit.
Python approach uses daily net flow deficit.
True lost revenue requires customer demand data
not available in current simulation.
This update was made after cross validation during pipeline development


### Inventory Turnover Interpretation
Turnover ratios reflect relative warehouse performance 
and seasonal patterns rather than absolute benchmarks.

| Context | Realistic Range | Simulation Result |
|---|---|---|
| Quarterly turnover | 1x - 4x | 300x - 1,300x |

### Days Inventory on hand
→ Days Inventory on Hand reflects same simulation
  constraints as turnover ratio. Absolute values
  should be interpreted for relative comparison
  and seasonal patterns only.

### Recommended Next Steps
| Priority | Enhancement | Business Impact |
|---|---|---|
| High | Add supplier lead time data | Identify delay-driven stockouts |
| High | Add demand forecasting | Improve inventory planning |
| Medium | Add vendor agreement table | Calculate true net shrinkage loss |
| Medium | Add warehouse transfer data | Identify allocation inefficiencies |
| Low | Add customer demand data | Calculate true lost revenue |

### 🔮 Future Technical Enhancements
| Enhancement | Tool | Business Value |
|---|---|---|
| Cloud data warehouse migration | Snowflake or BigQuery | Scalability |
| Data transformation layer | dbt | Standardized models |
| Workflow orchestration | Apache Airflow | Pipeline scheduling |
| Real time streaming | Kafka | Live inventory updates |

## Author
**kani okorji**  
Masters in Project Management (Analytics Concentration) | MBA  
Linkedin Profile URL: (https://www.linkedin.com/in/kani-okorji-20869666/) 
GitHub Profile URL: (https://github.com/Kani35000)
