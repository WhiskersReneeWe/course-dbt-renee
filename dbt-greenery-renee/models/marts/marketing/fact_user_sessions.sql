{{
    config(
        materialized = 'table',
        unique_key = 'session_guid'
    )
}}

with fact_user_sessions as (
    select 
          session_guid,
          user_guid,
          event_types,
          created_at
    from {{ ref('int_sessions_events_agg') }}
),

dim_users as (
    select 
        user_guid,
        first_name,
        last_name
    from {{ ref('dim_users') }}
)

select session_guid, created_at, fact_user_sessions.user_guid, dim_users.first_name, dim_users.last_name from fact_user_sessions
JOIN dim_users
ON fact_user_sessions.user_guid = dim_users.user_guid

-- a session contain multiple events and urls
-- https://support.google.com/analytics/answer/2731565?hl=en#zippy=%2Cin-this-article