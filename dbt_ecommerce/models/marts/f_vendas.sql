select 
     categoria_produto_id
    ,PedidoOrigemId
    ,OrigemId
    ,Status
    ,Preco
    ,Frete
    ,DataPedido
from {{ ref('int_vendas') }}