{{
    config(
        materialized = 'table'
    )
}}

with sessions_co as (
    select 
        product_guid,
        count(session_guid) as count_co
     from 
    {{ ref('int_events') }} 
    where event_type = 'add_to_cart' 
    AND session_guid in (select session_guid from {{ ref('int_events') }} where event_type = 'checkout')
    group by product_guid
)

select * from sessions_co

