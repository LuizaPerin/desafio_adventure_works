with

    sales_header as (
        select *
        from {{ ref('stg__sales_header_sales_reason') }}
    )

    , sales_reason as (
        select *
        from {{ ref('stg__sales_reason') }}
    )

    , dim_motivo as (
        select
            sales_header.sk_sales_reason
            , sales_header.sales_order_id
            , sales_header.sales_reason_id
            , sales_reason.sales_reason_name
            , sales_reason.reason_type
        from sales_header
        inner join sales_reason on sales_header.sales_reason_id = sales_reason.sales_reason_id
    )

select * from dim_motivo
