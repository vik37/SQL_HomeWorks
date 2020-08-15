use SEDCClass1
--drop table dbo.Businessentity_details
create table dbo.Businessentity_details
(
  [ID] int identity(1,1) not null,
  BusinessentityID int not null,
  AccountNumber nvarchar(15) not null,
  Adress nvarchar(250) not null,
  Contact nvarchar(100) not null,
  email nvarchar(250) not null,
  comment nvarchar (max) null
  constraint [PK_Businessentity_details] primary key clustered
  (
      [ID] asc
  )
)

--3-- insert values
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Adress],Contact,email,comment)
values(1,'210500222333','Partizanski Odredi 15','070555666','aaa@vitalia.com','Nema zabeleshka')
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Adress],Contact,email,comment)
values(2,'210500222334','XXXX 15','070779523','bbb@vitalia.com',NULL)
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Adress],Contact,email,comment)
values(3,'210500222335','XXXX 16','070779523','ccc@vitalia.com','TEST 1')
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Adress],Contact,email,comment)
values(4,'210500222335','XXXX 17','070779523','dddvitalia.com',NULL)
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Adress],Contact,email,comment)
values(5,'210500222336','XXXX 18','070779544','vvv@vitaliacom','Nema plateno faktura')
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Adress],Contact,email,comment)
values(6,'210500222337','XXXX 19','070779555','ddd@vitaliacom',NULL)
go
insert into dbo.businessentity_details (BusinessentityID,AccountNumber,[Adress],Contact,email,comment)
values(0,'210500222338','XXXX 20','070779566','aa@vitalia.com','Nevaliden kontakt')
go

alter table [dbo].[Businessentity_details] with check
add constraint [FK_Businessentity_details]
foreign key ([BusinessentityID])
references [dbo].[BusinessEntity] ([ID])
go

select *
from [dbo].[Businessentity_details]
update [dbo].[Businessentity_details]
set AccountNumber = 210500222339
where ID = 4

alter table [dbo].[Businessentity_details] with check
add constraint [UC_Businessentity_details_AccountNumber] unique (AccountNumber)
go
update [dbo].[Businessentity_details]
set email = 'ddvvital@ia.com'
where ID = 4
update [dbo].[Businessentity_details]
set email = 'vvv@vitalia.com'
where ID = 5
update [dbo].[Businessentity_details]
set email = 'ddd@vitalia.com'
where ID = 6

alter table [dbo].[Businessentity_details] with check
add constraint [CHK_Businessentity_details_email]
check (email like '%@%.%' )
go

alter table [dbo].[Businessentity_details] with check
add constraint CHK_substring
check (substring (Contact,1,2) != '07');
go

update [dbo].[Businessentity_details]
set Contact = 'Nema Zabeleska'

--5)Да се искреира функција за пресметка на вкупна количина на нарачки по продукт--6)Да се искреира функција за пресметка на вкупна сума на нарачки по продуктgo
create function dbo.fn_TotalSum(@ProductID int)
returns int
as
begin

    declare @Result int

   select @Result = sum(OrderId)
   from [dbo].[Product] p
   inner join [dbo].[OrderDetails] o on o.ProductId = p.Id
   where p.Id = @ProductID
   return @Result
end
go

create function dbo.fn_SumPrice (@productPrice int)
returns int
as
begin
     declare @result int 
	 select @result = sum(Price)
	 from [dbo].[OrderDetails]
	 where id = @productPrice
	 return @result
end
go
select dbo.fn_SumPrice(6)

go
------------------------------------------------------
------------------------------------------------------
create FUNCTION [dbo].[ToCyrillic](@str Nvarchar(MAX))
    RETURNS Nvarchar(MAX)
    AS
BEGIN
-- Declare the return variable here
DECLARE @inputLength int
DECLARE @i int
DECLARE @latinSymbol nVarchar(2)
DECLARE @latinSymbol2 nVarchar(2)
set @latinSymbol2=null
DECLARE @cyrillicSymbol nVarchar(2)
DECLARE @outputValue nVarchar(MAX)
SET @outputValue=N''
SET @inputLength=LEN(@str)
SET @i=1

DECLARE @TransTable table (upperCyr nvarchar(2) COLLATE Cyrillic_General_CI_AS, 
                            lowerCyr nvarchar(2) COLLATE Cyrillic_General_CI_AS, 
                            lowerLat nvarchar(2), cid int PRIMARY KEY IDENTITY(1,1))

