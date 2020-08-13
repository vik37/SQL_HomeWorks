use SEDCHome

--select Gender, count(*) as Total
--from [dbo].[Student]
--where Gender = 'M'
--group by Gender

--select Grade, sum(Grade) as StudentsGrade
--from [dbo].[Grade]
--where Grade > 7
--group by Grade
--having sum(Grade) > 45963
--order by Grade asc

--select Grade, avg(Grade)
--from [dbo].[Grade]
--group by Grade
--having avg(Grade) > 7
--order by Grade desc

--Homework requirement 1/3

select count(*) as TotalGrade
from [dbo].[Grade]

select TeacherID, count(TeacherID) as TotalPerTeacher
from [dbo].[Grade]
group by TeacherID

select TeacherID, count(TeacherID) as TotalTeacher
from [dbo].[Grade]
where StudentID < 100
group by TeacherID
order by TeacherID desc

select StudentID, max(Grade) as MaxGrade,avg(Grade) as AverigeGrade
from [dbo].[Grade]
group by StudentID
order by StudentID asc

--Homework requirement 2/3

select TeacherID, count(Grade) as TotalTeacherGrade
from [dbo].[Grade]
group by TeacherID
having count(Grade) > 200

select TeacherID, count(Grade) as TotalTeachGrPerStudents
from [dbo].[Grade]
where StudentID < 100
group by TeacherID
having count(Grade) > 50
order by TeacherID asc

select StudentID, max(Grade) as MaxGrade, avg(Grade) as AvgGrade
from [dbo].[Grade]
group by StudentID
having max(Grade) = avg(Grade)

select g.StudentID, s.FirstName,s.LastName, max(Grade) as MaxGrade, avg(Grade) as AvgGrade
from [dbo].[Grade] g
inner join [dbo].[Student] s on s.ID = g.StudentID
group by StudentID,s.FirstName,s.LastName
having max(Grade) = avg(Grade)

--Homework requirement 3/3
drop view if exists vv_StudentsGrade

create view vv_StudentsGrade
as
select StudentID, count(Grade) as TotalGrade
from [dbo].[Grade]
group by StudentID
go

select *
from vv_StudentsGrade

alter view vv_StudentsGrade
as
select DISTINCT s.FirstName,s.LastName, count(Grade) as TotalGrade
from [dbo].[Student] s
inner join [dbo].[Grade] g on s.ID = g.StudentID
group by FirstName,LastName

select *
from vv_StudentsGrade v
order by TotalGrade desc

create view vv_StudentGradeDetails
as
select DISTINCT s.FirstName,s.LastName,c.[Name], count(gd.AchievementPoints) as TotalPoints,min(gd.AchievementPoints) as miPoint
from [dbo].[GradeDetails] gd
inner join [dbo].[Grade] g on gd.GradeID = g.ID
inner join [dbo].[AchievementType] atp on gd.AchievementTypeID = atp.ID
inner join [dbo].[Course] c on g.CourseID = c.ID
inner join [dbo].[Student] s on g.StudentID = s.ID
where Grade > 6
group by s.FirstName,s.LastName,c.[Name]
having  min(gd.AchievementPoints) > 30

select *
from vv_StudentGradeDetails

select *
from [dbo].[Course]

select *
from [dbo].[Grade]

select *
from [dbo].[Student]

select *
from [dbo].[GradeDetails]

select *
from [dbo].[AchievementType]