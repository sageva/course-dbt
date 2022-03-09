{{
  config(
    materialized='table'
  )
}}

SELECT 
    address_id AS address_id,
    address,
    zipcode,
    state,
    country
FROM {{ source('project1', 'addresses') }}