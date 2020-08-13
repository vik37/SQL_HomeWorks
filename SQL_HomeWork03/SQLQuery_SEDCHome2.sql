
use SEDCHome

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
where EnrolledDate >= '1999.01.01' and EnrolledDate <= '1999.01.31'

select *
from [dbo].[Student]
where LastName like 'J%' and EnrolledDate between '1999.01.01' and '1999.01.31'

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
from [dbo].[Teacher]
intersect
select FirstName
from [dbo].[Student]


--Homework requirement 4/6

alter table [dbo].[GradeDetails]
add constraint DF_GradeDetails_AchievementMaxPoints
default 100 for [AchievementMaxPoints]
go

--Proba
insert into GradeDetails(GradeID,AchievementTypeID,AchievementPoints,AchievementMaxPoints,AchievementDate)
values(20122,4,83,CAST(N'2003-12-30T00:00:00.000' AS DateTime))

alter table [dbo].[GradeDetails] with check
add constraint CHK_GradeDetails_AchievementPoints
check (AchievementPoints <= 100);
go

--Proba
insert into GradeDetails(GradeID,AchievementTypeID,AchievementPoints,AchievementMaxPoints,AchievementDate)
values(20122,4,102,100,CAST(N'2003-12-30T00:00:00.000' AS DateTime))

alter table [dbo].[AchievementType] with check
add constraint UC_Name unique ([Name])
go

--Proba
insert into AchievementType([Name],[Description],ParticipationRate)
values ('Redovnost',NULL,30)

--Homework requirement 5/6

alter table [dbo].[Grade] with check
add constraint FK_Grade_StudentID
foreign key(StudentID)
references [dbo].[Student] (ID)

alter table [dbo].[Grade] with check
add constraint FK_Grade_CourseID
foreign key(CourseID)
references [dbo].[Course] (ID)

alter table [dbo].[Grade] with check
add constraint FK_Grade_TeacherID
foreign key(TeacherID)
references [dbo].[Teacher] (ID)

alter table [dbo].[GradeDetails] with check
add constraint FK_GradeDetails_GradeID
foreign key(GradeID)
references [dbo].[Grade] (ID)

alter table [dbo].[GradeDetails] with check
add constraint FK_GradeDetails_AchievementTypeID
foreign key(AchievementTypeID)
references [dbo].[AchievementType] (ID)


--Homework requirement 6/6
select c.[Name] as CourseName, a.[Name] as AchievmentName
from [dbo].[Course] c
cross join [dbo].[AchievementType] a
go

select DISTINCT t.FirstName,t.LastName
from [dbo].[Teacher] t
INNER JOIN [dbo].[Grade] g on t.ID = g.TeacherID
go

select DISTINCT t.*,g.*
from [dbo].[Teacher] t
left join [dbo].[Grade] g on t.ID = g.TeacherID
where g.TeacherID is NULL
go

select  t.*,g.*
from [dbo].[Grade] g
right join [dbo].[Teacher] t on g.TeacherID = t.ID
where g.TeacherID is NULL
order by FirstName asc
go

select *
from [dbo].[Teacher]

select *
from [dbo].[Grade]

select *
from [dbo].[GradeDetails]


select *
from [dbo].[AchievementType]

select *
from [dbo].[GradeDetails]

select *
from [dbo].[Student]