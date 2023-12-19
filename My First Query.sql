USE SAMPLEDB GO 
SELECT 
  * 
FROM 
  hcm.employees;
SELECT 
  employee_id, 
  first_name, 
  salary 
FROM 
  hcm.employees;
--9. select challenges
-- 1
SELECT 
  first_name, 
  last_name 
FROM 
  hcm.employees;
--2
SELECT 
  last_name AS customer_last_name, 
  city 
FROM 
  oes.customers;
--3
SELECT 
  * 
FROM 
  oes.order_items;
--Select Distinct Challenges
--1
SELECT 
  DISTINCT locality 
FROM 
  bird.antarctic_populations;
--2
SELECT 
  DISTINCT locality, 
  species_id 
FROM 
  bird.antarctic_populations;
SELECT 
  TOP(11) WITH TIES order_id, 
  customer_id, 
  order_date 
FROM 
  oes.orders 
ORDER BY 
  order_date DESC;
--Last 10 placed orders (With and without ties)
-- Order By Challenges
--1
SELECT 
  * 
FROM 
  hcm.employees 
ORDER BY 
  last_name;
--2
SELECT 
  * 
FROM 
  hcm.employees 
ORDER BY 
  salary DESC;
--3
SELECT 
  * 
FROM 
  hcm.employees 
ORDER BY 
  hire_date DESC;
--4
SELECT 
  * 
FROM 
  hcm.employees 
ORDER BY 
  department_id, 
  salary DESC;
--5
SELECT 
  TOP(10) employee_id, 
  first_name, 
  last_name, 
  salary 
FROM 
  hcm.employees 
ORDER BY 
  salary DESC;
--6
SELECT 
  TOP(1) WITH TIES employee_id, 
  first_name, 
  last_name, 
  salary 
FROM 
  hcm.employees 
ORDER BY 
  salary;
SELECT 
  employee_id, 
  first_name, 
  COALESCE(manager_id, 0) AS isupdateNeeded 
FROM 
  hcm.employees;
-- Where Clause Challenges
--1
SELECT 
  * 
FROM 
  OES.products 
WHERE 
  list_price > 100;
--2
SELECT 
  * 
FROM 
  OES.orders 
WHERE 
  shipped_date IS NULL;
--3
SELECT 
  * 
FROM 
  OES.orders 
WHERE 
  order_date = '20200226';
--4
SELECT 
  * 
FROM 
  OES.orders 
WHERE 
  order_date >= '20200101';
-- Pattern matching challenges
--1
SELECT 
  * 
FROM 
  hcm.countries 
WHERE 
  country_name LIKE 'N%';
--2
SELECT 
  * 
FROM 
  OES.customers 
WHERE 
  EMAIL LIKE '%@gmail.com';
--3
SELECT 
  * 
FROM 
  OES.products 
WHERE 
  product_name like '%mouse%';
--4
SELECT 
  * 
FROM 
  OES.products 
WHERE 
  product_name like '%[0-9]';
-- Query INFORMATION SCHEMA COLUMNS to find collation used
SELECT 
  table_schema, 
  table_name, 
  column_name, 
  data_type, 
  collation_name 
FROM 
  INFORMATION_SCHEMA.COLUMNS 
WHERE 
  TABLE_SCHEMA = 'hcm' 
  AND TABLE_NAME = 'countries';
-- Group by challenge


-- 1


SELECT 
  department_id, 
  COUNT(*) AS no_of_emp_in_dept 
FROM 
  hcm.employees 
GROUP BY 
  department_id;


--2


SELECT 
  department_id, 
  ROUND(AVG(salary),1) as avg_salary_in_dept 
FROM 
  hcm.employees 
GROUP BY 
  department_id
ORDER BY
 avg_salary_in_dept DESC;


--3

SELECT 
  warehouse_id, 
  SUM(quantity_on_hand) AS products_per_warehouse 
FROM 
  oes.inventories 
GROUP BY 
  warehouse_id 
HAVING 
  SUM(quantity_on_hand) > 5000;


--4

SELECT 
  locality, 
  MAX(date_of_count) as most_recent_population 
FROM 
  bird.antarctic_populations 
GROUP BY 
  locality;


--5

SELECT 
  * 
FROM 
  bird.antarctic_populations;
SELECT 
  species_id, 
  locality, 
  MAX(date_of_count) as most_recent_population 
FROM 
  bird.antarctic_populations 
GROUP BY 
  species_id, 
  locality;

