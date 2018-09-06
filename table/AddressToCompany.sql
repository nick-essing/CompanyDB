CREATE TABLE [dbo].[AdressToCompany]
(
	[Id] INT NOT NULL Identity(0,1) PRIMARY KEY,
	[AdressId] Int Not Null REFERENCES Address(Id),
	[CompanyId] Int Not Null REFERENCES Company(Id)
)
