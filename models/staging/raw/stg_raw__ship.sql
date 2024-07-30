with 

source as (

    select * from {{ source('raw', 'ship') }}

),

renamed as (

    select
        orders_id,
        shipping_fee,
        logcost as log_cost,
        ship_cost

    from source
    
)

select * from renamed