SELECT
    id,
    product_id,
    name,
    price,
    quantity
FROM {{ source('greenery','products') }}