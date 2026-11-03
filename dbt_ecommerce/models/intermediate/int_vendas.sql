select 
     concat(o.order_id,'|',i.product_id) as OrigemId
    ,o.Order_status as Status
    ,i.product_id as ProdutoOrigemId
    ,i.price as Preco
    ,i.freight_value as Frete
from {{ source('olist', 'olist_orders') }} o
left join {{ source('olist', 'olist_order_items') }} i on i.order_id = o.order_id