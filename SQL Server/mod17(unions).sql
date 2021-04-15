--/* mod 17 Union And Union ALL

CREATE TABLE tblIndiaCustomers
(
	Id int,
	Name nvarchar(50),
	Email nvarchar(50)
);

INSERT INTO tblIndiaCustomers 
VALUES (1,'Raj','R@r.com'),(2,'Sam','S@s.com');

CREATE TABLE tblUKCustomers
(
	Id int,
	Name nvarchar(50),
	Email nvarchar(50)
);

INSERT INTO tblUKCustomers
VALUES (1,'Ben','B@b.com'),(2,'Sam','S@s.com');

SELECT * FROM tblIndiaCustomers;
SELECT * FROM tblUKCustomers;

--union, removes duplicates
SELECT * FROM tblIndiaCustomers
UNION
SELECT * FROM tblUKCustomers;

--union all, includes duplicate values
SELECT Id,Name,Email FROM tblIndiaCustomers
UNION ALL
SELECT Id,Name,Email FROM tblUKCustomers;

--both should have same number of col,col datatypes and the order 
--below query throws error, as no.of mismatches 
SELECT Id,Name,Email FROM tblIndiaCustomers
UNION ALL
SELECT Id,Name FROM tblUKCustomers;

--below query throws error, as order of column mismatches 
SELECT Id,Name,Email FROM tblIndiaCustomers
UNION 
SELECT Email,Id,Name FROM tblUKCustomers;

--it executes, as the datatypes are same though they are not same columns
SELECT Id,Name,Email FROM tblIndiaCustomers
UNION 
SELECT Id,Email,Name FROM tblUKCustomers;

--using order by in unions
SELECT Id,Name,Email FROM tblIndiaCustomers
UNION ALL
SELECT Id,Name,Email FROM tblUKCustomers
ORDER BY Id;

--below query throws syntax error, as order by should be at last select statement
--SELECT Id,Name,Email FROM tblIndiaCustomers
--ORDER BY Id
--UNION ALL
--SELECT Id,Name,Email FROM tblUKCustomers;

--*/
