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