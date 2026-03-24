from running_inventory import calculate_running_inventory
from running_inventory import flag_stockouts
from extract_data import extract_transactions

# Get transactions
df = extract_transactions()

# Calculate running inventory
df = calculate_running_inventory(df)

# Flag stockouts
stockouts = flag_stockouts(df)

def detect_stockout(stockouts, df):
    if len(stockouts) > 0:
        # Daily unmet demand = ABS(net_units) 
        # when running_inventory < 0
        stockouts['lost_revenue'] = round(
            abs(stockouts['net_units']) 
            * stockouts['unit_price'], 2)
        
        stockouts_summary = stockouts.groupby(
            'warehouse_name').agg(
                stockout_days = ('transaction_date', 'count'),
                lost_revenue  = ('lost_revenue', 'sum')
        ).reset_index()
        
        return stockouts_summary.sort_values(
            'lost_revenue', ascending=False)





