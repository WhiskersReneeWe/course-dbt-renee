{% snapshot events_snapshot %}

  {{
    config(
      target_database = 'dbt',
      target_schema ='snapshots',
      unique_key='event_id',

      strategy='timestamp',
      updated_at='created_at'
    )
  }}

  SELECT * 
  FROM {{ ref('stg_events') }}

{% endsnapshot %}