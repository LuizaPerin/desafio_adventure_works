with

    source as (
        select *
        from {{ source('raw-data-sales','salesorderheadersalesreason') }}
    )

    , renamed as (
        select
            {{ dbt_utils.generate_surrogate_key(['salesorderid', 'salesreasonid']) }} as sk_sales_reason
            , salesorderid as sales_order_id
            , salesreasonid as sales_reason_id
            , modifieddate as modified_date
        from source
    )

select * from renamed
