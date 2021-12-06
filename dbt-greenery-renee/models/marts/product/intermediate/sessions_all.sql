{{
    config(
        materialized = 'table'
    )
}}

with sessions_all as (
    select 
        product_guid,
        count(session_guid) as count_all
    from 
    {{ ref('int_events') }} 
    where event_type = 'add_to_cart' 
    group by product_guid
)

select * from sessions_all