--/* mod 34 Temporary Tables

---------------------------------------------------------
--local temp tables
CREATE TABLE #PersonDetails(ID int, name varchar(20));

INSERT INTO #PersonDetails VALUES(1,'uday'),(2,'kumar');

SELECT * FROM #PersonDetails;

--to check whether a table is created using query
SELECT * FROM tempdb..sysobjects
WHERE Name like '#PersonDetails%'; --observer the name is suffixed with _ and random numbers

DROP TABLE #PersonDetails;

--creating temp tables inside sp
CREATE PROC spCreateLocalTempTable
AS
BEGIN
	CREATE TABLE #PersonDetails(Id int, Name nvarchar(20))

	INSERT INTO #PersonDetails Values(1, 'Mike')
	INSERT INTO #PersonDetails Values(2, 'John')
	INSERT INTO #PersonDetails Values(3, 'Todd')

	SELECT * FROM #PersonDetails
End

--when we exec sp, its create a temp db in it and destroies it at the end
EXEC spCreateLocalTempTable;

--below query will throw error, as the temp tbl will be destroyed 
SELECT * FROM #PersonDetails;

---------------------------------------------------------
--global temp tables

CREATE TABLE ##tbl (id int); -- 2 ## symbols

SELECT * FROM tempdb..sysobjects
WHERE Name like '##tbl';  -- observe name doesnt have any rand num as suffix

---------------------------------------------------------

--*/