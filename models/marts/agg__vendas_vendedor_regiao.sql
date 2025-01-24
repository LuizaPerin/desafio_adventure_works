with

    sales_order as (
        select *
        from {{ ref('stg__sales_order_header') }}
    )

    , sales_detail as (
        select *
        from {{ ref('stg__sales_order_detail') }}
    )

    , sales_person as (
        select *
        from {{ ref('stg__sales_person') }}
    )

    , sales_territory as (
        select *
        from {{ ref('stg__sales_territory') }}
    )

    , person as (
        select *
        from {{ ref('stg__person') }}
    )

    , aggregated as (
        select
            sales_territory.territory_name as region_name
            , person.first_name || ' ' || person.last_name as sales_person_name
            , count(distinct sales_order.sales_order_id) as number_of_sales
            , sum(sales_detail.unit_price * sales_detail.order_quantity) as total_sales
        from sales_order
        join sales_detail
            on sales_order.sales_order_id = sales_detail.sales_order_id
        join sales_person
            on sales_order.sales_person_id = sales_person.business_entity_id
        join sales_territory
            on sales_order.territory_id = sales_territory.territory_id
        join person
            on sales_person.business_entity_id = person.business_entity_id
        group by
            sales_territory.territory_name
            , sales_person.business_entity_id
            , person.first_name
            , person.last_name
    )

select *
from aggregated
