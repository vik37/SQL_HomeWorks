USE [SEDC_HomeWork]

--Homework requirement 1/6


select *
from [dbo].[Student]
where FirstName = 'Antonio'

select *
from [dbo].[Student]
where DateOfBirth > '1999.01.01'

select *
from [dbo].[Student]
where Gender = 'M'

select *
from [dbo].[Student]
where LastName like 'T%'

select *
from [dbo].[Student]
where EnrolledDate >= '1998.01.01' and EnrolledDate <= '1998.01.31'

select *
from [dbo].[Student]
where LastName like 'J%' and EnrolledDate between '1998.01.01' and '1998.01.31'

--Homework requirement 2/6

select *
from [dbo].[Student]
where FirstName = 'Antonio'
order by LastName asc

select *
from [dbo].[Student]
order by FirstName asc

select *
from [dbo].[Student]
where Gender = 'M'
order by EnrolledDate desc

--Homework requirement 3/6

select FirstName
from [dbo].[Teacher]
union all
select FirstName
from [dbo].[Student]

select LastName
from [dbo].[Teacher]
union
select LastName
from [dbo].[Student]

select FirstName 
from  [dbo].[Teacher]
intersect
select FirstName 
from [dbo].[Student] 

--Homework requirement 4/6

--Task 1
---------------------------------------
 alter table [dbo].[GradeDetails]
 add constraint DF_GradeDetails_AchievementMaxPoints
 default 100 for [AchievementMaxPoints]
 go

 --ZA PROVERKA
 insert into dbo.GradeDetails(GradeID,AchievementTypeID,AchievementPoints,AchievementDate)
 values (20122,4,78,'2019.05.26')
 go

--Task 2
----------------------------------------------------
alter table [dbo].[GradeDetails] with check
add constraint CHK_GradeDetails_AchievementPoints
check (AchievementPoints <= 100);
go

--ZA PROVERKA
 insert into dbo.GradeDetails(GradeID,AchievementTypeID,AchievementPoints,AchievementDate)
 values (20123,4,102,'2019.07.26')
 go

 --Task 3
 --------------------------------------------------
 alter table [dbo].[AchievementType] with check
 add constraint AchievementType_UC_Name unique (Name)
 go

 --ZA PROVERKA
 insert into dbo.AchievementType([Name],[Description],[ParticipationRate])
 values ('Redovnost',NULL,30.00)
 go

 --Homework requirement 6/6

 select *
 from [dbo].[Course]
 cross join [dbo].[AchievementType]

 select *
 from [dbo].[Teacher] inner join [dbo].[Grade]
 on dbo.Teacher.Id = dbo.Grade.TeacherID;

 select *
 from [dbo].[Teacher]
 left outer join [dbo].[Grade]
 on dbo.Teacher.Id = dbo.Grade.TeacherID

 select *
 from [dbo].[Grade]
 right outer join [dbo].[Student]
 on dbo.Grade.StudentID = dbo.Student.Id


 select * 
from [dbo].[Grade]

 select *
from [dbo].[Teacher]

select *
from [dbo].[AchievementType]

select* 
from [dbo].[Course]

select *
from [dbo].[GradeDetails]

select *
from [dbo].[Student]

