{{
    config(
        materialized = 'view',
        unique_key = 'product_id'
    )
}}

with products_src as (
    select 
        product_id as product_guid,
        name as product_name,
        price,
        quantity as inventory_level
        from {{ source('greenery', 'products') }}
)


select * from products_src
