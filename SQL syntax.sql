    --SQL retail sales analysis---

CREATE DATABASE sql_first_project;
  
       --CREATE TABLE--
DROP TABLE IF Exists retail_sales;  
CREATE TABLE retail_sales
           ( 
		      transactions_id INT PRIMARY KEY,
              sale_date DATE,
              sale_time TIME,
              customer_id INT,
              gender VARCHAR(15),	
              age INT,
              category VARCHAR(15),
              quantiy INT,
			  price_per_unit FLOAT,
              cogs FLOAT,		
              total_sale FLOAT
            );

SELECT * FROM retail_sales
LIMIT 10;

SELECT 
    COUNT(*)
    FROM retail_sales;	

---DATA CLEANING--

SELECT * FROM retail_sales
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

SELECT * FROM retail_sales
WHERE 
      transactions_id IS NULL
	  OR
	  sale_date IS NULL
	  OR
	  sale_time IS NULL
      OR
	  gender IS NULL
	  OR 
	  age IS NULL
	  OR
	  category IS NULL
	  OR
	  quantiy IS NULL
	  OR
	  price_per_unit IS NULL
	  OR
	  cogs IS NULL
	  OR
	  total_sale IS NULL;

 --
 DELETE FROM retail_sales
 WHERE 
      transactions_id IS NULL
	  OR
	  sale_date IS NULL
	  OR
	  sale_time IS NULL
      OR
	  gender IS NULL
	  OR 
	  age IS NULL
	  OR
	  category IS NULL
	  OR
	  quantiy IS NULL
	  OR
	  price_per_unit IS NULL
	  OR
	  cogs IS NULL
	  OR
	  total_sale IS NULL;
        
--DATA EXPLORATION--

--How many sales we have?
SELECT COUNT(*) AS total_sales FROM retail_sales;

--How many unique customers we have?
SELECT Count(DISTINCT customer_id) AS total_customer FROM retail_sales;

--How many unique category we have?
SELECT DISTINCT category AS category FROM retail_sales;


--DATA ANALYSIS AND BUSINESS KEY PROBLEMS AND ANSWER

--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT *
FROM retail_sales
Where sale_date = '2022-11-05';

--Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

SELECT *
FROM retail_sales
WHERE 
  	category = 'Clothing'
AND 
    To_CHAR (sale_date, 'YYYY-MM') = '2022-11'
AND 
    quantiy > 3;
  


--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category

SELECT
     category,
	 SUM(total_sale) AS net_sale,
	 COUNT(*) AS total_orders
FROM retail_sales
GROUP BY 1;
	 
--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

SELECT 
      ROUND(AVG(age),2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

--Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000

SELECT*
FROM retail_sales
WHERE total_sale > 1000

--Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

SELECT 
      category, 
	  gender,
      COUNT(*) as total_transaction
FROM  retail_sales
GROUP BY 1, 2
ORDER BY 1;

--Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
      year,
      month,
	  AVG_sale
FROM
(
	SELECT 
	     EXTRACT(YEAR FROM sale_date) AS year,
		 EXTRACT(MONTH FROM sale_date) AS month,
		 AVG(total_sale) as avg_sale,
		 RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
	FROM retail_sales
	GROUP BY 1,2
) AS t1
WHERE rank = 1;


--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

SELECT 
     customer_id,
	 SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--Q.9 Write a SQL query to find the number of unique customers who purchased items from each category

SELECT 
      category,
      COUNT(DISTINCT Customer_id) as unique_customer
FROM retail_sales
GROUP BY 1;

--Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sales
AS (
		SELECT *, 
		    CASE
			    WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		        ELSE 'Evening'
			END AS Shift
		FROM retail_sales
	)	
SELECT 
     Shift,
     COUNT(*) as total_order
FROM hourly_sales
GROUP BY Shift


----End of Project
	















