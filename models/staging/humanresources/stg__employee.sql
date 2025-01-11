with

    source as (
        select *
        from {{ source('raw-data-humanresources','employee') }}
    )

    , renamed as (
        select
            businessentityid as business_entity_id
            , nationalidnumber as national_id_number
            , loginid as login_id
            , jobtitle as job_title
            , birthdate as birth_date
            , maritalstatus as marital_status
            , gender
            , hiredate as hire_date
            , salariedflag as salaried_flag
            , vacationhours as vacation_hours
            , sickleavehours as sick_leave_hours
            , currentflag as current_flag
            , rowguid
            , modifieddate as modified_date
            , organizationnode as organization_node
        from source
    )

select *
from renamed
