-- Joining with date to get yyyy-mm, then grouping

SELECT d.cy_date, AVG(sales_qty) cnt
from transactions t
join date d on d.date = t.order_date
GROUP BY d.cy_date;