with

    credit_card as (
        select
            {{ dbt_utils.generate_surrogate_key(['credit_card_id', 'card_type']) }} as sk_credit_card
            , *
        from {{ ref('stg__credit_card') }}
    )

    , dim_cartao as (
        select
            sk_credit_card
            , credit_card_id
            , card_type
        from credit_card
    )

select * from dim_cartao
