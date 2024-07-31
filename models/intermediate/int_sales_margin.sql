WITH sales_data AS (
    SELECT 
        s.products_id, 
        s.date_date, 
        s.orders_id,
        s.revenue, 
        s.quantity, 
        CAST(p.purchase_price AS FLOAT64) AS purchase_price,
        ROUND(s.quantity * CAST(p.purchase_price AS FLOAT64), 2) AS purchase_cost,
        s.revenue - ROUND(s.quantity * CAST(p.purchase_price AS FLOAT64), 2) AS margin
    FROM {{ ref('stg_raw__sales') }} s
    LEFT JOIN {{ ref('stg_raw__product') }} p 
        ON s.products_id = p.products_id
)

SELECT 
    products_id, 
    date_date, 
    orders_id,
    revenue, 
    quantity, 
    purchase_price,
    purchase_cost,
    margin,
    ROUND({{ margin_percent('revenue', 'purchase_cost') }}, 2) AS margin_percent
FROM sales_data
