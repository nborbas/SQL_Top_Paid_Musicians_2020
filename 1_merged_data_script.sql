WITH cte -- Introducing Common Table Expressions for a cleaner query
AS
	(SELECT name, solo_band, genre, gender, origin, age_2021, grammy_won_2021, grammy_nom_2021, grammy_winning_rate
	FROM new_schema.tp2019_unpivot
	UNION ALL
	SELECT name, solo_band, genre, gender, origin, age_2021, grammy_won_2021, grammy_nom_2021, grammy_winning_rate
    FROM new_schema.tp2020_unpivot),
cte2
AS
	(SELECT name, col, value
	FROM new_schema.tp2019_unpivot
	UNION ALL
	SELECT name, col, value
    FROM new_schema.tp2020_unpivot)
-- Now selecting CTE values to get the merged data source
SELECT DISTINCT
	cte.name,
    cte2.col AS revenue_type, -- Renaming the unpivoted "col" column to "revenue_type"
    cte2.value AS revenue, -- Renaming the unpivoted "value" column to "revenue"
    tp2019_unpivot.ranking_2019, tp2020_unpivot.ranking_2020, cte.solo_band, cte.genre, cte.gender, cte.origin, cte.age_2021, cte.grammy_won_2021, cte.grammy_nom_2021, cte.grammy_winning_rate
FROM cte
LEFT JOIN new_schema.tp2019_unpivot
	ON cte.name = tp2019_unpivot.name
LEFT JOIN new_schema.tp2020_unpivot
	ON cte.name = tp2020_unpivot.name
LEFT JOIN cte2
	ON cte.name = cte2.name;