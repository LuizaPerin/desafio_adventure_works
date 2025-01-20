with

    customer as (
        select *
        from {{ ref('stg__customer') }}
    )

    , person as (
        select *
        from {{ ref('stg__person') }}
    )

    , store as (
        select *
        from {{ ref('stg__store') }}
    )

    , dim_clientes as (
        select
            {{ dbt_utils.generate_surrogate_key(['customer.customer_id', 'customer.person_id']) }} as sk_customer
            , customer.customer_id
            , customer.person_id
            , person.first_name || ' ' || person.last_name as customer_name
            , customer.store_id
            , store.store_name
        from customer
        left join person
            on customer.person_id = person.business_entity_id
        left join store
            on customer.store_id = store.business_entity_id
    )

select * from dim_clientes
