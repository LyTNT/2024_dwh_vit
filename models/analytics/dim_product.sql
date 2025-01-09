WITH dim_product__source AS (
  SELECT *
  FROM `vit-lam-data.wide_world_importers.warehouse__stock_items`
)

, dim_product__rename_and_cast_type AS (
  SELECT CAST (stock_item_id AS INTEGER) AS product_key
  , CAST(supplier_id AS INTEGER) AS supplier_key
  , CAST(stock_item_name AS STRING) AS product_name
  , CAST( brand AS STRING) AS brand_name
  , CAST(is_chiller_stock AS BOOLEAN) AS is_chiller_stock_boolean
  FROM dim_product__source
)

, dim_product__chiller_stock AS(
  SELECT *
  , CASE WHEN is_chiller_stock_boolean IS TRUE THEN 'Chiller Stock'
        WHEN is_chiller_stock_boolean IS FALSE THEN 'Not Chiller Stock'  
        WHEN is_chiller_stock_boolean IS NULL THEN 'Undefined'
        ELSE 'Invalid' END AS is_chiller_stock
  FROM dim_product__rename_and_cast_type
)

, dim_product_add_supplier AS (
  SELECT dim_product.*
  , COALESCE(dim_sup.supplier_name, 'Invalid') AS supplier_name
  FROM dim_product__chiller_stock dim_product
  LEFT JOIN {{ref("dim_supplier")}} dim_sup
  ON dim_sup.supplier_key = dim_product.supplier_key
)
SELECT product_key
, product_name
, COALESCE(brand_name, 'Undefined') AS brand_name
, supplier_key
, supplier_name
, is_chiller_stock
FROM dim_product_add_supplier




