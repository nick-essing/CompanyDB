CREATE TABLE [dbo].[Employee]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Name] NVARCHAR(256) NOT NULL,
	[CreationTime] Datetime2(7) not null DEFAULT GetDate(), 
    [DeleteTime] Datetime2(7) NULL,
	[DepartmentId] Int Not Null REFERENCES Department(Id),
)
