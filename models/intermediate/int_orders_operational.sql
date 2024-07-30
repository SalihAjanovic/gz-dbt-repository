WITH sales_margin AS (
    SELECT
        orders_id,
        date_date,
        revenue,
        purchase_cost,
        margin
    FROM {{ ref('int_sales_margin') }}
),

ship AS (
    SELECT
        orders_id,
        shipping_fee,
        log_cost,
        ship_cost
    FROM {{ ref('stg_raw__ship') }}
),

-- Join sales_margin and ship tables
joined_data AS (
    SELECT
        sm.orders_id,
        sm.date_date,
        sm.revenue,
        sm.purchase_cost,
        sm.margin,
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
    operational_margin
FROM joined_data
