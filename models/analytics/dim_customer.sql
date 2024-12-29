WITH dim_customer__source AS (
  SELECT 
  *
FROM `vit-lam-data.wide_world_importers.sales__customers`
)

, dim_customer__rename_and_cast_type AS(
  SELECT CAST(customer_id AS INTEGER) AS customer_key
  , CAST(customer_name AS STRING) AS customer_name
  FROM dim_customer__source
)

, dim
SELECT customer_key
, customer_name
FROM dim_customer__rename_and_cast_type