with

    dates as (
        {{ dbt_date.get_date_dimension("2011-05-01", "2014-07-01") }}
    )

    , dim_dates as (
        select
            date_day
            , day_of_month
            , day_of_week
            , day_of_week_name
            , month_of_year
            , month_name
            , quarter_of_year
            , week_of_year
            , year_number
        from dates
    )

select * from dim_dates
