use SEDCHome
GO

--Homework requirement 1a/2

--Create new procedure called CreateGrade
--Procedure should create only Grade header info (not Grade Details) 
--Procedure should return the total number of grades in the system for the Student on input (from the CreateGrade)
--Procedure should return second resultset with the MAX Grade of all grades for the Student and Teacher on input (regardless the Course)


CREATE PROCEDURE dbo.CreateGrade(
   @StudentID int, 
   @CourseID smallint, 
   @TeacherID smallint, 
   @Grade tinyint, 
   @Comment nvarchar(100),
   @CreatedDate datetime
)
AS
BEGIN
     insert into [dbo].[Grade](StudentID,CourseID,TeacherID,Grade,Comment,CreatedDate)
	 values(@StudentID,@CourseID,@TeacherID,@Grade,@Comment,@CreatedDate)

	 select count(*) as TotalNumOfGrades
	 from [dbo].[Grade] g
	 where g.StudentID = @StudentID

	 select max(Grade) as MAxGrade
	 from [dbo].[Grade] g
	 where g.StudentID = @StudentID and
	 g.TeacherID = @TeacherID

END

GO

exec dbo.CreateGrade @StudentID = 111,@CourseID = 4,@TeacherID = 85,@Grade = 8,@Comment = 'Snaodliv',@CreatedDate = '1999.02.05 00:00:00.000'

exec dbo.CreateGrade '337','5','5','10','Vreden','2002.03.26 00:00:00.000'
GO --AKO NE GO STAVAM OVA GO NAD CREATE PROCEDURE dbo.CreateGradeDetail ILI POD PRETHODNA QUERY SINTAKSA BILO KAKVA,
--MI JAVUVA GRESKA I PODVLECENO E SO CRVENO CREATE PROCEDURE dbo.CreateGradeDetail
----------------------------------------------------------------------------------------------


--Homework requirement 1b/2

--Create new procedure called CreateGradeDetail
--Procedure should add details for specific Grade (new record for new AchievementTypeID, Points, MaxPoints, Date for specific Grade)
--Output from this procedure should be resultset with SUM of GradePoints calculated with formula 
--AchievementPoints/AchievementMaxPoints*ParticipationRate for specific Grade


alter PROCEDURE dbo.CreateGradeDetail(
   @GradeID int,
   @AchievmentTypeID tinyint,
   @AchievmentPoints tinyint,
   @AchievmentMaxPoints tinyint,
   @AchievmentDate datetime
)
AS
BEGIN
    BEGIN TRY

	   --declare @ParticipationRate tinyint
	   declare @GradePoints int
   
	   select ParticipationRate
	   from [dbo].[AchievementType]
	   where ID = @AchievmentTypeID

	   insert into [dbo].[GradeDetails](GradeID,AchievementTypeID,AchievementPoints,AchievementMaxPoints,AchievementDate)
	   values(@GradeID,@AchievmentTypeID,@AchievmentPoints,@AchievmentMaxPoints,@AchievmentDate)

	   set @GradePoints = 
	   (
		  select sum(gd.AchievementPoints / gd.AchievementMaxPoints * act.ParticipationRate)
		  from [dbo].[GradeDetails] gd
		  inner join [dbo].[AchievementType] act on act.ID = gd.AchievementTypeID
		  where gd.AchievementTypeID = @AchievmentTypeID
	   )



	   select gd.AchievementDate as DateForSpecificGrade, sum(@GradePoints) as GradePoint
	   from [dbo].[GradeDetails] gd
	   where gd.GradeID = @GradeID
	   and gd.AchievementTypeID = @AchievmentTypeID
	   group by gd.AchievementDate

	END TRY
    BEGIN CATCH
	    SELECT
		ERROR_NUMBER() AS ErrorNumber  
		,ERROR_SEVERITY() AS ErrorSeverity  
		,ERROR_STATE() AS ErrorState  
		,ERROR_PROCEDURE() AS ErrorProcedure  
		,ERROR_LINE() AS ErrorLine  
		,ERROR_MESSAGE() AS ErrorMessage;  


	END CATCH
END

GO

exec dbo.CreateGradeDetail @GradeID = 3,@AchievmentTypeID = 3,@AchievmentPoints = 71,@AchievmentMaxPoints = 0,@AchievmentDate = '1998.06.27 00:00:00.000'
exec dbo.CreateGradeDetail '0','3','98','100','1999.01.27 00:00:00.000'

--DROP PROCEDURE dbo.CreateGradeDetail

select *
from [dbo].[Grade]

select *
from [dbo].[GradeDetails]

select *
from [dbo].[Course]

select *
from [dbo].[AchievementType]