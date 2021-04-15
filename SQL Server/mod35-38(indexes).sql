/* mod 35 indexes

USE SampleDB
GO

SELECT * FROM tblEmployee;

--index creation
CREATE INDEX IX_tblEmployee_Salary
ON tblEmployee (Salary ASC);

--to view the details about indexes
EXEC sp_helpindex tblEmployee;

-- to drop a index
DROP INDEX tblEmployee.IX_tblEmployee_Salary;
 
*/


/* mod 36 clustered vs nonclustered indexes

use SampleDB;
go

--clustered index created auto on primary key col, when none exists

select * from tblEmployee;

exec sp_helpindex tblEmployee;

create clustered index IX_tblEmployee_Gender_Salary
on tblEmployee (Gender Desc, Salary ASC);

create nonclustered index IX_tblEmployee_Name
on tblEmployee (Name);

drop index tblEmployee.IX_tblEmployee_Gender_Salary

exec sp_helpindex tblEmployee;

--*/


/* mod 37 unique vs non-unique indexes

use SampleDB;
go
 
exec sp_helpindex tblEmployee

select * from tblEmployee

--it can also nonclustered
create unique clustered index IX_tblEmployee_ID
On tblEmployee (ID)

create unique nonclustered index IX_tblEmployee_ID
On tblEmployee (ID)

--creates by def unique nonclustered index in background to enforce the uniqueness
alter table tblEmployee
add constraint UQ_tblEmployee_City
unique (Id)

-- we can change the def, and create clustered unique index for unique key constraint
alter table tblEmployee
add constraint UQ_tblEmployee_City
unique clustered (Id)

exec sp_helpindex tblEmployee

--*/


--/* mod 38 advantages & disadvantages of indexes

--covering queries

--*/



