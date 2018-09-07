CREATE PROCEDURE spInsertOrUpdateAddress
	@Id int = -1,
	@postcode int,
	@city nvarchar(256) = null,
	@street nvarchar(256) = null,
	@country nvarchar(256) = null
AS
BEGIN
	declare @InsertOrUpdateAddressId int
	Set  @InsertOrUpdateAddressId = (select Id FROM Address WHERE Id = @Id)
	if (@InsertOrUpdateAddressId is null) 
	begin
		INSERT INTO [dbo].[Address]([Postcode],[City], [Street],[Country])
		VALUES (@postcode, @city, @street, @country)
		Set @InsertOrUpdateAddressId = @@IDENTITY
	end
	else
	begin
		UPDATE [dbo].[Address]
		SET [Postcode] = @postcode, [City] = @city, [Street] = @street, [Country] = @country
		WHERE Id = @Id
	end
	RETURN @InsertOrUpdateAddressId
END
GO
