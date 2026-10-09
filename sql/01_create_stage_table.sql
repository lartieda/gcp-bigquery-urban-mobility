-- Build a cleaned staging table from the 2018 Citi Bike public dataset.
CREATE OR REPLACE TABLE `gcp-bigquery-analytics-ml.mobility_analytics.trips_2018_stage` AS
SELECT
  DATE(starttime) AS trip_date,
  starttime AS started_at,
  stoptime AS ended_at,
  tripduration AS trip_duration_seconds,
  ROUND(tripduration / 60, 2) AS trip_duration_minutes,
  start_station_id,
  start_station_name,
  end_station_id,
  end_station_name,
  bikeid,
  usertype,
  birth_year,
  gender
FROM `bigquery-public-data.new_york_citibike.citibike_trips`
WHERE EXTRACT(YEAR FROM starttime) = 2018
  AND tripduration > 0
  AND start_station_name IS NOT NULL
  AND end_station_name IS NOT NULL;