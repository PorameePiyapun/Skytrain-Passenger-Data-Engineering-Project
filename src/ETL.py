import pandas as pd
from sqlalchemy import create_engine
from datetime import datetime
import os
from dotenv import load_dotenv

def extract(data_source):
    return pd.read_csv(data_source)

def transform(data):
    data['Date'] = pd.to_datetime(data['Date'], format='%m/%d/%Y')
    data['DayOfWeek'] = data['Date'].dt.day_name()
    data.dropna(inplace=True)

    def time_categorize(time_str):
        hour = int(time_str.split(':')[0]) 
        if 5 <= hour < 12:
            return 'Morning'
        elif 12 <= hour < 15:
            return 'Afternoon'
        elif 16 <= hour < 18:
            return 'Evening'
        else:
            return 'Night'

    data['Daytime'] = data['time'].apply(time_categorize)

    output_folder = "D:\\coding\\data_en\\data\\processed"
    os.makedirs(output_folder, exist_ok=True)
    output_file = os.path.join(output_folder, f"Skytrain_data_Processed_{datetime.now().strftime('%Y%m%d')}.csv")
    data.to_csv(output_file, index=False)

    return data

def load(data, table_name):
    # Load environment variables
    username = os.getenv("DB_USERNAME")
    password = os.getenv("DB_PASSWORD")
    host = os.getenv("DB_HOST")
    port = os.getenv("DB_PORT")
    database = os.getenv("DB_NAME")

    database_url = f"mysql+pymysql://{username}:{password}@{host}:{port}/{database}"

    engine = create_engine(database_url)

    data.to_sql(table_name, con=engine, if_exists='replace', index=False, method='multi')

    print("Data loaded successfully.")

if __name__ == "__main__":
    file_path = "D:\\coding\\data_en\\data\\raw\\skytrain_data.csv"
    raw_data = extract(file_path)
    transformed_data = transform(raw_data)
    table_name = "skytrain_data"
    load(transformed_data, table_name)

    print("ETL pipeline completed.")
