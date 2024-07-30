WITH operational_data AS (
    SELECT
        date_date,
        orders_id,
        revenue,
        margin,
        operational_margin
    FROM {{ ref('int_orders_operational') }}
),

summary AS (
    SELECT
        date_date,
        COUNT(orders_id) AS nb_transactions,
        SUM(revenue) AS total_revenue,
        AVG(revenue) AS average_basket,
        SUM(margin) AS total_margin,
        SUM(operational_margin) AS total_operational_margin
    FROM operational_data
    GROUP BY date_date
)

SELECT
    date_date,
    nb_transactions,
    total_revenue AS revenue,
    average_basket,
    total_margin AS margin,
    total_operational_margin AS operational_margin
FROM summary
ORDER BY date_date , nb_transactions desc
