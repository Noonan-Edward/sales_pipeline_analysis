
-- Schema: Sales Pipeline Analytics Project
-- Purpose: Defines all the tables, columns, and relationships that will be used...
-- in the PostgreSQL database, here.

-- Table: Accounts
-- One row per account, where account is the primary key (PK).
-- Thus, account is the foreign key for pipeline.

create table accounts (
account text primary key,
sector text,
year_established int,
revenue numeric(14,2),
employees int,
office_location text,
subsidiary_of text
);

-- Table: Products
-- One row per product. Product is the PK, and thus will be the FK for pipeline.

create table products(
product text primary key,
series text,
sales_price numeric(10,2)
);

-- Table: Pipeline
-- One row per opportunity. The opportunity_id is the PK.
-- Here, sales_agent, product, and account link pipeline to all other datatables.

create table pipeline(
opportunity_id text primary key,
sales_agent text,
product text,
account text,
deal_stage text,
engage_date date,
close_date date,
close_value numeric(14,2),
foreign key (product) references products(product),
foreign key (account) references accounts(account)
);

-- Table: Teams
-- One row per sales agent. Sales_agent, thus, is the PK, but the FK for pipeline.

create table teams(
sales_agent text primary key,
manager text,
regional_office text
);

