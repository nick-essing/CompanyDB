CREATE PROCEDURE spDeleteAddress
	@Id int
AS
BEGIN
	declare @DeleteAddressId int
	Set  @DeleteAddressId = (select Id FROM viAddress WHERE Id = @Id)

	if (@DeleteAddressId is not null) 
	begin
		UPDATE [dbo].[Address]
		SET [DeleteTime] = GETDATE()
		WHERE Id = @Id
	end
	RETURN @DeleteAddressId
END
GO
