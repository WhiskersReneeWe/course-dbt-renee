{{
    config(
        materialized = 'table',
        unique_key = 'order_guid'
    )
}}

with customer_orders as (
    select order_guid, 
           user_guid, 
           order_created_at, 
           order_total_cost, 
           delivered_at,
           order_status
    FROM {{ ref('stg_orders') }}
),

customer_order_items as (
    select order_guid,
           product_guid,
           order_product_quantity
    from {{ ref('stg_order_items') }}
),

fact_orders as (
select co.order_guid, user_guid, coi.product_guid, order_product_quantity, order_created_at, delivered_at, order_status
from customer_orders as co
join customer_order_items as coi
on co.order_guid = coi.order_guid
) 

select * from fact_orders
