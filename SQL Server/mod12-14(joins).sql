--/* mod 12 Joins
USE SampleDBDB
GO
CREATE TABLE tblDepartment
(
	ID int PRIMARY KEY,
	DepartmentName nvarchar(50),
	Location nvarchar(50),
	DepartmentHead nvarchar(50)
)
Go

Insert into tblDepartment values (1, 'IT', 'London', 'Rick')
Insert into tblDepartment values (2, 'Payroll', 'Delhi', 'Ron')
Insert into tblDepartment values (3, 'HR', 'New York', 'Christie')
Insert into tblDepartment values (4, 'Other Department', 'Sydney', 'Cindrella')
Go

CREATE TABLE tblEmployee
(
     ID int PRIMARY KEY,
     Name nvarchar(50),
     Gender nvarchar(50),
     Salary int,
     DepartmentId int FOREIGN KEY REFERENCES tblDepartment(Id)
)
Go

Insert into tblEmployee values (1, 'Tom', 'Male', 4000, 1)
Insert into tblEmployee values (2, 'Pam', 'Female', 3000, 3)
Insert into tblEmployee values (3, 'John', 'Male', 3500, 1)
Insert into tblEmployee values (4, 'Sam', 'Male', 4500, 2)
Insert into tblEmployee values (5, 'Todd', 'Male', 2800, 2)
Insert into tblEmployee values (6, 'Ben', 'Male', 7000, 1)
Insert into tblEmployee values (7, 'Sara', 'Female', 4800, 3)
Insert into tblEmployee values (8, 'Valarie', 'Female', 5500, 1)
Insert into tblEmployee values (9, 'James', 'Male', 6500, NULL)
Insert into tblEmployee values (10, 'Russell', 'Male', 8800, NULL)
Go



SELECT * FROM tblDepartment;
SELECT * FROM tblEmployee;

--INNER JOIN
SELECT Name,Gender,Salary,DepartmentName
FROM tblEmployee
INNER JOIN tblDepartment
ON tblEmployee.DepartmentId = tblDepartment.ID;

--LEFT OUTER JOIN (or) LEFT JOIN
SELECT Name,Gender,Salary,DepartmentName
FROM tblEmployee
LEFT JOIN tblDepartment
ON tblEmployee.DepartmentId = tblDepartment.ID;

--RIGHT OUTER JOIN (or) RIGHT JOIN
SELECT Name,Gender,Salary,DepartmentName
FROM tblEmployee
RIGHT JOIN tblDepartment
ON tblEmployee.DepartmentId = tblDepartment.ID;

--FULL OUTER JOIN (or) FULL JOIN
SELECT Name,Gender,Salary,DepartmentName
FROM tblEmployee
FULL JOIN tblDepartment
ON tblEmployee.DepartmentId = tblDepartment.ID;

--CROSS JOIN 
SELECT Name,Gender,Salary,DepartmentName
FROM tblEmployee
CROSS JOIN tblDepartment

--*/



--/*mod 13 Advanced joins

--LEFT JOIN - INNER JOIN 
SELECT Name,Gender,Salary,DepartmentName
FROM tblEmployee E
LEFT JOIN tblDepartment D
ON E.DepartmentId = D.ID
WHERE D.ID IS NULL;

--RIGHT JOIN -INNER JOIN
SELECT Name,Gender,Salary,DepartmentName
FROM tblEmployee E
RIGHT JOIN tblDepartment D
ON E.DepartmentId = D.ID
WHERE E.DepartmentId IS NULL; 


--FULL JOIN - INNER JOIN
SELECT Name,Gender,Salary,DepartmentName
FROM tblEmployee E
FULL JOIN tblDepartment D
ON E.DepartmentId = D.ID
WHERE E.DepartmentId IS NULL 
OR D.ID IS NULL; 

--*/


--/* mod 14 SELF Joins

CREATE TABLE tblEmployees
(
	EmployeeID int,
	Name nvarchar(50),
	ManagerID int
)

INSERT INTO tblEmployees 
VALUES (1,'Mike',3)
	  ,(2,'Rob' ,1)
	  ,(3,'Todd',NULL)
	  ,(4,'Ben',1)
	  ,(5,'Sam',1);

SELECT * FROM tblEmployees;
SELECT * FROM tblEmployees;

--self inner join
SELECT E.Name AS Employee, M.Name as Manager
FROM tblEmployees E 
INNER JOIN tblEmployees M
ON  E.ManagerID = M.EmployeeID;

--self left join
SELECT E.Name AS Employee, M.Name as Manager
FROM tblEmployees E 
LEFT JOIN tblEmployees M
ON  E.ManagerID = M.EmployeeID;

--self right join
SELECT E.Name AS Employee, M.Name as Manager
FROM tblEmployees E 
RIGHT JOIN tblEmployees M
ON  E.ManagerID = M.EmployeeID;

--self FULL join
SELECT E.Name AS Employee, M.Name as Manager
FROM tblEmployees E 
FULL JOIN tblEmployees M
ON  E.ManagerID = M.EmployeeID;

--self CROSS join
SELECT E.Name AS Employee, M.Name as Manager
FROM tblEmployees E 
CROSS JOIN tblEmployees M;



--*/










