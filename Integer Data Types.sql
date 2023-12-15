USE SAMPLEDB
GO

SELECT 3 / 2;

/*
3 divided by 2 is 1.5. However, SQL Server returns 1 because the two inputs
were integers and therefore the resulting value will also be an integer.
*/

SELECT 3 / 2.0;

/*
3 divided by 2.0 returns 1.5 in SQL Server. This is because 2.0 includes a decimal
point and therefore SQL Server treats it as a DECIMAL data type. The resulting value
also has a DECIMAL data type.
*/

/*
The maximum value for the INT data type is 2,147,483,647
SQL Server converts integer constants greater than 2,147,483,647 to the DECIMAL data type.
*/

SELECT 2147483649 / 2;



