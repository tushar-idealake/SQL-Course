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




