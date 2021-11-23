{{
    config(
        materialized = 'view',
        unique_key = 'order_id'
    )
}}

with orders_src as (
    select * from {{ source('greenery', 'orders') }}
)

SELECT * from orders_src