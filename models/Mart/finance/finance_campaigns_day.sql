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
)

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
