/*****
In relation to the products:
*****/
#===================================================================================

-- 1. How many distinct tech products were sold?

SELECT COUNT(DISTINCT(oi.product_id)) AS tech_products_sold
FROM order_items oi
LEFT JOIN products p USING (product_id)
LEFT JOIN product_category_name_translation pt USING (product_category_name)
WHERE product_category_name_english IN (
	'audio', 'electronics', 'computers_accessories', 
	'pc_gamer', 'computers', 'tablets_printing_image', 'telephony');

#===================================================================================

-- 2. How many distinct products were sold? (all categories)

SELECT COUNT(DISTINCT(product_id)) AS products_sold
FROM order_items;

#===================================================================================

-- 3. What is the percentage of tech product sales?

WITH tech_products_sold AS (
    SELECT 
        oi.product_id, 
        pt.product_category_name_english
    FROM order_items oi
    LEFT JOIN products p USING (product_id)
    LEFT JOIN product_category_name_translation pt USING (product_category_name)
    WHERE product_category_name_english IN (
        'audio', 'electronics', 'computers_accessories',
        'pc_gamer', 'computers', 'tablets_printing_image', 'telephony'))
        
SELECT 
    ROUND(
        (SELECT COUNT(*) FROM tech_products_sold) 
        / (SELECT COUNT(*) FROM order_items) * 100, 2) AS pct_tech_products_sold;
    
#===================================================================================

-- 4. What is the average price of all sold products?

SELECT ROUND(AVG(price), 2) AS Avg_price
FROM order_items;

#===================================================================================

-- 5. What is the average price of sold tech products?

WITH tech_products_sold AS (
    SELECT 
        oi.product_id, 
        oi.price,
        pt.product_category_name_english
    FROM order_items oi
    LEFT JOIN products p USING (product_id)
    LEFT JOIN product_category_name_translation pt USING (product_category_name)
    WHERE product_category_name_english IN (
        'audio', 'electronics', 'computers_accessories',
        'pc_gamer', 'computers', 'tablets_printing_image', 'telephony'))
        
SELECT 
    ROUND(
        AVG(price), 2) AS AVG_price_tech FROM tech_products_sold;

#===================================================================================

-- 6. How are sold tech products distributed across price ranges?

SELECT COUNT(oi.product_id), 
	CASE 
		WHEN price > 1000 THEN "Expensive"
		WHEN price > 100 THEN "Mid-range"
		ELSE "Cheap"
	END AS "price_range"
FROM order_items oi
LEFT JOIN products p ON p.product_id = oi.product_id
LEFT JOIN product_category_name_translation pt USING (product_category_name)
WHERE pt.product_category_name_english IN (
	"audio", "electronics", "computers_accessories", 
	"pc_gamer", "computers", "tablets_printing_image", "telephony"
)
GROUP BY price_range
ORDER BY 1 DESC;

#===================================================================================
/*****
In relation to the sellers:
*****/
#===================================================================================
-- 7. How many months of purchase data exist in the database?

SELECT 
    TIMESTAMPDIFF(MONTH,
        MIN(order_purchase_timestamp),
        MAX(order_purchase_timestamp)) AS Months_stamp
FROM orders;

#===================================================================================
-- 8. How many sellers are there?

SELECT COUNT(DISTINCT seller_id) AS sellers_count
FROM sellers;

#===================================================================================

-- 9. How many sellers sold tech products?

SELECT COUNT(DISTINCT seller_id)
FROM sellers
LEFT JOIN order_items USING (seller_id)
LEFT JOIN products p USING (product_id)
LEFT JOIN product_category_name_translation pt USING (product_category_name)
WHERE pt.product_category_name_english IN (
	'audio', 'electronics', 'computers_accessories', 
	'pc_gamer', 'computers', 'tablets_printing_image', 'telephony'
);

#===================================================================================

-- 10. What is the percentage of tech products sellers?

WITH tech_sellers AS(
	SELECT seller_id
	FROM order_items
	LEFT JOIN products p USING (product_id)
	LEFT JOIN product_category_name_translation pt USING (product_category_name)
	WHERE pt.product_category_name_english IN (
		'audio', 'electronics', 'computers_accessories', 
		'pc_gamer', 'computers', 'tablets_printing_image', 'telephony'))
        
SELECT 
	ROUND((SELECT COUNT(DISTINCT(seller_id)) FROM tech_sellers) / 
    (SELECT COUNT(DISTINCT(seller_id)) FROM sellers) * 100, 2) AS tech_sellers_share;      

#===================================================================================

