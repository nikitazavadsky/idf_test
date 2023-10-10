-- Join (2 nested loops)

SELECT SUM(sales_qty * sales_amount)
from transactions t
join markets m on m.markets_code = t.market_code
join date d on d.date = t.order_date and d.year = 2020
where m.markets_name = 'Chennai';

-- Column-wide operation (1 nested loop) quicker

SELECT SUM(sales_qty * sales_amount)
from transactions t
join markets m on m.markets_code = t.market_code
where YEAR(order_date) = 2020 and markets_name = 'Chennai';