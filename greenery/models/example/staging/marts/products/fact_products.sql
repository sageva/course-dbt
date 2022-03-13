{{
  config(
    materialized='view'
  )
}}

SELECT 
   created_at, 
   order_id, 
   name, 
   quantity, 
   price, 
   order_cost, 
   shipping_cost, 
   order_total, 
   tracking_id, 
   shipping_service, 
   estimated_delivery_at, 
   delivered_at, 
   order_status
FROM {{ ref('int_orders') }} p
LEFT JOIN {{ ref('g_products') }} pp
USING (product_id)