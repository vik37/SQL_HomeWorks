--drop table dbo.Custumer
--drop table dbo.OrderDetails
--drop table Employee
--drop table BUSINESSENTITY
--drop table Produce
--exec sp_rename 'dbo.Order', 'dbo.MyOrdered'
--drop table dbo.dbo.MyOrdered

create table [dbo].[Student]
(
  [Id] [int] identity(1,1) not null,
  [FirstName] [nvarchar](100) not null,
  [LastName] [nvarchar](100) not null,
  [DateOfBirth] [date] null,
  [EnrolledDate] [date] null,
  [Gender] [nchar](1) null,
  [NationalIDNumber] [bigint] null,
  [StudentCardNumber] [bigint] null
constraint [PK_Student] primary key clustered
(
   [Id] asc
))

select *
from Student

create table [dbo].[Course]
(
   [Id] [int] identity(1,1) not null,
   [Name] [nvarchar](100) null,
   [Credit] [money] null,
   [AcademicYear] [smallint] null,
   [Semester] [tinyint] null,
constraint [PK_Course] primary key clustered
(
  [Id] asc
))

select *
from Course

create table [dbo].[Teacher]
(
   [Id] [int] identity (1,1) not null,
   [FirstName] [nvarchar](50) not null,
   [LastName] [nvarchar](50) not null,
   [DateOfBirth] [date] not null,
   [AcademicRank] [nvarchar](50) not null,
   [HireDate] [date] not null,
constraint [PK_Teacher] primary key clustered
(
   [Id] asc
))

select * 
from Teacher

create table [dbo].[Grade]
(
   [Id] [int] identity(1,1) not null,
   [StudentID] [int] not null,
   [CourseID] [smallint] not null,
   [TeacherID] [smallint] not null,
   [Grade] [tinyint] not null,
   [Comment] [nvarchar](100) null,
   CreatedDate [datetime] not null,
constraint [PK_Grade] primary key clustered
(
   [Id] asc
))

select *
from Grade

create table [dbo].[GradeDetails]
(
   [Id] [int] identity(1,1) not null,
   [GradeID] [int] not null,
   [AchievementTypeID] [int] not null,
   [AchievementPoints] [int] null,
   [AchievementMaxPoints] [bigint] null,
   [AchievementDate] [date] null,
constraint [PK_GradeDetails] primary key clustered
(
   [Id] asc
))

select * 
from GradeDetails

create table [dbo].[AchievementType]
(
   [Id] [int] identity(1,1) not null,
   [Name] [nvarchar](100) null,
   [Description] [nvarchar](max) null,
   [ParticipationRate] [decimal](18,2) null,
constraint [PK_AchievementType] primary key clustered
(   
   [Id] asc
))

select * 
from AchievementType
