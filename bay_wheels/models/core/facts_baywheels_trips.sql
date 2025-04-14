{{
  config(
    materialized='incremental',
    partition_by={
      'field': 'started_at', 
      'data_type': 'timestamp',
      'granularity': 'day'
    },
    cluster_by=['start_station_id', 'rider_type']
  )
}}

SELECT
    t.ride_id,
    t.rider_type,
    t.user_type,
    t.started_at,
    t.ended_at,
    t.duration_min,
    COALESCE(t.start_station_id, 'NA') as start_station_id,
    COALESCE(t.start_station_name, 'NO STATION') as start_station_name,
    COALESCE(t.end_station_id,'NA') as end_station_id,
    COALESCE(t.end_station_name, 'NO STATION') as end_station_name,
    --t.start_lat,
    --t.start_lng,
    ST_GEOGPOINT(t.start_lng, t.start_lat) as start_loc,
    --t.end_lat,
    --t.end_lng,
    ST_GEOGPOINT(t.end_lng, t.end_lat) as end_loc,
    pst.location as start_station_loc,
    dst.location as end_station_loc,

    EXTRACT(HOUR FROM t.started_at) AS hour_of_day,
    EXTRACT(DAYOFWEEK FROM t.started_at) AS day_of_week,
    CASE
       WHEN EXTRACT(HOUR FROM t.started_at) >= 5  AND EXTRACT(HOUR FROM t.started_at) < 12 THEN 'morning'
       WHEN EXTRACT(HOUR FROM t.started_at) >= 12 AND EXTRACT(HOUR FROM t.started_at) < 18 THEN 'afternoon'
       WHEN EXTRACT(HOUR FROM t.started_at) >= 18 AND EXTRACT(HOUR FROM t.started_at) < 21 THEN 'evening'
       ELSE 'night'
    END AS time_of_day,
    EXTRACT(MONTH FROM t.started_at) as pickup_month,
    EXTRACT(QUARTER FROM t.started_at) as pickup_quarter,
    EXTRACT(YEAR FROM t.started_at) as pickup_year,
    ST_DISTANCE(
      ST_GEOGPOINT(t.start_lng, t.start_lat),
      ST_GEOGPOINT(t.end_lng, t.end_lat)) / 1000 AS distance_km
  FROM
    {{ ref('stg_baywheels_trips') }} t
  LEFT JOIN
    {{ ref('dim_stations') }} pst
  ON
    t.start_station_id = pst.station_id
  LEFT JOIN
    {{ ref('dim_stations') }} dst
  ON
    t.end_station_id = dst.station_id

