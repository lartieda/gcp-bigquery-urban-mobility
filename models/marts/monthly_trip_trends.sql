with monthly_metrics as (

    select * from {{ ref('monthly_trip_summary') }}

),

with_previous_month as (

    select
        *,
        lag(total_trips) over (
            order by trip_month
        ) as previous_month_total_trips
    from monthly_metrics

)

select
    trip_month,
    total_trips,
    previous_month_total_trips,
    total_trips - previous_month_total_trips as month_over_month_change,
    round(
        100 * safe_divide(
            total_trips - previous_month_total_trips,
            previous_month_total_trips
        ),
        2
    ) as month_over_month_pct_change
from with_previous_month
order by trip_month
