# Scenario for "concatenating" two tables: There is a column of makers and a column of count of items they make. First, group both columns by maker, then create an additional row (with two entries) at the bottom of the table with "Total_count" and the total count of items by all makers
# Could be hacky: Need to filter both selections if not including all rows from the table

SELECT maker, COUNT(1) as 'Count_of_items'
FROM db.items
GROUP BY maker
UNION ALL
SELECT maker as 'Total_count', COUNT(1)
FROM db.items
