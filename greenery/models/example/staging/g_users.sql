{{
  config(
    materialized='table'
  )
}}

SELECT 
    user_id AS user_id,
    first_name as first_name,
    last_name as last_name,
    email as email,
    phone_number as phone_number,
    created_at as created_at,
    updated_at as updated_at,
    address_id as address_id
FROM {{ source('project1', 'users') }}