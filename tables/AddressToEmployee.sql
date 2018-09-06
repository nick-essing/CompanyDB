CREATE TABLE [dbo].[AddressToEmployee]
(
	[AddressId] Int Not Null REFERENCES Address(Id),
	[EmployeeId] Int Not Null REFERENCES Employee(Id)
	Identity(0,1) Primary Key (AddressId, EmployeeId)
)
