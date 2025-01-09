WITH dim_person__source AS (
  SELECT 
  *
  FROM `vit-lam-data.wide_world_importers.application__people`
)
, dim_person__rename_and_cast_type AS (
  SELECT 
  CAST(person_id AS INTEGER) AS person_key
  , CAST(full_name AS STRING) AS full_name
  , CAST(preferred_name AS STRING) AS preferred_name
  , CAST(search_name AS STRING) AS search_name
  FROM dim_person__source
)
SELECT person_key
, full_name
, COALESCE(preferred_name, 'Undefined') AS preferred_name
, COALESCE(search_name, 'Undefined') AS search_name
FROM dim_person__rename_and_cast_type


