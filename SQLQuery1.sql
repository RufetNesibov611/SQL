create database Kometa

use Kometa



create table Employees(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(50),
	[Surname] nvarchar(50),
	[Age] int


)

create table Students(
	[Id] int primary key identity(1,1),
	[FullName] nvarchar(50),
	[Email] nvarchar(100),
	[Age] int,
	[CityId] int,
	foreign key (CityId) references Cities(Id)
)


create table Countries(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(100)

)

create table Cities(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(50),
	[CountryId] int,
	foreign key (CountryId) references Countries(Id)


)


--create view vw_getStudentsByAge
--as
--select * from Students where [Age] > 30



select * from vw_getStudentsByAge



--create view vw_joinStudentData
--as
--select st.FullName as 'Student',ct.Name 'City',co.Name as 'Country' from Students st
--join Cities ct
--on st.CityId = ct.Id
--join Countries co
--on ct.CountryId = co.Id


--select * from vw_joinStudentData



create function showWord()
returns nvarchar(100)
as
begin
	return 'P418'
end


--declare @result nvarchar(100) = (select dbo.showWord())

--print @result


create function showWordWithParametr(@text nvarchar(50))
returns nvarchar(50)
as
begin
	return @text
end


select dbo.showWordWithParametr('Bakasetas')
select dbo.showWordWithParametr('Cornelius')



create function getStudentsAvgAgesByIds(@Id int)
returns int
as
begin
	declare @count int = (select COUNT(*) from Students where [Id] > @Id)
	declare @sumAge int = (select SUM(Age) from Students where [Id] > @Id)
	return @sumAge/@count
end






create function getStudentsAvgAgesByIds2(@Id int)
returns int
as
begin
	declare @avgAge int = (select AVG(Age) from Students where [Id] > @Id)
	return @avgAge
	
end


select dbo.getStudentsAvgAgesByIds2(2)

select dbo.getStudentsAvgAgesByIds(2)



declare @avgAge = (select dbo.getStudentsAvgAgesByIds(2))


create function getStudentsByCondition(@avgAge int)
returns table
as 
return (select * from Students where [Age] > @avgAge)



select * from getStudentsByCondition(2)






create procedure usp_showText
as 
print 'Salam'


exec usp_showText




create procedure usp_showTextWithParametr
@text nvarchar(100)
as
print @text

exec usp_showTextWithParametr 'Azerbaycan'


select * from Students




create procedure usp_deleteEmployeeById
@Id int
as
delete from Employees where [Id] = @Id


exec usp_deleteEmployeeById 3

select * from Employees



create procedure usp_createEmployee
@name nvarchar(50),
@surname nvarchar(50),
@age int
as
begin
	insert into Employees([Name],[Surname],[Age])
	values (@name,@surname,@age)
end

