{{
  config(
    materialized='table',
    alias='dim_stations',
    unique_key='station_id'
  )
}}

WITH station_data AS (
  SELECT DISTINCT
    start_station_id AS station_id,
    start_station_name AS station_name,
    start_lat AS lat,
    start_lng AS lng
  FROM {{ ref('stg_baywheels_trips') }}
  WHERE start_station_name IS NOT NULL AND start_station_id IS NOT NULL
  UNION ALL
  SELECT DISTINCT
    end_station_id AS station_id,
    end_station_name AS station_name,
    end_lat AS lat,
    end_lng AS lng
  FROM {{ ref('stg_baywheels_trips') }}
  WHERE end_station_name IS NOT NULL AND end_station_id IS NOT NULL
)
, station_area_data AS (
  SELECT
    s.*,
    a.county_id, a.county_name
  FROM station_data s
  LEFT JOIN {{ ref('dim_bay_area_county') }} a
  ON ST_WITHIN(ST_GEOGPOINT(lng, lat), a.geometry)   
  WHERE a.county_id IS NOT NULL
)
, clean_station_data AS (
  SELECT
    station_id,
    ANY_VALUE(station_name) AS station_name,
    ANY_VALUE(lat) AS lat,
    ANY_VALUE(lng) AS lng
  FROM station_area_data
  GROUP BY station_id
)
SELECT 
  *,
  ST_GEOGPOINT(lng, lat) as location,
  CURRENT_TIMESTAMP() AS dbt_updated_at
FROM clean_station_data