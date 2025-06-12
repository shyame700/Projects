select * from Cleaned_Salaries

--1.top 10 highest paid employees

select top 10 EmployeeName,TotalPayBenefits
from Cleaned_Salaries
order by TotalPayBenefits Desc;

--10 rows

--2.Average base pay by job title

select JobTitle,ROUND(AVG(BasePay),2) as Avg_Base_Pay
from Cleaned_Salaries
group by JobTitle
order by Avg_Base_Pay Desc;
--1637 rows

--3.Year-over-Year TotalPay Growth

select Year,SUM(TotalPay) As Yearly_TotalPay
from Cleaned_Salaries
group by Year
order by Year;

--4 rows

--4.Agency wise Total Compensation

select Agency,ROUND(SUM(TotalPayBenefits),2) as Total_Compensation
from Cleaned_Salaries
group by Agency
order by Total_Compensation Desc;

--1 row

--5.Total OvertimePay as % of TotalPay

select ROUND(SUM(OvertimePay)*100.0/SUM(TotalPay),2) as OvertimePay_Percentage
from Cleaned_Salaries

--1-row


--6. Top 5 Job Titles with highest average benefits

select top 5 JobTitle,ROUND(AVG(Benefits),2) as Avg_Benefits
from Cleaned_Salaries
group by JobTitle
order by Avg_Benefits ;

--7. Which job titles have the highest average total compensation

select top 5 JobTitle, AVG(TotalPayBenefits) as AvgCompensation
from Cleaned_Salaries
group by JobTitle
order by AvgCompensation desc;

--8.Which agencies spent the most on employee pay in a given year -2024

select Agency, SUM(TotalPayBenefits) as TotalAgencySpend
from Cleaned_Salaries
where Year = 2014
group by Agency
order by TotalAgencySpend desc;

--9.How many employees recevied benefits, and what's the average amount

select 
    COUNT(*) as EmployeesWithBenefits,
    AVG(Benefits) as AvgBenefitAmount
from Cleaned_Salaries
where Benefits > 0;

