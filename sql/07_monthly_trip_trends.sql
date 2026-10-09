-- Calculate month-over-month demand changes.
CREATE OR REPLACE TABLE `gcp-bigquery-analytics-ml.mobility_analytics.monthly_trip_trends` AS
SELECT
  trip_month,
  total_trips,
  avg_trip_duration_minutes,
  subscriber_trips,
  customer_trips,
  total_trips - LAG(total_trips) OVER (ORDER BY trip_month) AS month_over_month_change,
  ROUND(
    100 * SAFE_DIVIDE(
      total_trips - LAG(total_trips) OVER (ORDER BY trip_month),
      LAG(total_trips) OVER (ORDER BY trip_month)
    ),
    2
  ) AS month_over_month_pct_change
FROM `gcp-bigquery-analytics-ml.mobility_analytics.monthly_trip_summary`
ORDER BY trip_month;