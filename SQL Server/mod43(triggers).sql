use SampleDB
go


/* mod 43 DML Triggers

CREATE TABLE tblEmployeeAudit
(
  Id int identity(1,1) primary key,
  AuditData nvarchar(1000)
)

select * from tblEmployee
select * from tblEmployeeAudit


--- after or for insert trigger

create trigger tr_tblEmployee_ForInsert
on tblEmployee
FOR INSERT
as 
begin	
	declare @id int
	select @id = ID from inserted

	insert into tblEmployeeAudit
	values('New Employee with Id = ' + cast(@id as nvarchar(5)) + ' is added at ' + cast(getdate() as nvarchar(20)))
end

--insert which will trigger for insert 
insert into tblEmployee values(11, 'Jane', 'Male', 1800, 3);

select * from tblEmployee
select * from tblEmployeeAudit


-- after or for delete trigger

create trigger tr_tblEmployee_ForDelete
on tblEmployee
FOR DELETE
as 
begin	
	declare @id int
	select @id = ID from deleted

	insert into tblEmployeeAudit
	values('New Employee with Id = ' + cast(@id as nvarchar(5)) + ' is deleted at ' + cast(getdate() as nvarchar(20)))
end

--delete statement which will trigger after delete
delete from tblEmployee where ID = 11

select * from tblEmployee
select * from tblEmployeeAudit

*/



/* mod 44 after update trigger

select * from tblEmployee
select * from tblEmployeeAudit

--after update trigger
create trigger tr_tblEmployee_ForUpdate
on tblEmployee
FOR UPDATE
as 
begin	
	declare @Id int
	declare @OldName nvarchar(20), @NewName nvarchar(20)
	declare @OldSalary int, @NewSalary int
	declare @OldGender nvarchar(20), @NewGender nvarchar(20)
	declare @OldDeptId int, @NewDeptId int

	declare @AuditString nvarchar(1000)

	select *
	into #TempTable
	from inserted

	while(Exists(select ID from #TempTable))
	begin 
		set @AuditString = ' '

		select top 1 @Id = ID, @NewName	= Name, @NewGender = Gender, @NewSalary = Salary, @NewDeptId = DepartmentId
		from #TempTable

		select @OldName = Name, @OldSalary = Salary, @OldGender = Gender, @OldDeptId = DepartmentId
		from deleted where ID = @Id

		set @AuditString = 'Employee with ID = ' + + cast(@Id as nvarchar(5)) + ' changed '
		if(@OldName <> @NewName)
			set @AuditString = @AuditString + ' NAME from ' + @OldName + ' to ' + @NewName

		if(@OldGender <> @NewGender)
			set @AuditString = @AuditString + ' GENDER from ' + @OldGender + ' to ' + @NewGender
                 
        if(@OldSalary <> @NewSalary)
             set @AuditString = @AuditString + ' SALARY from ' + Cast(@OldSalary as nvarchar(10))+ ' to ' + Cast(@NewSalary as nvarchar(10))
                  
        if(@OldDeptId <> @NewDeptId)
             set @AuditString = @AuditString + ' DepartmentId from ' + Cast(@OldDeptId as nvarchar(10))+ ' to ' + Cast(@NewDeptId as nvarchar(10))

		insert into tblEmployeeAudit values(@AuditString)

		  -- Delete the row from temp table, so we can move to the next row
		delete from #TempTable where ID = @Id
	end
end


--update statement which will trigger after update trigger
UPDATE tblEmployee 
set Name = 'James', Salary = 3800, Gender = 'Male', DepartmentId = 2
where ID = 5



select * from tblEmployee
select * from tblEmployeeAudit

--*/


--/* mod 45 Instead of insert trigger

select * from tblEmployee
select * from tblDepartment

create view vwEmployeeDetails
as 
select emp.ID, Name, Gender, DepartmentName
from tblEmployee emp
inner join tblDepartment dept
on emp.ID = dept.ID

select * from vwEmployeeDetails

-- fails, as the view is based on multiple base tables
Insert into vwEmployeeDetails values (7, 'Uday', 'Male', 'IT')

--it can be achieved using instead of insert trigger

create trigger tx_vwEmployeeDetails_InsteadofInsert
on vwEmployeeDetails
Instead of Insert
as 
begin 
	declare @DeptId int

	-- check if there is a valid department id
	-- for the given departname
	select @DeptId = dept.ID
	from tblDepartment dept
	join inserted
	on inserted.DepartmentName = dept.DepartmentName

	-- if departmentid is null, throw an error
	-- and stop processing
	if(@DeptId is null)
	begin 
		Raiserror('Invalid DepartName, statement terminated',16,1)
		return
	end

	--Finally insert into tblEmployee table
	Insert into tblEmployee(id,Name,Gender,DepartmentId)
	select ID, Name, Gender, @DeptId
	from inserted
end


-- now the view has the instead of trigger, its passes

--garbage value for department
Insert into vwEmployeeDetails values (13, 'Uday', 'Male', 'adsasdfasd')

--valid value for department
Insert into vwEmployeeDetails values (13, 'Uday', 'Male', 'IT')

select * from vwEmployeeDetails
select * from tblEmployee