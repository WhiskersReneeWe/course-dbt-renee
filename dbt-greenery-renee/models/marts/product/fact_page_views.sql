{{
    config(
        materialized = 'table',
        unique_key = 'session_guid'
    )
}}


with session_pageurl_agg as (
    select 
        session_guid,
        user_guid,
        event_type,
        count(page_url) as total_pageviews_per_session_event
    from {{ ref('fact_events') }}
    group by session_guid, user_guid, event_type
)

select session_guid, 
       user_guid, 
       event_type, 
       total_pageviews_per_session_event
from session_pageurl_agg
where event_type = 'page_view'



