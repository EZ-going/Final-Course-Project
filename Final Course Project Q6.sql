USE mavenfuzzyfactory;

WITH
reached_products_page AS
(
SELECT
	created_at,
	website_session_id
FROM website_pageviews
WHERE pageview_url = '/products'
)

SELECT
	YEAR(a.created_at) AS year,
    MONTH(a.created_at) AS month,
    COUNT(DISTINCT CASE WHEN a.created_at < b.created_at THEN a.website_session_id ELSE NULL END)/
    COUNT(DISTINCT a.website_session_id) AS product_clickthrough_rate,
    COUNT(DISTINCT order_id)/COUNT(DISTINCT a.website_session_id) AS product_page_to_order_conv_rate,
    COUNT(DISTINCT product_id) AS products_available
FROM reached_products_page a
LEFT JOIN website_pageviews b ON a.website_session_id = b.website_session_id AND a.created_at <= b.created_at
LEFT JOIN 
(
	SELECT 
		website_session_id,
        product_id,
        a.order_id
	FROM orders a
	LEFT JOIN order_items b ON a.order_id = b.order_id
) c ON a.website_session_id = c.website_session_id
GROUP BY 1,2
ORDER BY 1,2