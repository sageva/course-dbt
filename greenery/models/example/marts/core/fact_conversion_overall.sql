{{
  config(
    materialized='view'
  )
}}

SELECT 
   ROUND((count(distinct case when order_id IS NOT NULL 
   then session_id ELSE NULL END) :: DECIMAL/
   count(distinct session_id)),2)
FROM {{ ref('g_events') }} 