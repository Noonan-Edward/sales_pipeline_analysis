--------------------------------------------------------------------------
-- Hero Question: Where is the greatest revenue potential derived from?
--------------------------------------------------------------------------
-- SUMMARY QUERYING:

select count(*) as total_opportunities
from pipeline;

select deal_stage, count(deal_stage) as total
from pipeline
group by deal_stage
order by total desc;

select max(close_date) -
min(engage_date) as total_days
from pipeline p;

select sum(close_value) as total_revenue
from pipeline p;

-- Across 8800 sales opportunities, 4238 winning opportunities yielded...
-- roughly $10M in revenue over the span of 437 days. 500 opportunities...
-- are merely prospecting, 1589 opportunities are actively engaged,...
-- and 2473 opportunities were lost.

--------------------------------------------------------------------------
-- EDA Guiding Question #1 - Pipeline Health
-- What does the sales pipeline look like across stages, products,...
-- and accounts?
--------------------------------------------------------------------------

-- -- How many opportunities have been created at each stage?

select deal_stage, count(*) as opportunity_count
from pipeline p 
group by p.deal_stage
order by opportunity_count desc;

-- -- How are the 7 unique products distributed across stages?

select product, 
deal_stage, 
count(*) as opportunity_count
from pipeline p
group by product, deal_stage
order by product, opportunity_count desc;

-- -- Which accounts close most frequently?

select account, 
count(*) as closed_deals
from pipeline
where close_date is not null
and account is not null
group by account
having count(*) > 1
order by closed_deals desc
limit 10;

-- -- How long do deals typically take to move from engaged to closed?

with cycles as(
select
product,
sales_agent,
engage_date,
close_date,
(close_date - engage_date) as cycle_days
from pipeline
where engage_date is not null
and close_date is not null 
)
select product,
avg(cycle_days) as avg_cycle_days
from cycles 
group by product
order by avg_cycle_days desc;

--------------------------------------------------------------------------
-- EDA Guiding Question #2 - Customer Value
-- Which customer segments generate the most value and in what ways...
-- do their deal patterns differ?
--------------------------------------------------------------------------

-- -- What sectors (tech, medical, etc.) create the most opportunities?

select a.sector, count(*) as opportunity_count
from pipeline p
left join accounts a on p.account = a.account 
group by a.sector 
order by opportunity_count desc;

select a.sector, count(*) as won_opportunities
from pipeline p
left join accounts a on p.account = a.account
where p.deal_stage = 'Won'
group by a.sector 
order by won_opportunities desc;

select a.sector,
count(*) as total_opportunities,
count(*) filter(where p.deal_stage = 'Won') as won_opportunities,
round(
count(*) filter(where p.deal_stage = 'Won')::numeric
/ count(*)::numeric, 3
) as win_rate
from pipeline p
left join accounts a on p.account = a.account
group by a.sector 
order by win_rate desc;

-- -- Which accounts have closed on the greatest total sales value?

select account, 
sum(close_value) as total_closed_value,
count(*) as closed_deals,
avg(close_value) as avg_deal_size
from pipeline p
where close_value is not null
group by account 
order by total_closed_value desc
limit 10;

-- -- How does company size vary as sales/magnitude of sale fluctuates?

select a.account, 
a.employees, 
count(*) as opportunity_count, 
sum(p.close_value) as total_closed_value, 
avg(p.close_value) as avg_deal_size,
case 
	when employees < 100 then 'Small'
	when employees between 100 and 999 then 'Mid-Market'
	else 'Enterprise'
end as size_segment
from pipeline p
join accounts a on a.account = p.account
group by a.account
order by total_closed_value desc;

-- -- Do repeat customers close faster/at higher rates?

with cycles as (
select account,
(close_date - engage_date) as cycle_days,
deal_stage 
from pipeline
where engage_date is not null 
and close_date is not null 
)
select account, 
count(*) as total_deals,
count(*) filter(where deal_stage = 'Won') as won_deals, 
round(
count(*) filter(where deal_stage = 'Won')::numeric 
/ count(*):: numeric, 3 
) as win_rate, 
avg(cycle_days) as avg_cycle_days 
from cycles 
group by account 
order by total_deals desc;


--------------------------------------------------------------------------
-- EDA Guiding Question #3 - Product Performance
-- How do product offerings trend with deal size, win rate, and...
-- the length of the sales cycle?
--------------------------------------------------------------------------

-- -- What products create the greatest sized sales closures?

select p.product, 
avg(p.close_value) as avg_close_value, 
sum(p.close_value) as total_close_value, 
count(*) as closed_deals 
from pipeline p 
left join products pr on p.product = pr.product 
where p.deal_stage = 'Won' 
group by p.product 
order by avg_close_value desc;

-- -- What products yield the highest win rate?

