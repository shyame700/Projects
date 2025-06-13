<h1>📌 Project Overview</h1>
In this project, I worked with the Netflix Titles dataset to perform data cleaning, transformation, and analysis using SQL. The goal was to draw insights about directors, genres, countries, and release patterns on Netflix, while strengthening my SQL skills through real-world data tasks.
<h2>Data Cleaning & Preparation</h2>
To prepare the data for analysis, I performed the following key steps:

1.	Removed Duplicate Records:
	Ensured accurate insights by using SQL techniques like ROW_NUMBER() to eliminate duplicates.
 
2.	Split Complex Columns into New Tables
	Created normalized tables for listed_in (genres), director, country, and cast to make querying more efficient and organized.
3.	Handled Missing Values
	Filled missing values in the country and duration columns by referencing values from rows with the same director.
	This improved data completeness using SQL joins .
4.	Inserted Cleaned Data into a Final Table
	Loaded the cleaned and structured data into a new table named netflix_country for easy querying and reusability.
<h3>📊 Business Questions Answered</h3>

 1.	How many movies and TV shows has each director created?
 

  Separated counts by type (Movie or TV Show) and filtered directors who have created both. 
	Learned how to use CASE, GROUP BY, and conditional aggregation.
 
 2.	Which country has the highest number of Comedy movies?

 Identified the top-performing countries in the Comedy genre using LIKE with filtering and grouping.

3.	Which director had the most movies released each year (based on Date Added)?

	Used date extraction and ranking functions to find the top director per year, helping understand content trends over time.

4.	What is the average duration of movies in each genre?
   
	Cleaned the duration column and calculated averages for genres, improving skills in text manipulation and numeric aggregation.

5.	Which directors have created both Comedy and Horror movies?
     
	Used self-joins or grouping with conditions to list directors who have worked in both genres, including counts for each.

	Strengthened my ability to filter and compare subsets of data.
