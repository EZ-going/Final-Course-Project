USE mavenfuzzyfactory;

SELECT
	YEAR(created_at) AS year,
    MONTH(created_at) AS month,
    -- primary_product_id,
    COUNT(DISTINCT a.order_id) AS total_orders,
    COUNT(DISTINCT CASE WHEN product_id = 1 AND is_primary_item = 0 THEN a.order_id ELSE NULL END) AS xsold_p1,
    COUNT(DISTINCT CASE WHEN product_id = 2 AND is_primary_item = 0 THEN a.order_id ELSE NULL END) AS xsold_p2,
    COUNT(DISTINCT CASE WHEN product_id = 3 AND is_primary_item = 0 THEN a.order_id ELSE NULL END) AS xsold_p3,
    COUNT(DISTINCT CASE WHEN product_id = 4 AND is_primary_item = 0 THEN a.order_id ELSE NULL END) AS xsold_p4,
    COUNT(DISTINCT CASE WHEN product_id = 1 AND is_primary_item = 0 THEN a.order_id ELSE NULL END)/
    COUNT(DISTINCT a.order_id) AS xsold_p1_rate,
    COUNT(DISTINCT CASE WHEN product_id = 2 AND is_primary_item = 0 THEN a.order_id ELSE NULL END)/
    COUNT(DISTINCT a.order_id) AS xsold_p2_rate,
    COUNT(DISTINCT CASE WHEN product_id = 3 AND is_primary_item = 0 THEN a.order_id ELSE NULL END)/
    COUNT(DISTINCT a.order_id) AS xsold_p3_rate,
    COUNT(DISTINCT CASE WHEN product_id = 4 AND is_primary_item = 0 THEN a.order_id ELSE NULL END)/
    COUNT(DISTINCT a.order_id) AS xsold_p4_rate
FROM order_items a
-- JOIN orders b ON a.order_id = b.order_id
WHERE DATE(a.created_at) >= '2014-12-05'
GROUP BY 1,2
ORDER BY 1,2