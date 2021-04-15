/* Mod 18 Stored Procedures

SELECT * FROM tblEmployee

--creating a stored procedure
CREATE PROCEDURE spGetEmployees
AS
BEGIN 
	SELECT Name,Gender FROM tblEmployee
END

--calling a sp
EXECUTE spGetEmployees; 
EXEC spGetEmployees; 

--sp with input params
CREATE PROC spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DeptId int
AS 
BEGIN 
	SELECT Name,Gender,DepartmentId FROM tblEmployee
	WHERE Gender = @Gender AND DepartmentId = @DeptId
END

--throws error as it expects input params
EXEC spGetEmployeesByGenderAndDepartment; 

--we can specify param name and values
EXEC spGetEmployeesByGenderAndDepartment @Gender = 'Male',@DeptId = 1;

--we can specify param name and values, then order doesn't matter
EXEC spGetEmployeesByGenderAndDepartment @DeptId = 1,@Gender = 'Male';

--we can also pass only values, but in order
EXEC spGetEmployeesByGenderAndDepartment 'Male',1;

--we can also pass only values, but in order. If not in order throws error
EXEC spGetEmployeesByGenderAndDepartment 1,'Male';


--to view sp text
exec sp_helptext 'spGetEmployeesByGenderAndDepartment';


--altering sp
ALTER PROC spGetEmployees
AS
BEGIN 
	SELECT Name,Gender FROM tblEmployee ORDER BY Name
END

EXEC spGetEmployees; 

--encrypting sp 
ALTER PROC spGetEmployees
WITH ENCRYPTION
AS
BEGIN 
	SELECT Name,Gender FROM tblEmployee ORDER BY Name
END

--once sp is encrypted, we cant view its text using sp_helptext
EXEC sp_helptext 'spGetEmployees';


--deleting sp
DROP PROC spGetEmployees;


--*/


/* mod 19 SP with output params

CREATE PROC spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmpCount int OUT
AS 
BEGIN 
	SELECT @EmpCount = COUNT(Id)
	FROM tblEmployee
	WHERE Gender = @Gender
END


--exec sp with o/p param
DECLARE @EmpTotal int --declaring var with samedatatype as that of o/p param
EXEC spGetEmployeeCountByGender 'Male',@EmpTotal OUT --if we dont specify out here then it'll have null value
PRINT @EmpTotal;

--passing var to o/p param without OUT keyword
DECLARE @EmpTotal int
EXEC spGetEmployeeCountByGender 'Male',@EmpTotal  --if we dont specify out here then it'll have null value
if(@EmpTotal IS NULL)
	PRINT '@EmpTotal is null'
ELSE 
	PRINT '@EmpTotal is not null'

-- we can also use param names to pass the inputs 
Declare @EmployeeTotal int
Execute spGetEmployeeCountByGender @EmpCount = @EmployeeTotal OUT, @Gender = 'Male'
Print @EmployeeTotal


--few system sp's

--sp_help, shows info about db obj like params, col etc.,
EXEC sp_help 'spGetEmployeeCountByGender'; --on sp, shows parama datatypes
EXEC sp_help tblEmployee;  --on table, shows col,keys etc.,

--sp_helptext, shows txt of sp
EXEC sp_helptext 'spGetEmployeeCountByGender';

--sp_depends, shows dependencies for a given db obj
EXEC sp_depends'spGetEmployeeCountByGender'; -- on sp, shows dependent tables
EXEC sp_depends tblEmployee; --on table, shows dependent sp's
 
--*/



/* mod 20 Differene between output param and Return values

SELECT * FROM tblEmployee;

--sp with output param, which has count of rows
CREATE PROC spGetTotalEmp
@TotalCount int OUT
AS 
BEGIN 
	SELECT @TotalCount = COUNT(Id) FROM tblEmployee
END

DECLARE @Count int
EXEC spGetTotalEmp @Count OUT;
SELECT @Count;

--sp wwhich returns count of rows 
CREATE PROC spGetTotalEmp1
AS 
BEGIN 
	RETURN (SELECT COUNT(Id) FROM tblEmployee)
END

DECLARE @Count int
EXEC @Count =  spGetTotalEmp1;
SELECT @Count;

--sp which returns name using out param
CREATE PROC spGetEmpNameById
@Id int,
@Name nvarchar(20) OUT
AS 
BEGIN
	SELECT @Name = Name FROM tblEmployee
	WHERE ID = @Id
END

DECLARE @EmpName nvarchar(20)
EXEC spGetEmpNameById 1, @EmpName OUT
PRINT 'Name of the Employee is ' + @EmpName;

--sp which return name(char) as return value, it fails. 
CREATE PROC spGetEmpNameById1
@Id int
AS 
BEGIN
	RETURN (SELECT Name FROM tblEmployee WHERE ID = @Id)
END

DECLARE @EmpName nvarchar(20)
EXEC @EmpName = spGetEmpNameById1 1
PRINT 'Name of the Employee is ' + @EmpName


DROP PROC spGetEmpNameById,spGetEmpNameById1,spGetTotalEmp,spGetTotalEmp1;

--*/




-- mod 21 Advantages of SP's over adhoc queries, theroy in book

