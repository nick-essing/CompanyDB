CREATE TABLE [dbo].[Address]
(
	[Id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	[Postcode] INT NULL, 
	[City] NVARCHAR(256) NULL, 
    [Street] NVARCHAR(256) NULL,
	[Country] NVARCHAR(256) NULL,
	[CompanyId] INT NULL REFERENCES Company(Id),
	[CreationTime] Datetime2(7) not null DEFAULT GETDATE(),
    [DeleteTime] Datetime2(7) NULL
)
