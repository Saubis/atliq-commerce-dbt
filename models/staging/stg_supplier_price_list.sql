{{ config(materialized='view') }}

SELECT
    CAST(product_id AS INT) AS product_id,
    CAST(supplier_cost AS DECIMAL(18,2)) AS supplier_cost

FROM atliq.silver.supplier_price_list

WHERE product_id IS NOT NULL