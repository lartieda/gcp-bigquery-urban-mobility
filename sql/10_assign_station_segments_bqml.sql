-- Assign each station to its nearest K-means segment.
CREATE OR REPLACE TABLE `gcp-bigquery-analytics-ml.mobility_analytics.station_segment_assignments` AS
SELECT
  centroid_id AS segment_id,
  start_station_name,
  total_departures,
  distinct_bikes_used,
  avg_trip_duration_minutes,
  subscriber_departures,
  customer_departures
FROM ML.PREDICT(
  MODEL `gcp-bigquery-analytics-ml.mobility_analytics.station_segments`,
  (
    SELECT
      start_station_name,
      CAST(total_departures AS FLOAT64) AS total_departures,
      avg_trip_duration_minutes,
      SAFE_DIVIDE(subscriber_departures, total_departures) AS subscriber_share,
      SAFE_DIVIDE(customer_departures, total_departures) AS customer_share,
      distinct_bikes_used,
      subscriber_departures,
      customer_departures
    FROM `gcp-bigquery-analytics-ml.mobility_analytics.station_trip_summary`
    WHERE total_departures > 0
      AND avg_trip_duration_minutes IS NOT NULL
  )
);
