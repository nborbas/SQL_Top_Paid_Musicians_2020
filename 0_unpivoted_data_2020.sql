SELECT
	ranking_2020,name,
    'streaming_2020' col, -- Converting 'streaming_2020' column name into a value in the "col" column
    streaming_2020 value, -- Converting the corresponding values into the "value" column
    solo_band, genre, gender, age_2021, grammy_won_2021, grammy_nom_2021, grammy_winning_rate, origin
FROM new_schema.top_paid_2020

UNION ALL -- Union all other revenue types to get the unpivoted data

SELECT
	ranking_2020, name,
	'sales_2020' col, -- Converting 'sales_2020' column name into a value in the "col" column
    sales_2020 value, -- Converting the corresponding values into the "value" column
    solo_band, genre, gender, age_2021, grammy_won_2021, grammy_nom_2021, grammy_winning_rate, origin
FROM new_schema.top_paid_2020

UNION ALL

SELECT
	ranking_2020, name,
    'publishing_2020' col, -- Converting 'publishing_2020' column name into a value in the "col" column
    publishing_2020 value, -- Converting the corresponding values into the "value" column
    solo_band, genre, gender, age_2021, grammy_won_2021, grammy_nom_2021, grammy_winning_rate, origin
FROM new_schema.top_paid_2020

UNION ALL

SELECT
	ranking_2020, name,
    'touring_2020' col,  -- Converting 'touring_2020' column name into a value in the "col" column
    touring_2020 value,  -- Converting the corresponding values into the "value" column
    solo_band, genre, gender, age_2021, grammy_won_2021, grammy_nom_2021, grammy_winning_rate, origin
FROM new_schema.top_paid_2020

UNION ALL

SELECT
	ranking_2020, name,
    'total_2020' col, -- Converting 'total_2020' column name into a value in the "col" column
    total_2020 value, -- Converting the corresponding values into the "value" column
    solo_band, genre, gender, age_2021, grammy_won_2021, grammy_nom_2021, grammy_winning_rate, origin
FROM new_schema.top_paid_2020;