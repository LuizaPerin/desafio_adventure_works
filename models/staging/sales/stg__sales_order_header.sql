with

    source as (
        select *
        from {{ source('raw-data-sales','salesorderheader') }}
    )

    , renamed as (
        select
            salesorderid as sales_order_id
            , revisionnumber as revision_number
            , orderdate::date as order_date
            , duedate::date as due_date
            , shipdate::date as ship_date
            , status
            , onlineorderflag as oline_order_flag
            , purchaseordernumber as purchase_order_number
            , accountnumber as account_number
            , customerid as customer_id
            , salespersonid as sales_person_id
            , territoryid as territory_id
            , billtoaddressid as bill_to_address_id
            , shiptoaddressid as ship_to_address_id
            , shipmethodid as ship_method_id
            , creditcardid as credit_card_id
            , creditcardapprovalcode as credit_card_approval_code
            , currencyrateid as currency_rate_id
            , subtotal as sub_total
            , taxamt as tax_amt
            , freight
            , totaldue as total_due
            , comment
            , rowguid
            , modifieddate as modified_date
        from source
    )

select * from renamed
