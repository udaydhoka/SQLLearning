/* mod 30 Scalar UDF

SELECT * FROM tblDateFunc;

--creating a scalar UDF
CREATE FUNCTION [dbo].[fn_CalculateAge]
(
	@DOB date
)
RETURNS INT
AS
BEGIN
	DECLARE @Age INT
	SET @Age = DATEDIFF(YEAR,@DOB,GETDATE()) -
					CASE
						WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR
							 ((MONTH(@DOB) = MONTH(GETDATE())) AND (DAY(@DOB) > DAY(GETDATE())))
						THEN 1
						ELSE 0
					END
    RETURN @Age
END

--calling a scalar UDF
SELECT [dbo].[fn_CalculateAge]('11/08/1993');
--or
SELECT [SampleDBDB].[dbo].[fn_CalculateAge]('11/08/1993');

--using udf in select clause
SELECT Name,DOB,[SampleDBDB].[dbo].[fn_CalculateAge](DOB) AS Age 
FROM tblDateFunc;

--using udf in where clause
SELECT Name,DOB,[SampleDBDB].[dbo].[fn_CalculateAge](DOB) AS Age 
FROM tblDateFunc
WHERE [SampleDBDB].[dbo].[fn_CalculateAge](DOB) > 15;

--to view contents 
EXEC sp_helptext [fn_CalculateAge];

-- to alter use ALTER FUNCTION fn_name ...

--to delete
DROP FUNCTION [fn_CalculateAge];

--*/



/* mod 31 Inline table valued Func(TVF)

CREATE TABLE [dbo].[tblEmp]
(
 [Id] [int] Primary Key,
 [Name] [nvarchar](50) NULL,
 [DateOfBirth] [datetime] NULL,
 [Gender] [nvarchar](10) NULL,
 [DepartmentId] [int] NULL
)


Insert into [tblEmp] values(1,'Sam','1980-12-30 00:00:00.000','Male',1)
Insert into [tblEmp] values(2,'Pam','1982-09-01 12:02:36.260','Female',2)
Insert into [tblEmp] values(3,'John','1985-08-22 12:03:30.370','Male',1)
Insert into [tblEmp] values(4,'Sara','1979-11-29 12:59:30.670','Female',3)
Insert into [tblEmp] values(5,'Todd','1978-11-29 12:59:30.670','Male',1)

SELECT * FROM tblEmp;

--creating a IL TVF 
CREATE FUNCTION [dbo].[fn_EmployeesByGender]
(
    @Gender nvarchar(10)
)
RETURNS TABLE 
AS
RETURN
(
	SELECT Id,Name,DateOfBirth,Gender,DepartmentId
	FROM tblEmp
	WHERE Gender = @Gender	       
)

--calling a IL TVF 
SELECT * FROM fn_EmployeesByGender('Male');
SELECT * FROM fn_EmployeesByGender('Female');

--we can use ALTER FUNCTION to alter it

--deleting TVF
DROP FUNCTION fn_EmployeesByGender;


-- we can aslo use the table returned by ILTVF in joins

SELECT * FROM tblEmp;
SELECT * FROM tblDepartment;

SELECT Name,Gender,DepartmentName
FROM fn_EmployeesByGender('Male') E 
JOIN tblDepartment D
ON E.DepartmentId = D.ID;


SELECT Name,Gender,DepartmentName
FROM fn_EmployeesByGender('Female') E 
JOIN tblDepartment D
ON E.DepartmentId = D.ID;

--updating the underlying table using ILTVF
UPDATE dbo.fn_EmployeesByGender('Male')
SET DepartmentId = 2 
WHERE Name = 'Todd';

SELECT * FROM tblEmp;
-------------------------------------------------------------

--*/



