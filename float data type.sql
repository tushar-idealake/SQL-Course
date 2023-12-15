USE SAMPLEDB
GO

/*
Declaring a variable called @val of DECIMAL(12,2) data type and giving it a value of 0.0
Using a WHILE loop to add 0.1 to @val which will continue iterating while 
@val does not equal 10.0
*/

DECLARE @val DECIMAL(12,2) = 0.0;

WHILE @val != 10.0
BEGIN 
	PRINT @val;
	SET @val += 0.1;
END;


-- If we try the same thing but give @val a data type of float then the loop doesn't stop:
DECLARE @val FLOAT(24) = 0.0;

WHILE @val != 10.0
BEGIN 
	PRINT @val;
	SET @val += 0.1;
END;


/*
When using the FLOAT datatype, the value 10 can be stored accurately.
However, the value 0.1 cannot be accurately represented in float. 
Therefore, even though we had the WHILE condition @val != 10.0, the @val will never 
exactly equal 10 when we use the FLOAT data type. This means that the loop 
will keep interating - by adding 0.1 - indefinitely.

However, if we look in the messages tab we can see that it does show that at
one point there was a value of 10. But this is just because SQL Server Management Studio
is rounding the values that are printed. In other words, SSMS is not showing us the actual
values.

To get a more accurate picture of the float values, we can use the STR function to convert
the float to a character string:
*/

DECLARE @val FLOAT(24) = 0.0;

WHILE @val != 10.0
BEGIN 
	PRINT str(@val,20,16); -- STR ( float_expression [ , length [ , decimal ] ] )  
	SET @val += 0.1;
END;




