CREATE PROCEDURE [dbo].[spAddAddressToCompany]
	@EmployeeId int,
	@AddressId int
AS
	BEGIN
	begin
		INSERT INTO [dbo].[AddressToEmployee]([AddressId],[EmployeeId])
		VALUES (@AddressId, @EmployeeId)
	end
END
GO
