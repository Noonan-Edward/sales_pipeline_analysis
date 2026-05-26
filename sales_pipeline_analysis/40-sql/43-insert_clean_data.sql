-- Load cleaned data into tables
-- Use the absolute file paths.

-- First, accounts:

copy accounts
from '.../data/cleaned/accounts_clean.csv'
delimiter ','
csv header;

-- Next, products:

copy products
from '.../data/cleaned/products_clean.csv' 
delimiter ','
csv header; 

-- Next, pipeline:

copy pipeline 
from '.../data/cleaned/pipeline_clean.csv'
delimiter ','
csv header; 

-- Lastly, teams:

copy teams
from '.../data/cleaned/teams_clean.csv' 
delimiter ','
csv header;