-- Logical Operator Challenges

--1

SELECT * FROM hcm.employees WHERE city = 'Seattle' OR city = 'Sydney';

--2

SELECT * FROM hcm.employees WHERE city = 'Sydney' AND salary > 200000;

--3

SELECT * FROM hcm.employees WHERE (city = 'Seattle' OR city = 'Sydney') AND (hire_date > '20190101');


--4

SELECT * FROM oes.products WHERE category_id NOT IN(1, 2, 5);

-- JOINS & Constraints

SELECT * FROM hcm.departments;

SELECT COUNT(*) AS row_count, COUNT(DISTINCT department_id) AS disctinct_row_count
FROM hcm.departments;


/*
INFORMATION_SCHEMA.TABLE_CONSTRAINTS view returns one row for each table constraint
in the current database.

INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE view returns one row for each 
column in the current database that has a constraint defined on the column.
*/

-- Query information schema views to get metadata on constraints on hcm.departments table:
SELECT 
	tc.TABLE_SCHEMA,
	tc.TABLE_NAME,
	tc.CONSTRAINT_TYPE,
	ccu.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc 
JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu
ON tc.CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
AND tc.TABLE_NAME = ccu.TABLE_NAME
AND tc.TABLE_SCHEMA = ccu.TABLE_SCHEMA
WHERE tc.TABLE_SCHEMA = 'hcm' AND tc.TABLE_NAME = 'departments';

-- Join Challenges

--1

SELECT d.department_name, 
	   e.employee_id, 
	   e.first_name, 
	   e.last_name, 
	   e.salary 
FROM hcm.departments d INNER JOIN hcm.employees e 
ON d.department_id = e.department_id;

--2


SELECT d.department_name, 
	   e.employee_id, 
	   e.first_name, 
	   e.last_name, 
	   e.salary 
FROM hcm.departments d RIGHT OUTER JOIN hcm.employees e 
ON d.department_id = e.department_id;

--3

SELECT d.department_name,
		COUNT(*) AS no_of_employees_in_dept
FROM hcm.departments d RIGHT OUTER JOIN hcm.employees e 
ON d.department_id = e.department_id
GROUP BY d.department_name;


-- Advanced Join Challenges

--1


--Write a query to return employee details for all employees as well 
--as the first and last name of each employee's manager. Include 
--the following columns:
-- employee_id
-- first_name
-- last_name
-- manager_first_name (alias for first_name)
-- manager_last_name (alias for last_name)


SELECT e.employee_id, e.first_name, e.last_name, e2.first_name AS manager_first_name, e2.last_name AS manager_last_name 
FROM hcm.employees e LEFT OUTER JOIN hcm.employees e2 
ON e.manager_id = e2.employee_id;


--2 


--Write a query to return all the products at each warehouse. 
--Include the following attributes:
-- product_id
-- product_name
-- warehouse_id
-- warehouse_name
-- quantity_on_hand


SELECT p.product_id, p.product_name,  w.warehouse_id, w.warehouse_name, i.quantity_on_hand 
FROM oes.inventories i LEFT OUTER JOIN  oes.products p
ON p.product_id = i.product_id
LEFT OUTER JOIN oes.warehouses w  
ON i.warehouse_id = w.warehouse_id;



--3

--Write a query to return the following attributes for all 
--employees from Australia:
-- employee_id
-- first_name
-- last_name
-- department_name
-- job_title
-- state_province


SELECT DISTINCT e.employee_id, e.first_name, e.last_name, d.department_name, j.job_title, l.state_province
FROM hcm.employees e INNER JOIN hcm.countries c 
ON e.country_id = c.country_id
AND c.country_name = 'Australia'
LEFT OUTER JOIN hcm.departments d
ON e.department_id = d.department_id
LEFT OUTER JOIN hcm.jobs j
ON e.job_id = j.job_id
LEFT OUTER JOIN hcm.locations l
ON e.country_id = l.country_id;

--or


SELECT 
	e.employee_id,
	e.first_name,
	e.last_name,
	d.department_name,
	j.job_title,
	e.state_province
FROM hcm.employees e
LEFT JOIN hcm.departments d
ON e.department_id = d.department_id
INNER JOIN hcm.jobs j
ON e.job_id = j.job_id
INNER JOIN hcm.countries c
ON e.country_id = c.country_id
WHERE c.country_name = 'Australia';


--4

