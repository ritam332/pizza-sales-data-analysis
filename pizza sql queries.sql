use pizzadb;
select * from pizza_sales;

-- kpi's
select SUM(total_price) as total_revenue from pizza_sales 

select sum(total_price)/ COUNT(distinct order_id) as avg_order_value from pizza_sales

select SUM(quantity) as total_pizza_sold from pizza_sales 

select count(distinct order_id) as total_orders from pizza_sales 

select CAST(SUM(quantity) as decimal(10,2))/cast(count(distinct order_id) as decimal (10,2)) as avg_pizzas_per_order from pizza_sales 

-- charts

-- Daily Trend for total orders

select DATENAME(DW,order_date) as order_day, COUNT(distinct order_id) as tot_orders
from pizza_sales group by DATENAME(DW,order_date)

-- Monthly Trend for total orders

select DATENAME(MONTH,order_date) as month_name, COUNT(distinct order_id) as tot_orders
from pizza_sales group by DATENAME(MONTH,order_date)  order by tot_orders desc

-- Percentage of Sales by Pizza Category 

select pizza_category, SUM(total_price) as total_sales, sum(total_price)*100/ (select sum(total_price) from pizza_sales) as percent_of_tot_sales
from pizza_sales group by pizza_category;

-- in january
select pizza_category, SUM(total_price) as total_sales, sum(total_price)*100/ (select sum(total_price) from pizza_sales where MONTH(order_date)=1) as percent_of_tot_sales
from pizza_sales where MONTH(order_date)=1
group by pizza_category;

-- Percentage of Sales by Pizza Size

select pizza_size, cast(SUM(total_price) as decimal(10,2)) as total_sales, cast(sum(total_price)*100/ (select sum(total_price) from pizza_sales) as decimal (10,2)) as percent_of_tot_sales
from pizza_sales 
group by pizza_size 
order by percent_of_tot_sales desc;

-- for 1st quarter of year

select pizza_size, cast(SUM(total_price) as decimal(10,2)) as total_sales, cast(sum(total_price)*100/ (select sum(total_price) from pizza_sales where DATEPART(QUARTER,order_date)=1) as decimal (10,2)) as percent_of_tot_sales
from pizza_sales 
where DATEPART(QUARTER,order_date)=1
group by pizza_size 
order by percent_of_tot_sales desc;

-- Total Pizzas sold by Pizza Category 

select pizza_category, count(distinct order_id) as total_orders
from pizza_sales 
group by pizza_category order by total_orders desc


-- Top 5 Best Sellers by Total Pizzas sold

select top 5 pizza_name , sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue desc

-- Bottom 5 Worst Sellers by Total Pizzas sold

select top 5 pizza_name , sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue asc

-- Top 5 Pizzas by Revenue

select top 5 pizza_name , sum(quantity) as total_quantity from pizza_sales
group by pizza_name
order by total_quantity desc


-- Bottom 5 Pizzas by Revenue

select top 5 pizza_name , sum(quantity) as total_quantity from pizza_sales
group by pizza_name
order by total_quantity asc

-- Top 5 Pizzas by Quantity

select top 5 pizza_name , COUNT(distinct order_id) as tot_orders from pizza_sales
group by pizza_name
order by tot_orders desc

-- Bottom 5 Pizzas by Quantity

select top 5 pizza_name , COUNT(distinct order_id) as tot_orders from pizza_sales
group by pizza_name
order by tot_orders asc

