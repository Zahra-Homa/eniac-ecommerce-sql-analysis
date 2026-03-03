-- Exploring the tables 
#==========================================================================

-- 1. How many months does the dataset cover?

SELECT TIMESTAMPDIFF(MONTH, MIN(order_purchase_timestamp) , MAX(order_purchase_timestamp)) AS Months_span
FROM orders;

#==========================================================================

-- 2. How many orders are there in the dataset?
SELECT 
    COUNT(*) AS orders_count
FROM
    orders;
       
#==========================================================================

-- 3. Are orders actually delivered?
SELECT 
    order_status, 
    COUNT(*) AS orders
FROM
    orders
GROUP BY order_status;

#==========================================================================

-- 4. Is Magist having user growth?
SELECT 
    YEAR(order_purchase_timestamp) AS year_,
    MONTH(order_purchase_timestamp) AS month_,
    COUNT(customer_id)
FROM
    orders
GROUP BY year_ , month_
ORDER BY year_ , month_;

-- alternative

SELECT 
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS _year_month,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(order_id) AS total_orders
FROM orders
WHERE order_purchase_timestamp IS NOT NULL
GROUP BY _year_month
ORDER BY _year_month;

#==========================================================================

-- 5. How many products are there in the products table?
SELECT 
    COUNT(DISTINCT product_id) AS products_count
FROM
    products;

#==========================================================================

-- 6. Which are the categories with most products?

SELECT 
    product_category_name_english, 
    COUNT(DISTINCT product_id) AS n_products
FROM
    products
LEFT JOIN product_category_name_translation USING (product_category_name)
GROUP BY product_category_name
ORDER BY n_products DESC;

#==========================================================================

-- 7. How many of those products were present in actual transactions?
SELECT 
	count(DISTINCT product_id) AS n_products
FROM
	order_items;

#==========================================================================

-- 8. What’s the price for the most expensive and cheapest products?

SELECT 
    MIN(price) AS cheapest, 
    MAX(price) AS most_expensive
FROM 
	order_items;

#==========================================================================

-- 9. What are the highest and lowest payment values?

SELECT 
	MAX(payment_value) as highest,
    MIN(payment_value) as lowest
FROM
	order_payments;

#==========================================================================

-- 10. Who paid the most for an order and how much?

SELECT
    op.order_id, o.customer_id, ROUND(SUM(payment_value) , 2) AS highest_order
FROM
    order_payments op
JOIN 
	orders o USING(order_id)
GROUP BY
    order_id, o.customer_id
ORDER BY
    highest_order DESC
LIMIT
    1;
