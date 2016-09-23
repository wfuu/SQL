# In this scenario, need to get the count of orders that were placed with promotion/sales in each category and their respective order dates in 2016
# Also need to have a column of consecutive order dates for all transactions (not just promotion/sales orders) for time series purposes

SELECT * FROM
  (SELECT
     LEFT(order_date,10) AS 'Date',
     COUNT(item_id) AS 'Total_count',
     SUM(CASE WHEN item_cat='1' THEN 1 ELSE 0 END) AS 'Decor',
     SUM(CASE WHEN item_cat='2' THEN 1 ELSE 0 END) AS 'Appliance',
     SUM(CASE WHEN item_cat='3' THEN 1 ELSE 0 END) AS 'Beauty'
     FROM db.trans
     WHERE order_type in ('Promotion','Sales')
     AND order_status <> 'Canceled'
     AND DATE(order_date) > '2016-01-01'
     GROUP BY LEFT(order_date,10)) a
RIGHT JOIN
  (SELECT DISTINCT LEFT(order_date,10) AS 'Full_Date'
   FROM db.trans WHERE DATE(order_date) > '2016-01-01') b
ON a.Date = b.Full_Date
ORDER BY b.Full_Date
