{{ config( error_if = "> 10",
    warn_if = "<= 10",) }}
-- donfiguração de aviso setada pois tem 7 dando erro por questão de arredondamento

with

    sales_order as (
        select *
        from {{ ref('stg__sales_order_header') }}
    )

    , sales_detail as (
        select *
        from {{ ref('stg__sales_order_detail') }}
    )

    , computed_subtotals as (
        select
            sales_order.sales_order_id,
            ROUND(sum(sales_detail.unit_price * (1 - sales_detail.unit_price_discount) * sales_detail.order_quantity), 2) as computed_subtotal
        from sales_order
        join sales_detail
            on sales_order.sales_order_id = sales_detail.sales_order_id
        group by sales_order.sales_order_id
    )

select
    sales_order.sales_order_id,
    ROUND(sales_order.sub_total, 2) as recorded_subtotal,
    computed_subtotals.computed_subtotal,
    case
        when ROUND(sales_order.sub_total,2) != computed_subtotals.computed_subtotal then 'mismatch'
        else 'match'
    end as status
from sales_order
join computed_subtotals
    on sales_order.sales_order_id = computed_subtotals.sales_order_id
where ROUND(sales_order.sub_total, 2) != computed_subtotals.computed_subtotal