--Return the total quantity ordered of each product in each  category. Do not include products which have never been ordered. Include the product name and category name in the 
--query. Order the results by category name from A to Z and then within each category name order by product name from A to Z.




SELECT pc.category_name,p.product_name, SUM(o.quantity) AS quantity_aggregation FROM oes.order_items o 
LEFT OUTER JOIN oes.products p 
ON o.product_id = p.product_id 
LEFT OUTER JOIN oes.product_categories pc
ON p.category_id = pc.category_id
GROUP BY pc.category_name, p.product_name
ORDER BY pc.category_name, p.product_name;


--5


--Return the total quantity ordered of each product in each category. Include products which have never been ordered and give these a total quantity ordered of 0. Include the product name 
--and category name in the query. Order the results by category name from A to Z and then within each category name order by product name from A to Z


SELECT pc.category_name,p.product_name, COALESCE(SUM(o.quantity), 0) as total_quantity_ordered FROM oes.products p 
LEFT JOIN oes.order_items o 
ON o.product_id = p.product_id 
JOIN oes.product_categories pc
ON p.category_id = pc.category_id
GROUP BY pc.category_name, p.product_name
ORDER BY pc.category_name, p.product_name;



-- SET Operator Challenges


--1 

SELECT * 
FROM bird.california_sightings
UNION ALL
SELECT * 
FROM bird.arizona_sightings;

--2


SELECT scientific_name 
FROM bird.california_sightings
UNION
SELECT scientific_name 
FROM bird.arizona_sightings

--3

SELECT scientific_name, 'california' as state_name
FROM bird.california_sightings
UNION
SELECT scientific_name, 'arizona' as state_name
FROM bird.arizona_sightings
UNION
SELECT scientific_name, 'florida' as state_name
FROM bird.florida_sightings;


SELECT sighting_id, common_name, scientific_name, location_of_sighting, sighting_date, 'California' AS state_name
FROM bird.california_sightings
UNION ALL
SELECT sighting_id, common_name, scientific_name, sighting_location, sighting_date, 'Arizona'
FROM bird.arizona_sightings
UNION ALL
SELECT observation_id, NULL AS common_name, scientific_name, locality, sighting_datetime, 'Florida'
FROM bird.florida_sightings;

--5

SELECT customer_id
FROM oes.customers
INTERSECT
SELECT customer_id
FROM oes.orders;

--6

SELECT product_id
FROM oes.products
EXCEPT 
SELECT product_id
FROM oes.inventories;

-- Subquery Challenges

--1

-- Return the following product details for the cheapest product(s) in the oes.products table:
-- product_id
-- product_name
-- list_price
-- category_id


SELECT 
  product_id, 
  product_name, 
  list_price, 
  category_id 
FROM 
  oes.products 
WHERE 
  list_price = (
    SELECT 
      MIN(list_price) 
    FROM 
      oes.products
  );

  -- equivalent using TOP

  SELECT
	TOP(1) WITH TIES
	product_id,
	product_name,
	list_price,
	category_id
	FROM
	oes.products
	ORDER BY list_price;
	

--2

-- Use a correlated subquery to return the following product details for the cheapest product(s) in each product category as given by the category_id column:
-- product_id
-- product_name
-- list_price
-- category_id


SELECT
  product_id, 
  product_name, 
  list_price, 
  category_id 
FROM 
  oes.products p1 
WHERE 
  list_price = (
    SELECT 
      MIN(p2.list_price) 
    FROM 
      oes.products p2 
    WHERE 
      p2.category_id = p1.category_id
  );


--3

-- Return the same result as challenge 2 i.e. the cheapest product(s) in each product category except this time by using an inner join to a derived table

  
SELECT 
  p1.product_id, 
  p1.product_name, 
  p1.list_price, 
  p1.category_id 
FROM 
  oes.products p1 
  INNER JOIN (
    SELECT 
      category_id, 
      MIN(list_price) AS min_cat_price 
    FROM 
      oes.products 
    GROUP BY 
      category_id
  ) p2 ON p1.category_id = p2.category_id 
  AND p1.list_price = p2.min_cat_price;

--4

-- Return the same result as challenge 2 and 3 i.e. the cheapest product(s) in each product category except this time by using a common table expression.

-- with window function

WITH p AS (
  SELECT 
    product_id, 
    product_name, 
    list_price, 
    category_id, 
    RANK() OVER (
      PARTITION BY category_id 
      ORDER BY 
        list_price
    ) AS rnk 
  FROM 
    oes.products
) 
SELECT 
  p.product_id, 
  p.product_name, 
  p.list_price, 
  p.category_id
