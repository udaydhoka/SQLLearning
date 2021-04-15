/* mod 2 create,alter & drop

CREATE DATABASE SampleDB;


ALTER DATABASE SampleDB MODIFY NAME = SampleDB1;

--using system sp to rename a db
EXECUTE sp_renamedb 'SampleDB1','SampleDB';

DROP DATABASE SampleDB;

ALTER DATABASE SampleDB SET SINGLE_USER with Rollback Immediate;

*/




/* mod 3 Tables

USE [SampleDB]
GO

CREATE TABLE tblPerson
(
	ID int NOT NULL Primary Key,
	NAME nvarchar(50) NOT NULL,
	Email nvarchar(50) NOT NULL,
	GenderId int NULL
	--for defining FK while creating table
	--GenderId int NULL FOREIGN KEY REFERENCES tblGender(ID)
)

CREATE TABLE tblGender
(
	ID int NOT NULL Primary Key,
	Gender nvarchar(10) NOT NULL
)

--for defining fk on existing table
ALTER TABLE [tblPerson] ADD CONSTRAINT tblPerson_GenderId_FK
FOREIGN KEY (GenderId) references tblGender(ID);

--for defining pk on existing table
ALTER TABLE [tblPerson] ADD CONSTRAINT PK_tblPerson PRIMARY KEY (ID);

--for droping pk or fk
ALTER TABLE [tblPerson] DROP CONSTRAINT PK_tblPerson;
ALTER TABLE [tblPerson] DROP CONSTRAINT tblPerson_GenderId_FK;
*/






/* mod 4 Default Constraint 

--inserting values into the table, genderid col will have null value
INSERT INTO tblPerson (ID,Name,Email) values(7,'Rich','r@r.com')

--adding default contraint
ALTER TABLE tblPerson
ADD CONSTRAINT DF_tblPerson_GenderId
DEFAULT 3 FOR GenderId;

--below insert will have 3 for Genderid col as its default
INSERT INTO tblPerson (ID,Name,Email) values(8,'Mike','Mike@r.com');
--below insert will have 2 for genderId, as default will be overridden 
INSERT INTO tblPerson (ID,Name,Email,GenderId) values(5,'Sara','sara@r.com',2);
-- here the generid will have null not default, as we're supplying a value, doesnt matter if its null or not null
INSERT INTO tblPerson (ID,Name,Email,GenderId) values(6,'Jony','sara@r.com',NULL);

*/






/* mod 5 Cascading Referential Integrity Constraint 

 --throws error, as its id is fk for genderid in tblperson
DELETE FROM tblGender where ID = 1;
--set action to default and run 
DELETE FROM tblGender where ID = 1;

select * from tblGender;
select * from tblPerson;

--set action to null and run 
DELETE FROM tblGender where ID = 2;

select * from tblGender;
select * from tblPerson;

--set action to cascade and run 
DELETE FROM tblGender where ID = 3;

select * from tblGender;
select * from tblPerson;
*/






/* mod 6 check constraint
SELECT * FROM tblPerson;
SELECT * FROM tblGender;

INSERT INTO tblGender VALUES(1,'Male'),(2,'Female'),(3,'Unknown');

ALTER TABLE tblPerson ADD Age int;

ALTER TABLE tblPerson ADD CONSTRAINT CK_tblPerson_Age CHECK (Age>0 AND Age < 150);
--below query throws error due to check constraint
INSERT INTO tblPerson VALUES(1,'Mark','m@m.com',1,-1);
--this will execute
INSERT INTO tblPerson VALUES(3,'Mike','m@m.com',1,61);

--to drop a constraint
ALTER TABLE tblPerson DROP CONSTRAINT CK_tblPerson_Age;
--*/






