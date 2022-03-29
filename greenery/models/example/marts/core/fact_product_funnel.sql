{{
  config(
    materialized='table'
  )
}}

SELECT * FROM
(SELECT session_id, max(funnel_step) as funnel_step
FROM {{ ref('int_product_funnel') }}
GROUP BY 1) g 
LEFT JOIN (SELECT * FROM 
{{ ref('int_product_funnel') }}) l USING (session_id, funnel_step)