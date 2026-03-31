# ============================================
# SHRINKAGE ANALYSIS
# retail-inventory-pipeline/02_pipeline/shrinkage_analysis.py
# ============================================
# Equivalent SQL logic from KPI 4 and KPI 5:
# shrinkage % = (system_inventory - physical_count) 
#             / system_inventory * 100

import pandas as pd
from extract_data import extract_cycle_counts

df = extract_cycle_counts()
df['dollar_loss'] = (
    (df['system_inventory'] - df['physical_count']) 
    * df['unit_cost']
)

shrinkage_summary = df.groupby('warehouse_name').agg(
    total_system_inventory = ('system_inventory', 'sum'),
    total_physical_count   = ('physical_count', 'sum'),
    total_dollar_loss      = ('dollar_loss', 'sum')
).reset_index()


def get_shrinkage_summary(df):
    df['dollar_loss'] = (
        (df['system_inventory'] - df['physical_count']) 
        * df['unit_cost']
    )
    #  Shrinkage % per warehouse
    shrinkage_summary = df.groupby('warehouse_name').agg(
        total_system_inventory = ('system_inventory', 'sum'),
        total_physical_count   = ('physical_count', 'sum'),
        total_dollar_loss      = ('dollar_loss', 'sum')
    ).reset_index()
    return shrinkage_summary

def calculate_shrinkage(shrinkage_summary):
    shrinkage_summary['perc_shrinkage_loss'] = round((
        (shrinkage_summary['total_system_inventory'] - 
         shrinkage_summary['total_physical_count']) /
         shrinkage_summary['total_system_inventory'] * 100
    ), 2)
    return shrinkage_summary

shrinkage_summary = calculate_shrinkage(shrinkage_summary)


def get_high_shrinkage_warehouses(shrinkage_summary, 
                                   high_shrinkage=5.0):
    high_shrink_df = shrinkage_summary[
        shrinkage_summary['perc_shrinkage_loss'] >= high_shrinkage
    ]
    return high_shrink_df

print("\n📊 Full Shrinkage Summary:")
print(shrinkage_summary.sort_values(
    'total_dollar_loss', ascending=False
).to_string(index=False))

high_shrinkage = get_high_shrinkage_warehouses(shrinkage_summary)
print("\n🚨 High Shrinkage Warehouses (>5%):")
print(high_shrinkage[[
    'warehouse_name',
    'perc_shrinkage_loss',
    'total_dollar_loss'
]].to_string(index=False))

total_loss = shrinkage_summary['total_dollar_loss'].sum()
print(f"\n💰 Total Network Loss: ${total_loss:,.2f}")