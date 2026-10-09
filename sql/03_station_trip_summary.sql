-- Identify the busiest departure stations.
CREATE OR REPLACE TABLE `gcp-bigquery-analytics-ml.mobility_analytics.station_trip_summary` AS
SELECT
  start_station_name,
  COUNT(*) AS total_departures,
  COUNT(DISTINCT bikeid) AS distinct_bikes_used,
  ROUND(AVG(trip_duration_minutes), 2) AS avg_trip_duration_minutes,
  COUNTIF(usertype = 'Subscriber') AS subscriber_departures,
  COUNTIF(usertype = 'Customer') AS customer_departures
FROM `gcp-bigquery-analytics-ml.mobility_analytics.trips_2018_stage`
GROUP BY start_station_name
HAVING COUNT(*) >= 100
ORDER BY total_departures DESC;