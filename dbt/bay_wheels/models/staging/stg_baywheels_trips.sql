{{
    config(
        materialized='view'
    )
}}

with tripdata as 
(
  select *,
    row_number() over(partition by ride_id, started_at) as rn
  from {{ source('staging','baywheels_tripdata') }}
  where ride_id is not null 
)
select
    -- identifiers
    ride_id,
    rideable_type as rider_type,
    cast(started_at as timestamp) as started_at,
    cast(ended_at as timestamp) as ended_at,
    TIMESTAMP_DIFF(CAST(ended_at AS TIMESTAMP), CAST(started_at AS TIMESTAMP), MINUTE) AS duration_min,
    start_station_id,
    start_station_name,
    end_station_id,
    end_station_name,
    start_lat,
    start_lng,
    end_lat,
    end_lng,
    member_casual as user_type,
    CURRENT_TIMESTAMP() AS updated_at
from tripdata

{% if var('is_test_run', default=true) %}
limit 100
{% endif %}