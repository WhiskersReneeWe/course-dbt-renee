{{
    config(
        materialized = 'table',
        unique_key = 'session_guid'
    )
}}


{{
    config(
        materialized = 'table',
        unique_key = 'session_guid'
    )
}}

with session_events_agg as (
    select 
        session_guid,
        user_guid,
        created_at,
        count(event_guid) as total_events_per_user_session
    from {{ ref('fact_events') }}
    group by session_guid, user_guid, created_at
),

session_pageurl_agg as (
    select 
        session_guid,
        event_guid,
        user_guid,
        count(page_url) as total_pageviews_per_session_event
    from {{ ref('fact_events') }}
    group by session_guid, user_guid, event_guid
)

select e.session_guid, e.user_guid, 
       e.total_events_per_user_session as total_session_events, 
       p.total_pageviews_per_session_event
from session_events_agg as e
join session_pageurl_agg as p
on e.session_guid = p.session_guid



