{{
    config(
        materialized = 'view',
        unique_key = 'event_id'
    )
}}

with events_src as (
    select * from {{ source('greenery', 'events') }}
)


select * from events_src
