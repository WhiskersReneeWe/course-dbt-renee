SELECT 
    id,
    promo_id,
    discout,
    status
FROM {{ source('greenery', 'promos') }}