WITH sales AS (
    SELECT
        orders_id,
        products_id,
        revenue,
        CAST(quantity AS FLOAT64) AS quantity
    FROM {{ ref('stg_raw__sales') }}
),

product AS (
    SELECT
        products_id,
        CAST(purchase_price AS FLOAT64) AS purchase_price
    FROM {{ ref('stg_raw__product') }}
),

-- Join sales and product tables
sales_with_cost AS (
    SELECT
        s.orders_id,
        s.products_id,
        s.revenue,
        s.quantity,
        p.purchase_price,
        s.quantity * p.purchase_price AS purchase_cost
    FROM sales s
    INNER JOIN product p
    ON s.products_id = p.products_id
)

SELECT
    orders_id,
    products_id,
    purchase_cost,
    ROUND(revenue - purchase_cost,1) AS margin
FROM sales_with_cost
