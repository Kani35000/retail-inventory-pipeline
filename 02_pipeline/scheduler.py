# ============================================
# AUTOMATION SCHEDULER
# retail-inventory-pipeline/02_pipeline/scheduler.py
# ============================================

from extract_data import extract_transactions, extract_cycle_counts
from running_inventory import calculate_running_inventory, flag_stockouts
from shrinkage_analysis import get_shrinkage_summary, calculate_shrinkage
from stockout_detection import detect_stockout
from db_connection import get_engine
import schedule
import time

def run_nightly_pipeline():
    print("🔄 Starting nightly pipeline...")
    
    # Step 1 - Extract fresh data
    df = extract_transactions()
    
    # Step 2 - Calculate running inventory
    df_run_inv = calculate_running_inventory(df)
    
    # Step 3 - Detect stockouts
    stockouts = flag_stockouts(df_run_inv)
    
    # Step 4 - Calculate shrinkage
    df_cycle = extract_cycle_counts()
    shrinkage = get_shrinkage_summary(df_cycle)
    perc_shrinkage = calculate_shrinkage(shrinkage)
    
    # Step 5 - Generate KPI summary
    summary = detect_stockout(stockouts)
    
    # Step 6 - Save to database
    engine = get_engine()
    summary.to_sql('kpi_daily_summary', 
                   engine, if_exists='replace', index=False)
    print("✅ KPI summary saved to database")
    
    # Step 7 - Send alert if high shrinkage
    if perc_shrinkage['perc_shrinkage_loss'].max() > 5:
        print("🚨 HIGH SHRINKAGE ALERT")
        print(perc_shrinkage[
            perc_shrinkage['perc_shrinkage_loss'] > 5
        ][['warehouse_name', 'perc_shrinkage_loss']])
    
    print("✅ Nightly pipeline complete")

# Schedule to run every night at midnight
schedule.every().day.at("00:00").do(run_nightly_pipeline)

while True:
    try:
        schedule.run_pending()
    except Exception as e:
        print(f"❌ Scheduler error: {e}")
    time.sleep(60)