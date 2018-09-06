CREATE PROCEDURE spDeleteAddress
	@Id int
AS
BEGIN
	declare @DBId int
	Set  @DBId = (select Id FROM viAddress WHERE Id = @Id)

	if (@DBId is not null) 
	begin
		UPDATE [dbo].[Address]
		SET [DeleteTime] = GETDATE()
		WHERE Id = @Id
	end
	RETURN @DBId
END
GO
