{{
    config(
        materialized = 'table'
    )
}}

with temp_add2cart as (
    select 
        session_guid, 
        product_guid,
        event_type, 
        0 as checkout
    from {{ ref('int_events') }}
    where event_type = 'add_to_cart' OR event_type = 'checkout'
    )

select * from temp_add2cart
