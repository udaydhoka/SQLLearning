use SampleDB	
go

/* mod 39 views

select * from tblEmployee

select * from tblDepartment

sp_helptext vwEmployeesByDepartment

create view vwEmployeesByDepartment
as
select emp.ID, Name, Salary, Gender, DepartmentName
from tblEmployee emp
inner join tblDepartment dpt
on emp.DepartmentId = dpt.ID

select * from vwEmployeesByDepartment

--row level securtiy, ie., select only rows whose dept is IT
create view vwITEmployees
as
select emp.ID, Name, Salary, Gender, DepartmentName
from tblEmployee emp
inner join tblDepartment dpt
on emp.DepartmentId = dpt.ID
where dpt.DepartmentName = 'IT'

select * from vwITEmployees


--col level security i.e., not displaying the salary col

create view vwNonConfidentialData
as
select emp.ID, Name, Gender, DepartmentName
from tblEmployee emp
inner join tblDepartment dpt
on emp.DepartmentId = dpt.ID

select * from vwNonConfidentialData

-- showing only aggregate data, hiding detailed data

create view vsSummarizedData
as 
select dpt.DepartmentName, COUNT(emp.ID) as TotalEmployess
from tblEmployee emp
inner join tblDepartment dpt 
on emp.DepartmentId = dpt.ID
group by DepartmentName


select * from vsSummarizedData
--*/



/* mod 40 updatable views

create view vwEmployeesDataExceptSalary
as
select ID, Name, Gender, DepartmentId
from tblEmployee 


select * from vwEmployeesDataExceptSalary

-- views are updatable in sql

-- updating the table using view
update vwEmployeesDataExceptSalary
set Name = 'Mikey' where ID = 2

select * from vwEmployeesDataExceptSalary

-- deleting from view
delete from vwEmployeesDataExceptSalary
where ID = 2;

select * from vwEmployeesDataExceptSalary

--inserting using views
insert into vwEmployeesDataExceptSalary
values(2, 'Mike', 'Male', 2);

select * from vwEmployeesDataExceptSalary

--views with mulitple underlying tables
sp_helptext vwEmployeesByDepartment

select * from vwEmployeesByDepartment

-- here update happens incorrectly, we should use instead of triggers
update vwEmployeesByDepartment
set DepartmentName = 'IT' 
where Name = 'Tom'
--*/







/* mod 41 indexed views

Create Table tblProduct
(
 ProductId int primary key,
 Name nvarchar(20),
 UnitPrice int
)

--Script to pouplate tblProduct, with sample data
Insert into tblProduct Values(1, 'Books', 20)
Insert into tblProduct Values(2, 'Pens', 14)
Insert into tblProduct Values(3, 'Pencils', 11)
Insert into tblProduct Values(4, 'Clips', 10)

--Script to create table tblProductSales
Create Table tblProductSales
(
 ProductId int foreign key references tblProduct(ProductId),
 QuantitySold int
)
 
--Script to pouplate tblProductSales, with sample data
Insert into tblProductSales values(1, 10)
Insert into tblProductSales values(3, 23)
Insert into tblProductSales values(4, 21)
Insert into tblProductSales values(2, 12)
Insert into tblProductSales values(1, 13)
Insert into tblProductSales values(3, 12)
Insert into tblProductSales values(4, 13)
Insert into tblProductSales values(1, 11)
Insert into tblProductSales values(2, 12)
Insert into tblProductSales values(1, 14)

select * from tblProduct
select * from tblProductSales

-- view suitable to create index on them 
-- should have schemabinding
create view vwTotalSalesByProduct
with schemabinding
as 
select Name, sum(ISNULL((UnitPrice * QuantitySold), 0)) as TotalSales, COUNT_BIG(*) as TotalTransactions
from dbo.tblProduct
inner join dbo.tblProductSales
on tblProduct.ProductId = tblProductSales.ProductId
group by Name


select * from vwTotalSalesByProduct

--creating index on view 
create unique clustered index IX_vwTotalSalesByProduct_Name
on vwTotalSalesByProduct(Name)

--*/



/* mod 42 views limitations

-- cant pass params to views

select * from tblEmployee

-- throws error
select * from vwWithParams
@Gender nvarchar(20)
as 
select Id,Name, Gender, DepartmentId
from tblEmployee
where Gender = @Gender

-- to achieve parameterized view, we can use TVF

create function fnParamViewSubstitute
(
@Gender nvarchar(20)
)
returns table
as
return
	(
		select Id,Name, Gender, DepartmentId
		from tblEmployee
		where Gender = @Gender
	)


select * from fnParamViewSubstitute('Male')

--throws error
Create View vWEmployeeDetailsSorted
as
Select Id, Name, Gender, DepartmentId
from tblEmployee
order by Id

--views cant be used with temp tables

drop table ##TestTempTable

Create Table ##TestTempTable(Id int, Name nvarchar(20), Gender nvarchar(10))

Insert into ##TestTempTable values(101, 'Martin', 'Male')
Insert into ##TestTempTable values(102, 'Joe', 'Female')
Insert into ##TestTempTable values(103, 'Pam', 'Female')
Insert into ##TestTempTable values(104, 'James', 'Male')

select * from ##TestTempTable

-- Error: Cannot create a view on Temp Tables
Create View vwOnTempTable
as
Select Id, Name, Gender
from ##TestTempTable

--*/