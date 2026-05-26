# Edward Noonan
# Contact Information:
#   email: ednoonan22@gmail.com
#   phone: 618 670 6699
# File Function: Cleaning sales_pipeline_analysis Datasets
# Last Updated: 5/24/2026 17:26

# Note to viewer: sales_pipeline_analysis/notebooks/01_data_cleaning...
# ...provides a script walkthrough.

import pandas as pd
from pathlib import Path

raw_path = Path(r"...\data\raw")
clean_path = Path(r"...\data\cleaned")

accounts_raw = pd.read_csv(raw_path / "accounts_raw.csv")
products_raw = pd.read_csv(raw_path / "products_raw.csv")
teams_raw = pd.read_csv(raw_path / "teams_raw.csv")
pipeline_raw = pd.read_csv(raw_path / "pipeline_raw.csv")

pipeline_raw.head()

accounts_raw.head()

products_raw.head()

teams_raw.head()


accounts_raw.columns = accounts_raw.columns.str.lower().str.strip()
products_raw.columns = products_raw.columns.str.lower().str.strip()
pipeline_raw.columns = pipeline_raw.columns.str.lower().str.strip()
teams_raw.columns = teams_raw.columns.str.lower().str.strip()

pipeline_raw['product'] = pipeline_raw['product'].replace({'GTXPro': 'Gtx Pro'})

def clean_text(x):
    if pd.isna(x):
        return x
    return x.strip().title()

pipeline_raw['product'] = pipeline_raw['product'].apply(clean_text)
products_raw['product'] = products_raw['product'].apply(clean_text)

pipeline_raw['product'] = pipeline_raw['product'].replace({'GTXPro': 'Gtx Pro'})


accounts_raw['account'] = accounts_raw['account'].apply(clean_text)
pipeline_raw['account'] = pipeline_raw['account'].apply(clean_text)

set(pipeline_raw['account']) - set(accounts_raw['account'])

teams_raw['sales_agent'] = teams_raw['sales_agent'].apply(clean_text)
pipeline_raw['sales_agent'] = pipeline_raw['sales_agent'].apply(clean_text)

set(pipeline_raw['sales_agent']) - set(teams_raw['sales_agent'])

pipeline_raw['engage_date'] = pd.to_datetime(pipeline_raw['engage_date'], errors='coerce')
pipeline_raw['close_date'] = pd.to_datetime(pipeline_raw['close_date'], errors='coerce')

pipeline_raw['close_value'] = pd.to_numeric(pipeline_raw['close_value'], errors='coerce')
products_raw['sales_price'] = pd.to_numeric(products_raw['sales_price'], errors='coerce')
accounts_raw['revenue'] = pd.to_numeric(accounts_raw['revenue'], errors='coerce')
accounts_raw['employees'] = pd.to_numeric(accounts_raw['employees'], errors='coerce')

accounts_raw['subsidiary_of'] = accounts_raw['subsidiary_of'].replace("", pd.NA)

pipeline_raw['engage_date'] = pd.to_datetime(pipeline_raw['engage_date'], errors='coerce')
pipeline_raw['close_date'] = pd.to_datetime(pipeline_raw['close_date'], errors='coerce')
pipeline_raw['close_value'] = pd.to_numeric(pipeline_raw['close_value'], errors='coerce')

accounts_raw['account'] = accounts_raw['account'].replace("", pd.NA)
pipeline_raw['close_date'] = pipeline_raw['close_date'].replace("", pd.NA)
pipeline_raw['engage_date'] = pipeline_raw['engage_date'].replace("", pd.NA)
pipeline_raw['close_value'] = pipeline_raw['close_value'].replace("", pd.NA)

accounts_raw.to_csv(clean_path / "accounts_clean.csv", index=False)
products_raw.to_csv(clean_path / "products_clean.csv", index=False)
teams_raw.to_csv(clean_path / "teams_clean.csv", index=False)
pipeline_raw.to_csv(clean_path / "pipeline_clean.csv", index=False)








