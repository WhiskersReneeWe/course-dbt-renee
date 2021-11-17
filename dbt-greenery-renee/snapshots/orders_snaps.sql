{% snapshot orders_snapshot %}

  {{
    config(
      target_database = 'dbt',
      target_schema ='snapshots',
      unique_key='order_id',

      strategy='timestamp',
      updated_at='delivered_at'
    )
  }}

  SELECT * 
  FROM  {{ ref('stg_orders') }}

{% endsnapshot %}