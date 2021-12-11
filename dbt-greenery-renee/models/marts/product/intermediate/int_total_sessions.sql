{{
    config(
        materialized = 'table',
        unique_key = 'session_guid'
    )
}}

with total_sessions_pv_a2c_co as (
    select 1 as col_index, count(distinct session_guid) as total_sessions
    from {{ ref('fact_events') }}
    where event_type in ('page_view', 'add_to_cart', 'checkout')
),

total_sessions_a2c_co as (
    select 1 as col_index, count(distinct session_guid) as total_sessions_a2c_co
    from {{ ref('fact_events') }}
    where event_type in ('add_to_cart', 'checkout')
),

total_sessions_co as (
    select 1 as col_index, count(distinct session_guid) as total_sessions_co
    from {{ ref('fact_events') }}
    where event_type in ('checkout')
)

select ts_1.total_sessions, ts_2.total_sessions_a2c_co, ts_3.total_sessions_co
from total_sessions_pv_a2c_co ts_1 
JOIN total_sessions_a2c_co ts_2
ON ts_1.col_index = ts_2.col_index
JOIN total_sessions_co ts_3
ON ts_2.col_index = ts_3.col_index



