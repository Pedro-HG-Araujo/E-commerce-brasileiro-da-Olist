
import pandas as pd
import psycopg
from pathlib import Path
from utils.database import get_connection


def load_csv_to_postgres(
    file_path,
    table_name,
    schema="raw",
):

    # 1. Ler o CSV
    df = pd.read_csv(file_path)

    # 2. Inferir tipos de dados
    def get_postgres_type(dtype):

        if pd.api.types.is_integer_dtype(dtype):
            return "BIGINT"

        elif pd.api.types.is_float_dtype(dtype):
            return "DOUBLE PRECISION"

        elif pd.api.types.is_bool_dtype(dtype):
            return "BOOLEAN"

        elif pd.api.types.is_datetime64_any_dtype(dtype):
            return "TIMESTAMP"

        else:
            return "TEXT"

    columns = []

    for column, dtype in df.dtypes.items():

        pg_type = get_postgres_type(dtype)

        columns.append(
            f'"{column}" {pg_type}'
        )

    columns_sql = ", ".join(columns)

    # 3. Conectar ao PostgreSQL
    
    with get_connection() as conn:

        with conn.cursor() as cur:

            # 4. Criar schema
            cur.execute(
                f'CREATE SCHEMA IF NOT EXISTS "{schema}"'
            )

            # 5. Criar tabela
            cur.execute(
                f'''
                CREATE TABLE IF NOT EXISTS "{schema}"."{table_name}"
                ({columns_sql})
                '''
            )

            # 6. Executar COPY
            copy_columns = ", ".join(
                f'"{col}"' for col in df.columns
            )

            with cur.copy(
                f'''
                COPY "{schema}"."{table_name}"
                ({copy_columns})
                FROM STDIN
                WITH (FORMAT CSV, HEADER TRUE)
                '''
            ) as copy:

                copy.write(df.to_csv(index=False, header=True))

        conn.commit()

    print(
        f"Carga concluída: {len(df)} registros "
        f"em {schema}.{table_name}"
    )
