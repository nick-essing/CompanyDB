CREATE TABLE [dbo].[AdressToCompany]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[AdressId] Int Not Null REFERENCES Address(Id),
	[CompanyId] Int Not Null REFERENCES Company(Id)
)
