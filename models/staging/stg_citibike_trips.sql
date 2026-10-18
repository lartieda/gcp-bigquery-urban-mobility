with source as (

    select * from {{ source('mobility_analytics', 'trips_2018_stage') }}

)

select
    trip_date,
    started_at,
    ended_at,
    trip_duration_seconds,
    trip_duration_minutes,
    start_station_id,
    start_station_name,
    end_station_id,
    end_station_name,
    bikeid,
    usertype,
    birth_year,
    gender,
    extract(hour from started_at) as start_hour,
    case
        when extract(dayofweek from trip_date) in (1, 7) then 'Weekend'
        else 'Weekday'
    end as day_type
from source
