USE mavenfuzzyfactory;

SELECT
	year,
    quarter,
    COUNT(DISTINCT CASE WHEN search_type = 'gsearch nonbrand' THEN order_id ELSE NULL END)/
    COUNT(DISTINCT CASE WHEN search_type = 'gsearch nonbrand' THEN website_session_id ELSE NULL END) AS gsearch_nonbrand_session_to_order_conv_rates,
    COUNT(DISTINCT CASE WHEN search_type = 'bsearch nonbrand' THEN order_id ELSE NULL END)/
    COUNT(DISTINCT CASE WHEN search_type = 'bsearch nonbrand' THEN website_session_id ELSE NULL END) AS bsearch_nonbrand_session_to_order_conv_rates,
    COUNT(DISTINCT CASE WHEN search_type = 'brand search' THEN order_id ELSE NULL END)/
    COUNT(DISTINCT CASE WHEN search_type = 'brand search' THEN website_session_id ELSE NULL END) AS brand_search_session_to_order_conv_rates,
    COUNT(DISTINCT CASE WHEN search_type = 'organic search' THEN order_id ELSE NULL END)/
    COUNT(DISTINCT CASE WHEN search_type = 'organic search' THEN website_session_id ELSE NULL END) AS organic_search_session_to_order_conv_rates,
    COUNT(DISTINCT CASE WHEN search_type = 'direct type-in' THEN order_id ELSE NULL END)/
    COUNT(DISTINCT CASE WHEN search_type = 'direct type-in' THEN website_session_id ELSE NULL END) AS direct_type_in_session_to_order_conv_rates
FROM
(
	SELECT
		YEAR(a.created_at) AS year,
		QUARTER(a.created_at) AS quarter,
		CASE 
			WHEN http_referer IS NULL THEN 'direct type-in'
			WHEN utm_source IS NULL AND http_referer IS NOT NULL THEN 'organic search'
			WHEN utm_campaign = 'brand' THEN 'brand search'
			WHEN utm_source = 'gsearch' AND utm_campaign = 'nonbrand' THEN 'gsearch nonbrand'
			WHEN utm_source = 'bsearch' AND utm_campaign = 'nonbrand' THEN 'bsearch nonbrand'
			ELSE NULL
		END AS search_type,
		order_id,
        a.website_session_id
	FROM website_sessions a
	LEFT JOIN orders b ON a.website_session_id = b.website_session_id
) a
GROUP BY 1,2
ORDER BY 1,2