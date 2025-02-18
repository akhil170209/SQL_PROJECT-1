# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis   
**Database**: `p1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Establish and populate a structured database with sales records.  
2. **Data Cleaning**: Detect and eliminate missing or null entries for data accuracy.  
3. **Exploratory Data Analysis (EDA)**: Conduct initial data exploration to uncover key patterns.  
4. **Business Insights**: Leverage SQL queries to extract meaningful sales insights.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
create datbase p1;
use p1;

create table retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Total Records**: Compute the total number of transactions recorded in the dataset to understand its size.  
- **Unique Customers**: Identify the number of distinct customers to analyze customer reach and engagement.  
- **Product Categories**: List all unique product categories to gain insights into the variety of items sold.  
- **Data Validation**: Examine the dataset for missing or null values and remove incomplete records to ensure data quality.

  
```sql
select count(*) from retail_sales;
select count(distinct customer_id) from retail_sales;
select distinct category from retail_sales;

select * from retail_sales
where
    sale_date is null or sale_time is null or customer_id is null or 
    gender is null or age is null or category is null or 
    quantity is null or price_per_unit is null or  cogs is null;

delete from retail_sales
where
    sale_date is null or sale_time is null or customer_id is null or 
    gender is null or age is null or category is null or
    quantity is null or price_per_unit is null or cogs is null;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select 
sale_date,total_sale
from retail_sales 
where sale_date = '2022-11-05'
order by total_sale desc;

```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022**:
```sql
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
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select category,sum(total_sale) as total_sales
from retail_sales
group by category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select
    avg(age) as avg_age
from retail_sales
where category = 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select customer_id,total_sale
from retail_sales
where total_sale>1000
order by total_sale desc;
```

6. **Write a SQL query to find calculate the transactions (transaction_id) made by each gender in each category.**:
```sql
select
  category,
  gender,
  sum(transaction_id) as total_transactions
from retail_sales
group by 1,2
order by 1;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales**:
```sql
select
    customer_id,
    sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 8;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select 
    category,    
    count(distinct customer_id) as cnt_unique_cs
from retail_sales
group by category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
with hourly_sale
as
(
select *,
    case
        when extract(hour from sale_time) < 12 then 'Morning'
        when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
       else 'Evening'
    end as shift
from retail_sales
)
select 
    shift,
   count(*) as total_orders    
from hourly_sale
group by shift;
```

## Findings

- **Customer Demographics**: The data highlights customer distribution across age groups, with purchases spanning multiple categories like Apparel and Cosmetics.
- **High-Value Transactions**: Transactions exceeding 1000 indicate luxury spending patterns and premium product preferences.
- **Sales Trends**: Monthly sales fluctuations reveal seasonal demand shifts and peak revenue periods.
- **Customer Insights**: Identifies top spenders and trending product categories, offering valuable business intelligence.

## Reports

- **Sales Summary**: Overview of total revenue, customer segments, and category-wise performance.
- **Trend Analysis**: Examination of monthly sales patterns and shifting demand trends.
- **Customer Insights**: Highlights top buyers and category-specific customer distribution.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business insights SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.



## Author - Akhilesh Basetty

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join social media

For more queries on SQL, data analysis, and other data-related topics, make sure to follow me on social media and join my linkedin:

- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/akhilesh-basetty-8b5970227/))

Thank you for your support, and I look forward to connecting with you!
