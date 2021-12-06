{{
    config(
        materialized = 'table'
    )
}}


with temp_prod as (
    select a.product_guid as product_guid, 
           count_all as co_counts,
           count_co as all_counts
    from {{ ref('sessions_all') }} a
    join {{ ref('sessions_w_co')}} b
    on a.product_guid = b.product_guid
)


select * from temp_prod

-- use this query to find out conversion rate by product
-- product_guid, co_counts/all_counts::decimal as conversion_rate from dbt_renee_liu.fin_conversion_by_prod;





