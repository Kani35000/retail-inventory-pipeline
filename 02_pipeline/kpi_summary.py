import pandas as pd
from extract_data import extract_transactions, extract_cycle_counts
from running_inventory import calculate_running_inventory, flag_stockouts
from shrinkage_analysis import get_high_shrinkage_warehouses, get_shrinkage_summary, calculate_shrinkage
from stockout_detection import detect_stockout

# Warehouse    | Revenue | Shrinkage%- | Shrinkage$- | Stockout Days- | Stockout Loss-


# # Get stockout loss

# Calculate revenue by warehouse
df_extract_transactions = extract_transactions()
df_cycle_counts = extract_cycle_counts()

def calculate_revenue_by_warehouse(df_extract_transactions):
    df_extract_transactions['revenue'] = df_extract_transactions['units_sold'] * df_extract_transactions['unit_price']
    revenue = df_extract_transactions.groupby('warehouse_name').agg(
        revenue = ('revenue', 'sum')
    ).reset_index()
    return revenue

df_revenue_by_warehouse = calculate_revenue_by_warehouse(df_extract_transactions)
df_shrinkage_loss_cycle_counts = extract_cycle_counts()

shrinkage_summary = get_shrinkage_summary(df_shrinkage_loss_cycle_counts)

perc_shrinkage_by_warehouse = calculate_shrinkage(shrinkage_summary)

df_running_inventory = calculate_running_inventory(df_extract_transactions)
stockouts = flag_stockouts(df_running_inventory)
detect_stockouted = detect_stockout(stockouts)


shrinkage = perc_shrinkage_by_warehouse[['warehouse_name', 'total_dollar_loss' , 'perc_shrinkage_loss' ]]


kpi_summary = df_revenue_by_warehouse.merge(shrinkage, on = 'warehouse_name').merge(detect_stockouted, on = 'warehouse_name')


print("\n💰 Network Executive Summary:")
print(f"Total Revenue:        ${kpi_summary['revenue'].sum():,.2f}")
print(f"Total Shrinkage Loss: ${kpi_summary['total_dollar_loss'].sum():,.2f}")
print(f"Total Stockout Loss:  ${kpi_summary['lost_revenue'].sum():,.2f}")
print(f"Total Loss Exposure:  ${(kpi_summary['total_dollar_loss'].sum() + kpi_summary['lost_revenue'].sum()):,.2f}")

kpi_summary.columns = [
    'Warehouse',
    'Revenue',
    'Shrinkage Loss',
    'Shrinkage %',
    'Stockout Days',
    'Stockout Loss'
]
# Adding Loss % of Revenue per warehouse
kpi_summary['loss_%'] = (
    (kpi_summary['Shrinkage Loss'] + kpi_summary['Stockout Loss']) 
    / kpi_summary['Revenue']
) * 100

print(kpi_summary)
