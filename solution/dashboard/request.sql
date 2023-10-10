WITH monthly_sales AS (
    SELECT
        product_code,
        currency,
        d.cy_date,
        COALESCE(SUM(sales_amount * sales_qty), 0) AS sales
    FROM
        date d
    LEFT JOIN
        transactions t ON d.date = t.order_date
                      AND year = 2020
    WHERE product_code is not null
    GROUP BY
        product_code, d.cy_date, currency
)
SELECT
    product_code,
    cy_date,
    sales,
    (sales - LAG(sales, 1, 0) OVER (PARTITION BY product_code ORDER BY cy_date)) /
    NULLIF(sales, 0) AS percentage_diff
FROM
    monthly_sales;
