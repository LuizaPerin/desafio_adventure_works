with

    source as (
        select *
        from {{ source('raw-data-sales','salesorderdetail') }}
    )

    , renamed as (
        select
            salesorderid as sales_order_id
            , salesorderdetailid as sales_order_detail_id
            , carriertrackingnumber as carrier_tracking_number
            , orderqty as order_quantity
            , productid as product_id
            , specialofferid as special_offer_id
            , unitprice as unit_price
            , unitpricediscount as unit_price_discount
            , rowguid
            , modifieddate as modified_date
        from source
    )

select * from renamed
