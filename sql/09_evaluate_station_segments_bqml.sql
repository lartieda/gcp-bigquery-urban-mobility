-- Assess the compactness and separation of the K-means station segments.
SELECT *
FROM ML.EVALUATE(
  MODEL `gcp-bigquery-analytics-ml.mobility_analytics.station_segments`
);
