CREATE PROCEDURE [dbo].[spAddEmployeesToAddresses]
	@EmployeeId int,
	@AddressId int
AS
	BEGIN
	declare @DBIdEmployee int
	declare @DBIdAddress int
	declare @DBNULL int
	Set  @DBIdEmployee = (select Id FROM Employee WHERE Id = @EmployeeId)
	Set  @DBIdAddress = (select Id FROM Address WHERE Id = @AddressId)
	Set  @DBNULL = (select EmployeeId FROM AddressToEmployee WHERE EmployeeId = @EmployeeId AND AddressId = @AddressId)
	if (@DBIdEmployee is not null AND @DBIdAddress is not null AND @DBNULL is not null) 
	begin
		INSERT INTO [dbo].[AddressToEmployee]([AddressId],[EmployeeId])
		VALUES (@DBIdAddress, @DBIdEmployee)
	end
END
GO
