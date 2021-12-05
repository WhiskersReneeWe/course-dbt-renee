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
)

select * from temp_co