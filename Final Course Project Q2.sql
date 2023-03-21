USE mavenfuzzyfactory;

SELECT
	YEAR(a.created_at) AS year,
    QUARTER(a.created_at) AS quarter,
    COUNT(DISTINCT b.order_id)/COUNT(DISTINCT a.website_session_id) AS session_to_order_rate,
    SUM(price_usd)/COUNT(DISTINCT b.order_id) AS revenue_per_order,
    SUM(price_usd)/COUNT(DISTINCT a.website_session_id) AS revenue_per_session
FROM website_sessions a
LEFT JOIN orders b ON a.website_session_id = b.website_session_id
GROUP BY 1,2
ORDER BY 1,2