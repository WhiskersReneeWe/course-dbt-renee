{{
    config(
        materialized = 'table',
        unique_key = 'session_guid'
    )
}}

with int_sessions_events as (
    select 
        session_guid,
        created_at,
        user_guid,
        count(event_type) as event_types
    from {{ ref('fact_events') }}
    group by session_guid, created_at, user_guid
    order by event_types DESC
)

select * from int_sessions_events