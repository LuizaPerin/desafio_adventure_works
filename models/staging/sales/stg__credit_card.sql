with

    source as (
        select *
        from {{ source('raw-data-sales','creditcard') }}
    )

    , renamed as (
        select
            creditcardid as credit_card_id
            , cardtype as card_type
            , modifieddate as modified_date
        from source
    )

select * from renamed
