with

    product as (
        select
            {{ dbt_utils.generate_surrogate_key(['product_id', 'product_name']) }} as sk_product
            , *
        from {{ ref('stg__product') }}
    )

    , dim_produtos as (
        select
            sk_product
            , product_id
            , product_name
            , product_number
            , safety_stock_level
            , reorder_point
            , color
            , product_size
            , size_unit_measure_code
            , product_weight
            , weight_unit_measure_code
            , days_to_manufacture
            , class
            , style
            , sell_start_date
            , sell_end_date
            , discontinued_date
        from product
    )

select * from dim_produtos
