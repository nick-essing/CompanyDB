CREATE TABLE [dbo].[AddressToEmployee]
(
	[Id] INT NOT NULL Identity(0,1) PRIMARY KEY,
	[AdressId] Int Not Null REFERENCES Address(Id),
	[EmployeeId] Int Not Null REFERENCES Employee(Id)
)
