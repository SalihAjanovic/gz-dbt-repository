WITH source AS (
    SELECT * 
    FROM {{ source('raw', 'ship') }}
),

renamed AS (
    SELECT
        orders_id,
        CAST(shipping_fee AS FLOAT64) AS shipping_fee,
        CAST(logCost AS FLOAT64) AS log_cost,
        CAST(ship_cost AS FLOAT64) AS ship_cost
    FROM source
)

SELECT * FROM renamed
