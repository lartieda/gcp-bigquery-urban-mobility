with trips as (

    select * from {{ ref('stg_citibike_trips') }}

)

select
    date_trunc(trip_date, month) as trip_month,
    count(*) as total_trips,
    count(distinct bikeid) as active_bikes,
    count(distinct start_station_name) as active_start_stations,
    round(avg(trip_duration_minutes), 2) as avg_trip_duration_minutes,
    countif(usertype = 'Subscriber') as subscriber_trips,
    countif(usertype = 'Customer') as customer_trips
from trips
group by trip_month
order by trip_month
