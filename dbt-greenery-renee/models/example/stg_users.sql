{{
    config(
        materialized = 'view',
        unique_key = 'user_id'
    )
}}

with user_src as (
    select * from {{ source('greenery', 'users') }}
)


select * from user_src