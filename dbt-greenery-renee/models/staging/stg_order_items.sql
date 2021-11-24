{{
    config(
        materialized = 'view',
        unique_key = 'order_id'
    )
}}

with order_items_src as (
    select 
        order_id as order_guid,
        product_id as product_guid,
        quantity as order_product_quantity
        from {{ source('greenery', 'order_items') }}
)

SELECT * FROM order_items_src
