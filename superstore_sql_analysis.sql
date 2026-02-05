CREATE DATABASE superstore_project;
USE superstore_project;


select * from SampleSuperstore;

-- Total number of orders
select count(*) as total_orders 
from SampleSuperstore;

-- Total sales and total profit
select sum(Sales) as total_sales, sum(Profit) as total_profit, sum(Quantity) as total_quantity from SampleSuperstore;

-- List all unique categories
select distinct Category, `Sub-Category` from SampleSuperStore;

-- List all unique regions.
select distinct Region from SampleSuperStore;

-- List all unique ship modes
select distinct `Ship Mode` from SampleSuperStore;

-- List all unique segments.
select distinct Segment from SampleSuperStore;


-- SALES ANALYSIS

-- Total sales by category.
select Category, sum(Sales) as total_sales from SampleSuperStore group by Category;

-- Total sales by sub-category.
select `Sub-Category`, sum(Sales) as total_sales 
from SampleSuperStore 
group by `Sub-Category`;

-- Total sales by region.
select Region, sum(Sales) as total_sales 
from SampleSuperStore 
group by Region;

-- Total sales by state
select State, sum(Sales) as total_sales 
from SampleSuperStore 
group by State;

-- Total sales by city.
select City, sum(Sales) as total_sales from SampleSuperStore 
group by City;

-- Top 10 cities by sales.
select 
	City, sum(Sales) as total_sales from SampleSuperStore 
group by City 
order by total_sales desc
limit 10;

-- Bottom 10 cities by sales.
select 
	City, sum(Sales) as total_sales from SampleSuperStore 
group by City
order by total_sales asc limit 10;

-- PROFIT ANALYSIS

-- Total profit by category.
select 
	Category, sum(Profit) as total_profit 
from SampleSuperStore 
group by Category;

-- Total profit by sub-category.
select 
	`Sub-Category`, sum(Profit) as total_profit 
from SampleSuperStore 
group by `Sub-Category`;

-- Most profitable states.
select 
     State, sum(Profit) as total_profit 
from SampleSuperStore 
group by State  
order by total_profit desc 
limit 10;

-- Least profitable states.
select 
     State, sum(Profit) as total_profit 
from SampleSuperStore 
group by State  
order by total_profit asc 
limit 10;

-- Loss-making sub-categories
select `Sub-Category`, sum(Profit) as total_profit
from SampleSuperStore 
group by `Sub-Category`
having sum(Profit)<0;

-- Cities with negative total profit
select City, sum(Profit) as total_profit 
from SampleSuperStore 
group by City 
having sum(Profit)<0;

-- SHIPPING ANALYSIS 

-- Sales by ship mode.
select `Ship Mode`, sum(Sales) as total_sales 
from SampleSuperStore 
group by `Ship Mode`;

-- Profit by ship mode.
select `Ship Mode`, sum(Profit) as total_profit
from SampleSuperStore 
group by `Ship Mode`;

-- Average profit per ship mode.
select `Ship Mode`, avg(Profit) as avg_profit
from SampleSuperStore 
group by `Ship Mode`;

-- Which ship mode has highest average sales.
select `Ship Mode`, avg(Sales) as avg_sales
from SampleSuperStore 
group by `Ship Mode`
order by avg_sales desc
limit 1;

-- DISCOUNT ANALYSIS

-- Average discount by category.
select Category, avg(Discount) as avg_discount
from SampleSuperStore
group by Category;

-- Average profit when discount > 0.
select avg(Profit) as avg_profit 
from SampleSuperStore
where Discount>0;

-- Sub-categories with highest average discount.
select `Sub-category`, avg(Discount) as avg_discount 
from SampleSuperStore
group by `Sub-category`
order by  avg_discount desc;

-- Orders with high discount but negative profit.
select * from SampleSuperStore
where 
Discount>0.3 
and
Profit<0;

-- SEGMENT ANALYSIS

-- Sales by segment.
select Segment ,sum(Sales) as total_sales
from SampleSuperStore
group by Segment;

-- Profit by segment.
select Segment ,sum(Profit) as total_profit
from SampleSuperStore
group by Segment;

-- Quantity sold by segment.
select Segment, sum(Quantity) as total_quantity
from SampleSuperStore
group by Segment;

-- Segment with highest average order value.
select Segment, avg(Sales) as avg_order_value
from SampleSuperStore
group by Segment
order by avg_order_value
limit 1;

-- Categories with sales above average sales
select Category, sum(Sales) as total_Sales
from SampleSuperStore
group by Category
having  sum(Sales)>( select avg(Sales) from  SampleSuperStore);

-- States with profit higher than overall average profit
select State, sum(Profit) as total_profit
from SampleSuperStore
group by State
having  sum(Profit)>( select avg(Profit) from  SampleSuperStore);

-- Cities whose total sales are higher than average city sales
select City, sum(Sales) as total_sales
from SampleSuperStore
group by City
having sum(Sales)>( select avg(total_sales) 
					from (select sum(Sales) as total_sales 
						  from SampleSuperStore group by City) t);



-- States with sales but overall loss
select State, sum(Sales) as total_sales, sum(Profit) as total_profit
from SampleSuperStore
group by State
having sum(Profit) <(select avg(Profit)
					 from SampleSuperStore);


 
