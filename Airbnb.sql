create database airbnb;

use airbnb;

create table airbnb (
Host_Id int,
Host_Since date,
Name varchar(150),
Neighbourhood  varchar(100),
Property_Type varchar(100),
Review_Scores_Rating_bin int,
Room_Type varchar (100),
zipcode int,
Beds int,
Number_of_Records int,
Number_Of_Reviews int,
Price int,
Review_Scores_Rating int
 );

UPDATE airbnb SET Review_Scores_Rating_bin = 0 WHERE Review_Scores_Rating_bin = NULL;
SET SQL_SAFE_UPDATES = 0;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.3/Uploads/airbnb.csv" 
into table airbnb
fields terminated by ',' escaped by '\\'
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

##Modifications for errors
SET GLOBAL sql_mode = '';
alter table airbnb
drop Host_Since;
SELECT 
    CASE 
        WHEN Review_Scores_Rating_bin = '' THEN '0'
        ELSE Review_Scores_Rating_bin
    END AS Review_Scores_Rating_bin
FROM airbnb;
alter table airbnb
drop Review_Scores_Rating;
ALTER TABLE airbnb MODIFY COLUMN price int;

##Modifications end

##Q1. What is the average price of properties in each neighborhood?

select 
Neighbourhood,
avg(price) as average_price
from
airbnb
group by Neighbourhood
order by  avg(price) desc;
 
 ##2 Question: How many properties are listed in each neighborhood?
 select 
 Neighbourhood,
 sum(Number_of_Records) as No_of_Properties
 from
 airbnb
 group by Neighbourhood;
 
## 3 Question: How many properties have a review scores rating above 90?
select
Review_Scores_Rating_bin as Review_score,
Property_Type
from
airbnb
where
Review_Scores_Rating_bin > 90
order by Property_Type

