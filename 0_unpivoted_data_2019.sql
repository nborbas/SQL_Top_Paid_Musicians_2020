SELECT
	ranking_2019,name,
    'streaming_2019' col, -- Converting 'streaming_2019' column name into a value in the "col" column
    streaming_2019 value, -- Converting the corresponding values into the "value" column
    solo_band, genre, gender, age_2021, grammy_won_2021, grammy_nom_2021, grammy_winning_rate, origin
FROM new_schema.top_paid_2019

UNION ALL -- Union all other revenue types to get the unpivoted data

SELECT
	ranking_2019, name,
	'sales_2019' col, -- Converting 'sales_2019' column name into a value in the "col" column
    sales_2019 value, -- Converting the corresponding values into the "value" column
    solo_band, genre, gender, age_2021, grammy_won_2021, grammy_nom_2021, grammy_winning_rate, origin
FROM new_schema.top_paid_2019

UNION ALL

SELECT
	ranking_2019, name,
    'publishing_2019' col, -- Converting 'publishing_2019' column name into a value in the "col" column
    publishing_2019 value, -- Converting the corresponding values into the "value" column
    solo_band, genre, gender, age_2021, grammy_won_2021, grammy_nom_2021, grammy_winning_rate, origin
FROM new_schema.top_paid_2019

UNION ALL

SELECT
	ranking_2019, name,
    'touring_2019' col,  -- Converting 'touring_2019' column name into a value in the "col" column
    touring_2019 value,  -- Converting the corresponding values into the "value" column
    solo_band, genre, gender, age_2021, grammy_won_2021, grammy_nom_2021, grammy_winning_rate, origin
FROM new_schema.top_paid_2019

UNION ALL

SELECT
	ranking_2019, name,
    'total_2019' col, -- Converting 'total_2019' column name into a value in the "col" column
    total_2019 value, -- Converting the corresponding values into the "value" column
    solo_band, genre, gender, age_2021, grammy_won_2021, grammy_nom_2021, grammy_winning_rate, origin
FROM new_schema.top_paid_2019;