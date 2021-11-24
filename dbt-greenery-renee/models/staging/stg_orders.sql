{{
    config(
        materialized = 'view',
        unique_key = 'order_id'
    )
}}

with orders_src as (
    select 
        id as order_id,
        order_id as order_guid,
        user_id as user_guid,
        promo_id,
        address_id as address_guid,
        created_at as order_created_at,
        order_cost,
        shipping_cost,
        order_total as order_total_cost,
        tracking_id,
        shipping_service,
        estimated_delivery_at,
        delivered_at,
        status as order_status
from {{ source('greenery', 'orders') }}
)

SELECT * from orders_src