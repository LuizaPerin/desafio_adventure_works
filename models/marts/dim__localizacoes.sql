with

    address_table as (
        select *
        from {{ ref('stg__address') }}
    )

    , state_province as (
        select *
        from {{ ref('stg__state_province') }}
    )

    , country_region as (
        select *
        from {{ ref('stg__country_region') }}
    )

    , dim_localizacao as (
        select
            {{ dbt_utils.generate_surrogate_key(['address_id', 'postal_code']) }} as sk_address
            , address_table.address_id
            , state_province.country_region_code
            , address_table.address_line_1
            , address_table.city
            , address_table.postal_code
            , address_table.spatial_location
            , state_province.state_province_code
            , state_province.state_province_name
            , country_region.coutry_region_name as country_region_name
        from address_table
        left join state_province
            on address_table.state_province_id = state_province.state_province_id
        left join country_region
            on state_province.country_region_code = country_region.country_region_code
    )

select * from dim_localizacao
