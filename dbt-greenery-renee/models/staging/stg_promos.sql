{{
    config(
        materialized = 'view',
        unique_key = 'promo_id'
    )
}}

with promo_src as (
    select * from {{ source('greenery', 'promos') }}
)

SELECT * from promo_src
