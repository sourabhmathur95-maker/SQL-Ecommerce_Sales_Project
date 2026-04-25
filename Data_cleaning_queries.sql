-- Performing data cleaning 
-- 1. Funding NULLs if any 
SELECT 
	COUNT(*) AS total_count,
    COUNT(user_id) AS user_id_count
FROM users;

SELECT 
	COUNT(*) AS total_count,
    COUNT(product_id) AS product_id_count
FROM products;

SELECT 
	COUNT(*) AS total_count,
    COUNT(order_id) AS order_id_count
FROM orders;


-- 2. Finding duplicates if any 
SELECT * FROM (
	SELECT 
	user_id,
    COUNT(*) OVER(PARTITION BY user_id) AS check_dup_u
	FROM users) AS t
WHERE check_dup_u > 1;

SELECT * FROM (
	SELECT 
	product_id,
    COUNT(*) OVER(PARTITION BY product_id) AS check_dup_p
	FROM products) AS t
WHERE check_dup_p > 1;

SELECT * FROM (		
    SELECT 
	order_id,
    COUNT(*) OVER(PARTITION BY order_id) AS check_dup_o
	FROM orders) AS t
WHERE check_dup_o > 1;