CREATE TABLE [dbo].[Department]
(
	[Id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Name] NVARCHAR(256) NOT NULL,
	[CreationTime] Datetime2(7) not null DEFAULT GETDATE(), 
    [DeleteTime] Datetime2(7) NULL,
	[CompanyId] Int Null REFERENCES Company(Id),
	[EmployeeId] Int Null REFERENCES  Employee(Id)
)
