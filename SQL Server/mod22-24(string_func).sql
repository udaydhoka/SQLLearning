--/* mod 22,23,24 String functions

-----------------------------------------------------------

--ASCII(char_exp) , input should be only valid ascii values
SELECT ASCII('A');

SELECT ASCII('ABC'); --returns ascii of first char

-----------------------------------------------------------

--CHAR(int_exp), 0<int_exp<255
SELECT CHAR(65);

SELECT CHAR(656);  --returns null if invalid ascill value is passed

--prints all acsii values
DECLARE @Number int
SET @Number = 1
WHILE(@Number <= 255)
BEGIN 
	PRINT CHAR(@Number)
	SET @Number = @Number + 1
END

--prints all the uppercase alphabet
DECLARE @Number1 int
SET @Number1 = 65
WHILE(@Number1 <= 90)
BEGIN 
	PRINT CHAR(@Number1)
	SET @Number1 = @Number1 + 1
END

--prints all the lowercase alphabet
DECLARE @Number2 int
SET @Number2 = 97
WHILE(@Number2 <= 122)
BEGIN 
	PRINT CHAR(@Number2)
	SET @Number2 = @Number2 + 1
END

-----------------------------------------------------------

--LTRIM(char_exp) & RTIRM(cahr_exp)

SELECT LTRIM('  Hello');

SELECT RTRIM('Hello   ');

SELECT LTRIM(RTRIM('  Hello   '));

SELECT * FROM tblNames;

SELECT  LTRIM(RTRIM( FirstName + ' ' + MiddleName + ' ' + LastName)) AS FullName
FROM tblNames;

SELECT Name, LTRIM(RTRIM(Name)) AS Name 
FROM tblEmployee;
-----------------------------------------------------------

--LOWER(char_exp) and UPPER(char_exp)

SELECT LOWER('CONVERT This String Into Lower Case');

SELECT Name, LOWER(Name) AS NameInSmalls
FROM tblEmployee;

SELECT UPPER('CONVERT This String Into upper Case');

SELECT * FROM tblEmployee;

SELECT Name, UPPER(Name) AS NameInCaps 
FROM tblEmployee;

-----------------------------------------------------------

--REVERSE(string_exp)
SELECT REVERSE('ABCDEFGHIJKLMNOPQRSTUVWXYZ');

SELECT REVERSE('ABC D');

SELECT Name, REVERSE(Name) AS NameReversed 
FROM tblEmployee;

-----------------------------------------------------------

--LEN(string_exp), it doesn't count blank spaces at the end
Select LEN('SQL Functions');

SELECT LEN('SQL Functions   ');

SELECT Name, LEN(Name) AS NameLength 
FROM tblEmployee;

-----------------------------------------------------------

--LEFT(Character_Expression, Integer_Expression) & RIGHT(Character_Expression, Integer_Expression)

SELECT LEFT('ABCDE', 3);

SELECT LEFT('AB CDE', 3);

SELECT RIGHT('ABCDE', 3);

SELECT RIGHT('AB CDE', 3);

-----------------------------------------------------------

--CHARINDEX('Expression_To_Find', 'Expression_To_Search', 'Start_Location') 

SELECT CHARINDEX('@','uday@u.com',1);

SELECT CHARINDEX('@','ud@y@u.com',4);

SELECT CHARINDEX('u','kumar');

SELECT CHARINDEX('u','kumar',1);

SELECT * FROM tblPerson;

SELECT Email, CHARINDEX('@',Email) AS Position
FROM tblPerson;


-----------------------------------------------------------

--SUBSTRING('Expression', 'Start', 'Length')

SELECT SUBSTRING('uday@u.com',6,5); --hardcode values, below is extracting values dynamically

SELECT SUBSTRING('uday@u.com'
				,(CHARINDEX('@','uday@u.com')+1)
				,(LEN('uday@u.com')-CHARINDEX('@','uday@u.com')));


SELECT * FROM tblPerson;

--getting count of email domains 
SELECT SUBSTRING(Email
				 ,(CHARINDEX('@',Email)+1)
				 ,(LEN(Email)-CHARINDEX('@',Email)))  AS EmailDomain, COUNT(Email)
FROM tblPerson
GROUP BY SUBSTRING(Email,(CHARINDEX('@',Email)+1),(LEN(Email)-CHARINDEX('@',Email)));


-----------------------------------------------------------

--REPLICATE(String_To_Be_Replicated, Number_Of_Times_To_Replicate)
SELECT REPLICATE('Uday',3);

SELECT * FROM tblPerson;

SELECT Name,Email FROM tblPerson;
--masking email values
SELECT Name
	  ,SUBSTRING(Email,1,2) 
		+ REPLICATE('*',5) 
		+ SUBSTRING(Email, CHARINDEX('@',Email), LEN(Email) - CHARINDEX('@',Email)+1) AS Email
FROM tblPerson;


-----------------------------------------------------------

--SPACE(Number_Of_Spaces)

SELECT 'Hello' + SPACE(5) + 'World';

SELECT * FROM tblNames;

Select FirstName + SPACE(1) + MiddleName + SPACE(1) + LastName as FullName
From tblNames;


-----------------------------------------------------------

--PATINDEX('%Pattern%', Expression), returns zero if pat doesnt match

SELECT PATINDEX('%.com','uday@dhoka.com');

SELECT PATINDEX('%.c.om','uday@dhoka.com');

SELECT * FROM tblPerson;

SELECT Email, PATINDEX('%m.com',Email) AS [First Occurance]
FROM tblPerson;

--to diplay non-zero results
SELECT Email, PATINDEX('%m.com',Email) AS [First Occurance]
FROM tblPerson
WHERE PATINDEX('%m.com',Email) > 0;

-----------------------------------------------------------

--REPLACE(String_Expression, Pattern , Replacement_Value)

SELECT REPLACE('Uday','a','aaaa');

SELECT REPLACE('Udaya','a','aaaa');

SELECT * FROM tblPerson;

SELECT Email, REPLACE(Email,'.com','.net') AS ConvertedEmail
FROM tblPerson;

-----------------------------------------------------------
use SampleDB
go
--STUFF(Original_Expression, Start, Length, Replacement_expression)

SELECT STUFF('uday@gmail.com',6,5,'yahoo');
SELECT STUFF('uday@gmail.com',6,0,'yahoo');

SELECT * FROM tblPerson;

SELECT Email, STUFF(Email,2,3,'****')
FROM tblPerson;

-----------------------------------------------------------

--*/