FROM 
  p 
WHERE 
  p.rnk = 1;

-- Alternate with MIN AND INNER JOIN

WITH cheapest_product_by_category AS (
  SELECT 
    category_id, 
    MIN(list_price) AS min_list_price 
  FROM 
    oes.products 
  GROUP BY 
    category_id
) 
SELECT 
  p.product_id, 
  p.product_name, 
  p.list_price, 
  p.category_id
FROM 
  oes.products p 
  INNER JOIN cheapest_product_by_category p2 ON p.category_id = p2.category_id 
  AND p.list_price = p2.min_list_price;


--5

-- Repeat challenge 4, except this time include the product category name as given in the oes.product_categories table.


WITH p AS (
  SELECT 
    product_id, 
    product_name, 
    list_price, 
    category_id, 
    RANK() OVER (
      PARTITION BY category_id 
      ORDER BY 
        list_price
    ) AS rnk 
  FROM 
    oes.products
) 
SELECT 
  p.product_id, 
  p.product_name, 
  p.list_price, 
  p.category_id, 
  pc.category_name 
FROM 
  p 
  LEFT JOIN oes.product_categories pc ON pc.category_id = p.category_id 
WHERE 
  p.rnk = 1;


--6

-- Background:
-- The employee_id column in the oes.orders table gives the employee_id of the salesperson who made the sale. 

--Challenge:
-- Use the NOT IN operator to return all employees who have never been the salesperson for any customer order. Include the following columns from hcm.employees:
-- employee_id
-- first_name
-- last_name

SELECT 
  employee_id, 
  first_name, 
  last_name 
FROM 
  hcm.employees 
WHERE 
  employee_id NOT IN (
    SELECT 
      employee_id 
    FROM 
      oes.orders 
    WHERE 
      employee_id IS NOT NULL
  );

--7

--Return the same result as challenge 6, except use WHERE NOT EXISTS

SELECT 
  employee_id, 
  first_name, 
  last_name 
FROM 
  hcm.employees e 
WHERE 
  NOT EXISTS (
    SELECT 
      * 
    FROM 
      oes.orders o 
    WHERE 
      o.employee_id = e.employee_id
  );

--8

-- Return unique customers who have ordered the 'PBX Smart Watch 4�. Include:
-- customer_id
-- first_name
-- last_name
-- email

SELECT 
  customer_id, 
  first_name, 
  last_name, 
  email 
FROM 
  oes.customers 
WHERE 
  customer_id IN (
    SELECT
      customer_id 
    FROM 
      oes.orders 
      LEFT JOIN oes.order_items ON oes.order_items.order_id = oes.orders.order_id 
      LEFT JOIN oes.products ON oes.order_items.product_id = oes.products.product_id 
    WHERE 
      oes.products.product_name = 'PBX Smart Watch 4'
  );


  -- Function Challenges


--1

-- Concatenate the first name and last name of each employee. Include a single space between the first and 
-- last name. Name the new expression employee_name. Include:
-- employee_id
-- first_name
-- last_name
-- employee_name

SELECT 
  employee_id, 
  first_name, 
  last_name, 
  CONCAT(first_name, ' ' + last_name) AS employee_name 
FROM 
  hcm.employees;


--2

-- Concatenate the first name, middle name, and last name of each employee. Include a single space between each 
-- of the names. Name the new expression employee_name. Include:
-- employee_id
-- first_name
-- last_name
-- employee_name

SELECT 
  employee_id, 
  first_name,
  middle_name,
  last_name, 
  CONCAT(first_name, ' ' + middle_name, ' ' , last_name  ) AS employee_name 
FROM 
  hcm.employees;

--3

-- Extract the genus name from the scientific_name as given in the bird.antarctic_species table.

SELECT 
  LEFT(
    scientific_name, 
    CHARINDEX(' ', scientific_name)-1
  ) AS genus_name 
FROM 
  bird.antarctic_species;

--4

-- Extract the species name from the scientific_name as given in the bird.antarctic_species table.

SELECT 
  SUBSTRING(
    scientific_name, 
    CHARINDEX(' ', scientific_name)+1,
	LEN(scientific_name)
  ) AS genus_name 
FROM 
  bird.antarctic_species;

--5

-- Return the age in years for all employees. Name this expression as employee_age. Include:
-- employee_id
-- first_name
-- last_name
-- birth_date
-- employee_age