/* mod 32 Multi Statement Table Valued Function(MS_TVF)

SELECT * FROM tblEmp;

--creating ILTVF to demo the diff
CREATE FUNCTION fn_ILTVF_GetEmployees()
RETURNS TABLE -- we dont specify the table structure
AS                -- no begin and end 
RETURN 
(
	SELECT Id,Name,CAST(DateOfBirth AS DATE) AS DOB
	FROM tblEmp
)

--CALLING ILLTVF
SELECT * FROM fn_ILTVF_GetEmployees();

--creating MSTVF
CREATE FUNCTION fn_MSTVF_GetEmployees()  --it can or cant have params
RETURNS @Table TABLE (Id int, Name nvarchar(20), DOB Date) --its has structure of the table defined here 
AS
BEGIN   
	INSERT INTO @Table
	SELECT Id,Name,CAST(DateOfBirth AS DATE)
	FROM tblEmp
	
	RETURN -- we dont specify anything here
END -- it has begin and end block


--calling MSTVF
SELECT * FROM fn_MSTVF_GetEmployees(); 


--we cant update the underlying table using MSTVF()
UPDATE fn_MSTVF_GetEmployees()  --throws errorr
SET Name = 'uday'
WHERE Id = 1;

--we can update the underlying table using ILTVF()
UPDATE fn_MSTVF_GetEmployees() 
SET Name = 'uday'
WHERE Id = 1;

--------------------------------------------------------------------------------------

--*/



--/* mod 33 Functions Concepts

SELECT * FROM [dbo].[tblEmp];

--deterministic funcitons

SELECT COUNT(*) FROM [dbo].[tblEmp]; --gives same o/p as long as we wont change the tblEmp
 
SELECT SQUARE(3);  -- gives same result everytime we run this 

--non-deterministic functions

SELECT GETDATE(); -- gives different value everytime we run this 

SELECT CURRENT_TIMESTAMP;

-- RAND() is non-deterministic when no seed value is provide

SELECT RAND(); -- gives different value everytime we run this 

-- RAND() is deterministic when seed value is provide

SELECT RAND(1); -- gives same result everytime we run this 

----------------------------------------------------------------------------

--without encryption

CREATE FUNCTION fn_GetEmployeeNameById
(
	@Id int
)
RETURNS nvarchar(20)
AS
BEGIN
 RETURN
	(
		SELECT Name 
		FROM tblEmp
		WHERE Id = @Id
	)
END

--we can read the text of func
EXEC sp_helptext 'dbo.fn_GetEmployeeNameById';

--now lets alter the fn_GetEmployeeNameById with encryption

ALTER FUNCTION fn_GetEmployeeNameById
(
	@Id int
)
RETURNS nvarchar(20)
WITH ENCRYPTION
AS
BEGIN
 RETURN
	(
		SELECT Name 
		FROM tblEmp
		WHERE Id = @Id
	)
END

--we can't read the text of func as its encrypted
EXEC sp_helptext 'dbo.fn_GetEmployeeNameById';


----------------------------------------------------------------------------

--with schemabinding

--now lets drop the tblEmp on which fn_GetEmployeeNameById is dependent

DROP TABLE [dbo].[tblEmp];

--now lets execute the func

SELECT dbo.fn_GetEmployeeNameById(1); --throws error: Invalid object name 'tblEmp'.

--lets create that table back 

CREATE TABLE [dbo].[tblEmp]
(
 [Id] [int] Primary Key,
 [Name] [nvarchar](50) NULL,
 [DateOfBirth] [datetime] NULL,
 [Gender] [nvarchar](10) NULL,
 [DepartmentId] [int] NULL
)


Insert into [tblEmp] values(1,'Sam','1980-12-30 00:00:00.000','Male',1)
Insert into [tblEmp] values(2,'Pam','1982-09-01 12:02:36.260','Female',2)
Insert into [tblEmp] values(3,'John','1985-08-22 12:03:30.370','Male',1)
Insert into [tblEmp] values(4,'Sara','1979-11-29 12:59:30.670','Female',3)
Insert into [tblEmp] values(5,'Todd','1978-11-29 12:59:30.670','Male',1)

SELECT * FROM tblEmp;


SELECT dbo.fn_GetEmployeeNameById(1); 

--lets alter the finction with schemabinding

ALTER FUNCTION dbo.fn_GetEmployeeNameById
(
	@Id int
)
RETURNS nvarchar(20)
WITH SCHEMABINDING
AS
BEGIN
 RETURN
	(
		SELECT Name 
		FROM dbo.tblEmp
		WHERE Id = @Id
	)
END


SELECT dbo.fn_GetEmployeeNameById(1); 

--now lets try deleting the dependent tblEmp table, it;ll throw error
DROP TABLE dbo.tblEmp; -- throws error: Cannot DROP TABLE 'dbo.tblEmp' because it is being referenced by object 'fn_GetEmployeeNameById'.

----------------------------------------------------------------------------

--*/