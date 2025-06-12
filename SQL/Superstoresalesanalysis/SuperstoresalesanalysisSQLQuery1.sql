
--1.Top 10 Customers by Total Sales
--Which customers generated the most revenue over all?

select top 10 customer_id,customer_name
,round(sum(sales),2) as total_sales
,count(distinct order_id) as count_of_orders
from orders
Group by customer_id,customer_name
order by total_sales Desc

--2.Calculate total sales by month:
select FORMAT(order_date,'yyyy-MM') as year_month
,round(sum(sales),2) as total_sales
from orders
group by FORMAT(order_date,'yyyy-MM')
order by year_month

--3.Monthly Sales Trend for the Last Two Years
--what was the trend of sales month over month?

WITH monthly_sales AS (
	SELECT 
		FORMAT(order_date,'yyyy-MM') AS year_month,
		YEAR(order_date) AS year,
		MONTH(order_date) AS month,
		SUM(sales) AS total_sales
	FROM orders
	WHERE order_date >=DATEADD(YEAR, -2,'2021-12-30')
	GROUP BY FORMAT(order_date,'yyyy-MM'),YEAR(order_date),MONTH(order_date)
)
SELECT
year_month,
total_sales,
LAG(total_sales) OVER (ORDER BY year,month) AS prev_month_sales,
total_sales - LAG(total_sales) OVER (ORDER BY year,month) AS sales_change,
CASE
WHEN LAG(total_sales) OVER (ORDER BY year,month) = 0 THEN NULL
ELSE ROUND(
		(CAST(total_sales AS FLOAT) - LAG(total_sales) OVER (ORDER BY year,month))* 100.0/
		NULLIF(LAG(total_sales) OVER(ORDER BY year,month),0),2
	)
	END AS pct_change
FROM monthly_sales
ORDER BY year,month;
--25 rows

--4.Average Order Value
SELECT round(AVG(sales),2) AS avg_order_value
FROM orders

--5.Sales and Profit by Product Category
--How do different product categories perform in terms of sales and profit
SELECT category
,round(sum(sales),2) as total_sales
,round(sum(profit),2) as total_profit
FROM orders
GROUP BY category
ORDER BY total_profit,total_sales

--6.Orders by Shipping Mode 
--What is the count and percentage distribution of orders by ship mode?
SELECT ship_mode
,count(ship_mode) count_ship_mode
,round ((count(ship_mode)*100.0/(SELECT count(*) FROM orders)),2) percentage_distribution
FROM orders
GROUP BY ship_mode
ORDER BY percentage_distribution DESC

--7. Top 5 Most Profitable Products
--Which individual products yielded the highest profit?
SELECT top 5 product_name
,product_id
,round(avg(profit),2) as avg_profit
FROM orders
GROUP BY product_name,product_id
ORDER BY avg_profit DESC

--8. Region -wise Sale and Profit Analysis
--How do different regions perform financially?
SELECT region
,round(sum(sales),2) as total_sales
,round(sum(profit),2) as total_profit
FROM orders
GROUP BY region
ORDER BY total_profit DESC,total_sales DESC

--9.Customer Segment Performance
--Which customer segment brings in the most revenue?
SELECT top 1 segment
,round(sum(sales),2) as total_revenue
FROM orders
GROUP BY segment
ORDER BY total_revenue DESC

--10. Daily Sales Trend
SELECT CAST(order_date as DATE) as order_day
,round(sum(sales),2) as total_sales 
FROM orders
GROUP BY CAST(order_date as DATE)
ORDER BY total_sales DESC,order_day

--1236 rows

--11.Orders with Negative Profit(Loss_Making Orders)
--Identify transactions that resulted in a loss
SELECT order_id, profit
FROM orders
WHERE profit<0
ORDER BY order_id 

--1871 rows

--12. Sales and Profit by State
--Which States performt the best and worst in terms of sales and profit
--12 a. top 10 states performing best in terms of sales and profit

SELECT top 10 state
,round(sum(sales),2) as total_sales
,round(sum(profit),2) as total_profit
FROM orders
GROUP BY state
ORDER BY total_sales DESC,total_profit DESC

--12 b. top 10 states performing worst in terms of sales
SELECT state
,round(sum(sales),2) as total_sales
,round(sum(profit),2) as total_profit
FROM orders
GROUP BY state
HAVING sum(sales)<0 or sum(profit)<0

--13. Average Delivery time by region 
--Calculate the average shipping time (order date to ship date0 by region
SELECT region, order_id
,AVG(DATEDIFF(day,order_date,ship_date)) as avg_no_of_days
,avg(DATEDIFF(HOUR,order_date,ship_date)) as avg_no_of_hours
FROM orders
GROUP BY region, order_id
ORDER BY region, avg_no_of_days DESC
--5009 rows

--14. Identify Sales Outliers (High Value Orders)
SELECT *
FROM orders
WHERE sales > (SELECT AVG(sales)+ 2*STDEV(sales) FROM orders)

--247 rows


--15. Repeat Customer Rate

SELECT 
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT CASE WHEN order_count > 1 THEN customer_id END) AS repeat_customers,
    ROUND(
        COUNT(DISTINCT CASE WHEN order_count > 1 THEN customer_id END) * 100.0 
        / COUNT(DISTINCT customer_id), 2
    ) AS repeat_customer_rate
FROM (
    SELECT 
        customer_id,
        COUNT(order_id) AS order_count
    FROM orders
    GROUP BY customer_id
) A;

--16. Product Sales ranking per month
SELECT FORMAT(order_date,'yyyy-MM') AS year_month
,product_id
,SUM(sales) AS total_sales
,RANK() OVER(PARTITION BY FORMAT(order_date,'yyyy-MM') ORDER BY SUM(sales) DESC) AS product_rank
FROM orders
GROUP BY FORMAT(order_date, 'yyyy-MM'), product_id
ORDER BY year_month,product_rank;
--9294 rows