USE mavenfuzzyfactory;

SELECT
	CASE WHEN product_comb IS NULL THEN primary_product_id ELSE product_comb END AS product_comb,
    COUNT(DISTINCT order_id) AS orders
FROM
(	
	SELECT DISTINCT
		a.order_id,
		b.primary_product_id,
        items_purchased,
		GROUP_CONCAT(b.primary_product_id,',',CASE WHEN primary_product_id <> a.product_id THEN a.product_id ELSE NULL END) AS product_comb
	FROM order_items a
	LEFT JOIN orders b ON a.order_id = b.order_id
	WHERE DATE(a.created_at) >= '2014-12-05'
	GROUP BY 1,2,3
) a
GROUP BY 1
ORDER BY 2 DESC