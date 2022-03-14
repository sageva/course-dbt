{{
  config(
    materialized='view'
  )
}}

SELECT 
   case when promo_id IS NULL THEN 'No promo used' else promo_id END as promotion, 
   count(distinct order_id) as total_orders, 
   sum(discount) as total_discount 
FROM {{ ref('int_promos') }}
GROUP BY 1