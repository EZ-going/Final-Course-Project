USE mavenfuzzyfactory;

# To account for the incomplete quarters during the start of the company and the most recent quarter in the dataset,
# we can check for the average sessions and orders made daily

SELECT
	YEAR(a.created_at) AS year,
    QUARTER(a.created_at) AS quarter,
    COUNT(DISTINCT DATE(a.created_at)) AS days,
    COUNT(DISTINCT a.website_session_id) AS sessions,
    COUNT(DISTINCT a.website_session_id)/COUNT(DISTINCT DATE(a.created_at)) AS avg_sessions_per_day,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT order_id)/COUNT(DISTINCT DATE(a.created_at)) AS avg_orders_per_day
FROM website_sessions a
LEFT JOIN orders b ON a.website_session_id = b.website_session_id
GROUP BY 1,2