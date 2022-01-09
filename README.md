# Data Prepping for the "Top Paid Musicians in the USA" visualization

Original visualization: [Tableau Public](https://public.tableau.com/app/profile/norbert.borb.s/viz/TopPaidMusiciansInTheUSA/TopPaid1)
<img src="https://user-images.githubusercontent.com/96722899/148366715-48ed0a34-43b7-4b1a-ad07-b75b6337712b.png" width="800" height="550">

## Story
This was the first project where I have collected the data myself.  
Although, it was a manual process from Billboard's website saving directly into an Excel file.  

At this point though, I did not know what I would like to visualize.  
After figuring it out, I needed the data in another format, so I rubbed my hands together that FINALLY I can use some SQL for problem solving.

Attached you will find the original dataset and here the process I did for wrangling the data into the desired shape.

## SQL


## Calculations

Toan Hoang blog

New On List 2020
```
IF {FIXED [Name] : MIN({EXCLUDE YEAR([Year]) : MIN(YEAR([Year]))})} = 2020 THEN "New On List"
ELSE "Been Listed Before"
END
```
X
```
IF [TC_Index]<= 100 THEN
    SIN(RADIANS(([TC_Index]*[TC_Step Size])+[TC_Starting Point]))*([TC_Previos SUM Revenue])
ELSE
    SIN(RADIANS(((201-[TC_Index])*[TC_Step Size])+[TC_Starting Point]))*([TC_SUM Revenue]+[TC_Previos SUM Revenue])
END
```
Y
```
IF [TC_Index]<= 100 THEN
    COS(RADIANS(([TC_Index]*[TC_Step Size])+[TC_Starting Point]))*([TC_Previos SUM Revenue])
ELSE
    COS(RADIANS(((201-[TC_Index])*[TC_Step Size])+[TC_Starting Point]))*([TC_SUM Revenue]+[TC_Previos SUM Revenue])
```    
TC_Index
```
INDEX()-1
```

TC_Step Size
```
3.6/4
```

TC_Starting Point
```
[TC_Rev Type Part]*[TC_Step Size]*100
```

TC_Rev_Type_Part
```
WINDOW_MAX(MAX([Rev. Type Code]))-1
```
