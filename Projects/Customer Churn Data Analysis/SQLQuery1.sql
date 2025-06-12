select top 10 * from customer_churn_dataset_training_master

--count total customers'
select count(*) as total_customers
from customer_churn_dataset_training_master
--440832

--1.churn rate
select
round(sum(Churn)*100.0/count(*),2) as churn_rate_percent
from customer_churn_dataset_training_master

-- 2.Churn by Gender
select
Gender,
count(*) as total,
sum(Churn) as churned,
ROUND(sum(churn)*100.0/COUNT(*),2) as churn_rate
from customer_churn_dataset_training_master
group by Gender
--2 rows

  --4.Churn by Subscription type
SELECT 
    "Subscription Type",
    COUNT(*) AS total_customers,
    SUM(Churn) AS churned_customers,
    ROUND(SUM(Churn) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn_dataset_training_master
GROUP BY "Subscription Type";
-- 3 rows

--5.Average metrics for Churned VS Non-Churned

SELECT 
    Churn,
    ROUND(AVG("Age"), 1) AS avg_age,
    ROUND(AVG("Tenure"), 1) AS avg_tenure,
    ROUND(AVG("Usage Frequency"), 1) AS avg_usage,
    ROUND(AVG("Support Calls"), 1) AS avg_support_calls,
    ROUND(AVG("Payment Delay"), 1) AS avg_payment_delay,
    ROUND(AVG("Total Spend"), 1) AS avg_total_spend
From customer_churn_dataset_training_master
group by Churn
-- two rows

 --6.Contract Length and Churn
SELECT 
    "Contract Length",
    COUNT(*) AS total,
    SUM(Churn) AS churned,
    ROUND(SUM(Churn) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn_dataset_training_master
GROUP BY "Contract Length"
ORDER BY churn_rate DESC;
--3 rows

--7.Top risk segment , who's churning the most?
SELECT top 5
    "Subscription Type",
    "Contract Length",
    ROUND(SUM(Churn) * 100.0 / COUNT(*), 2) AS churn_rate,
    COUNT(*) AS total_customers
FROM customer_churn_dataset_training_master
GROUP BY "Subscription Type", "Contract Length"
ORDER BY churn_rate DESC;
-- 5 rows

--8.Quantify the Risk
--churn rate % and customer count

SELECT 
    "Subscription Type", 
    "Contract Length", 
    ROUND(SUM(Churn) * 100.0 / COUNT(*), 2) AS churn_rate,
    COUNT(*) AS total_customers
FROM customer_churn_dataset_training_master
GROUP BY "Subscription Type", "Contract Length"
ORDER BY churn_rate DESC;
-- 9 rows