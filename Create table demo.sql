USE SAMPLEDB
GO

-- Create table called parks1:
CREATE TABLE parks1 
	(
	park_id INT,
	park_name VARCHAR(50),
	entry_fee DECIMAL(6,2)
	);


--selecting from the parks1 table:
SELECT *
FROM dbo.parks1;


-- Populate parks1 table with some data:
INSERT INTO dbo.parks1 (park_id, park_name, entry_fee)
	VALUES (1, 'Bellmont Park', 5);

INSERT INTO dbo.parks1 (park_id, park_name, entry_fee)
	VALUES (2, 'Redmond Park', 10);

INSERT INTO dbo.parks1 (park_id, park_name, entry_fee)
	VALUES (3, 'Highland Mountains', 6.74);


--selecting from the parks1 table:
SELECT *
FROM dbo.parks1;


-- Create table called parks2:
CREATE TABLE dbo.parks2 
	(
	park_id INT IDENTITY(1,1),
	park_name VARCHAR(50) NOT NULL,
	entry_fee DECIMAL(6,2) NOT NULL,
	CONSTRAINT PK_parks2_park_id PRIMARY KEY (park_id)
	);


-- Populate parks2 table with some data:
INSERT INTO dbo.parks2 (park_name, entry_fee)
	VALUES ('Bellmont Park', 5);

INSERT INTO dbo.parks2 (park_name, entry_fee)
	VALUES ('Redmond Park', 10);

INSERT INTO dbo.parks2 (park_name, entry_fee)
	VALUES ('Highland Mountains', 6.75);


--selecting from the parks2 table:
SELECT *
FROM dbo.parks2;


-- create child table called park_visits:
CREATE TABLE dbo.park_visits 
	(
	visit_id INT IDENTITY,
	park_id INT NOT NULL,
	visit_date DATE NOT NULL,
	first_name NVARCHAR(50) NOT NULL,
	last_name  NVARCHAR(50) NOT NULL,
	CONSTRAINT PK_park_visits_visit_id PRIMARY KEY (visit_id),
	CONSTRAINT FK_park_visits_park_id FOREIGN KEY (park_id) REFERENCES parks2 (park_id)
	);


-- insert some rows into the park_visits table:
INSERT INTO dbo.park_visits (park_id, visit_date, first_name, last_name)
	VALUES (2, '20200109', 'Bill', 'Evans');
INSERT INTO dbo.park_visits (park_id, visit_date, first_name, last_name)
	VALUES (1, '20201122', 'Jane', 'Dillon');
INSERT INTO dbo.park_visits (park_id, visit_date, first_name, last_name)
	VALUES (1, '20200623', 'Mike', 'Cruz');
INSERT INTO dbo.park_visits (park_id, visit_date, first_name, last_name)
	VALUES (3, '20200520', 'Irene', 'Pritchard');


-- select data from the park_visits table:
SELECT *
FROM dbo.park_visits;


--foreign key prevents the following row from being inserted:
INSERT INTO dbo.park_visits (park_id, visit_date, first_name, last_name)
	VALUES (99, '20200520', 'Helen', 'Turner');

/*
The row above cannot be inserted because park_id 99 does not exist in the parks2 
parent table. The foreign key ensures that values inserted into the park_id
of the park_visits table must match an existing value in park_id of parks2 table.
*/




--permanently deleting (i.e. dropping) the parks and parks2 tables:
DROP TABLE dbo.park_visits;
DROP TABLE dbo.parks1;
DROP TABLE dbo.parks2;