select product, 
count(*) filter(where deal_stage in ('Won','Lost')) as closed_opportunities, 
count(*) filter(where deal_stage = 'Won') as won_opportunities, 
round(
count(*) filter(where deal_stage = 'Won')::numeric 
/ nullif(count(*) filter(where deal_stage in ('Won','Lost')), 0), 3 
) as win_rate 
from pipeline
group by product 
order by win_rate desc;

-- -- Which product yields the highest sales velocity?

select product, 
avg(close_date - engage_date) as avg_cycle_days 
from pipeline
where engage_date is not null
and close_date is not null 
group by product 
order by avg_cycle_days asc;

select product, 
avg(close_value) / avg(close_date - engage_date) as revenue_per_cycle_day 
from pipeline 
where close_value is not null 
and engage_date is not null 
and close_date is not null 
group by product 
order by revenue_per_cycle_day desc;

-- -- Do higher-priced products win at a lower rate?

select p.product, 
pr.sales_price, 
count(*) filter(where p.deal_stage in ('Won','Lost')) as closed_opportunities, 
count(*) filter(where p.deal_stage = 'Won') as won_opportunities, 
round(
count(*) filter(where p.deal_stage = 'Won')::numeric 
/ nullif(count(*) filter(where p.deal_stage in ('Won','Lost')), 0), 3 
) as win_rate 
from pipeline p 
join products pr on p.product = pr.product 
group by p.product, pr.sales_price 
order by win_rate desc;

--------------------------------------------------------------------------
-- EDA Guiding Question #4 - Sales Team Performance
-- How do sales offices and individual agents perform against one another?
--------------------------------------------------------------------------

-- -- Which regional office produces the greatest revenue yield?

select t.regional_office, 
sum(p.close_value) as total_revenue, 
avg(p.close_value) as avg_deal_size, 
count(*) as closed_deals 
from pipeline p 
join teams t on p.sales_agent = t.sales_agent 
where p.close_value is not null 
group by t.regional_office 
order by total_revenue desc;

-- -- Which regional office is the most efficient?

select t.regional_office, 
avg(p.close_date - p.engage_date) as avg_cycle_days, 
sum(p.close_value) / avg(p.close_date - p.engage_date) as revenue_per_cycle_day 
from pipeline p
join teams t on p.sales_agent = t.sales_agent 
where p.engage_date is not null 
and p.close_date is not null 
and p.close_value is not null 
group by t.regional_office 
order by avg_cycle_days asc;

select t.regional_office,
count(*) filter(where p.deal_stage in ('Won','Lost')) as closed_opportunities, 
count(*) filter(where p.deal_stage = 'Won') as won_opportunities, 
round(
count(*) filter(where p.deal_stage = 'Won')::numeric 
/ nullif(count(*) filter(where p.deal_stage in ('Won','Lost')), 0), 3 
) as win_rate 
from pipeline p
join teams t on p.sales_agent = t.sales_agent 
group by t.regional_office 
order by win_rate desc;

-- -- What sales agents close (won) on the greatest proportions of their...
-- -- 	opportunities?

select sales_agent, 
count(*) filter(where deal_stage in ('Won','Lost')) as closed_opportunities, 
count(*) filter(where deal_stage = 'Won') as won_opportunities, 
round(
count(*) filter(where deal_stage = 'Won')::numeric 
/ nullif(count(*) filter(where deal_stage in ('Won','Lost')), 0), 3 
) as win_rate 
from pipeline 
group by sales_agent 
order by win_rate desc;

-- -- What sales agents have generated the most revenue?

select sales_agent,
sum(close_value) as revenue
from pipeline p
where close_value is not null
group by sales_agent
order by revenue desc;

-- -- Which reps close (winning vs. losing) deals fastest?

select sales_agent, 
avg(close_date - engage_date) as avg_cycle_days, 
count(*) filter(where deal_stage = 'Won') as won_deals 
from pipeline 
where engage_date is not null 
and close_date is not null 
group by sales_agent 
order by avg_cycle_days asc
limit 10;

select sales_agent,
avg(close_value) /
avg(close_date - engage_date) as value_of_engagement_per_day
from pipeline p
group by sales_agent
order by value_of_engagement_per_day desc
limit 10;

-- What sales agent creates the most value per day?

select sales_agent,
sum(close_value) / 
437 as value_per_day,
count(close_value) as total_wins,
avg(close_value) / avg(close_date - engage_date) as revenue_per_cycle_day
from pipeline p
where deal_stage = 'Won'
group by sales_agent 
order by value_per_day desc
limit 10;


select sales_agent, 
count(*) filter(where p.deal_stage in ('Won','Lost')) as closed_opportunities, 
count(*) filter(where p.deal_stage = 'Won') as won_opportunities, 
round(
count(*) filter(where p.deal_stage = 'Won')::numeric 
/ nullif(count(*) filter(where p.deal_stage in ('Won','Lost')), 0), 3 
) as win_rate
from pipeline p
group by sales_agent
order by win_rate desc;














