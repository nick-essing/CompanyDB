CREATE TABLE [dbo].[department]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[Name] NVARCHAR(256) NOT NULL,
	[CreationTime] Datetime2(7) not null DEFAULT GetDate(), 
    [DeleteTime] DATETIME2 NULL,
	[CompanyId] Int Not Null REFERENCES Company(Id),
	[EmployeeId] Int Not Null REFERENCES  Employee(Id)
)
