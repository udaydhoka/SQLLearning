--/* mod 15 Ways to Replace NULL


SELECT * FROM tblEmployees;
SELECT * FROM tblEmployees;

--self LEFT join
SELECT E.Name AS Employee, M.Name as Manager
FROM tblEmployees E 
LEFT JOIN tblEmployees M
ON  E.ManagerID = M.EmployeeID;

--above out has null, which can replaced in three ways

-- 1 using ISNULL()
SELECT ISNULL(NULL,'NO Name') AS COL;
SELECT ISNULL('uday','No Name') AS COL;

 SELECT E.Name AS Employee, ISNULL(M.Name,'No Manager') as Manager
FROM tblEmployees E 
LEFT JOIN tblEmployees M
ON  E.ManagerID = M.EmployeeID;

-- 2 using CASE statement
SELECT  E.Name AS Employee,
	    CASE 
			WHEN M.Name IS NULL THEN 'No Manager' ELSE M.Name
		END 
		AS Manager
FROM tblEmployees E 
LEFT JOIN tblEmployees M
ON  E.ManagerID = M.EmployeeID;

--3 using COALESCE()
SELECT COALESCE('Name','No Manager') AS COL;
SELECT COALESCE(NULL,'No Manager') AS COL;

SELECT E.Name AS Employee, COALESCE(M.Name,'No Manager')as Manager
FROM tblEmployees E 
LEFT JOIN tblEmployees M
ON  E.ManagerID = M.EmployeeID;

DROP TABLE tblEmployees

--*/



/* Mod 16 COALESCE 

--it returns first non-null value
--we can pass as many parameters to it 

SELECT COALESCE(NULL,'Kumar','Kuruva') AS COL; -- returns Kumar, as its first non-null value
SELECT COALESCE('Uday',NULL,'Kuruva') AS COL; -- returns uday, as its first non-null value
SELECT COALESCE(NULL,NULL,'Kuruva') AS COL; -- returns kuruva, as its first non-null value
SELECT COALESCE('Uday',NULL,NULL) AS COL; --returns uday, as its first non-null value
SELECT COALESCE('Uday','Kumar',NULL) AS COL; --returns uday, as its first non-null value
SELECT COALESCE('Uday','Kumar','Kuruva') AS COL; --returns uday, as its first non-null value


CREATE TABLE tblNames
(
	Id int,
	FirstName nvarchar(50),
	MiddleName nvarchar(50),
	LastName nvarchar(50)
)

INSERT INTO tblNames 
VALUES (1,'Uday',NULL,NULL)
	  ,(2,NULL,'Kumar','Kuruva')
	  ,(3,NULL,NULL,'Kuruva')
	  ,(4,'Uday',NULL,NULL)
	  ,(5,'Uday','Kumar',NULL)
	  ,(6,'Uday','Kumar','Kuruva');

SELECT * FROM tblNames;

SELECT Id,COALESCE(FirstName,MiddleName,LastName) AS Name
FROM tblNames;

DROP TABLE tblNames;

--*/