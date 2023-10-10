-- Order by + limit
-- More straighforward, sort is present

SELECT product_code, customer_code, COUNT(*) as bought_count
FROM transactions
WHERE product_code = 'Prod048'
GROUP BY product_code, customer_code
ORDER BY bought_count DESC
LIMIT 1;

-- having
-- More complex, sort is absent

WITH sales_stats as (
    SELECT product_code, customer_code, COUNT(*) bought_count
    FROM transactions
    WHERE product_code = 'Prod048'
    GROUP BY product_code, customer_code
)
SELECT customer_code, bought_count
FROM sales_stats
GROUP BY product_code, customer_code
HAVING bought_count = MAX(bought_count);