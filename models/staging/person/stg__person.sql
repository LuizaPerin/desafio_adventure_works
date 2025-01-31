with

    source as (
        select *
        from {{ source('raw-data-person','person') }}
    )

    , renamed as (
        select
            businessentityid as business_entity_id
            , persontype as person_type
            , namestyle as name_style
            , title
            , firstname as first_name
            , middlename as middle_name
            , lastname as last_name
            , suffix
            , emailpromotion as email_promotion
            , additionalcontactinfo as additional_contact_info
            , demographics
            , rowguid
            , modifieddate as modified_date
        from source
    )

select *
from renamed
