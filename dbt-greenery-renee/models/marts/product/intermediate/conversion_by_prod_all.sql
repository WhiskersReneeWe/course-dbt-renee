{{
    config(
        materialized = 'table'
    )
}}

with conversion_by_prodguid as (
    select * from {{ ref('int_conversion_by_prod') }}
),

temp_dim_prods as (
    select 
        product_guid,
        product_name
    from {{ ref('dim_products') }}
),

conversion_by_prod_all as (
    select product_name, conversion_by_prodguid.*
    from conversion_by_prodguid join
    temp_dim_prods
    on conversion_by_prodguid.product_guid = temp_dim_prods.product_guid
)


select * from conversion_by_prod_all