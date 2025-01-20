with

    sales_header as (
        select *
        from {{ ref('stg__sales_order_header') }}
    )

    , sales_detail as (
        select *
        from {{ ref('stg__sales_order_detail') }}
    )

    , sales_reason as (
        select *
        from {{ ref('dim__motivos_de_venda') }}
    )

    , fct_vendas as (
        select
            /* Primary key */
            {{ dbt_utils.generate_surrogate_key(['sales_header.sales_order_id', 'sales_detail.product_id']) }} as sk_salesline

            /* Foreign keys and IDs */
            , sales_header.sales_order_id
            , sales_header.customer_id
            , sales_header.ship_to_address_id
            , sales_header.credit_card_id
            , sales_header.sales_person_id
            , sales_detail.product_id

            /* Timestamps */
            , sales_header.order_date

             /* Status and properties */
            , sales_header.status as order_status
            , sales_detail.order_quantity
            , sales_detail.unit_price
            , sales_detail.unit_price_discount
            , sales_detail.unit_price * sales_detail.order_quantity as gross_amount
            , sales_detail.unit_price * (1 - sales_detail.unit_price_discount) * sales_detail.order_quantity as net_amount
            , gross_amount - net_amount as discount_amount
            , sales_header.sub_total
            , sales_header.tax_amt
            , sales_header.freight
            , sales_header.total_due
            , listagg(sales_reason.sales_reason_name, ', ') as sales_reason_name
        from sales_header
        left join sales_detail
            on sales_header.sales_order_id = sales_detail.sales_order_id
        left join sales_reason
            on sales_header.sales_order_id = sales_reason.sales_order_id
        group by all
    )

select * from fct_vendas
