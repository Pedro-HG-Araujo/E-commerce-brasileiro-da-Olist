/* 
 Focado em SCD Tipo 1, com a criação de uma chave substituta para cada registro, 
 garantindo a unicidade. 
 A macro `generate_surrogate_key` é projetada para gerar uma chave substituta única para cada registro 
 em uma tabela de destino, com base em uma chave de negócios fornecida (OrigemId). 
 Ela utiliza uma sequência para garantir que cada chave substituta seja única e incremental.
*/

{% macro generate_surrogate_key(source_relation, business_key, surrogate_key) %}

    {% set sequence_name = 'seq_' ~ this.name %}

    {% if execute %}

        {% do run_query("CREATE SCHEMA IF NOT EXISTS dw") %}

        {% do run_query(
            "CREATE SEQUENCE IF NOT EXISTS dw." ~ sequence_name
        ) %}

    {% endif %}

    {% if is_incremental() %}

        SELECT
            COALESCE(
                d.{{ surrogate_key }},
                nextval('dw.{{ sequence_name }}')
            ) AS {{ surrogate_key }},
            s.*

        FROM {{ source_relation }} s

        LEFT JOIN {{ this }} d
            ON s.{{ business_key }} = d.{{ business_key }}

    {% else %}

        SELECT
            nextval('dw.{{ sequence_name }}') AS {{ surrogate_key }},
            s.*

        FROM {{ source_relation }} s

    {% endif %}

{% endmacro %}