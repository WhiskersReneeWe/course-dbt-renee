{% snapshot users_snapshot %}

    {{
    config(
      target_database = 'dbt',
      target_schema ='snapshots',
      unique_key='id',

      strategy='timestamp',
      updated_at='updated_at'
    )
  }}

{% endsnapshot %}