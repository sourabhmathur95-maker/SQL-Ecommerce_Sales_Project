-- KPIs
-- 1. Total orders 
SELECT 
	COUNT(order_id) AS total_orders
FROM orders;


-- 2. Total revenue 
SELECT 
	ROUND(SUM(total_price)) AS total_revenue
FROM orders;


-- 3. Total quantity sold 
SELECT 
	SUM(quantity) AS total_quantity_sold 
FROM orders;


-- 4. Average order value 
SELECT 
	ROUND(AVG(total_price)) AS avg_order_value 
FROM orders;


-- 5. Sales by category 
SELECT 
	p.category,
    SUM(o.total_price) AS total_sales
	FROM orders o 
    JOIN products p  
    ON o.product_id = p.product_id
GROUP BY p.category;


-- 6. Sales by country 
SELECT 
	u.country,
    SUM(o.total_price) AS total_sales 
    FROM orders o 
    JOIN users u 
    ON o.user_id = u.user_id 
GROUP BY u.country;


-- 7. Sales by customer segment
SELECT 
	u.customer_segment,
    SUM(o.total_price) AS total_sales
    FROM orders o 
    JOIN users u 
    ON o.user_id = u.user_id 
GROUP BY u.customer_segment;


-- 8. Total revenue in each year 
SELECT 
	YEAR(order_date) AS order_year,
    SUM(total_price) AS total_revenue
    FROM orders
GROUP BY order_year;


-- Average sales 
SELECT 
	ROUND(AVG(total_price), 2) AS avg_sales 
FROM orders;
    
    