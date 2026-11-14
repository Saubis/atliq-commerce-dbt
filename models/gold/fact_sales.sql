SELECT

    oi.order_item_id,

    oi.order_id,

    o.customer_id,

    oi.product_id,

    o.order_date,

    oi.quantity,

    oi.item_price,

    CAST(oi.quantity AS DECIMAL(18,2))
        * CAST(oi.item_price AS DECIMAL(18,2))
        AS gross_revenue,

    o.status

FROM {{ ref('stg_order_items') }} AS oi

INNER JOIN {{ ref('stg_orders') }} AS o
    ON oi.order_id = o.order_id