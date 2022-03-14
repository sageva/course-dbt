{{
  config(
    materialized='table'
  )
}}

SELECT 
created_at,
promo_id,
order_id,
order_cost,
shipping_cost,
order_total, 
discount
FROM {{ ref('g_orders') }} 
LEFT JOIN {{ ref('g_promos') }} 
USING (promo_id)