{{
    config(
        materialized = 'table'
    )
}}

/*
with fact_conversion_agg as (
select
    sum(case when event_type = 'add_to_cart' then 1 end) as total_add_to_cart,
    sum(case when event_type = 'checkout' then 1 end) as total_checkout,
    sum(case when event_type = 'delete_from_cart' then 1 end) as total_delete_from_cart,
    sum(case when event_type = 'package_shipped' then 1 end) as total_package_shipped,
    sum(case when event_type = 'page_view' then 1 end) as total_page_view,
    sum(case when event_type = 'account_created' then 1 end) as total_account_created
from {{ ref('fact_events') }}
)
*/

      
{% set event_types = ["page_view", "add_to_cart", "delete_from_cart", "checkout", "package_shippe", "account_created"] %}

select
    {% for event_type in event_types %}
    sum(case when event_type = '{{ event_type }}' then 1 end) as total_{{ event_type }}
    {{ "," if not loop.last }}
    {% endfor %}
    
from {{ ref('fact_events') }}   






