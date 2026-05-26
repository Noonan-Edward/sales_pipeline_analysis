create table accounts (
account text primary key,
sector text,
year_established int,
revenue numeric(14,2),
employees int,
office_location text,
subsidiary_of text
);

create table products(
product text primary key,
series text,
sales_price numeric(10,2)
);

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

create table teams(
sales_agent text primary key,
manager text,
regional_office text
);