WITH sales_margin AS (
    SELECT
        orders_id,
        date_date,
        revenue,
        margin,
        purchase_cost
    FROM {{ ref('int_sales_margin') }}
),

ship AS (
    SELECT
        orders_id,
        CAST(shipping_fee AS FLOAT64) AS shipping_fee,
        CAST(log_cost AS FLOAT64) AS log_cost,
        CAST(ship_cost AS FLOAT64) AS ship_cost
    FROM {{ ref('stg_raw__ship') }}
),

-- Join sales_margin and ship tables
joined_data AS (
    SELECT
        sm.orders_id,
        sm.date_date,
        sm.revenue,
        sm.margin,
        sm.purchase_cost,
        s.shipping_fee,
        s.log_cost,
        s.ship_cost,
        sm.margin + s.shipping_fee - s.log_cost - s.ship_cost AS operational_margin
    FROM sales_margin sm
    LEFT JOIN ship s
    ON sm.orders_id = s.orders_id
)

SELECT
    orders_id,
    date_date,
    revenue,
    margin,
    purchase_cost,
    shipping_fee,
    log_cost,
    ship_cost,
    operational_margin
FROM joined_data
