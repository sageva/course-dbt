{{
  config(
    materialized='table'
  )
}}

SELECT * 
FROM 
(
    (SELECT 1 as funnel_step, session_id, user_id, page_url, e.created_at as events_created_at, 
event_type, order_id, product_id, name as product_name, price, inventory, zipcode, state
FROM {{ ref('g_events') }} e LEFT JOIN {{ ref('int_users') }} USING (user_id)
LEFT JOIN {{ ref('g_products') }} USING (product_id)
WHERE event_type != 'package_shipped')
UNION ALL
    (SELECT 2 as funnel_step, session_id, user_id, page_url, e.created_at as events_created_at, 
event_type, order_id, product_id, name as product_name, price, inventory, zipcode, state
FROM {{ ref('g_events') }} e LEFT JOIN {{ ref('int_users') }} USING (user_id)
LEFT JOIN {{ ref('g_products') }} USING (product_id)
WHERE event_type != 'package_shipped' AND event_type != 'page_view')
UNION ALL
    (SELECT 3 as funnel_step, session_id, user_id, page_url, e.created_at as events_created_at, 
event_type, order_id, product_id, name as product_name, price, inventory, zipcode, state
FROM {{ ref('g_events') }} e LEFT JOIN {{ ref('int_users') }} USING (user_id)
LEFT JOIN {{ ref('g_products') }} USING (product_id)
WHERE event_type = 'checkout')
) l 