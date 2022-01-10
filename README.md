# Data Prepping for the "Top Paid Musicians in the USA" visualization

Original visualization: [Tableau Public](https://public.tableau.com/app/profile/norbert.borb.s/viz/TopPaidMusiciansInTheUSA/TopPaid1)  
Tableau Workbook is downloadable from the link.
<img src="https://user-images.githubusercontent.com/96722899/148366715-48ed0a34-43b7-4b1a-ad07-b75b6337712b.png" width="800" height="550">

## Story
This was the first project where I have collected the data myself.  
Although, it was a basic process where data was collected manually from Billboard's website ([2020 data here](https://www.billboard.com/music/music-news/musician-us-money-makers-highest-paid-2020-9602078/)) into Excel files.

At the point of data collection, I did not know what I would like to visualize.  
After figuring it out, I needed the 2019 and 2020 data in another merged, pivoted and unpivoted formats, so I rubbed my hands together that I can use some SQL for problem solving. I went with MSSQL and the **scripts are attached to the repo with some highlights from the code below.**  

## SQL

**Process overview:**
1. Uploading 2019 and 2020 data to "new_schema"
2. Unpivoting both 2019 and 2020 data
3. Merging unpivoted data into 1 file containing both years' data
4. Merging pivoted data into 1 file containing both years' data
5. Loading both data sources in Tableau


**Details for Step 2**, with code snippet highlighted on how to do unpivoting using "col" and "value" functionality and UNION ALL statement:
```
SELECT
    ranking_2019,name,
    'streaming_2019' col, -- Converting 'streaming_2019' column name into a value in the "col" column
    streaming_2019 value, -- Converting the corresponding values into the "value" column
    solo_band, genre, gender, age_2021, grammy_won_2021, grammy_nom_2021, grammy_winning_rate, origin
FROM new_schema.top_paid_2019

UNION ALL -- Union all other revenue types to get the unpivoted data
...
```

**Details for Step 3**, with code snippet on how I used Common Table Expression to call the previously created unpivoted data:
```
WITH cte -- Introducing Common Table Expressions for a cleaner query
AS
   (SELECT name, solo_band, genre, gender, origin, age_2021, grammy_won_2021, grammy_nom_2021, grammy_winning_rate
   FROM new_schema.tp2019_unpivot
   UNION ALL
   SELECT name, solo_band, genre, gender, origin, age_2021, grammy_won_2021, grammy_nom_2021, grammy_winning_rate
   FROM new_schema.tp2020_unpivot),
...
```

**Details for Step 4**, with code snippet on applying subquery on getting full list of artist names from both years:
```
SELECT DISTINCT subquery.name, streaming_2020, sales_2020, publishing_2020, touring_2020, total_2020, streaming_2019, sales_2019, publishing_2019, touring_2019
FROM
   -- Creating subquery to gather all names in both year's table then selecting distinctively in the SELECT statement.
   (SELECT name FROM new_schema.top_paid_2020
   UNION ALL
   SELECT name FROM new_schema.top_paid_2019) AS subquery
```

## Tableau Calculations

One of the main elements on the dashboard are the Coxcomb Charts, displaying the artist revenues by types: **streaming, publishing, sales & touring.**  
These were built based on Toan Hoang's awesome [tutorial](https://tableau.toanhoang.com/creating-a-coxcomb-chart-in-tableau).  

**Base calculations in the workbook:**
**TC_Index**
```
INDEX()-1
```

**TC_Step Size**:
```
// Dividing the full 360° circle into 4 pieces = 4 revenue types.
3.6/4
```

**TC_Rev_Type_Part**
```
//Revenue Types are coded from 1-4.
WINDOW_MAX(MAX([Rev. Type Code]))-1
```

**TC_Starting Point**
```
[TC_Rev Type Part]*[TC_Step Size]*100
```

**X** = column "coordinate" (using SIN)
```
IF [TC_Index]<= 100 THEN
   SIN(RADIANS(([TC_Index]*[TC_Step Size])+[TC_Starting Point]))*([TC_Previos SUM Revenue])
ELSE
   SIN(RADIANS(((201-[TC_Index])*[TC_Step Size])+[TC_Starting Point]))*([TC_SUM Revenue]+[TC_Previos SUM Revenue])
END
```
**Y** = row "coordinate" (using COS)
```
IF [TC_Index]<= 100 THEN 
   COS(RADIANS(([TC_Index]*[TC_Step Size])+[TC_Starting Point]))*([TC_Previos SUM Revenue])
ELSE
   COS(RADIANS(((201-[TC_Index])*[TC_Step Size])+[TC_Starting Point]))*([TC_SUM Revenue]+[TC_Previos SUM Revenue])
END
```    

**+ 1 extra calculation** that I would like to highlight here is the one which returns whether an artist is new on the 2020 list or were listed in 2019 as well  

**New On List 2020**
```
IF {FIXED [Name] : MIN({EXCLUDE YEAR([Year]) : MIN(YEAR([Year]))})} = 2020 THEN "New On List"
ELSE "Been Listed Before"
END
```
