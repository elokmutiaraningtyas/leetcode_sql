--1068. Product Sales Analysis I
SELECT b.product_name, a.year, a.price
FROM Sales as a
LEFT JOIN Product as b on b.product_id = a.product_id
