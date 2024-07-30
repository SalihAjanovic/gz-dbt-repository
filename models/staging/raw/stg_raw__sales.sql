WITH source AS (
    SELECT * 
    FROM {{ source('raw', 'sales') }}
),

renamed AS (
    SELECT
        orders_id,
        products_id,
        date_date, -- Ensure this column is included
        CAST(quantity AS INT64) AS quantity,
        CAST(revenue AS FLOAT64) AS revenue
    FROM source
)

SELECT * FROM renamed


