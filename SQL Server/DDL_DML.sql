
--/* CREATE,ALTER,DROP,TRUNCATE,UPDATE,INSERT,INSERT INTO SELECT,SELECT INTO & DELETE

USE SQL
GO

CREATE TABLE Test
(
	ID int NOT NULL,
	Name nvarchar(50)
)

SELECT * FROM Test;

INSERT INTO Test VALUES (1,'a'),(2,'b'),(3,'c');

--deletes row with ID = 1
DELETE FROM Test WHERE ID = 1;
--deletes all the rows
DELETE FROM Test;

INSERT INTO Test VALUES (1,'a'),(2,'b'),(3,'c');
SELECT * FROM Test;
--deletes all the rows, but table is still available
TRUNCATE TABLE Test;

--deletes
INSERT INTO Test VALUES (1,'a'),(2,'b'),(3,'c');
--deletes the table along with data
DROP TABLE Test;
-----------------------------------------------------------------------------

SELECT * FROM [SampleDB].[dbo].[tblPerson];

--creating new table based on existing table and copying the data
SELECT * INTO Test FROM [SampleDB].[dbo].[tblPerson];
SELECT * FROM Test;

--updating single col
UPDATE Test SET GenderId = 1 WHERE GenderId IS NULL;
--updating multiple col
UPDATE Test SET GenderId = 1,Age = 20 WHERE GenderId IS NULL OR Age IS NULL;
--update all the records for a given col
UPDATE Test SET City = 'Banglore';

DROP TABLE Test;

-----------------------------------------------------------------------------

--creating only table structure from other table
SELECT * INTO  Test FROM [SampleDB].[dbo].[tblPerson] WHERE 1 = 2;
SELECT * FROM Test;

--inserting data into one table from other 
INSERT INTO Test SELECT * FROM [SampleDB].[dbo].[tblPerson];
SELECT * FROM Test;

DROP TABLE Test;

-----------------------------------------------------------------------------

--creating only table structure(selected rows) from other table with data
SELECT ID,Name INTO Test FROM [SampleDB].[dbo].[tblPerson];
SELECT * FROM Test;

DROP TABLE Test;

--creating only table structure(selected rows) from other table without data
SELECT ID,Name INTO Test FROM [SampleDB].[dbo].[tblPerson] WHERE 1 = 2 ;
SELECT * FROM Test;


--INserting data into one table(existing) from other 
INSERT INTO Test SELECT ID,Name FROM [SampleDB].[dbo].[tblPerson];
SELECT * FROM Test;

TRUNCATE TABLE Test;

--adding extra column
ALTER TABLE Test
ADD Email nvarchar(50);

INSERT INTO Test(ID,Name,Email) SELECT ID,Name,Email FROM [SampleDB].[dbo].[tblPerson] 
SELECT * FROM Test;

--delteing the column
ALTER TABLE Test 
DROP COLUMN Email;

--INSERT INTO Test(Email) SELECT Email FROM [SampleDB].[dbo].[tblPerson] WHERE [SampleDB].[dbo].[Test].ID = [SampleDB].[dbo].[tblPerson].ID;

SELECT * FROM [SampleDB].[dbo].[Test];	

DROP TABLE Test;

--*/