-- Train a BigQuery ML K-means model to segment departure stations.
CREATE OR REPLACE MODEL `gcp-bigquery-analytics-ml.mobility_analytics.station_segments`
OPTIONS (
  model_type = 'KMEANS',
  num_clusters = 4,
  standardize_features = TRUE
) AS
SELECT
  CAST(total_departures AS FLOAT64) AS total_departures,
  avg_trip_duration_minutes,
  SAFE_DIVIDE(subscriber_departures, total_departures) AS subscriber_share,
  SAFE_DIVIDE(customer_departures, total_departures) AS customer_share
FROM `gcp-bigquery-analytics-ml.mobility_analytics.station_trip_summary`
WHERE total_departures > 0
  AND avg_trip_duration_minutes IS NOT NULL;
