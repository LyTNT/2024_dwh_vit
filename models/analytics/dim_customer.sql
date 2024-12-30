WITH dim_customer__source AS (
  SELECT 
  *
FROM `vit-lam-data.wide_world_importers.sales__customers`
)

, dim_customer__rename_and_cast_type AS(
  SELECT CAST(customer_id AS INTEGER) AS customer_key
  , CAST(customer_name AS STRING) AS customer_name
  , CAST(customer_category_id AS INTEGER) AS customer_category_key
  , CAST(buying_group_id AS INTEGER) AS buying_group_key
  FROM dim_customer__source
)

SELECT dim_cus.customer_key
, dim_cus.customer_name
, dim_cus.customer_category_key
, stg_dim_cus_category.customer_category_name
, dim_cus.buying_group_key
, stg_dim_buying_group.buying_group_name

FROM dim_customer__rename_and_cast_type dim_cus
LEFT JOIN {{ref('stg_dim_customer_category')}} AS stg_dim_cus_category
ON stg_dim_cus_category.customer_category_key = dim_cus.customer_category_key
LEFT JOIN {{ref ('stg_dim_buying_group')}} AS stg_dim_buying_group
ON stg_dim_buying_group.buying_group_key = dim_cus.buying_group_key