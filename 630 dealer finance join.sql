# Joining a numner of columns from the birst_finance table and the birst_dealer table to get the rate cards of current dealers

# First get a sense of what charge codes (distinct) are there:
SELECT distinct charge_code FROM birst_finance
WHERE left(charge_date,7) = '2016-05' 

# Then do the join... subselecting isn't the best because queries are not indexed
SELECT * FROM
(SELECT dealer_pk,charge_code,charge_amount,charge_date,charge_amount_to_usd
FROM birst_finance
WHERE LEFT(charge_date,7) = '2016-05') AS f 
JOIN
(SELECT dealer_pk,dealer_policy,dealer_vertical,dealer_rating,date_registered,agreement_start,dealer_name,dealer_contact_country,dealer_storefront_name,storefront_continent_facet,storefront_country_facet,dealer_default_currency,dealer_setupFee,dealer_monthlyFee,dealer_photoRate,dealer_marketplaceRate,dealer_featuredRate,dealer_noPriceRate,dealer_listingFee,dealer_listingFeeNP
FROM birst_dealer WHERE dealer_status='active') AS d 
ON f.dealer_pk=d.dealer_pk
ORDER BY f.dealer_pk, f.charge_code,f.charge_date DESC

# optimized query (full indexed)

SELECT 
	d.dealer_pk,
	d.dealer_policy,
	d.dealer_vertical,
	# add d. before all other variables #
	# etc.
	f.dealer_pk,
	f.charge_code,
	f.charge_amount,
	f.charge_date,
	f.charge_amount_to_usd
FROM reporting.birst_dealer d
	JOIN reporting.birst_finance f ON d.dealer_pk=f.dealer_pk
WHERE dealer_status='active' AND LEFT(charge_date,7) = '2016-05'
ORDER BY f.dealer_pk, f.charge_code,f.charge_date DESC