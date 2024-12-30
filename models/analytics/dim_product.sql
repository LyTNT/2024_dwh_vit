WITH dim_product__source AS (
  SELECT *
  FROM `vit-lam-data.wide_world_importers.warehouse__stock_items`
)

, dim_product__rename_and_cast_type AS (
  SELECT CAST (stock_item_id AS INTEGER) AS product_key
  , CAST(supplier_id AS INTEGER) AS supplier_key
  , CAST(stock_item_name AS STRING) AS product_name
  , CAST( brand AS STRING) AS brand_name
  , CAST(is_chiller_stock AS STRING) AS is_chiller_stock
  FROM dim_product__source
)

, dim_product__chiller_stock AS(
  SELECT product_key
  , supplier_key
  , product_name
  , brand_name
  , CASE WHEN is_chiller_stock = 'true' THEN 'is_chiller_stock'
        WHEN is_chiller_stock = 'false' THEN 'no_chiller_stock'  END AS is_chiller_stock
  FROM dim_product__rename_and_cast_type
)

, dim_product_add_supplier AS (
  SELECT dim_product.*
  , dim_sup.supplier_name
  FROM dim_product__chiller_stock dim_product
  LEFT JOIN {{ref("dim_supplier")}} dim_sup
  ON dim_sup.supplier_key = dim_product.supplier_key
)
SELECT product_key
, product_name
, brand_name
, supplier_key
, supplier_name
, is_chiller_stock
FROM dim_product_add_supplier




