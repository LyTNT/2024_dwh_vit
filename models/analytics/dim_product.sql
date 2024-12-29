WITH dim_product__source AS (
  SELECT *
  FROM `vit-lam-data.wide_world_importers.warehouse__stock_items`
)

, dim_product_rename AS (
  SELECT CAST (stock_item_id AS INTEGER) AS product_key
  , CAST(stock_item_name AS STRING) AS product_name
  , CAST( brand AS STRING) AS brand_name
  FROM dim_product__source
)

SELECT product_key
, product_name
, brand_name
FROM dim_product_rename




