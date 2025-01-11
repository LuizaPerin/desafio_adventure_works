with

    source as (
        select *
        from {{ source('raw-data-person','countryregion') }}
    )

    , renamed as (
        select
            countryregioncode as country_region_code
            , name as coutry_region_name
            , modifieddate as modified_date
        from source
    )

select * from renamed
