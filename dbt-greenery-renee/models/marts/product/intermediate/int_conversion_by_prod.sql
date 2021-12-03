{{
    config(
        materialized = 'table'
    )
}}

{% 
  
  set event_types = dbt_utils.get_query_results_as_dict(
      "select distinct event_type from "
      ~ ref('fact_events')
      ~ "group by 1"
      )
%}

with conversion_by_prod_guid as(
select
      product_guid,
      {% for event_type in event_types['event_type'] %}
    sum(case when event_type = '{{ event_type }}' then 1 end) as total_{{ event_type }}
    {{ "," if not loop.last }}
    {% endfor %}
  
from {{ ref('int_events') }}
group by 1
)


select * from conversion_by_prod_guid



