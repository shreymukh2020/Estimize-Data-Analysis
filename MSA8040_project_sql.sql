
/* drop a database if exists */
/*drop database if exists msa8040_finalproject_sql;*/



/* create a database with name 'msa8040_finalproject' */
create database msa8040_finalproject_sql;


/* Use database */
use msa8040_finalproject_sql;



/*drop table if exists eps;*/

/* drop table if exists company; */

/*drop table if exists analyst;*/


/*create table "eps" using import wizard*/

/*create table "company" using import wizard*/

/*create table "analyst" using import wizard*/

/* Check whether the csv files have been imported in the database successfully */

show tables;

/* Check for number of records in each table */

select * from eps;

select * from company;

select * from analyst;


/* Question 1:  Given a ticker, how many analysts have made estimations for its EPS? Rank them
by their confidence score, total points, error rate or accuracy percentile? */


# Number of Analysts per company
select distinct Company_Name, count(Name) from eps group by Company_Name order by count(Name) desc;


# We are choosing Ticker 'A' - Agilient Industries and num_analysts who have made estimation for its EPS. 

select distinct E.Ticker, E.Company_Name, E.Name,  A.User_ID , A.Analyst_Confidence_Score, A.Accuracy_Percentile, sum(A.Points) as Total_points
from eps E
inner join analyst A
where E.Ticker ='A'
and E.Name = A.Name
group by E.Name
order by A.Analyst_Confidence_Score desc, A.Points, A.Accuracy_Percentile;


/* Question 2 : Given a industry, how many companies are covered, the average number of analysts,
the average bias between the Estimize Consensus and the Reported Earnings? */

# Avg num of analysts for all the industries
 
select C.Company_Name, C.Industries, C.Sectors, avg(Num_analysts) as Avg_analysts
from company C
inner join eps E
where C.Company_Name = E.Company_Name
group by C.Industries;

# Avg num of analysts for ' Airlines' Industries:

select E.Company_Name, C.Industries, C.Sectors, avg(Num_analysts) as Avg_analysts
from eps E
inner join company C
where Industries = ' Airlines'
and C.Company_Name = E.Company_Name;


/* Question 3: Which company have the largest number of analysts with confidence score greater
than 7?*/

select * from analyst;
select * from eps;
select * from company;

# Names of the Analysts whose Confidence score is > 7 

select Name, count(Name) from analyst where Analyst_Confidence_score >7 group by Name;



select C.Company_Name, A.Name, A.Analyst_Confidence_score
from company C , analyst A 
where  A.Analyst_Confidence_score  > 7 
group by C.Company_Name;


# Company having highest number of analysts with confidence score > 7

select distinct C.Company_Name, count(A.Name) as Analyst_count
from company C 
inner join analyst A 
where  A.Analyst_Confidence_score  =  (
	select max(A.Analyst_Confidence_score) as max_score from analyst A 
    where A.Analyst_confidence_score >7
);



/* Question 4: Who has the largest number of followers*/

select distinct Ticker, Company_Name, Num_Followers from company
where Num_Followers = (select max(Num_Followers) from company);

