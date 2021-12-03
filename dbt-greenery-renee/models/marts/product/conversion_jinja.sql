{{
    config(
        materialized = 'table'
    )
}}
    
{% set event_types = ["page_view", "add_to_cart", "delete_from_cart", "checkout", "package_shipped", "account_created"] %}

select
    {% for event_type in event_types %}
    sum(case when event_type = '{{ event_type }}' then 1 end) as total_{{ event_type }}
    {{ "," if not loop.last }}
    {% endfor %}
    
from {{ ref('fact_events') }}   






