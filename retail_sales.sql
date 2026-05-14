
---SQL RETAIL SALES ANALYSIS---
CREATE DATABASE Project1

USE Project1

---DATA CLEANING
---Finding null values in columns

SELECT * FROM retail_sales1
WHERE
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	---age is null
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null ;

--------------------

DELETE FROM 
	retail_sales1
WHERE
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null ;

-----------------------------------
/*DATA EXPLORATION */
-----------------------------------
---How many sales we have ?

SELECT 
	COUNT(*) AS total_sales 
FROM retail_sales1

---How many unique customers we have ?
	
SELECT
	COUNT(DISTINCT customer_id) AS Total_customers
FROM retail_sales1 

---How many unique categories we have ?

SELECT
	COUNT (DISTINCT category) AS Total_category
FROM retail_sales1

---------------------------------------------------	
/*Data anlysis & business key problems & answers */
---------------------------------------------------

---My Analysis & Findings
---Q.1 Write a SQL query to retrieve all the columns for sales made on 2022-11-05

SELECT * FROM retail_sales1
WHERE sale_date = '2022-11-05'

---Q.2 Write a SQL query to retrieve all transactions where the category is 'clothing' and the 
---quantity sold is more than 10 in the month of nov -2022


SELECT *
FROM retail_sales1
WHERE
	category = 'Clothing'
	AND 
	FORMAT (sale_date,'yyyy-MM') = '2022-11'
	AND 
	quantiy >=4;

---Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT
	category,
	SUM(total_sale) AS total_sales,
	COUNT(*) AS total_orders 
FROM retail_sales1
GROUP BY category;

---Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

SELECT 
	ROUND(AVG(age),2) AS avg_age
FROM retail_sales1
WHERE category = 'Beauty';

---Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT*
FROM retail_sales1
WHERE total_sale > 1000;
---Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
	category,
	gender,
	COUNT(*) AS total_transaction
FROM retail_sales1
GROUP BY
	category,
	gender
ORDER BY category
 
---Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.

SELECT 
    year,
    month,
    avg_sale
FROM
(
SELECT
	YEAR(sale_date) AS year,
	MONTH(sale_date) AS month,
	AVG(total_sale) AS avg_sale,
	RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC ) AS ranking
FROM retail_sales1
GROUP BY
	YEAR(sale_date),
	MONTH(sale_date)
) T1
WHERE ranking = 1;

--- Q.8 Write a query to find the top 5 Customers based on the highest total sales

SELECT 
	TOP 5
	customer_id,
	SUM(total_sale) AS Total_sale
FROM retail_sales1
GROUP BY customer_id
ORDER BY Total_sale DESC

---Q.9 Write a query to find the number of unique customers who purchased items from each category 

SELECT 
COUNT (DISTINCT customer_id),
category
FROM retail_sales1
GROUP BY category

--- Q.10 write a sql query to create each shift and no. of orders (example morning <= 12, afternoo 12 & 17 , evening >17)

WITH hourly_sale AS
(
    SELECT *,
    
        CASE 
            WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
            
            WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 
            THEN 'Afternoon'
            
            ELSE 'Evening'
            
        END AS shift_time
        
    FROM retail_sales1
)

SELECT
    shift_time,
    COUNT(*) AS Total_orders
    
FROM hourly_sale

GROUP BY shift_time;

---END OF PROJECT 






















