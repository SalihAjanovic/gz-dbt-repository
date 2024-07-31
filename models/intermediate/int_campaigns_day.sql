WITH campaigns AS (
    SELECT
        date_date,
        paid_source,
        campaign_key,
        campaign_name,
        ads_cost,
        impression,
        click
    FROM {{ ref('int_campaigns') }}
),

aggregated AS (
    SELECT
        date_date,
        paid_source,
        COUNT(DISTINCT campaign_key) AS nb_campaigns,
        SUM(CAST(ads_cost AS FLOAT64)) AS ads_cost,
        SUM(impression) AS impression,
        SUM(click) AS click
    FROM campaigns
    GROUP BY date_date, paid_source
)

SELECT * FROM aggregated
