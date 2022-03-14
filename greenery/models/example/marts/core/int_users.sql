{{
  config(
    materialized='table'
  )
}}

SELECT 
address_id,
user_id,
first_name,
last_name,
email,
phone_number,
created_at, 
updated_at, 
address,
zipcode,
state,
country
FROM {{ ref('g_users') }} 
LEFT JOIN {{ ref('g_addresses') }} 
USING (address_id)