{{
    config(
        materialized = 'table'
    )
}}

with conversion_by_prod as (
    select {{ dbt_utils.star(ref('conversion_by_prod_all') , except=['product_guid']) }}
    from {{ ref('conversion_by_prod_all') }}
)

select * from conversion_by_prod