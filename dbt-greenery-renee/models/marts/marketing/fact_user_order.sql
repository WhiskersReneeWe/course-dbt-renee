{{
    config(
        materialized = 'table',
        unique_key = 'user_id'
    )
}}

with user_order_events as (
    select user_id,
           session_id,
           created_at
    from {{ ref('stg_events') }}
),

user_orders as (
    select user_id,
           promo_id,
           order_id,
           order_cost,
           order_total,
           shipping_service
    from {{ ref('stg_orders') }}      
),

fact_user_orders as (
    select uoe.user_id AS user_id, 
           order_id, 
           session_id, 
           promo_id, 
           order_total, 
           shipping_service, 
           created_at
    from user_order_events as uoe 
    join user_orders as uo 
    on uoe.user_id = uo.user_id
)

select * from fact_user_orders

-- questions to ask
-- how many users used promo
-- does promo usage have to do with order cost and shipping service