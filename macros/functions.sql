{% macro margin_percent(revenue, purchase_cost, precision=2) %}
    SAFE_DIVIDE((revenue - purchase_cost), revenue) * 100.0
{% endmacro %}
