CREATE TABLE [dbo].[Address]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[CreationTime] Datetime2(7) not null DEFAULT GetDate(), 
    [DeleteTime] DATETIME2 NULL,
	[CompanyId] Int Not Null REFERENCES Company(Id), 
    [Postcode/City] NCHAR(10) NULL
)
