{{
    config(
        materialized = 'table'
    )
}}

with product_funnel as (
    select 
        'product' as conversion_rate, 
        ROUND((total_sessions_a2c_co / total_sessions::DECIMAL),2) * 100 as add_to_cart_percent, 
        ROUND((total_sessions_co / total_sessions_a2c_co::decimal),2) * 100 as checkout_percent 
    from {{ ref('int_total_sessions') }}
)

select * from product_funnel