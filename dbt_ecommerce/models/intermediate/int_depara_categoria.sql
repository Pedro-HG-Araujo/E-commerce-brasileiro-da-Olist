select 
     product_id
    ,c.id as categoria_produto_id
from {{ ref('olist_products') }} p
JOIN {{ ref('int_scd_categoria_produto') }} c on c.OrigemId = upper(coalesce(replace(product_category_name,'_',' '), '(Não categorizado)'))
                                            and c.dbt_valid_to is null