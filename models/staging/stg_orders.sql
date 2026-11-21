SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    LOWER(TRIM(o.status)) AS status,
    o.order_amount,
    o.created_at,
    o.updated_at
FROM {{ source('silver', 'orders') }} AS o

INNER JOIN {{ ref('stg_customers') }} AS c
    ON o.customer_id = c.customer_id

WHERE COALESCE(c.is_test, false) = false