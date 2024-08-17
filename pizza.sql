CREATE DATABASE pizza;
USE pizza;

-- Total Revenue
SELECT ROUND(SUM(total_price),2) AS "Revenue" 
FROM pizza_sales;

-- Average Order Value
SELECT ROUND(SUM(total_price)/COUNT(DISTINCT order_id),2) AS "Average_Order_Value"
FROM pizza_sales;

-- Total Pizzas Sold
SELECT SUM(quantity) AS "No_Of_Pizzas_Sold"
FROM pizza_sales;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS "No_Of_Orders"
FROM pizza_sales;

-- Average Pizzas Per Order
SELECT AVG(Pizzas_Per_Order) AS "Average_Pizzas_Per_Order" FROM 
(SELECT order_id,COUNT(pizza_id) AS "Pizzas_Per_Order"
FROM pizza_sales
GROUP BY order_id) a;

-- Number Of Orders On Daily Basis
SELECT DAYNAME(order_date) AS "Day", COUNT(DISTINCT order_id) AS "No_Of_Orders"
FROM pizza_sales
GROUP BY DAYNAME(order_date)
ORDER BY COUNT(DISTINCT order_id) DESC;

-- Number Of Orders On Hourly Basis
SELECT HOUR(order_time), COUNT(DISTINCT order_id) AS "No_Of_Orders"
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY COUNT(DISTINCT order_id) DESC;

-- Percentage Of Sales By Pizza Category
SELECT * FROM
(SELECT pizza_category,ROUND(SUM(total_price),2) AS "Total_Revenue",
ROUND((SUM(total_price)/(SELECT SUM(total_price) FROM pizza_sales))*100,2) AS "Percentage_Contribution"
FROM pizza_sales
GROUP BY pizza_category) a
ORDER BY Percentage_Contribution DESC;

-- Percentage Of Sales By Pizza Size
SELECT * FROM
(SELECT pizza_size,ROUND(SUM(total_price),2) AS "Total_Revenue",
ROUND((SUM(total_price)/(SELECT SUM(total_price) FROM pizza_sales))*100,2) AS "Percentage_Contribution"
FROM pizza_sales
GROUP BY pizza_size) a
ORDER BY Percentage_Contribution DESC;

-- Top 5 Best Selling Pizzas
SELECT pizza_name,SUM(quantity) AS "No_Of_Pizzas"
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) DESC LIMIT 5;

-- Bottom 5 Least Selling Pizzas
SELECT pizza_name,SUM(quantity) AS "No_Of_Pizzas"
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) ASC LIMIT 5;