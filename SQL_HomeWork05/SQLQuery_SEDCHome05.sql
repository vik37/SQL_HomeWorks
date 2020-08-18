use SEDCHome
go

CREATE FUNCTION dbo.fn_StudentExam (@TeacherID int,@CourseID int)
RETURNS @Output table (StudentFirstName nvarchar(100),StudentLastName nvarchar(100),Grade tinyint,CreatedDate datetime)
AS
BEGIN
INSERT INTO @Output
select DISTINCT s.FirstName as StudentFirstName, s.LastName as StudentLastName, g.Grade, g.CreatedDate 
from [dbo].[Grade] g
inner join [dbo].[Teacher] t on t.ID = g.TeacherID
inner join [dbo].[Course] c on c.ID = g.CourseID
inner join [dbo].[Student] s on s.ID = g.StudentID
where g.Grade > 6
and g.TeacherID = @TeacherID
and g.CourseID = @CourseID
order by g.CreatedDate

RETURN
END
GO

select *
from dbo.fn_StudentExam(3,3)

select *
from [dbo].[Teacher]

select *
from [dbo].[Course]

select *
from [dbo].[Student]

select *
from [dbo].[GradeDetails]

select *
from [dbo].[Grade]

select *
from [dbo].[AchievementType]