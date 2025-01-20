with

    employee as (
        select *
        from {{ ref('stg__employee') }}
        where job_title like '%Sales%'
    )

    , sales_person as (
        select *
        from {{ ref('stg__sales_person') }}
    )

    , person as (
        select *
        from {{ ref('stg__person') }}
    )

    , dim_vendedores as (
        select
            {{ dbt_utils.generate_surrogate_key(['sales_person.business_entity_id']) }} as sk_sales_person
            , employee.business_entity_id
            , person.first_name || ' ' || person.last_name as sales_person_name
            , employee.job_title
            , employee.current_flag
            , sales_person.sales_quota
            , sales_person.bonus
            , sales_person.commission_pct
            , sales_person.sales_ytd
            , sales_person.sales_last_year
        from employee
        left join sales_person
            on employee.business_entity_id = sales_person.business_entity_id
        left join person
            on employee.business_entity_id = person.business_entity_id
    )

select *
from dim_vendedores
where sales_ytd is not null
