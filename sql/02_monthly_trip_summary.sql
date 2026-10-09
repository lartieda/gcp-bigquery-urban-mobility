-- Aggregate cleaned trips at monthly level for trend analysis.
CREATE OR REPLACE TABLE `gcp-bigquery-analytics-ml.mobility_analytics.monthly_trip_summary` AS
SELECT
  DATE_TRUNC(trip_date, MONTH) AS trip_month,
  COUNT(*) AS total_trips,
  COUNT(DISTINCT bikeid) AS active_bikes,
  COUNT(DISTINCT start_station_name) AS active_start_stations,
  ROUND(AVG(trip_duration_minutes), 2) AS avg_trip_duration_minutes,
  COUNTIF(usertype = 'Subscriber') AS subscriber_trips,
  COUNTIF(usertype = 'Customer') AS customer_trips
FROM `gcp-bigquery-analytics-ml.mobility_analytics.trips_2018_stage`
GROUP BY trip_month
ORDER BY trip_month;