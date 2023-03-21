USE mavenfuzzyfactory;

SELECT
    YEAR(a.created_at) AS year,
    QUARTER(a.created_at) AS quarter,
    SUM(price_usd) AS total_revenue,
    SUM(price_usd - cogs_usd) AS total_margin,
    COUNT(DISTINCT order_id) AS total_sales,
    
    SUM(CASE WHEN product_id = 1 THEN price_usd ELSE 0 END) AS og_mrfuzzy_revenue,
    SUM(CASE WHEN product_id = 1 THEN price_usd - cogs_usd ELSE 0 END) AS og_mrfuzzy_margin,
    COUNT(DISTINCT CASE WHEN product_id = 1 THEN order_id ELSE NULL END) AS og_mrfuzzy_total_sales,
    
    SUM(CASE WHEN product_id = 2 THEN price_usd ELSE 0 END) AS frvr_love_bear_revenue,
    SUM(CASE WHEN product_id = 2 THEN price_usd - cogs_usd ELSE 0 END) AS frvr_love_bear_margin,
    COUNT(DISTINCT CASE WHEN product_id = 2 THEN order_id ELSE NULL END) AS frvr_love_bear_total_sales,
    
    SUM(CASE WHEN product_id = 3 THEN price_usd ELSE 0 END) AS bday_panda_revenue,
    SUM(CASE WHEN product_id = 3 THEN price_usd - cogs_usd ELSE 0 END) AS bday_panda_margin,
    COUNT(DISTINCT CASE WHEN product_id = 3 THEN order_id ELSE NULL END) AS bday_panda_total_sales,
    
    SUM(CASE WHEN product_id = 4 THEN price_usd ELSE 0 END) AS mini_bear_revenue,
    SUM(CASE WHEN product_id = 4 THEN price_usd - cogs_usd ELSE 0 END) AS mini_bear_margin,
    COUNT(DISTINCT CASE WHEN product_id = 4 THEN order_id ELSE NULL END) AS mini_bear_total_sales
    
FROM order_items a
GROUP BY 1,2
ORDER BY 1,2
