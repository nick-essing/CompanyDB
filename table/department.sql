CREATE TABLE [dbo].[department]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[Name] NVARCHAR(256) NOT NULL,
	[CreationTime] Datetime2(7) not null DEFAULT GetDate(), 
    [DeleteTime] Datetime2(7) NULL,
	[CompanyId] Int Null REFERENCES Company(Id),
	[EmployeeId] Int Null REFERENCES  Employee(Id)
)
