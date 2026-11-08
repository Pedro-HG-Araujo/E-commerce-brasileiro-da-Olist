with vendas as (
select 
     concat(o.order_id,'|',i.order_item_id) as OrigemId
    ,o.order_id as PedidoOrigemId
    ,o.Order_status as Status
    ,TO_DATE(LEFT(o.order_purchase_timestamp, 10), 'YYYY-MM-DD') as DataPedido
    ,c.categoria_produto_id
    ,coalesce(i.price,0) as Preco
    ,i.freight_value as Frete
from {{ ref('olist_orders') }} o
left join {{ ref('olist_order_items') }} i on i.order_id = o.order_id
left join {{ ref('int_depara_categoria') }} c on c.product_id = i.product_id
where c.categoria_produto_id is not null
)

{{ generate_surrogate_key(
    'vendas',
    'OrigemId',
    'Id'
) }}