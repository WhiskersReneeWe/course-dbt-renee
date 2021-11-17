{{
    config(
        materialized = 'view',
        unique_key = 'order_id'
    )
}}

with order_items_src as (
    select * from {{ source('greenery', 'order_items') }}
)

SELECT * FROM order_items_src
