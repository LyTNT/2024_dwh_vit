WITH stg_dim_customer_category__source AS (
  SELECT *
  FROM `vit-lam-data.wide_world_importers.sales__customer_categories`
)
, stg_dim_customer_category__rename_and_cast_type AS (
  SELECT 
  CAST (customer_category_id AS INTEGER) AS customer_category_key
  , CAST (customer_category_name AS STRING) AS customer_category_name
  FROM stg_dim_customer_category__source
)
SELECT customer_category_key
, customer_category_name
FROM stg_dim_customer_category__rename_and_cast_type