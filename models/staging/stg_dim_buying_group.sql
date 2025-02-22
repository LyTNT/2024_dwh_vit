WITH stg_dim_buying_group__source AS (
  SELECT * 
  FROM `vit-lam-data.wide_world_importers.sales__buying_groups`
)
, stg_dim_buying_group__rename_and_cast_type AS (
  SELECT 
  CAST (buying_group_id AS INTEGER) AS buying_group_key
  , CAST (buying_group_name AS STRING) AS buying_group_name
  FROM stg_dim_buying_group__source
)
SELECT buying_group_key
, buying_group_name
FROM stg_dim_buying_group__rename_and_cast_type