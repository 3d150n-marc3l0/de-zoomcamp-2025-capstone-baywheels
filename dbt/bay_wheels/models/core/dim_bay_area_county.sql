{{
  config(
    materialized='table',
    alias='dim_bay_area_county',
    unique_key='county_id'
  )
}}

SELECT
    county_id,
    county_name,
    fipsstco,
    ST_GeogFromText(geometry) AS geometry,
    CURRENT_TIMESTAMP() AS updated_at
FROM {{ source('staging','bay_area_county_ext') }}