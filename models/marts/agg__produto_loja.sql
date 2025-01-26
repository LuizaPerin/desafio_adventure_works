with

    sales as (
        select *
        from {{ ref('fct__vendas') }}
    )

    , products as (
        select *
        from {{ ref('dim__produtos') }}
    )

    , store as (
        select *
        from {{ ref('dim__clientes') }}
        where store_id is not null
    )

    , territory as (
        select
            address_id
            , case
                when country_region_name = 'United States'
                then state_province_name
                else country_region_name
            end as region
        from {{ ref('dim__localizacoes') }}
    )

    , aggregated as (
        select
            DATE_TRUNC('month', sales.order_date) as order_date
            , products.product_id
            , products.product_name
            , store.store_id
            , store.store_name
            , territory.region
            , sum (sales.order_quantity) as quantity_sold
        from sales
        left join products
            on sales.product_id = products.product_id
        left join territory
            on sales.ship_to_address_id = territory.address_id
        inner join store
            on sales.customer_id = store.customer_id
        group by
            DATE_TRUNC('month', sales.order_date)
            , products.product_id
            , products.product_name
            , store.store_id
            , store.store_name
            , territory.region
    )

select *
from aggregated