/* mod 7 Identity Column

SELECT * FROM tblPerson;

INSERT INTO tblPerson VALUES(4,'cath','c@c.com',2,32);

CREATE TABLE tblPerson1
(
	PersonID int IDENTITY(1,1) PRIMARY KEY,
	Name nvarchar(20)
)

SELECT * FROM tblPerson1;

INSERT INTO [dbo].[tblPerson1] VALUES('Uday');
INSERT INTO [dbo].[tblPerson1] VALUES('Kumar');
INSERT INTO [dbo].[tblPerson1] VALUES('kuruda');

DELETE FROM tblPerson1 WHERE PersonID = 2;
--here id 2 isn't reassigned to jane, rather a new one is used
INSERT INTO [dbo].[tblPerson1] VALUES('jane');
--we cant do this, throws error
--INSERT INTO [dbo].[tblPerson1] VALUES(2,'jane');

--condition to insert values in identity col
SET IDENTITY_INSERT tblPerson1 ON;
--we'd use col list in query while inserting value into identity col
INSERT INTO [dbo].[tblPerson1] (PersonID,Name) VALUES(2,'Todd');

--throws error as Explicit value must be specified for identity column in table 'tblPerson1' either when IDENTITY_INSERT is set to ON
INSERT INTO [dbo].[tblPerson1] VALUES('kuruva');

--we need to set IDENTITY_INSERT before using implicit values 
SET IDENTITY_INSERT tblPerson1 OFF;

INSERT INTO [dbo].[tblPerson1] VALUES('kuruva');

DELETE FROM tblPerson1;

SELECT * FROM tblPerson1;
--it gets next identity, but wont reset it 
INSERT INTO [dbo].[tblPerson1] VALUES('Uday');

--to reset we'd use DBCC
DBCC CHECKIDENT('tblPerson1',RESEED,0);

INSERT INTO [dbo].[tblPerson1] VALUES('Uday');
SELECT * FROM tblPerson1;

DROP TABLE tblPerson1;

--*/




/* mod 8 retrieving identity col values
CREATE TABLE Test1
(
	ID int IDENTITY,
	Value nvarchar(20)
)
CREATE TABLE Test2
(
	ID int IDENTITY,
	Value nvarchar(20)
)

INSERT INTO Test1 VALUES('X');
SELECT * FROM Test1;

--to retrive last generated identity col value
SELECT SCOPE_IDENTITY();
--both gives same value
SELECT @@IDENTITY;

--creating a trigger to insert data in test2 table, when data is inserted on test1 table
CREATE TRIGGER trForInsert ON Test1 FOR INSERT
AS 

BEGIN
	INSERT INTO Test2 VALUES('yy');
END

SELECT * FROM Test1;
SELECT * FROM Test2;

INSERT INTO Test2 VALUES('z');

--to retrive last generated identity col value
SELECT SCOPE_IDENTITY();

SELECT @@IDENTITY;

SELECT IDENT_CURRENT('Test2');

DROP TABLE Test1,Test2;

--*/




/* mod 9 Unique key Constraint

select * from tblPerson;

--creating unique constraint
ALTER TABLE tblPerson ADD CONSTRAINT UQ_tblPerson_Email 
UNIQUE (Email);

INSERT INTO tblPerson VALUES (8,'ABC','A@a.com',1,20);

--throws error as we're passing duplicate values to the email col
INSERT INTO tblPerson VALUES (9,'XYZ','A@a.com',1,20);

--dropping a unique constraint
ALTER TABLE tblPerson DROP CONSTRAINT UQ_tblPerson_Email;

--*/




