select Id
      ,OrigemId
      ,Categoria
from {{ ref('int_categoria_produto') }}