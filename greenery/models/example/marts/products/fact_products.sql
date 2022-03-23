{{
  config(
    materialized='view'
  )
}}

SELECT 
{{ dbt_utils.star(from=ref('int_orders'), 
except=["user_id", "promo_id",
"address_id","product_id","quantity"]) }},
name
FROM {{ ref('int_orders') }} p
LEFT JOIN {{ ref('g_products') }} pp
USING (product_id)