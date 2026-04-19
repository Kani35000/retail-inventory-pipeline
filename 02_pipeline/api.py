# 02_pipeline/api.py

from fastapi import FastAPI
from shrinkage_analysis import get_shrinkage_summary
from shrinkage_analysis import calculate_shrinkage
from extract_data import extract_cycle_counts
from extract_data import extract_transactions
from running_inventory import calculate_running_inventory
from running_inventory import flag_stockouts
from stockout_detection import detect_stockout
from kpi_summary import calculate_revenue_by_warehouse

app = FastAPI(
    title="Retail Inventory Analytics API",
    description="REST API for retail inventory KPI data",
    version="1.0.0"
)

@app.get("/")
def root():
    return {
        "message": "Retail Inventory Analytics API",
        "version": "1.0.0",
        "endpoints": [
            "/api/kpi/shrinkage",
            "/api/kpi/stockouts",
            "/api/kpi/summary"
        ]
    }

@app.get("/api/kpi/shrinkage")
def get_shrinkage():
    df = extract_cycle_counts()
    summary = get_shrinkage_summary(df)
    result = calculate_shrinkage(summary)
    return result[[
        'warehouse_name',
        'perc_shrinkage_loss',
        'total_dollar_loss'
    ]].to_dict(orient='records')

@app.get("/api/kpi/stockouts")
def get_stockouts():
    df = extract_transactions()
    df = calculate_running_inventory(df)
    stockouts = flag_stockouts(df)
    result = detect_stockout(stockouts)
    return result.to_dict(orient='records')

@app.get("/api/kpi/summary")
def get_summary():
    # Extract data
    df_transactions = extract_transactions()
    df_cycle = extract_cycle_counts()

    # Calculate revenue
    revenue_df = calculate_revenue_by_warehouse(df_transactions)
    total_revenue = round(revenue_df['revenue'].sum(), 2)

    # Calculate shrinkage
    shrinkage_summary = get_shrinkage_summary(df_cycle)
    shrinkage_df = calculate_shrinkage(shrinkage_summary)
    total_shrinkage = round(
        shrinkage_df['total_dollar_loss'].sum(), 2
    )

    # Calculate stockouts
    df_inv = calculate_running_inventory(df_transactions)
    stockouts = flag_stockouts(df_inv)
    stockout_df = detect_stockout(stockouts)
    total_stockout = round(
        stockout_df['lost_revenue'].sum(), 2
    )

    # Calculate combined metrics
    combined_loss = round(
        total_shrinkage + total_stockout, 2
    )
    projected_savings = round(
        total_shrinkage * 0.05, 2
    )

    return {
        "total_revenue": total_revenue,
        "shrinkage_loss": total_shrinkage,
        "stockout_loss": total_stockout,
        "combined_loss": combined_loss,
        "projected_savings": projected_savings
    }
