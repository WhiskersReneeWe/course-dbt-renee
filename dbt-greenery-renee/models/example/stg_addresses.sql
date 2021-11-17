{{
    config(
        materialized = 'view',
        unique_key = 'address_id'
    )
}}

with addresses_src as (
    select * from {{ source('greenery', 'addresses') }}
)

SELECT * FROM addresses_src