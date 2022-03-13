{{
  config(
    materialized='view'
  )
}}

SELECT 
order_id, 
user_id, 
first_name, 
last_name, 
email, 
phone_number, 
name, 
quantity, 
tracking_id, 
estimated_delivery_at, 
order_status
FROM 
{{ ref('int_orders') }} o
LEFT JOIN {{ ref('int_users') }} u
USING (user_id)
LEFT JOIN {{ ref('g_products') }}
USING (product_id)
WHERE order_status != 'delivered'