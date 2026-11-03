with vendas as (
select 
     concat(o.order_id,'|',i.product_id) as OrigemId
    ,o.Order_status as Status
    ,c.categoria_produto_id
    ,i.price as Preco
    ,i.freight_value as Frete
from {{ ref('olist_orders') }} o
left join {{ ref('olist_order_items') }} i on i.order_id = o.order_id
left join {{ ref('int_depara_categoria') }} c on c.product_id = i.product_id
)

{{ generate_surrogate_key(
    'vendas',
    'OrigemId',
    'Id'
) }}