CREATE TABLE [dbo].[AddressToEmployee]
(
	[AddressId] Int Not Null REFERENCES Address(Id),
	[EmployeeId] Int Not Null REFERENCES Employee(Id),
	Primary Key (AddressId, EmployeeId), 
	[CreationTime] Datetime2(7) not null DEFAULT GETDATE(),
    [DeleteTime] Datetime2(7) NULL
)
