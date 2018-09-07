CREATE PROCEDURE [dbo].[spAddEmployeesToAddresses]
		@AddressId int,
		@EmployeeId int
AS
	BEGIN
		INSERT INTO [dbo].[AddressToEmployee]([AddressId], [EmployeeId])
		VALUES (@AddressId, @EmployeeId)
	RETURN @EmployeeId
END
GO
