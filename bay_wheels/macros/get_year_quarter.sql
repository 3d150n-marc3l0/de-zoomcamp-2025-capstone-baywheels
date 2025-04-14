{#
    This macro returns the description of the payment_type 
#}

{% macro get_year_quarter(pickup_datetime) %}
    CAST(
      CONCAT(
        EXTRACT(YEAR FROM {{ pickup_datetime }}),
        '/Q',
        EXTRACT(QUARTER FROM {{ pickup_datetime }})
      ) AS STRING
    )
{% endmacro %}