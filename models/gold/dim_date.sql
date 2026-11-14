WITH date_bounds AS (

    SELECT

        LEAST(
            COALESCE(
                (SELECT MIN(order_date)
                 FROM {{ ref('stg_orders') }}),
                CURRENT_DATE()
            ),

            COALESCE(
                (SELECT MIN(CAST(event_ts AS DATE))
                 FROM {{ ref('stg_web_events') }}),
                CURRENT_DATE()
            )
        ) AS start_date,

        MAKE_DATE(
            YEAR(CURRENT_DATE()) + 1,
            12,
            31
        ) AS end_date

),

calendar AS (

    SELECT
        EXPLODE(
            SEQUENCE(
                start_date,
                end_date,
                INTERVAL 1 DAY
            )
        ) AS date_day

    FROM date_bounds

)

SELECT

    CAST(DATE_FORMAT(date_day, 'yyyyMMdd') AS INT) AS date_key,

    date_day,

    YEAR(date_day) AS year,

    QUARTER(date_day) AS quarter,

    MONTH(date_day) AS month,

    DATE_FORMAT(date_day, 'MMMM') AS month_name,

    DATE_FORMAT(date_day, 'yyyy-MM') AS year_month,

    DATE_FORMAT(date_day, 'EEEE') AS weekday

FROM calendar