-- 11. What is the total revenue earned by all sellers?

SELECT ROUND(SUM(oi.price) , 2) AS total
FROM order_items oi
LEFT JOIN orders o USING (order_id)
WHERE o.order_status NOT IN ('unavailable' , 'canceled');

#===================================================================================

-- 12. What is the average monthly income per seller?

WITH total_revenue AS (
	SELECT SUM(oi.price) AS total
	FROM order_items oi
	LEFT JOIN orders o USING (order_id)
	WHERE o.order_status NOT IN ('unavailable' , 'canceled'))
, month_stamp AS (SELECT 
    TIMESTAMPDIFF(MONTH,
        MIN(order_purchase_timestamp),
        MAX(order_purchase_timestamp)) AS Months_stamp
FROM orders)
SELECT 
	ROUND((SELECT * FROM total_revenue) / 
		  (SELECT COUNT(DISTINCT seller_id) FROM sellers) / 
          (SELECT * FROM month_stamp) , 2) AS sellers_avg_monthly_income;

#===================================================================================

-- 13. What is the total revenue earned by all tech sellers?

SELECT ROUND(SUM(oi.price),2) AS total_revenue_Tech
FROM order_items oi
LEFT JOIN orders o USING (order_id)
LEFT JOIN products p USING (product_id)
LEFT JOIN product_category_name_translation pt USING (product_category_name)
WHERE o.order_status NOT IN ('unavailable' , 'canceled')
  AND pt.product_category_name_english IN (
	'audio', 'electronics', 'computers_accessories', 
	'pc_gamer', 'computers', 'tablets_printing_image', 'telephony');

#===================================================================================

-- 14. What is the average monthly income per tech seller?

WITH total_revenue_tech AS (
	SELECT SUM(oi.price) AS total, COUNT(DISTINCT(seller_id)) AS tech_sellers_count
	FROM order_items oi
	LEFT JOIN orders o USING (order_id)
    LEFT JOIN products p USING (product_id)
	LEFT JOIN product_category_name_translation pt USING (product_category_name)
	WHERE o.order_status NOT IN ('unavailable' , 'canceled') AND pt.product_category_name_english IN (
		'audio', 'electronics', 'computers_accessories', 
		'pc_gamer', 'computers', 'tablets_printing_image', 'telephony')),
Month_stamp AS (
	SELECT TIMESTAMPDIFF(MONTH,
    MIN(order_purchase_timestamp),
    MAX(order_purchase_timestamp)) AS months_stamp
	FROM orders)
    
SELECT 
	ROUND((SELECT total/tech_sellers_count FROM total_revenue_tech) / 
		  (SELECT months_stamp FROM Month_stamp) , 2) AS sellers_avg_monthly_income;

#===================================================================================
/*****
In relation to the delivery time:
*****/
#===================================================================================

-- 15. How long does it take on average for an order to be delivered?


SELECT CEILING(AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp))) AS delivery_days
FROM orders;

#===================================================================================

-- 16. How can orders be classified as on-time or delayed?

SELECT 
    CASE 
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) > 0 THEN 'Delayed' 
        ELSE 'On time'
    END AS delivery_status, 
    COUNT(DISTINCT order_id) AS orders_count
FROM orders 
WHERE order_status = 'delivered'
  AND order_estimated_delivery_date IS NOT NULL
  AND order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status;

#===================================================================================

-- 17. Do heavier products tend to fall into longer delay buckets?

SELECT
    CASE 
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) > 100 THEN '> 100 days!!!'
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) BETWEEN 30 AND 100 THEN '> 30 - 100 days'
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) BETWEEN 7 AND 30 THEN '1 week - 30 days'
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) BETWEEN 4 AND 7 THEN '4-7 days'
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) BETWEEN 1 AND 3 THEN '1-3 days'
        WHEN DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) <= 0 THEN 'On time or early'
    END AS delay_range,

    ROUND(AVG(product_weight_g)/1000, 3) AS avg_weight_kg,
    ROUND(MAX(product_weight_g)/1000,3) AS max_weight_kg,
    ROUND(MIN(product_weight_g)/1000,3) AS min_weight_kg,
    COUNT(DISTINCT a.order_id) AS order_count

FROM orders a
LEFT JOIN order_items b USING (order_id)
LEFT JOIN products c USING (product_id)
WHERE a.order_status = 'delivered'
  AND a.order_delivered_customer_date IS NOT NULL
  AND a.order_estimated_delivery_date IS NOT NULL
GROUP BY delay_range
ORDER BY delay_range DESC;