SELECT 
  employee_id, 
  first_name, 
  last_name, 
  birth_date, 
  DATEDIFF(
    year, birth_date, CURRENT_TIMESTAMP
  ) AS employee_age 
FROM 
  hcm.employees;

--6

-- Assuming an estimated shipping date of 7 days after the order date, add a column expression called 
-- estimated_shipping_date for all unshipped orders. Include:
-- order_id
-- order_date
-- estimated_shipping_date

SELECT 
  order_id, 
  order_date, 
  DATEADD(day, 7, order_date) AS estimated_shipping_date 
FROM 
  oes.orders 
WHERE 
  shipped_date IS NULL;

--7

-- Calculate the average number of days it takes each shipping company to ship an order. Call this expression 
-- avg_shipping_days. Include:
-- company_name
-- avg_shipping_days

SELECT 
  s.company_name, 
  AVG(
    DATEDIFF(
      day, o.order_date, o.shipped_date
    )
  ) AS avg_shipping_days 
FROM 
  oes.orders o 
  JOIN oes.shippers s ON o.shipper_id = s.shipper_id 
GROUP BY 
  company_name;


-- Case expression Challenges

--Select the following columns from the oes.products table:
--• product_id
--• product_name
--• discontinued
--Include a CASE expression in the SELECT statement called 
--discontinued_description. Give this expression the string 
--‘No’ when the discontinued column equals 0 and a string of 
--‘Yes’ when the discontinued column equals 1. In all other 
--cases give the expression the string of ‘unknown’.

SELECT product_id, product_name, discontinued, CASE WHEN discontinued = 0 THEN 'No'
WHEN discontinued = 1 THEN 'Yes'
ELSE 'Unknown'
END As discontinued_description
FROM oes.products;


--2

--Select the following columns from the oes.products table:
--• product_id
--• product_name
--• list_price
--• Include a CASE expression in the SELECT statement called 
--price_grade. For this expression..
--• If list_price is less than 50 then give the string ‘Low’.
--• If list_price is greater than or equal to 50 and list_price is 
--less than 250 then give the string ‘Medium’.
--• If list_price is greater than or equal to 250 then give the 
--string ‘High’.
--• In all other cases, give the expression the string of ‘unknown’.


SELECT product_id, product_name, list_price,
CASE WHEN list_price < 50 THEN 'Low'
WHEN list_price >= 50 AND list_price < 250 THEN 'Medium'
WHEN list_price >= 250  THEN 'High'
ELSE 'Unknown'
END As price_grade
FROM oes.products;

--3

-- Select the following columns from the oes.orders table:
-- • order_id
-- • order_date
-- • shipped_date
-- • Include a CASE expression called shipping_status which 
-- determines the difference in days between the order_date and 
-- the shipped_date. When this difference is less than or equal to 7 
-- then give the string value ‘Shipped within one week’.
-- • If the difference is greater than 7 days, then give the string 
-- ‘Shipped over a week later’.
-- • If shipped_date is null then give the string ‘Not yet shipped’.

SELECT 
  order_id, 
  order_date, 
  shipped_date, 
  CASE WHEN DATEDIFF(day, order_date, shipped_date) <= 7 THEN 'Shipped Within a week' WHEN DATEDIFF(day, order_date, shipped_date) > 7 THEN 'Shipped over a week later' WHEN shipped_date IS NULL THEN 'Not yet Shipped' END AS shipping_status
FROM 
  oes.orders;

--4

-- Repeat the third challenge to derive the shipping_status
-- expression, but this time get the count of orders by the 
-- shipping_status expression.


WITH o 
AS (SELECT 
  order_id, 
  order_date, 
  shipped_date, 
  CASE WHEN DATEDIFF(day, order_date, shipped_date) <= 7 THEN 'Shipped Within a week' WHEN DATEDIFF(day, order_date, shipped_date) > 7 THEN 'Shipped over a week later' WHEN shipped_date IS NULL THEN 'Not yet Shipped' END AS shipping_status
FROM 
  oes.orders)
  SELECT 
  o.shipping_status,
  COUNT(o.shipping_status)
  from 
  o
  group by 
  o.shipping_status
	;


-- CREATE TABLE Challenges

--1

-- Create a table called dept in the dbo schema. Specify the following 
-- columns:
-- - dept_id INT
-- - dept_name VARCHAR(50) 
-- Give the IDENTITY property to the dept_id column. Also, put a 
-- primary key constraint on the dept_id column. Put a NOT NULL
-- constraint on the dept_name column.

