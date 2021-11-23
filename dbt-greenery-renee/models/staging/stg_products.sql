{{
    config(
        materialized = 'view',
        unique_key = 'product_id'
    )
}}

with products_src as (
    select * from {{ source('greenery', 'products') }}
)


select * from products_src
