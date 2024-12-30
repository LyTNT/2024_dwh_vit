WITH fact_sales_order_line__source AS (
  SELECT * 
  FROM `vit-lam-data.wide_world_importers.sales__order_lines`
)

, fact_sales_order_line__rename_and_cast AS(
  SELECT 
    CAST(order_line_id AS INTEGER) AS sales_order_line_key
  , CAST (order_id AS INTEGER) AS sales_order_key
  , CAST(quantity AS INTEGER) AS quantity
  , CAST(unit_price AS NUMERIC) AS unit_price
  , CAST(stock_item_id AS INTEGER) AS product_key
  FROM fact_sales_order_line__source
)

, fact_sales_order_line__count_gross_amount AS(
  SELECT *
  , quantity * unit_price AS  gross_amount
  FROM fact_sales_order_line__rename_and_cast
)

, fact_sales_order_line__add_customer AS (
  SELECT fact_line.*
  , fact_header.customer_key
  FROM fact_sales_order_line__count_gross_amount fact_line
  LEFT JOIN {{ ref('stg_fact_sales_order')}} fact_header
  ON fact_header.sales_order_key = fact_line.sales_order_key
)

SELECT sales_order_line_key
, sales_order_key
, product_key
, customer_key
, quantity
, unit_price
, gross_amount
FROM fact_sales_order_line__add_customer

