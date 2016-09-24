# Count the number of makers with more than 100 available Decor items
# Records are on the item level. Each item has a "maker" attribute
SELECT COUNT(*) FROM
  (SELECT maker, COUNT(*) FROM db.items
   WHERE item_type = 'Decor' AND available = 1 AND maker <> 'Unknown'
   GROUP BY maker
   HAVING COUNT(*) > 100) tmp

# Count the Decor items sold for these makers by joining with the transaction table
# Both tables are on the item level. The item_type attribute is only in the items table
# Then list alongside the number of available Decor items for these makers
SELECT * FROM
  (SELECT maker, COUNT(*) AS 'Count_of_sold' FROM db.trans t
   JOIN db.items i
   ON i.item_id = t.item_id
   WHERE maker <> 'Unknown'
   AND item_type = 'Decor'
   GROUP BY maker) AS a
RIGHT JOIN
  (SELECT maker, COUNT(*) AS 'Count_of_listed' FROM db.items
   WHERE maker <> 'Unknown'
   AND item_type = 'Decor'
	 AND available = 1
   GROUP BY maker
   HAVING COUNT(*) > 100) AS b
ON a.maker = b.maker

# Get a list of buyer IDs whose first order is a Decor item
# Correct: First aggregate to get buyer's first order, then filter for item type
# Wrong: If filter for item type before group by, it gets buyer's first Decor order (if any) out of all orders

SELECT buyer_id, MIN(order_date) AS 'First_Order_Date'
FROM db.trans t
JOIN db.items i
ON t.item_id = i.item_id
WHERE order_status <> 'Canceled'
GROUP BY buyer_id
WHERE item_type = 'Decor'
