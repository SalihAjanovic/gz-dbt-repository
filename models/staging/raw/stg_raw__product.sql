WITH source AS (
    SELECT * 
    FROM {{ source('raw', 'product') }}
),

renamed AS (
    SELECT
        products_id,
        CAST(purchase_price AS FLOAT64) AS purchase_price
    FROM source
)

SELECT * FROM renamed