CREATE TABLE dbo.dept(
		dept_id INT IDENTITY CONSTRAINT PK_dept_id PRIMARY KEY,
		dept_name VARCHAR(50) NOT NULL
		);


-- Write an insert statement to insert the following row into the dbo.dept table:


-- dept_id |   dept_name
--   1	   |	Business Intelligence

INSERT INTO dbo.dept( dept_name) VALUES ( 'Business Intelligence');


-- Populate the dbo.dept table with more rows: Insert all department names from the hcm.departments table.

INSERT INTO dbo.dept (dept_name) SELECT department_name FROM hcm.departments;


--Create a table called emp in the dbo schema. Specify the following columns:
-- emp_id INT 
-- first_name VARCHAR(50)
-- last_name VARCHAR(50)
-- hire_date DATE
-- dept_id INT


CREATE TABLE dbo.emp(
		emp_id INT IDENTITY CONSTRAINT PK_emp_id PRIMARY KEY,
		dept_id INT NOT NULL,
		first_name VARCHAR(50) NOT NULL,
		last_name VARCHAR(50) NOT NULL,
		hire_date DATE NOT NULL,
		CONSTRAINT FK_dept_id FOREIGN KEY (dept_id) REFERENCES dbo.dept (dept_id)
		);


-- Populate the dbo.emp table with the following two employees:

--emp_id |first_name  |last_name |hire_date		|dept_id
--1		 |scott       |davis	 |dec-11-2020   |1
--2		 |miriam	  |yardley	 |dec-05-2020   |1


INSERT INTO dbo.emp (first_name, last_name, hire_date, dept_id)
VALUES('scott', 'davis', '20201211', 1),('miriam', 'yardley', '20201205', 1)


-- UPDATE TABLE challenge

UPDATE dbo.emp
	SET last_name = 'Greenbank'
	WHERE emp_id = 2;

-- DELETE Statement Challenge

DELETE dbo.emp
WHERE emp_id = 1;

-- DROP TABLE Statement


-- Initially not able to drop table as Foreign Key Constraint was present

DROP TABLE SAMPLEDB.dbo.dept;

-- Removing Foreign KEY Constraint using ALTER TABLE + DROP CONSTRAINT

ALTER TABLE dbo.emp DROP CONSTRAINT [FK_dept_id];

-- IF Exists only available in SQL SERVER 2016 +

DROP TABLE IF EXISTS SAMPLEDB.dbo.dept;

-- Alternate equivalent For legacy SQL

IF OBJECT_ID (N'SAMPLEDB.dbo.dept', N'U') IS NOT NULL DROP TABLE dbo.dept;


-- Store Procedures Demo

-- Select all employees from 'Finance' Department

SELECT 
	e.employee_id,
	e.first_name,
	e.last_name,
	d.department_name
FROM hcm.employees e INNER JOIN hcm.departments d
ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';

GO


-- Stored procedure with one input parameter

CREATE PROCEDURE hcm.getEmployeesByDepartment (@department_name VARCHAR(50))
AS
SELECT
	e.employee_id,
	e.first_name,
	e.last_name,
	d.department_name
FROM hcm.employees e INNER JOIN hcm.departments d
ON e.department_id = d.department_id
WHERE d.department_name = @department_name;

GO

-- Execute hcm.getEmployeesByDepartment stored procedure to get
-- all employees in the 'Finance' department

EXECUTE hcm.getEmployeesByDepartment @department_name ='Finance';

-- or

EXECUTE hcm.getEmployeesByDepartment 'Finance';

--or

EXEC hcm.getEmployeesByDepartment 'Finance';

-- SELECT query that selcts customers who contain the string '34th' in their street address

SELECT 
customer_id,
first_name,
last_name,
email,
street_address
FROM
oes.customers
WHERE street_address LIKE '%34th%'

-- Store procedure to search Customers by street address which includes provided searchstring

GO

CREATE PROCEDURE oes.searchCustomersByStreetAddress
(
@street_address_search VARCHAR(50)
)
AS
SELECT
	customer_id,
	first_name,
	last_name,
	email,
	street_address
FROM oes.customers
WHERE street_address LIKE '%' + @street_address_search + '%';

-- Executing the query

EXEC oes.searchCustomersByStreetAddress '34th';

-- SELECT query that selects customers from AUstralia who have gmail addresses

