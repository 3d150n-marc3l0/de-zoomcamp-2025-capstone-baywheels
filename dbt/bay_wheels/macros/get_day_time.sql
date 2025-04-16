{#
    This macro returns the description of the payment_type 
#}

{% macro get_time_day(datetime_at) %}
    CASE
       WHEN EXTRACT(HOUR FROM datetime_at) >= 5  AND EXTRACT(HOUR FROM datetime_at) < 12 THEN 'morning'
       WHEN EXTRACT(HOUR FROM datetime_at) >= 12 AND EXTRACT(HOUR FROM datetime_at) < 18 THEN 'afternoon'
       WHEN EXTRACT(HOUR FROM datetime_at) >= 18 AND EXTRACT(HOUR FROM datetime_at) < 21 THEN 'evening'
       ELSE 'night'
    END
{% endmacro %}