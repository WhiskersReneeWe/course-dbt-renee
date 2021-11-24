{{
    config(
        materialized = 'table',
        unique_key = 'session_guid'
    )
}}

with fact_user_orders_agg as (
    select 
        user_guid,
        sum(order_product_quantity) as total_product_ordered,
        count(order_guid) as total_orders_placed
    from {{ ref('fact_order')}}
    group by user_guid
)

select * from fact_user_orders_agg