SELECT *
FROM {{ source('silver', 'orders') }}
LIMIT 10