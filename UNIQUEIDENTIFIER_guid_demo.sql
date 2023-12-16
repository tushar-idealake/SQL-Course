USE SAMPLEDB
GO


-- Selecting a guid value by using the NEWID function:
SELECT NEWID() AS guid_value;
GO

---------------
CREATE TABLE dbo.subjects1 
(
	subject_id INT IDENTITY,
	subject_name VARCHAR(20),
	global_id UNIQUEIDENTIFIER,
	CONSTRAINT pk_subjects1_subject_id PRIMARY KEY (subject_id)
);
GO

INSERT INTO dbo.subjects1 (subject_name, global_id)
	VALUES ('Biology', NEWID()),
	       ('Physics', NEWID()),
		   ('English', NEWID());
GO


SELECT *
FROM dbo.subjects1;


---------------
CREATE TABLE dbo.subjects2
(
	subject_id INT IDENTITY,
	subject_name VARCHAR(20),
	global_id UNIQUEIDENTIFIER DEFAULT NEWID(),
	CONSTRAINT pk_subjects2_subject_id PRIMARY KEY (subject_id)
);
GO

INSERT INTO dbo.subjects2 (subject_name)
	VALUES ('Biology'),
	       ('Physics'),
		   ('English');
GO


SELECT *
FROM dbo.subjects2;


-----------------
CREATE TABLE dbo.subjects3
(
	subject_id INT IDENTITY,
	subject_name VARCHAR(20),
	global_id UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID(),
	CONSTRAINT pk_subjects3_subject_id PRIMARY KEY (subject_id)
);
GO

INSERT INTO dbo.subjects3 (subject_name)
	VALUES ('Biology'),
	       ('Physics'),
		   ('English');
GO


SELECT *
FROM dbo.subjects3;
------------

