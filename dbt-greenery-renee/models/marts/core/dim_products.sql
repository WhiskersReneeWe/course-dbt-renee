{{
    config(
        materialized = 'table',
        unique_key = 'product_id'
    )
}}

with dim_products as (
    select product_guid, 
           product_name,
           price,
           inventory_level
    from {{ ref('stg_products') }}
)

select * from dim_products