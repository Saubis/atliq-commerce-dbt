WITH first_orders AS (

    SELECT
        customer_id,
        MIN(order_date) AS first_order_date
    FROM {{ ref('stg_orders') }}
    GROUP BY customer_id

)

SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    c.signup_date,

    DATE_FORMAT(c.signup_date, 'yyyy-MM') AS signup_cohort,

    f.first_order_date

FROM {{ ref('stg_customers') }} AS c

LEFT JOIN first_orders AS f
    ON c.customer_id = f.customer_id

WHERE COALESCE(c.is_test, false) = false