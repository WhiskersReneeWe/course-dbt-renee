{{
    config(
        materialized = 'table',
        unique_key = 'event_id'
    )
}}

with event_session_w_types as (
    select 
          event_id, 
          session_id,
          page_url,
          event_type,
          created_at,
          user_id
    from {{ ref('stg_events') }}
)

select * from event_session_w_types
-- a session contain multiple events and urls
-- https://support.google.com/analytics/answer/2731565?hl=en#zippy=%2Cin-this-article