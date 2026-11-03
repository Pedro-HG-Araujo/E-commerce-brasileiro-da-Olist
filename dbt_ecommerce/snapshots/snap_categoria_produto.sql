{% snapshot snap_categoria_produto %}
{{
    config(
        unique_key='OrigemId',
        strategy='check',
        check_cols='all',
    )
}}
SELECT
    *
FROM {{ ref('stg_categoria_produto') }}
{% endsnapshot %}