SELECT * FROM oes.customers;


SELECT
cu.customer_id,
cu.first_name,
cu.last_name,
cu.email,
ct.country_name
FROM oes.customers cu
INNER JOIN hcm.countries ct
ON cu.country_id = ct.country_id
WHERE ct.country_name = 'Australia'
AND cu.email LIKE '%gmail.com'

GO

-- Generalize above query to search customers from particular country with email

CREATE PROCEDURE oes.searchCustomersByCountryEmail (@country_name VARCHAR(50), @email VARCHAR(320))
AS
BEGIN
SELECT
	cu.customer_id,
	cu.first_name,
	cu.last_name,
	cu.email,
	ct.country_name
FROM oes.customers cu
INNER JOIN hcm.countries ct
ON cu.country_id = ct.country_id
WHERE ct.country_name = @country_name
AND cu.email LIKE '%' + @email
END
GO
;

EXEC oes.searchCustomersByCountryEmail @country_name = 'Australia', @email ='yahoo.com';


-- Select employees who have a salary greater than or equal to 80000 and less than or equal 100000

SELECT * FROM hcm.employees
WHERE salary >= 80000
AND salary <= 100000;

-- Create generalized Store procedure for filtering employees based on minimum and maximum salary

GO

CREATE PROCEDURE hcm.filterEmployeesBySalary(@min_salary numeric(12,2), @max_salary numeric(12,2))
AS
BEGIN
SELECT * FROM hcm.employees
WHERE salary >= @min_salary
AND salary <= @max_salary;
END


EXEC hcm.filterEmployeesBySalary @min_salary = 80000, @max_salary = 100000;


-- Optional Parameters

/*


*/

ALTER PROCEDURE hcm.filterEmployeesBySalary(@min_salary numeric(12,2) = 0, @max_salary numeric(12,2) = 99999999)
AS
BEGIN
SELECT * FROM hcm.employees
WHERE salary >= @min_salary
AND salary <= @max_salary;
END


-- Select Employees with default salary range i.e min = 0 max = 99999999 

EXEC hcm.filterEmployeesBySalary;

-- min of 90000
EXEC hcm.filterEmployeesBySalary @min_salary = 90000;

-- max of 150000

EXEC hcm.filterEmployeesBySalary @max_salary = 150000;

-- Output parameters
GO

CREATE PROCEDURE dbo.addNewPark(
@park_name VARCHAR(50),
@entry_fee DECIMAL(6,2) = 0,
@new_park_id INT OUT)
AS
-- No messages reporting How many rows were affected
SET NOCOUNT ON
-- All errors will cause transaction to rollback IF XACT_ABORT ON IF Off then not all errors will cause transaction to rollback
SET XACT_ABORT ON;
BEGIN
INSERT INTO dbo.parks2 (park_name, entry_fee)
VALUES (@park_name, @entry_fee);
-- Setting new park id output parameter to the value returned by SCOPE_IDENTITY (Which returns IDENTITY of last INSERT that occured)
SELECT @new_park_id = SCOPE_IDENTITY();
END
GO

-- Declare a variable called @ParkID of data type INT
-- This will store the value returned by the @new_park_id output parameter

DECLARE @ParkID INT;

-- Execute the stored procedure to add national park set OUT for variable that is set in Execute query

EXEC dbo.addNewPark @park_name = 'National Park', @entry_fee = 20.00, @new_park_id = @ParkID OUT;

-- Return Output scalar variable
SELECT @ParkID

 -- Stored Procedure Challenges


--1

-- Create a stored procedure called oes.getQuantityOnHand that 
-- returns the quantity_on_hand in the oes.inventories table for a 
-- given product_id and warehouse_id.
-- Execute the stored procedure to return the quantity on hand of 
-- product id 4 at warehouse id 2.

-- Creating Stored Procedure
GO
  CREATE PROCEDURE oes.getQuantityOnHand (@product_id INT, @warehouse_id INT) 
  AS 
  BEGIN
SELECT
  i.quantity_on_hand
FROM
  oes.inventories i
WHERE
  i.product_id = @product_id
  AND i.warehouse_id = @warehouse_id
END

-- Executing Stored Procedure
EXEC oes.getQuantityOnHand 4,2


--2

-- Create a stored procedure called oes.getCurrentProducts
-- that returns current products (discontinued = 0) in the 
-- oes.products table. In addition, define two input parameters:
-- - A parameter called @product_name of data type VARCHAR(100). 
-- Allow users to wildcard search on the product_name.
-- - A parameter called @max_list_price of data type 
-- DECIMAL(19,4). Allow users to only include current products 
-- that have a list_price that is less than or equal to a 
-- specified value for this parameter.


