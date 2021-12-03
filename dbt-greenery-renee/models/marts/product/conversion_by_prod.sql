{{
    config(
        materialized = 'table'
    )
}}

with conversion_by_prod as (
    select {{ dbt_utils.star(ref('conversion_by_prod_all') , except=['product_guid']) }}
    from {{ ref('conversion_by_prod_all') }}
    order by 1
)

select * from conversion_by_prod