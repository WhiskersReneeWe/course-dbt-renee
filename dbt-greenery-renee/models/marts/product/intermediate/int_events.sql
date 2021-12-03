{{
    config(
        materialized = 'table',
        unique_key = 'event_guid'
    )
}}


with int_events as (
    select 
        event_guid, 
        session_guid,
        user_guid,
        page_url,
        NULLIF(split_part(page_url, '/', 5), '') as product_guid,
        event_type 
    from {{ ref('stg_events') }}
)

select * from int_events