{{
    config(
        materialized = 'table',
        unique_key = 'user_id'
    )
}}

with dim_customers as (
    select user_id, 
           first_name, 
           last_name,
           email,
           phone_number
    from {{ ref('stg_users') }}
)

select * from dim_customers