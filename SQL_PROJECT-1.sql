use p1;

CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );
select* from retail_sales;

SELECT 
    COUNT(*) 
FROM retail_sales;

-- Data Cleaning
SELECT * FROM retail_sales
WHERE transaction_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- 
DELETE FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales;

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;



SELECT DISTINCT category FROM retail_sales;


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select 
sale_date,total_sale
from retail_sales 
where sale_date = '2022-11-05'
order by total_sale desc;

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

select 
category, quantity, sale_time
from retail_sales
where 
    category = 'Clothing'
    and 
    sale_date >= '2022-11-01'
    and
    sale_date < '2022-12-01'
    and
    quantity >= 3;
    
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category,sum(total_sale) as total_sales
from retail_sales
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select
    avg(age) as avg_age
from retail_sales
where category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select customer_id,total_sale
from retail_sales
where total_sale>1000
order by total_sale desc;

-- Q.6 Write a SQL query to calculate the total number of transactions (transaction_id) made by each gender in each category.

select category,gender,sum(transaction_id) as total_transactions
from retail_sales
group by 1,2
order by 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select
year,month,avg_sale
from
(
select 
    extract(year from sale_date) as year,
    extract(month from sale_date) as month,
   avg(total_sale) as avg_sale,
    rank() over(partition by EXTRACT(year from sale_date) order by avg(total_sale) desc) as sales_rank
from retail_sales
group by 1, 2
) as t1
where sales_rank = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select
    customer_id,
    sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 8;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select 
    category,    
    COUNT(distinct customer_id) as cnt_unique_cs
from retail_sales
group by category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

with hourly_sale
as
(
select *,
    case
        when EXTRACT(hour from sale_time) < 12 then 'Morning'
        when EXTRACT(hour from sale_time) between 12 and 17 then 'Afternoon'
       else 'Evening'
    end as shift
from retail_sales
)
select 
    shift,
   count(*) as total_orders    
from hourly_sale
group by shift