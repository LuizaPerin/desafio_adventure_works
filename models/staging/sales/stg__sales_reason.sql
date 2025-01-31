with

    source as (
        select *
        from {{ source('raw-data-sales','salesreason') }}
    )

    , renamed as (
        select
            salesreasonid as sales_reason_id
            , name as sales_reason_name
            , reasontype as reason_type
            , modifieddate as modified_date
        from source
    )

select * from renamed
