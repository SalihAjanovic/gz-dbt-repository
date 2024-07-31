WITH campaigns_day AS (
    SELECT
        date_date,
        paid_source,
        nb_campaigns,
        ads_cost,
        impression,
        click
    FROM {{ ref('int_campaigns_day') }}
),

finance_days AS (
    SELECT
        date_date,
        revenue,
        average_basket,
        average_basket_bis,
        margin,
        operational_margin,
        purchase_cost,
        shipping_fee,
        logcost,
        ship_cost,
        quantity
    FROM {{ ref('finance_days') }}
),

combined_data AS (
    SELECT
        c.date_date,
        c.paid_source,
        c.nb_campaigns,
        c.ads_cost,
        c.impression,
        c.click,
        f.revenue,
        f.average_basket,
        f.average_basket_bis,
        f.margin,
        f.operational_margin,
        f.purchase_cost,
        f.shipping_fee,
        f.logcost,
        f.ship_cost,
        f.quantity,
        f.operational_margin - c.ads_cost AS ads_margin
    FROM campaigns_day c
    JOIN finance_days f
    ON c.date_date = f.date_date
),

aggregated_month AS (
    SELECT
        DATE_TRUNC(date_date, MONTH) AS month,
        paid_source,
        SUM(nb_campaigns) AS nb_campaigns,
        SUM(ads_cost) AS ads_cost,
        SUM(impression) AS impression,
        SUM(click) AS click,
        SUM(revenue) AS revenue,
        AVG(average_basket) AS average_basket,
        AVG(average_basket_bis) AS average_basket_bis,
        SUM(margin) AS margin,
        SUM(operational_margin) AS operational_margin,
        SUM(purchase_cost) AS purchase_cost,
        SUM(shipping_fee) AS shipping_fee,
        SUM(logcost) AS logcost,
        SUM(ship_cost) AS ship_cost,
        SUM(quantity) AS quantity,
        SUM(ads_margin) AS ads_margin
    FROM combined_data
    GROUP BY month, paid_source
)

SELECT * FROM aggregated_month
