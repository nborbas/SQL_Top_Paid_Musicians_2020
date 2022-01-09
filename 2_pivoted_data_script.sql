SELECT DISTINCT subquery.name, streaming_2020, sales_2020, publishing_2020, touring_2020, total_2020, streaming_2019, sales_2019, publishing_2019, touring_2019
FROM
	-- Creating subquery to gather all names in both year's table then selecting distinctively in the SELECT statement.
	(SELECT name FROM new_schema.top_paid_2020
	UNION ALL
	SELECT name FROM new_schema.top_paid_2019) AS subquery
-- Joining revenue data (identified in the SELECT statement) from 2020 and 2019 to the names extracted from the subquery.
LEFT JOIN new_schema.top_paid_2020
	ON subquery.name = new_schema.top_paid_2020.name
LEFT JOIN new_schema.top_paid_2019
	ON subquery.name = new_schema.top_paid_2019.name;