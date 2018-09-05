CREATE TABLE [dbo].[Address]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[CompanyId] Int Not Null REFERENCES Company(Id),
	[CreationTime] Datetime2(7) not null DEFAULT GetDate(), 
    [DeleteTime] DATETIME2 NULL 

)
