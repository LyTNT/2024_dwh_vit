WITH stg_fact_sales_order__source AS (
  SELECT * 
  FROM `vit-lam-data.wide_world_importers.sales__orders`
)
, stg_fact_sales_order__rename_cast_type AS (
  SELECT CAST(order_id AS INTEGER) AS sales_order_key 
  , CAST(customer_id AS INTEGER) AS customer_key 
  , CAST(picked_by_person_id AS INTEGER) AS picked_by_person_key
  FROM stg_fact_sales_order__source
)
SELECT sales_order_key
, customer_key
, picked_by_person_key
FROM stg_fact_sales_order__rename_cast_type