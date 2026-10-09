-- Summarise the most frequent origin-to-destination routes.
CREATE OR REPLACE TABLE `gcp-bigquery-analytics-ml.mobility_analytics.route_trip_summary` AS
SELECT
  start_station_name,
  end_station_name,
  COUNT(*) AS total_trips,
  ROUND(AVG(trip_duration_minutes), 2) AS avg_trip_duration_minutes,
  COUNT(DISTINCT bikeid) AS distinct_bikes_used
FROM `gcp-bigquery-analytics-ml.mobility_analytics.trips_2018_stage`
WHERE start_station_name != end_station_name
GROUP BY
  start_station_name,
  end_station_name
HAVING COUNT(*) >= 100
ORDER BY total_trips DESC;