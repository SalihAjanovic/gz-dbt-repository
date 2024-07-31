WITH source AS (
    SELECT * 
    FROM {{ source('raw', 'sales') }}
),

renamed AS (
    SELECT
        orders_id,
        pdt_id AS products_id,  -- Corrected column name
        date_date,
        CAST(quantity AS INT64) AS quantity,
        CAST(revenue AS FLOAT64) AS revenue
    FROM source
)

SELECT * FROM renamed
