select 
	  upper(coalesce(replace(product_category_name,'_',' '), '(Não categorizado)')) as OrigemId
	, upper(coalesce(replace(product_category_name,'_',' '), '(Não categorizado)')) as Categoria
from {{ ref('olist_products') }} p
group by product_category_name
