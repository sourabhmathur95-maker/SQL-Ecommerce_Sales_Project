-- Analysis
-- Cumulative total sale (running total)
	SELECT 
	order_id,
	order_date, 
    total_price,
    SUM(total_price) OVER(ORDER BY order_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM orders;


-- Rolling total 
SELECT 
	order_id,
    order_date,
    total_price,
    SUM(total_price) OVER(ORDER BY order_date
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_total  
FROM orders;


-- Moving average 
SELECT 
	o.order_id,
    o.order_date,
    o.total_price,
    p.category,
    ROUND(AVG(total_price) OVER(PARTITION BY p.category ORDER BY order_date), 2) AS moving_avg
	FROM orders o 
	JOIN products p 
ON p.product_id = o.product_id;


-- Top customers by ranking 
SELECT 
	u.user_id,
    SUM(o.total_price) AS total_spent,
    RANK() OVER(ORDER BY SUM(o.total_price) DESC) AS customer_rank
    FROM orders o 
    JOIN users u 
    ON u.user_id = o.user_id
GROUP BY u.user_id;


-- Rank products category 
SELECT 
	p.category,
	p.product_id,
    SUM(o.total_price) AS product_revenue,
    RANK() OVER(PARTITION BY p.category ORDER BY SUM(o.total_price) DESC) AS product_ranking 
    FROM orders o 
    JOIN products p 
    ON o.product_id = p.product_id
GROUP BY p.category, p.product_id;


-- Identify customers behavior of purchase 
SELECT 
	u.user_id,
    o.order_id,
    o.total_price,
    ROUND(AVG(o.total_price) OVER(PARTITION BY u.user_id), 2) AS cust_avg_spent,
    o.total_price - ROUND(AVG(o.total_price) OVER(PARTITION BY u.user_id), 2) AS diff_from_avg
	FROM orders o 
    JOIN users u 
    ON o.user_id = u.user_id;
    
	
