SELECT *
FROM {{ source('silver', 'web_events') }}