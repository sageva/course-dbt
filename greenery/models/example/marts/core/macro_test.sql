{{
  config(
    materialized='view'
  )
}}

{{ event_types('session_id', 'checkout')}}