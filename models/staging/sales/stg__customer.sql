with

    source as (
        select *
        from {{ source('raw-data-sales','customer') }}
    )

    , renamed as (
        select
            customerid as customer_id
            , personid as person_id
            , storeid as store_id
            , territoryid as territory_id
            , rowguid
            , modifieddate as modified_date
        from source
    )

select * from renamed
