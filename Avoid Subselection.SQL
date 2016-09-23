# Joining a number of columns from the finance table and from the seller table to get the billing info of current active dealers

# Get a list of distinct billing info variables:
SELECT DISTINCT billing_code FROM db.finance
WHERE LEFT(yrmoday,7) = '2016-05'

# Perform an inner join
# The following subselection causes slower performance because the result returned by the query is not indexed
SELECT * FROM
(SELECT seller_id,billing_code,bill_amount,yrmoday
FROM db.finance
WHERE LEFT(yrmoday,7) = '2016-05') AS f
JOIN
(SELECT seller_id,seller_name,seller_region,seller_gmv
FROM db.seller WHERE status = 'active') AS d
ON f.seller_id = d.seller_id
ORDER BY f.seller_id,billing_code,yrmoday DESC

# Aliasing can be helpful for optimizing the query
SELECT
	d.seller_id,
	d.seller_name,
	# etc.
	f.billing_code,
	f.bill_amount
	# etc.
FROM db.seller d
	JOIN db.finance f ON d.seller_id = f.seller_id
WHERE status = 'active' AND LEFT(yrmoday,7) = '2016-05'
ORDER BY f.seller_id,billing_code,yrmoday DESC
