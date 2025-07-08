create database loan_analysis;
use loan_analysis;
create table loan_customers(
customerid int primary key,
name varchar(100),
age int,
gender varchar(10),
city varchar(50),
employmenttype varchar(50),
income decimal(10,2),
loanamount decimal(10,2),
loanterm int,
creditscore int,
previousdefaults int,
approved varchar(5),
defaulted varchar(5)
);
drop table loan_customers;
SHOW VARIABLES LIKE 'secure_file_priv';

load data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/loan_data_large.csv'
into table loan_customers
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

-- total customers
select count(*) from loan_customers;

-- defaulted & non defaulted
select defaulted,count(*) as total from loan_customers group by defaulted;
-- defaulted only customers
select * from loan_customers where defaulted='true';

-- default rate by city
 select city,count(*) as totalcustomers,
 sum(case when defaulted='true' then 1 else 0 end) as defaults,
 round(sum(case when defaulted='true' then 1 else 0 end)/count(*)*100,2) as defaultrate
 from loan_customers
group by city; 

-- credit score buckets
select case
when creditscore <580 then 'poor'
when creditscore <670 then 'fair'
when creditscore <740 then 'good'
when creditscore <800 then 'very good'
else 'excellent'
end as scorecategory,
count(*) as total
from loan_customers
group by scorecategory;

select * from loan_customers where creditscore<500;

