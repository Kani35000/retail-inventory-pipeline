# ============================================
# DATABASE CONNECTION
# retail-inventory-pipeline/02_pipeline/db_connection.py
# ============================================

from sqlalchemy import create_engine

# Database connection settings
DB_HOST     = "localhost"
DB_PORT     = "5432"
DB_NAME     = "retail_analytics"
DB_USER     = "postgres"
DB_PASSWORD = "TDjakes35"

def get_engine():
    """Create and return database connection engine"""
    connection_string = (
        f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}"
        f"@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    )
    engine = create_engine(connection_string)
    return engine

def test_connection():
    """Test database connection"""
    try:
        engine = get_engine()
        with engine.connect() as conn:
            print("✅ Database connection successful")
            return True
    except Exception as e:
        print(f"❌ Connection failed: {e}")
        return False

if __name__ == "__main__":
    test_connection()