/* mod 10 SELECT 
ALTER TABLE tblPerson ADD CIty nvarchar(50);

UPDATE tblPerson SET City = 'Mumbai' WHERE Name like 'M%';
UPDATE tblPerson SET City = 'Calculta' WHERE Name like 'c%';
UPDATE tblPerson SET City = 'Agra' WHERE Name like 'A%';
UPDATE tblPerson SET City = 'Delhi' WHERE Name like 'S%';
UPDATE tblPerson SET City = 'Mumbai' WHERE Name like 'M%';
UPDATE tblPerson SET City = 'Jodhpur' WHERE Name like 'J%';


SELECT * FROM tblPerson;

SELECT ID,Name,City FROM [SampleDB].[dbo].[tblPerson];

SELECT DISTINCT City FROM [SampleDB].[dbo].[tblPerson];

SELECT DISTINCT Name,City FROM [SampleDB].[dbo].[tblPerson];

SELECT * FROM tblPerson WHERE City = 'Mumbai';
-- <> is similar to !=
SELECT * FROM tblPerson WHERE City <> 'Mumbai';

SELECT * FROM tblPerson WHERE Age IN (32,20);

SELECT * FROM tblPerson WHERE Age BETWEEN 20 AND 35;

SELECT * FROM tblPerson WHERE City LIKE 'M%';

SELECT * FROM tblPerson WHERE City NOT LIKE 'M%';

SELECT * FROM tblPerson WHERE Email LIKE '%@%';

SELECT * FROM tblPerson WHERE Email LIKE '_@_.com';

SELECT * FROM tblPerson WHERE Name LIKE '[MSYT]%';

SELECT * FROM tblPerson WHERE Name LIKE '[^MSYT]%';

SELECT * FROM tblPerson WHERE (City = 'Mumbai' OR City = 'Agra') AND Age > 20;

SELECT * FROM tblPerson ORDER BY Age; --by default its ascending order

SELECT * FROM tblPerson ORDER BY Age DESC;

SELECT * FROM tblPerson ORDER BY City DESC, Age ASC;

SELECT TOP 2 * FROM tblPerson;

SELECT TOP 2 ID,Name FROM tblPerson;

SELECT TOP 2 PERCENT * FROM tblPerson;

SELECT TOP 50 PERCENT ID,Name FROM tblPerson;

--finding eldest person in the table
SELECT TOP 1 * FROM tblPerson ORDER BY Age DESC;

--*/ 


/* mod 11 Group BY 

CREATE TABLE tblEmployees
(
	ID int IDENTITY PRIMARY KEY,
	Name nvarchar(255) NOT NULL,
	Gender nvarchar(10) NOT NULL,
	Salary int NOT NULL,
	City nvarchar(255) 
)

INSERT INTO tblEmployees 
VALUES ('Tom','Male',4000,'London')
	  ,('Pam','FeMale',3000,'New York')
	  ,('John','Male',3500,'London')
	  ,('Sam','Male',4500,'London')
	  ,('Todd','Male',2800,'Sydney')
	  ,('Ben','Male',7000,'New York')
	  ,('Sara','FeMale',4300,'Sydney')
	  ,('Valarie','FeMale',5500,'New York')
	  ,('James','Male',6500,'London')
	  ,('Rusell','Male',8800,'London');

SELECT * FROM tblEmployees;

--aggregare functions
SELECT COUNT(Salary) FROM tblEmployees;
SELECT AVG(Salary) FROM tblEmployees;
SELECT MIN(Salary) FROM tblEmployees;
SELECT MAX(Salary) FROM tblEmployees;
SELECT SUM(Salary) FROM tblEmployees;

--GROUP BY
SELECT City,SUM(Salary) AS TotalSalary
FROM tblEmployees 
GROUP BY City;

--throws error
--SELECT ID,SUM(Salary) AS TotalSalary
--FROM tblEmployees 
--GROUP BY City;

--throws error
--SELECT City,SUM(Salary) AS TotalSalary
--FROM tblEmployees 

--group by multiple columns
SELECT City,Gender,SUM(Salary) AS TotalSalary
FROM tblEmployees 
GROUP BY City,Gender
ORDER BY City;

----group by multiple columns and multiple aggregate func
SELECT City,Gender,SUM(Salary) AS TotalSalary, COUNT(ID) AS [Total Employees]
FROM tblEmployees 
GROUP BY City,Gender
ORDER BY City;

--filtering groups using where 
SELECT City,Gender,SUM(Salary) AS TotalSalary, COUNT(ID) AS [Total Employees]
FROM tblEmployees 
WHERE Gender = 'Male'
GROUP BY City,Gender
ORDER BY City;

--filtering groups using having 
SELECT City,Gender,SUM(Salary) AS TotalSalary, COUNT(ID) AS [Total Employees]
FROM tblEmployees 
GROUP BY City,Gender
HAVING Gender = 'Male'
ORDER BY City;

--aggregate functions cant be used in where clause, throws error
--SELECT * FROM tblEmployees 
--WHERE SUM(Salary) > 500 

-- can be used in having class 
SELECT City,Gender,SUM(Salary) AS TotalSalary, COUNT(ID) AS [Total Employees]
FROM tblEmployees 
GROUP BY City,Gender
HAVING SUM(Salary) > 4500
ORDER BY City;

DROP TABLE tblEmployees;

--*/


