from utils.loader import load_csv_to_postgres


## olist_customers_dataset
load_csv_to_postgres(
    file_path="data/olist/olist_customers_dataset.csv",
    table_name="olist_customers",
    schema="stage"
)

## olist_geolocation_dataset
load_csv_to_postgres(
    file_path="data/olist/olist_geolocation_dataset.csv",
    table_name="olist_geolocation",
    schema="stage"
)

## olist_order_items_dataset
load_csv_to_postgres(
    file_path="data/olist/olist_order_items_dataset.csv",
    table_name="olist_order_items",
    schema="stage"
)

## olist_order_payments_dataset
load_csv_to_postgres(
    file_path="data/olist/olist_order_payments_dataset.csv",
    table_name="olist_order_payments",
    schema="stage"
)

## olist_order_reviews_dataset
load_csv_to_postgres(
    file_path="data/olist/olist_order_reviews_dataset.csv",
    table_name="olist_order_reviews",
    schema="stage"
)

## olist_orders_dataset
load_csv_to_postgres(
    file_path="data/olist/olist_orders_dataset.csv",
    table_name="olist_orders",
    schema="stage"
)

## olist_products_dataset
load_csv_to_postgres(
    file_path="data/olist/olist_products_dataset.csv",
    table_name="olist_products",
    schema="stage"
)

## olist_sellers_dataset
load_csv_to_postgres(
    file_path="data/olist/olist_sellers_dataset.csv",
    table_name="olist_sellers",
    schema="stage"
)

## product_category_name_translation
load_csv_to_postgres(
    file_path="data/olist/product_category_name_translation.csv",
    table_name="product_category_name_translation",
    schema="stage"
)