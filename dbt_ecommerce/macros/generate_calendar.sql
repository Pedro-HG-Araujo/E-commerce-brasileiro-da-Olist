
{% macro generate_calendar(source_relation, date_column) %}

WITH periodo AS (
    SELECT
        MIN({{ date_column }}::date) AS data_inicial,
        MAX({{ date_column }}::date) AS data_final
    FROM {{ source_relation }}
),

calendario AS (
    SELECT
        generate_series(
            data_inicial,
            data_final,
            INTERVAL '1 day'
        )::date AS data
    FROM periodo
    WHERE data_inicial IS NOT NULL
)

SELECT
    TO_CHAR(data, 'YYYYMMDD')::INTEGER AS sk_data,
    data,
    EXTRACT(YEAR FROM data)::INTEGER AS ano,
    EXTRACT(QUARTER FROM data)::INTEGER AS trimestre,
    EXTRACT(MONTH FROM data)::INTEGER AS mes,
    CASE EXTRACT(MONTH FROM data)::INTEGER
        WHEN 1 THEN 'Janeiro'
        WHEN 2 THEN 'Fevereiro'
        WHEN 3 THEN 'Março'
        WHEN 4 THEN 'Abril'
        WHEN 5 THEN 'Maio'
        WHEN 6 THEN 'Junho'
        WHEN 7 THEN 'Julho'
        WHEN 8 THEN 'Agosto'
        WHEN 9 THEN 'Setembro'
        WHEN 10 THEN 'Outubro'
        WHEN 11 THEN 'Novembro'
        WHEN 12 THEN 'Dezembro'
    END AS nome_mes,
    TO_CHAR(data, 'YYYYMM')::INTEGER AS ano_mes,
    EXTRACT(DAY FROM data)::INTEGER AS dia,
    EXTRACT(DOY FROM data)::INTEGER AS dia_ano,
    EXTRACT(ISODOW FROM data)::INTEGER AS dia_semana,
    CASE EXTRACT(ISODOW FROM data)::INTEGER
        WHEN 1 THEN 'Segunda-feira'
        WHEN 2 THEN 'Terça-feira'
        WHEN 3 THEN 'Quarta-feira'
        WHEN 4 THEN 'Quinta-feira'
        WHEN 5 THEN 'Sexta-feira'
        WHEN 6 THEN 'Sábado'
        WHEN 7 THEN 'Domingo'
    END AS nome_dia,
    EXTRACT(WEEK FROM data)::INTEGER AS semana_ano,
    EXTRACT(ISOYEAR FROM data)::INTEGER AS ano_semana,
    EXTRACT(QUARTER FROM data)::INTEGER AS trimestre_ano,
    EXTRACT(MONTH FROM data)::INTEGER IN (1, 2, 3) AS primeiro_trimestre,
    EXTRACT(ISODOW FROM data)::INTEGER IN (6, 7) AS fim_de_semana,
    EXTRACT(ISODOW FROM data)::INTEGER NOT IN (6, 7) AS dia_util,
    DATE_TRUNC('month', data)::date AS primeiro_dia_mes,
    (DATE_TRUNC('month', data) + INTERVAL '1 month - 1 day')::date
        AS ultimo_dia_mes,
    DATE_TRUNC('year', data)::date AS primeiro_dia_ano,
    (DATE_TRUNC('year', data) + INTERVAL '1 year - 1 day')::date
        AS ultimo_dia_ano,
    (data = DATE_TRUNC('month', data)::date) AS inicio_mes,
    (data = (DATE_TRUNC('month', data) + INTERVAL '1 month - 1 day')::date)
        AS fim_mes,
    CASE
        WHEN EXTRACT(MONTH FROM data) <= 6 THEN 1
        ELSE 2
    END AS semestre
FROM calendario
--ORDER BY data
{% endmacro %}
