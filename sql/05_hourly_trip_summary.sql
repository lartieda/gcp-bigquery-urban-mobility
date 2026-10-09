-- Measure demand by hour of day.
CREATE OR REPLACE TABLE `gcp-bigquery-analytics-ml.mobility_analytics.hourly_trip_summary` AS
SELECT
  EXTRACT(HOUR FROM started_at) AS trip_hour,
  COUNT(*) AS total_trips,
  ROUND(AVG(trip_duration_minutes), 2) AS avg_trip_duration_minutes,
  COUNTIF(usertype = 'Subscriber') AS subscriber_trips,
  COUNTIF(usertype = 'Customer') AS customer_trips
FROM `gcp-bigquery-analytics-ml.mobility_analytics.trips_2018_stage`
GROUP BY trip_hour
ORDER BY trip_hour;