-- Creating Stored Procedure
GO
  CREATE PROCEDURE oes.getCurrentProducts (
    @product_name VARCHAR(100),
    @max_list_price DECIMAL(19, 4)
  ) 
  AS 
  BEGIN
SELECT
  *
FROM
  oes.products p
WHERE
  p.discontinued = 0
  AND p.product_name LIKE '%' + @product_name + '%'
  AND p.list_price <= @max_list_price
END

-- Executing Stored Procedure

EXEC oes.getCurrentProducts 'Drone', 700

--3

-- Create a stored procedure called oes.transferFunds that 
-- transfers money from one bank account to another bank 
-- account by updating the balance column in the 
-- oes.bank_accounts table. Also, insert the bank transaction 
-- details into oes.bank_transactions table. Define three input 
-- parameters:
-- - @withdraw_account_id of data type INT
-- - @deposit_account_id of data type INT
-- - @transfer_amount of data type DECIMAL(30,2)
-- Test the stored procedure by transferring $100 from Anna’s 
-- bank account to Bob’s account.

-- Creating Stored Procedure

GO
 CREATE PROCEDURE oes.transferFunds (
    @withdraw_account_id INT,
    @deposit_account_id INT,
    @transfer_amount DECIMAL(30, 2)
  ) AS
SET
  NOCOUNT ON
SET
  XACT_ABORT ON;
BEGIN
BEGIN TRANSACTION ;
-- Update sender's account by reducing specified amount
UPDATE
  [oes].[bank_accounts]
SET
  balance = balance - @transfer_amount
WHERE
  account_id = @withdraw_account_id 
  -- Update receiver's account by adding specified amount
UPDATE
  [oes].[bank_accounts]
SET
  balance = balance + @transfer_amount
WHERE
  account_id = @deposit_account_id 
  -- Add entry for transaction in bank transaction table
INSERT INTO
  [oes].[bank_transactions] (from_account_id, to_account_id, amount)
VALUES
  (
    @withdraw_account_id,
    @deposit_account_id,
    @transfer_amount
  ) 
  COMMIT TRANSACTION ;
  END

-- Executing Store Procedure
  EXEC oes.transferFunds 2, 1, 100

-- Checking the transaction and account balances of sender and receiver

 SELECT
  *
FROM
  [oes].[bank_accounts]


SELECT
  *
FROM
  [oes].[bank_transactions]

-- ALTER TABLE Challenges

--1

--Add a new column called ‘termination_date’ onto the 
--hcm.employees table. Give this new column a data type of 
--DATE.

ALTER TABLE
  hcm.employees
ADD
  termination_date DATE;
	

--2


--Write two SQL statements to change the data type of the 
--first_name and last_name columns to NVARCHAR(60) in the 
--oes.customers table.

ALTER TABLE
  oes.customers
ALTER COLUMN
  first_name NVARCHAR(60);

ALTER TABLE
  oes.customers
ALTER COLUMN
  last_name NVARCHAR(60);

--3

--Use sp_rename to rename the column name 'phone' to 
--'main_phone' in the oes.customers table.

GO


  sp_rename 'oes.customers.phone',
  'main_phone',
  'COLUMN';


 -- UNIQUE constraint challenge

 -- Use an ALTER TABLE statement to add UNIQUE constraint to
 -- the departma=ent_name column in the hcm.departments
 -- table

 -- Checking if department_name coulumn has only unique values

SELECT
  COUNT(*) as total_count,
  COUNT(DISTINCT department_name) as unique_value_count
FROM
  hcm.departments;

-- Adding unique key

ALTER TABLE
  hcm.departments
ADD
  CONSTRAINT uk_departments_department_name UNIQUE (department_name);

 -- Attempting to insert a duplicate value for department_name
INSERT INTO
  hcm.departments (department_name, location_id)
VALUES
('Administration', 1800);

-- GIVES ERROR FOR UNIQUE CONSTRAINT

-- Check constraints Challenges

-- Use an ALTER TABLE statement to add a CHECK constraint on the salary column in the hcm.employees
-- table to ensure that salary is greater than or equal to zero

ALTER TABLE
  hcm.employees
ADD
  CONSTRAINT chk_employee_salary CHECK (salary >= 0);