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
  , CAST(is_on_credit_hold AS BOOLEAN) AS is_on_credit_hold_boolean
  FROM dim_customer__source
)

, dim_customer__add_columns AS (
  SELECT *
  , CASE 
      WHEN is_on_credit_hold_boolean IS TRUE THEN 'Credit Hold'
      WHEN is_on_credit_hold_boolean IS FALSE THEN 'Not Credit Hold'
      WHEN is_on_credit_hold_boolean IS NULL THEN 'Undefined'
      ELSE 'Invalid' END AS is_on_credit_hold
  FROM dim_customer__rename_and_cast_type
)

SELECT dim_cus.customer_key
, dim_cus.customer_name
, dim_cus.customer_category_key
, COALESCE(stg_dim_cus_category.customer_category_name, 'Invalid') AS customer_category_name
, dim_cus.buying_group_key
, COALESCE(stg_dim_buying_group.buying_group_name, 'Invalid') AS buying_group_name
, dim_cus.is_on_credit_hold

FROM dim_customer__add_columns dim_cus
LEFT JOIN {{ref('stg_dim_customer_category')}} AS stg_dim_cus_category
ON stg_dim_cus_category.customer_category_key = dim_cus.customer_category_key
LEFT JOIN {{ref ('stg_dim_buying_group')}} AS stg_dim_buying_group
ON stg_dim_buying_group.buying_group_key = dim_cus.buying_group_key