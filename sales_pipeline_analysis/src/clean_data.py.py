# Edward Noonan
# Contact Information:
#   email: ednoonan22@gmail.com
#   phone: 618 670 6699
# File Function: Cleaning CRM_Sales_Opportunities Datasets
# Last Updated: 4/2/2026 17:29

import pandas as pd

accounts = pd.read_csv(r"C:\Users\ednoo\Downloads\Data Analytics Project Portfolio\Project 1 - Sales Analysis\accounts.csv")

products = pd.read_csv(r"C:\Users\ednoo\Downloads\Data Analytics Project Portfolio\Project 1 - Sales Analysis\products.csv")

pipeline = pd.read_csv(r"C:\Users\ednoo\Downloads\Data Analytics Project Portfolio\Project 1 - Sales Analysis\sales_pipeline.csv")
                             
teams = pd.read_csv(r"C:\Users\ednoo\Downloads\Data Analytics Project Portfolio\Project 1 - Sales Analysis\sales_teams.csv")


# Loaded up the files and printed info, head, describe for each to get a good grasp of...
# ...what we're working with + a sanity check.

accounts.columns = accounts.columns.str.lower().str.strip()

products.columns = products.columns.str.lower().str.strip()

pipeline.columns = pipeline.columns.str.lower().str.strip()

teams.columns = teams.columns.str.lower().str.strip()

# Got rid of funky whitespaces using the strip() and ensure everythings in lowercase string...
# ...formatting for consistency, allowing column names to match.

pipeline['product'] = pipeline['product'].replace({'GTXPro': 'Gtx Pro'})

# Noticed the 'GTX Pro' in products is 'GTXPro' in the pipeline. So that it matches...
# ...we can change it right off the rip.

def clean_text(x):
    if pd.isna(x):
        return x
    return x.strip().title()

# Here we define clean text as that which returns normalized column names

pipeline['product'] = pipeline['product'].apply(clean_text)
products['product'] = products['product'].apply(clean_text)

# And here we apply that clean text to our product names.

pipeline['product'] = pipeline['product'].replace({'GTXPro': 'Gtx Pro'})

# ^ This is redundancy. One of the two is unneeded, but after some tweaking and moving...
# ...things around, things are working. So it's as simple as 'don't touch it.'

# Now we can clean account and sales agent names, that way all of our foreign keys will...
# ...link up properly in PostgreSQL.

accounts['account'] = accounts['account'].apply(clean_text)
pipeline['account'] = pipeline['account'].apply(clean_text)

set(pipeline['account']) - set(accounts['account'])

teams['sales_agent'] = teams['sales_agent'].apply(clean_text)
pipeline['sales_agent'] = pipeline['sales_agent'].apply(clean_text)

set(pipeline['sales_agent']) - set(teams['sales_agent'])

# We print(set(pipeline['sales_agent']) - set(teams['sales_agent'])) show us any...
# ..."bad" names. The output returns no "bad" names, so we're clear to move forward.

pipeline['engage_date'] = pd.to_datetime(pipeline['engage_date'], errors='coerce')
pipeline['close_date'] = pd.to_datetime(pipeline['close_date'], errors='coerce')

# This uses pandas' prose to convert to proper dates.

pipeline['close_value'] = pd.to_numeric(pipeline['close_value'], errors='coerce')
products['sales_price'] = pd.to_numeric(products['sales_price'], errors='coerce')
accounts['revenue'] = pd.to_numeric(accounts['revenue'], errors='coerce')
accounts['employees'] = pd.to_numeric(accounts['employees'], errors='coerce')

# And this used pandas' prose to convert to numeric fields where needbe.

# Here's what we notice when we run df.isna().sum() and print it.
# accounts: 70 NAs in 'subsidiary_of'
# pipeline: 1425 NAs in 'account,' 500 NAs in 'engage_date,' 2089 NAs in 'close_date,'...
# ...and 2089 NAs in 'close_value.'

accounts['subsidiary_of'] = accounts['subsidiary_of'].replace("", pd.NA)

pipeline['engage_date'] = pd.to_datetime(pipeline['engage_date'], errors='coerce')
pipeline['close_date'] = pd.to_datetime(pipeline['close_date'], errors='coerce')
pipeline['close_value'] = pd.to_numeric(pipeline['close_value'], errors='coerce')

accounts['account'] = accounts['account'].replace("", pd.NA)
pipeline['close_date'] = pipeline['close_date'].replace("", pd.NA)
pipeline['engage_date'] = pipeline['engage_date'].replace("", pd.NA)
pipeline['close_value'] = pipeline['close_value'].replace("", pd.NA)


# Here we can make sure that Pandas parsed these columned correctly.
# The cleaning process is error-free, and we should now have a solid basis...
# ...to build off of when creating foreign keys in PostgreSQL.

accounts.to_csv("accountsclean.csv", index=False)
products.to_csv("productsclean.csv", index=False)
pipeline.to_csv("pipelineclean.csv", index=False)
teams.to_csv("teamsclean.csv", index=False)


import matplotlib.pyplot as plt
import numpy as np

Q1V1 = pd.read_csv(r"C:\Users\ednoo\Downloads\Q1V1.csv")

Q1V1.info()







