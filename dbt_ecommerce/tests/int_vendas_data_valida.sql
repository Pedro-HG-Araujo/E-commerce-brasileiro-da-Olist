select 1
from {{ ref('int_vendas') }}
where DataPedido > CURRENT_DATE 