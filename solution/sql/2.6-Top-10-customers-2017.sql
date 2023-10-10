-- By qty
-- Calculating total qty and get first 10 with row number and filtering

SELECT customer_code, cnt
FROM (
      SELECT t.customer_code,
             SUM(sales_qty) cnt,
             ROW_NUMBER() over (ORDER BY SUM(sales_qty) DESC) rn
      FROM transactions t
      WHERE YEAR(order_date) = 2017
      GROUP BY t.customer_code
) tmp
WHERE rn <= 10;

-- By generated revenue
-- Calculating total revenue generated and get first 10 with row number and filtering

SELECT customer_code, cnt
FROM (
      SELECT t.customer_code,
             SUM(sales_qty*sales_amount) cnt,
             ROW_NUMBER() over (ORDER BY SUM(sales_qty*sales_amount) DESC) rn
      FROM transactions t
      WHERE YEAR(order_date) = 2017
      GROUP BY t.customer_code
) tmp
WHERE rn <= 10;