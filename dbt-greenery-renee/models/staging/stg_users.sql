{{
    config(
        materialized = 'view',
        unique_key = 'user_id'
    )
}}

with user_src as (
    select 
        id as user_id,
        user_id as user_guid,
        first_name,
        last_name,
        email,
        phone_number,
        created_at as user_created_at,
        updated_at as user_updated_at,
        address_id
     from {{ source('greenery', 'users') }}
)


select * from user_src