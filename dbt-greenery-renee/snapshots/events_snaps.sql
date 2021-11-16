{% snapshot events_snapshot %}

  {{
    config(
      target_database = 'dbt',
      target_schema ='snapshots',
      unique_key='id',

      strategy='timestamp',
      updated_at='created_at'
    )
  }}

  SELECT * 
  FROM {{ source('greenery', 'events') }}

{% endsnapshot %}