insert into @TransTable values (N'А', N'а', N'a')
insert into @TransTable values (N'Б', N'б', N'b')
insert into @TransTable values (N'В', N'в', N'v')
insert into @TransTable values (N'Г', N'г', N'g')
insert into @TransTable values (N'Д', N'д', N'd')
insert into @TransTable values (N'Ђ', N'ђ', N'đ')
insert into @TransTable values (N'Е', N'е', N'e')
insert into @TransTable values (N'Ж', N'ж', N'ž')
insert into @TransTable values (N'З', N'з', N'z')
insert into @TransTable values (N'И', N'и', N'i')
insert into @TransTable values (N'Ј', N'ј', N'j')
insert into @TransTable values (N'К', N'к', N'k')
insert into @TransTable values (N'Л', N'л', N'l')
insert into @TransTable values (N'Љ', N'љ', N'lj')
insert into @TransTable values (N'М', N'м', N'm')
insert into @TransTable values (N'Н', N'н', N'n')
insert into @TransTable values (N'Њ', N'њ', N'nj')
insert into @TransTable values (N'О', N'о', N'o')
insert into @TransTable values (N'П', N'п', N'p')
insert into @TransTable values (N'Р', N'р', N'r')
insert into @TransTable values (N'С', N'с', N's')
insert into @TransTable values (N'Т', N'т', N't')
insert into @TransTable values (N'Ћ', N'ћ', N'ć')
insert into @TransTable values (N'У', N'у', N'u')
insert into @TransTable values (N'Ф', N'ф', N'f')
insert into @TransTable values (N'Х', N'х', N'h')
insert into @TransTable values (N'Ц', N'ц', N'c')
insert into @TransTable values (N'Ч', N'ч', N'č')
insert into @TransTable values (N'Џ', N'џ', N'dž')
insert into @TransTable values (N'Ш', N'ш', N'šˇ')


WHILE (@i<=@inputLength)
BEGIN
    SET @latinSymbol=SUBSTRING(@str,@i,1)
    SET @cyrillicSymbol=@latinSymbol    -- If not found below, then use that char (e.g. numbers etc)

        -- exceptions Љ,Њ,Џ
if (@i+1<=@inputLength) set @latinSymbol2=SUBSTRING(@str,@i+1,1)    
if lower(@latinSymbol+@latinSymbol2) in ('lj','nj','dž')    
    begin
        if ((@latinSymbol COLLATE Croatian_CS_AS)=UPPER(@latinSymbol))
            BEGIN
            SELECT TOP 1 @cyrillicSymbol=upperCyr FROM @TransTable WHERE lowerlat=lower(@latinSymbol+@latinSymbol2) ORDER BY CID
            END
            ELSE
            BEGIN
            SELECT TOP 1 @cyrillicSymbol=lowerCyr FROM @TransTable WHERE lowerlat=lower(@latinSymbol+@latinSymbol2) ORDER BY CID
            END     
            SET @i=@i+2    
        end
    else--end exceptions
    begin
        IF ((@latinSymbol COLLATE Croatian_CS_AS)=UPPER(@latinSymbol))
        BEGIN
        SELECT TOP 1 @cyrillicSymbol=upperCyr FROM @TransTable WHERE lowerlat=lower(@latinSymbol) ORDER BY CID
        END
        ELSE
        BEGIN
        SELECT TOP 1 @cyrillicSymbol=lowerCyr FROM @TransTable WHERE lowerlat=lower(@latinSymbol) ORDER BY CID
        END
        SET @i=@i+1
    end
    set @outputValue=@outputValue+@cyrillicSymbol
END

RETURN @outputValue

END
go


--7) Потребно е да се направи view за приказ на:---име на компанија---регион(пошта - име на регион)---број на сметка---адреса, вредноста XXXX да се замени со ‘Улица број’---име на продукт---вкупна продадена количина по продукт да биде во податочен тип int---вкупна сума по продукт да биде дополнета со валута МКД--Во искреираното view колоните да се прикажат на кирилица и податоците во--колоните за име на комапнија, име на регион и име на продукт исто така да бидат--на кирилица.--View-то да прикажува само ставки за продукт со име Granola.--На крај да се направи подредување по колона Име на компанија


create view VV_Company
as
select   [dbo].[ToCyrillic](be.[Name]) as ImeNaKompanija,
         [dbo].[ToCyrillic](be.Region) as ImeNaRegion,
		 [dbo].[ToCyrillic](p.[Name]) as ImeNaProduct,
         be.[Name],be.Region,bed.AccountNumber,bed.Adress,p.[Name], 
         dbo.fn_TotalSum(p.Id) as TotalSum,
		 [dbo].[ToCyrillic]('MKD') as [Value],
		 dbo.fn_SumPrice(p.Id) as SumPrice
from [dbo].[BusinessEntity] be
inner join [dbo].[Businessentity_details] bed
on be.Id = bed.BusinessentityID
inner join [dbo].[Order] o
on o.BusinessEntityId = be.Id
inner join [dbo].[OrderDetails] od
on od.OrderId = o.Id
inner join [dbo].[Product] p
on p.Id = od.ProductId
where p.[Name] = 'Granola'
order by be.[Name]
go

select *
from [dbo].[Businessentity_details]
select *
from [dbo].[OrderDetails]
select *
from [dbo].[Product]
select *
from [dbo].[BusinessEntity]