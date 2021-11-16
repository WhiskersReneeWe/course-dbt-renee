{% snapshot orders_snapshot %}

  {{
    config(
      target_database = 'dbt',
      target_schema ='snapshots',
      unique_key='id',

      strategy='timestamp',
      updated_at='delivered_at'
    )
  }}

  SELECT * 
  FROM {{ source('greenery', 'orders') }}

{% endsnapshot %}