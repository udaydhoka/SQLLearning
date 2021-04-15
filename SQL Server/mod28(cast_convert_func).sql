
--/* mod 28 Cast and Convert Functions

SELECT * FROM tblDateFunc;

----------------------------------------------------------------------------------

--using CAST(exp AS datatype[(len)])

SELECT Id,Name,DOB, CAST(DOB AS nvarchar) AS ConvertedDOB 
FROM tblDateFunc;

SELECT Id,Name,DOB, CAST(DOB AS nvarchar(4)) AS ConvertedDOB  ---len for datatype is optional
FROM tblDateFunc;

SELECT CAST(GETDATE() AS DATE); -- to get only date
SELECT CAST(GETDATE() AS TIME); -- to get only time

--Concatenate int and name
SELECT Id,Name, Name + '-'+ Id  AS [Name-Id]  --throws error, we need to cast int(id) to chars
FROM tblDateFunc;

SELECT Id,Name, Name + '-'+ CAST(Id AS nvarchar) AS [Name-Id] 
FROM tblDateFunc;

----------------------------------------------------------------------------------

--using CONVERT(datatype[(len)],exp[,style])

SELECT Id,Name,DOB,CONVERT(nvarchar,DOB) AS ConvertedDOB 
FROM tblDateFunc;

SELECT Id,Name,DOB,CONVERT(nvarchar(4),DOB) AS ConvertedDOB 
FROM tblDateFunc;

SELECT Id,Name,DOB,CONVERT(nvarchar,DOB,101) AS ConvertedDOB  --using 101 for style param which gets only datepart
FROM tblDateFunc;

SELECT Id,Name,DOB,CONVERT(nvarchar,DOB,103) AS ConvertedDOB  --using 101 for style param which gets only datepart
FROM tblDateFunc;

SELECT CONVERT(DATE,GETDATE());  -- to get only date
SELECT CONVERT(TIME,GETDATE());  -- to get only time

SELECT CONVERT(DATE,GETDATE(),103); --style format is ignored here, as the datatype tobe converted isnt nvarchar


----------------------------------------------------------------------------------

--practical example of cast
SELECT * FROM tblPerson;

---creating new table from existing table and also copying data from it
SELECT Id,Name,Email INTO tblRegistrations FROM tblPerson;

SELECT * FROM  tblRegistrations;

--adding colum with datetime for date of registration
ALTER TABLE tblRegistrations
ADD RegisteredDate datetime NOT NULL DEFAULT GETDATE();

SELECT * FROM  tblRegistrations;

--updating the datetime col with different datetime
UPDATE tblRegistrations
SET RegisteredDate = DATEADD(DAY,3,GETDATE()) WHERE Name like '[a-j]%'

UPDATE tblRegistrations
SET RegisteredDate = DATEADD(DAY,3,GETDATE()) WHERE Name like 'abc%'

--updating the datetime col with different datetime
DECLARE @id int
SET @id = 1
WHILE(@id <= 8)
	BEGIN
		UPDATE tblRegistrations SET RegisteredDate = DATEADD(MINUTE,@id,RegisteredDate) WHERE ID = @id
		SET @id = @id + 1
	END

SELECT * FROM  tblRegistrations;
--table creation with data is complted

--query to list the registration per day using group by
SELECT RegisteredDate, COUNT(RegisteredDate) AS Number 
FROM tblRegistrations
GROUP BY RegisteredDate;
--the above query doesnt give the desired results, as we are grouping by for datetime col, it'll consider ss& nnn as well
--so, we need to cast it to date type and then group it 

SELECT CAST(RegisteredDate AS DATE) AS RegisteredDate , COUNT(RegisteredDate) AS TotalRegistrations 
FROM tblRegistrations
GROUP BY CAST(RegisteredDate AS DATE);

----------------------------------------------------------------------------------

--*/