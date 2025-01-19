with

    source as (
        select *
        from {{ source('raw-data-sales','salesperson') }}
    )

    , renamed as (
        select
            businessentityid as business_entity_id
            , territoryid as territory_id
            , salesquota as sales_quota
            , bonus
            , commissionpct as commission_pct
            , salesytd as sales_ytd
            , saleslastyear as sales_last_year
            , rowguid
            , modifieddate as modified_date
        from source
    )

select * from renamed
