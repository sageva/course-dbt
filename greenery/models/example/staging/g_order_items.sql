{{
  config(
    materialized='table'
  )
}}

SELECT 
    order_id,
    product_id,
    quantity
FROM {{ source('project1', 'order_items') }}