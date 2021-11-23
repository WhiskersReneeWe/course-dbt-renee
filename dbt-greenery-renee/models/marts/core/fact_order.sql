{{
    config(
        materialized = 'table',
        unique_key = 'order_id'
    )
}}

with customer_orders as (
    select order_id, 
           user_id, 
           created_at, 
           order_total, 
           delivered_at,
           status
    FROM {{ ref('stg_orders') }}
),

customer_order_items as (
    select order_id,
           product_id,
           quantity
    from {{ ref('stg_order_items') }}
),

customer_fact_order as (
select co.order_id, user_id, coi.product_id, quantity, order_total, created_at, delivered_at, status
from customer_orders as co
join customer_order_items as coi
on co.order_id = coi.order_id
) 

select * from customer_fact_order