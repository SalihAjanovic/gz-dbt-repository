WITH sales_margin AS (
    SELECT
        orders_id,
        date_date, -- Ensure this column is included
        revenue,
        purchase_cost,
        revenue - purchase_cost AS margin
    FROM {{ ref('int_sales_margin') }}
)

SELECT
    orders_id,
    date_date, -- Ensure this column is included
    SUM(revenue) AS total_revenue,
    SUM(purchase_cost) AS total_purchase_cost,
    SUM(margin) AS total_margin
FROM sales_margin
GROUP BY orders_id, date_date
