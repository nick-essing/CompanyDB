CREATE PROCEDURE spInsertOrUpdateAddress
	@Id int = -1,
	@postcode_city nvarchar(256),
	@street_streetnumber nvarchar(256),
	@country nvarchar(256)
AS
BEGIN
	declare @DBId int
	Set  @DBId = (select Id FROM Address WHERE Id = @Id)
	if (@DBId is null) 
	begin
		INSERT INTO [dbo].[Address]([Postcode_City],[Street_Streetnumber],[Country])
		VALUES (@postcode_city, @street_streetnumber, @country)
		Set @DBId = @@IDENTITY
	end
	else
	begin
		UPDATE [dbo].[Address]
		SET [Postcode_City] = @postcode_city, [Street_Streetnumber] = @street_streetnumber, [Country] = @country
		WHERE Id = @Id
	end
	RETURN @DBId
END
GO
