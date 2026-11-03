with snap_categoria_produto as (
    select * from {{ ref('snap_categoria_produto') }}
)

select 
 row_number() over (order by dbt_valid_from, OrigemId) as Id
,*
from snap_categoria_produto