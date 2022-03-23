{% macro event_types(column_name, eventtype) %}
    SELECT
    {{column_name}}, sum(case when event_type = '{{eventtype}}' then 1 else 0 end)
    FROM {{ref('g_events')}} GROUP BY 1 ORDER BY 1
{% endmacro %}