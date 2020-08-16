use SEDCHome

--Homework requirement 1/2

declare @FirstName nvarchar(100)
set @FirstName = 'Antonio'

select *
from [dbo].[Student]
where FirstName = @FirstName
go

declare @Student table
(StudentID int,StudentName nvarchar(100),StdDateOfBirth date);

insert into @Student
select ID,FirstName,DateOfBirth
from [dbo].[Student]
where Gender = 'F'

select *
from @Student
go

create table #TempStudent 
(LastName nvarchar(100),EnrolledDate date)

insert into #TempStudent
select LastName,EnrolledDate
from [dbo].[Student]
where Gender = 'M' and FirstName like '%A' and len(LastName) = 7
go

select *
from #TempStudent

select *
from [dbo].[Teacher]
where len(FirstName) < 5 and left(FirstName,3) = left(LastName,3)
go
--Homework requirement 2/2
create function dbo.fn_FormatStudentName(@StudentId int)
returns nvarchar(100)
as
begin
     declare @Result nvarchar(100)
	 select @Result = SUBSTRING(s.StudentCardNumber,4,8) + '-' + LEFT(FirstName,1) + '.' + LastName
	 from [dbo].[Student] s
	 where s.ID = @StudentId
	 return @Result
end
go

select *,dbo.fn_FormatStudentName(ID) as FunctionStudent
from [dbo].[Student]

select *
from [dbo].[Student]