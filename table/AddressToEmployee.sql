CREATE TABLE [dbo].[AddressToEmployee]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[AdressId] Int Not Null REFERENCES Address(Id),
	[EmployeeId] Int Not Null REFERENCES Employee(Id)
)
