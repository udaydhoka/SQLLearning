
--/* mod 25,26,27 DateTime Functions

----------------------------------------------------------------

--tbl with all date & time datatypes
CREATE TABLE [tblDateTime]
(
 [c_time] [time](7) NULL,
 [c_date] [date] NULL,
 [c_smalldatetime] [smalldatetime] NULL,
 [c_datetime] [datetime] NULL,
 [c_datetime2] [datetime2](7) NULL,
 [c_datetimeoffset] [datetimeoffset](7) NULL
);

EXEC sp_help tblDateTime;

SELECT * FROM tblDateTime;

----------------------------------------------------------------

SELECT GETDATE(), 'GETDATE()';

INSERT INTO tblDateTime VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE());
SELECT * FROM tblDateTime;

----------------------------------------------------------------

SELECT CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP';

UPDATE tblDateTime SET c_datetime = CURRENT_TIMESTAMP;
SELECT * FROM tblDateTime;

----------------------------------------------------------------

SELECT SYSDATETIME(), 'SYSDATETIME()';

UPDATE tblDateTime SET c_datetime2 = SYSDATETIME();
SELECT * FROM tblDateTime;

----------------------------------------------------------------

SELECT SYSDATETIMEOFFSET(), 'SYSDATETIMEOFFSET()';

UPDATE tblDateTime SET c_datetimeoffset = SYSDATETIMEOFFSET();
SELECT * FROM tblDateTime;

----------------------------------------------------------------


SELECT GETUTCDATE(), 'GETUTCDATE()';

----------------------------------------------------------------

SELECT SYSUTCDATETIME(), 'SYSUTCDATETIME()';

----------------------------------------------------------------
DROP TABLE tblDateTime;
----------------------------------------------------------------

--ISDATE() 
SELECT ISDATE('uday'); --o/p is 0

SELECT ISDATE(GETDATE()); --o/p is 1

SELECT ISDATE(SYSDATETIME()); -- error: Argument data type datetime2 is invalid for argument 1 of isdate function.

SELECT ISDATE(SYSDATETIMEOFFSET()); -- error : Argument data type datetimeoffset is invalid for argument 1 of isdate function.

SELECT ISDATE('2020-06-22 08:12:24.0969993'); -- o/p 0 as its datetime2 value

SELECT ISDATE('2020-06-22 08:12:24.096'); --o/p 1 as its datetime value

SELECT ISDATE('2020-06-22'); --o/p 1 as its date value

SELECT ISDATE('08:12:24.0969993'); --o/p 0 as its time value, but with 7 dig nano seconds 

SELECT ISDATE('08:12:24.096'); --o/p 1 as its time value

SELECT ISDATE('2020-06-22 13:49:22.1107773 +05:30'); -- o/p 0, as its datetimeoffset value

----------------------------------------------------------------

--DAY()
SELECT DAY(GETDATE());

SELECT DAY('2020-06-22');

SELECT DAY('2020/06/22');

SELECT DAY('06/22/2012');

SELECT DAY('2020-06-22 13:49:22.1107773 +05:30');

SELECT DAY(SYSDATETIME());

SELECT DAY(SYSDATETIMEOFFSET());

----------------------------------------------------------------

--MONTH()

SELECT MONTH(GETDATE());

SELECT MONTH('2020-06-22');

SELECT MONTH('2020/06/22');

SELECT MONTH('06/22/2012');

SELECT MONTH('2020-06-22 13:49:22.1107773 +05:30');

SELECT MONTH(SYSDATETIME());

SELECT MONTH(SYSDATETIMEOFFSET());

----------------------------------------------------------------

--YEAR()

SELECT YEAR(GETDATE());

SELECT YEAR('2020-06-22');

SELECT YEAR('2020/06/22');

SELECT YEAR('06/22/2012');

SELECT YEAR('2020-06-22 13:49:22.1107773 +05:30');

SELECT YEAR(SYSDATETIME());

SELECT YEAR(SYSDATETIMEOFFSET());

----------------------------------------------------------------

--DATENAME(DatePart,date) returns nvarchar

SELECT DATENAME(Day, '2012-09-30 12:43:46.837');
SELECT DATENAME(WEEKDAY, '2012-09-30');
SELECT DATENAME(MONTH, '2012-09-30 12:43:46');
SELECT DATENAME(HOUR, '12:43:46');

SELECT DATENAME(YEAR,GETDATE());
--or
SELECT DATENAME(YY,GETDATE());
--or
SELECT DATENAME(YYYY,GETDATE());


SELECT DATENAME(QUARTER,GETDATE());
--OR
SELECT DATENAME(QQ,GETDATE());
--OR
SELECT DATENAME(Q,GETDATE());


SELECT DATENAME(MONTH,GETDATE());
--OR
SELECT DATENAME(MM,GETDATE());
--OR
SELECT DATENAME(M,GETDATE());


SELECT DATENAME(DAYOFYEAR,GETDATE());
--OR
SELECT DATENAME(DY,GETDATE());
--OR
SELECT DATENAME(Y,GETDATE());


SELECT DATENAME(DAY,GETDATE());
--OR
SELECT DATENAME(DD,GETDATE());
--OR
SELECT DATENAME(D,GETDATE());


SELECT DATENAME(WEEK,GETDATE());
--OR
SELECT DATENAME(WK,GETDATE());
--OR
SELECT DATENAME(WW,GETDATE());


SELECT DATENAME(WEEKDAY,GETDATE());
--OR
SELECT DATENAME(W,GETDATE());
--OR
SELECT DATENAME(DW,GETDATE());


SELECT DATENAME(HOUR,GETDATE());
--OR
SELECT DATENAME(HH,GETDATE());


SELECT DATENAME(MINUTE,GETDATE());
--OR
SELECT DATENAME(MI,GETDATE());
--OR
SELECT DATENAME(N,GETDATE());


SELECT DATENAME(SECOND,GETDATE());
--OR
SELECT DATENAME(SS,GETDATE());
--OR
SELECT DATENAME(S,GETDATE());


SELECT DATENAME(MILLISECOND,GETDATE());
--OR
SELECT DATENAME(MS,GETDATE());


SELECT DATENAME(MICROSECOND,GETDATE());
--OR
SELECT DATENAME(MCS,GETDATE());


SELECT DATENAME(NANOSECOND,GETDATE());
--OR
SELECT DATENAME(NS,GETDATE());


SELECT DATENAME(TZOFFSET,SYSDATETIMEOFFSET());
--OR
SELECT DATENAME(TZ,SYSDATETIMEOFFSET());



CREATE TABLE tblEmp
(
	Id int,
	Name nvarchar(50),
	DOB datetime
);

INSERT INTO tblEmp
VALUES (1,'Sam','2012-09-01 11:49:46.837')
	  ,(2,'Pam','2007-01-07 12:41:46.837')
	  ,(3,'Jam','2000-07-25 09:40:46.837')
	  ,(4,'Ram','1990-04-09 05:03:46.837');

SELECT * FROM tblEmp;

SELECT Name
	  ,DOB
	  ,DATENAME(WEEKDAY,DOB) AS [DAY]
	  ,MONTH(DOB) AS [MONTH NUMBER]
	  ,DATENAME(MONTH,DOB) AS [MONTH NAME]
	  ,DATENAME(YEAR,DOB) AS [YEAR]
FROM tblEmp;

EXEC sp_rename '[SampleDB].[dbo].[tblEmp]', 'tblDateFunc' ;

SELECT * FROM [SampleDB].[dbo].[tblDateFunc];

----------------------------------------------------------------

--DATEPART(DatePart,Date), sames as DATENAME() except it returns the int values

SELECT DATEPART(Day, '2012-09-30 12:43:46.837');
SELECT DATEPART(WEEKDAY, '2012-09-30');
SELECT DATEPART(MONTH, '2012-09-30 12:43:46');
SELECT DATEPART(HOUR, '12:43:46');

SELECT DATEPART(DAYOFYEAR,GETDATE());
SELECT DATEPART(WEEK,GETDATE());
SELECT DATEPART(QUARTER,GETDATE());


----------------------------------------------------------------

--DATEADD(Datepart,NummberToAdd,Date)

SELECT DATEADD(MINUTE,-30,GETDATE());

SELECT DATEADD(MONTH,2,'2012-09-30 12:43:46');

SELECT DATEADD(MINUTE,30,GETDATE());

SELECT DATEADD(DAY,-3,GETDATE());

----------------------------------------------------------------

--DATEDIFF(Datepart,startdate,enddate)

SELECT DATEDIFF(DAY,'06/22/2019','06/22/2020');

SELECT DATEDIFF(WEEK,'06/22/2019','06/22/2020');

SELECT DATEDIFF(MONTH,'06/22/2019','06/22/2020');

SELECT DATEDIFF(YEAR,'06/22/2019','06/22/2020');

SELECT DATEDIFF(HOUR,DATEADD(MONTH,-3,GETDATE()),GETDATE());

--loop hole in the diff func, though its not one year. but the func considers only year value
SELECT DATEDIFF(YEAR,'12/30/2019','01/01/2020');
--same goes with month
SELECT DATEDIFF(MONTH,'12/30/2019','01/01/2020');

----------------------------------------------------------------

--Age Calculation function

CREATE FUNCTION fnComputeAge(@DOB datetime)
RETURNS nvarchar(50)
BEGIN

DECLARE @tempdate datetime, @years int, @months int, @days int

SELECT @tempdate = @DOB

SELECT @years = DATEDIFF(YEAR, @tempdate, GETDATE()) -
				CASE 
					WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR 
						 (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE()))
					THEN 1
					ELSE 0
				END
SELECT @tempdate = DATEADD(YEAR,@years,@tempdate)

SELECT @months = DATEDIFF(MONTH,@tempdate,GETDATE()) -
				 CASE 
					WHEN DAY(@DOB) > DAY(GETDATE())
					THEN 1
					ELSE 0
				 END
SELECT @tempdate = DATEADD(MONTH,@months,@tempdate)

SELECT @days = DATEDIFF(DAY,@tempdate,GETDATE())

	DECLARE @Age nvarchar(50)
	SET @Age = CAST(@years as nvarchar(4)) + ' Years ' 
			  +CAST(@months as nvarchar(2)) + ' Months ' 
			  +CAST(@days AS nvarchar(2)) + ' Days Old'

	RETURN @Age

END



SELECT dbo.fnComputeAge('08/11/1993');


SELECT Id,Name,DOB,dbo.fnComputeAge(DOB) AS Age
FROM tblDateFunc;

----------------------------------------------------------------

--*/