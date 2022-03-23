{{
  config(
    materialized='view'
  )
}}

SELECT 
product_id
, name
, ROUND((count(distinct case when order_id IS NOT NULL 
then session_id ELSE NULL END) :: DECIMAL / 
count(distinct case when event_type = 'page_view' 
then session_id
ELSE NULL END)),2) 
as conversion_percentage
FROM
(SELECT m.session_id, m.event_type, m.order_id, a.product_id FROM
(SELECT * FROM {{ ref('g_events') }} WHERE session_id IN 
(SELECT distinct session_id 
FROM {{ ref('g_events') }} WHERE product_id IS NOT NULL)) m
LEFT JOIN {{ ref('g_events') }} a USING (session_id) WHERE a.product_id IS NOT NULL) p
LEFT JOIN {{ ref('g_products') }} USING (product_id)
GROUP BY 1,2 ORDER BY 3,2,1