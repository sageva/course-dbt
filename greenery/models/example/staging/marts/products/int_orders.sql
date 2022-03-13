{{
  config(
    materialized='table'
  )
}}

SELECT 
   o.order_id, 
   user_id, 
   o.promo_id, 
   address_id, 
   created_at, 
   order_cost, 
   shipping_cost, 
   order_total, 
   tracking_id, 
   shipping_service, 
   estimated_delivery_at, 
   delivered_at, 
   o.status as order_status,
   product_id,
   quantity
FROM {{ ref('g_orders') }} o
LEFT JOIN {{ ref('g_order_items') }} i
ON o.order_id = i.order_id