select
    trip_month,
    total_trips,
    subscriber_trips,
    customer_trips
from {{ ref('monthly_trip_summary') }}
where total_trips != subscriber_trips + customer_trips
