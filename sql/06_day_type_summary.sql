-- Compare weekday and weekend usage patterns.
CREATE OR REPLACE TABLE `gcp-bigquery-analytics-ml.mobility_analytics.day_type_summary` AS
SELECT
  CASE
    WHEN EXTRACT(DAYOFWEEK FROM trip_date) IN (1, 7) THEN 'Weekend'
    ELSE 'Weekday'
  END AS day_type,
  COUNT(*) AS total_trips,
  ROUND(AVG(trip_duration_minutes), 2) AS avg_trip_duration_minutes,
  COUNTIF(usertype = 'Subscriber') AS subscriber_trips,
  COUNTIF(usertype = 'Customer') AS customer_trips
FROM `gcp-bigquery-analytics-ml.mobility_analytics.trips_2018_stage`
GROUP BY day_type
ORDER BY total_trips DESC;