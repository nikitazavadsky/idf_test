-- Calculating profit and sales grouping by market_code
-- Using window function to tag rows and filter by tags further

SELECT *
FROM (
    SELECT market_code,
           SUM(sales_qty * profit_margin) as total_profit,
           SUM(sales_qty * sales_amount) as total_sales,
           ROW_NUMBER() over (ORDER BY SUM(sales_qty * profit_margin) DESC) top_n
    from transactions t
    join markets m on m.markets_code = t.market_code
    GROUP BY market_code
) tmp
WHERE tmp.top_n <= 5;
