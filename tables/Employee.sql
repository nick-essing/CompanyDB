CREATE TABLE [dbo].[Employee]
(
	[Id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY, 
    [Name] NVARCHAR(256) NOT NULL,
	[Birthdate] Date NULL,
	[Salery] Money NULL,
	[Gender] int NULL,
	[CreationTime] Datetime2(7) not null DEFAULT GETDATE(), 
    [DeleteTime] Datetime2(7) NULL,
	[DepartmentId] Int Null REFERENCES Department(Id),
)
