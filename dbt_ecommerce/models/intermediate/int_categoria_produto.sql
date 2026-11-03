{{
    config(
        materialized='incremental',
        unique_key='OrigemId',
        incremental_strategy='merge'
    )
}}

with dim_categoria_produto as (
	select 
		  upper(coalesce(replace(product_category_name,'_',' '), '(Não categorizado)')) as OrigemId
		, upper(coalesce(replace(product_category_name,'_',' '), '(Não categorizado)')) as Categoria
	from {{ ref('olist_products') }} p
	group by product_category_name
)

{{ generate_surrogate_key(
    'dim_categoria_produto',
    'OrigemId',
    'Id'
) }}