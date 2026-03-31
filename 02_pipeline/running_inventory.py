# ============================================
# RUNNING INVENTORY CALCULATION
# retail-inventory-pipeline/02_pipeline/running_inventory.py
# ============================================

import pandas as pd
from extract_data import extract_transactions



def calculate_running_inventory(df):
    """
    Calculate daily running inventory per 
    product per warehouse
    
    Equivalent SQL logic:
    SUM(units_received + units_returned 
        - units_sold - units_damaged)
    OVER (PARTITION BY warehouse_id, product_id
          ORDER BY transaction_date
          ROWS UNBOUNDED PRECEDING)
    """
    
    # Step 1 - Sort by warehouse, product, date
    # Same as ORDER BY in window function
    df = df.sort_values(
        ['warehouse_id', 'product_id', 'transaction_date']
    ).reset_index(drop=True)
    
    # Step 2 - Calculate daily net units
    # received + returned - sold - damaged
    df['net_units'] = (
        df['units_received'] 
        + df['units_returned'] 
        - df['units_sold'] 
        - df['units_damaged']
    )
    
    # Step 3 - Calculate running inventory
    # groupby = PARTITION BY
    # cumsum  = ROWS UNBOUNDED PRECEDING
    df['running_inventory'] = df.groupby(
        ['warehouse_id', 'product_id']
    )['net_units'].cumsum()
    
    print(f"✅ Running inventory calculated")
    print(f"   Total rows: {len(df):,}")
    
    return df


def flag_stockouts(df):
    """
    Flag rows where running inventory
    falls below zero
    """
    stockouts = df[df['running_inventory'] < 0].copy()
    
    print(f"✅ Stockout events identified")
    print(f"   Total stockout rows: {len(stockouts):,}")
    
    return stockouts

if __name__ == "__main__":
    # Extract data
    print("📥 Extracting transaction data...")
    transactions = extract_transactions()
    
    # Calculate running inventory
    print("\n⚙️  Calculating running inventory...")
    df_inventory = calculate_running_inventory(transactions)
    
    # Flag stockouts
    print("\n🚨 Flagging stockout events...")
    df_stockouts = flag_stockouts(df_inventory)
    
    # Preview results
    print("\n📊 Sample running inventory:")
    print(df_inventory[
        ['transaction_date', 'warehouse_name', 
         'product_name', 'net_units', 'running_inventory']
    ].head(10))
    
    print("\n📊 Sample stockout events:")
    print(df_stockouts[
        ['transaction_date', 'warehouse_name',
         'product_name', 'running_inventory']
    ].head(10))




