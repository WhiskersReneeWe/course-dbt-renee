{{
    config(
        materialized = 'table'
    )
}}

with temp_co as (
    select 
        session_guid,
        event_type
    from {{ ref('int_events') }}
    where event_type = 'checkout'
),

temp_add2cart as (
    select 
        session_guid, 
        product_guid,
        event_type
    from {{ ref('int_events') }}
    where event_type in('add_to_cart', 'checkout')
),

temp_0 as (
    select a.session_guid, 
           a.product_guid,
           co.event_type as event_type_co,
           a.event_type as event_type_a2c
    from temp_add2cart a
    join temp_co co
    on a.session_guid = co.session_guid
),

/*
temp_1 as (
    select 
        session_guid,
        product_guid,
        case 
            when 
             event_type_co = 'checkout' AND event_type_a2c = 'checkout' THEN 1 
            else 0 
        END as checkout
    from temp_0
)
*/
select * from temp_0




