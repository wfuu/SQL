# ISNULL() function is used to specify how we want to treat NULL values
# In MySQL, use the IFNULL() or COALESCE() functions to achieve the same

SELECT item_name,unit_price * (count_current + IFNULL(count_projected,0))
FROM db.items

# Or replace IFNULL with COALESCE 
