{{
    config(
        materialized = 'table',
        unique_key = 'event_guid'
    )
}}


with int_events as (
    select 
        event_guid,
        user_guid,
        session_guid,
        page_url,
        NULLIF(split_part(page_url, '/', 5), '') as product_guid,
        event_type 
    from {{ ref('stg_events') }}
    order by user_guid, session_guid, product_guid
)

select * from int_events

-- How does a user decide to checkout a product
-- typically when does a user create an account after viewing certain product
-- what product makes a user most likely to create an account
