-- Join (2 nested loops)

SELECT SUM(sales_qty * sales_amount)
from transactions t
join markets m on m.markets_code = t.market_code
join date d on d.date = t.order_date and d.year = 2020 and month_name = 'January';

-- Column-wide operation (1 nested loop)

SELECT SUM(sales_qty * sales_amount)
from transactions t
join markets m on m.markets_code = t.market_code
where YEAR(order_date) = 2020 and MONTH(order_date) = 'January';