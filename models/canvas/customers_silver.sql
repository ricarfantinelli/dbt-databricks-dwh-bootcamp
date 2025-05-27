WITH customer_bronze AS (
  SELECT
    *
  FROM {{ source('tpch', 'customer_bronze') }}
), filter_1 AS (
  SELECT
    c_custkey,
    c_name,
    c_nationkey,
    c_acctbal
  FROM customer_bronze
  WHERE
    NOT c_custkey IS NULL AND c_nationkey <> 21
), formula_1 AS (
  SELECT
    c_custkey,
    c_name,
    c_nationkey,
    c_acctbal,
    c_acctbal < 0 AS has_negative_acctbal
  FROM filter_1
), customers_silver_sql AS (
  SELECT
    *
  FROM formula_1
)
SELECT
  *
FROM customers_silver_sql