CREATE TABLE [dbo].[Address]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[Postcode_City] NVARCHAR(256) NULL, 
    [Street_Streetnumber] NVARCHAR(256) NULL,
	[CreationTime] Datetime2(7) not null DEFAULT GetDate(), 
    [DeleteTime] Datetime2(7) NULL,
	[CompanyId] Int Not Null REFERENCES Company(Id),
	[EmployeeId] Int Not Null REFERENCES Employee(Id)
)
