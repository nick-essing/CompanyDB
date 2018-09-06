CREATE PROCEDURE spDeleteEmployee
	@Id int
AS
BEGIN
	declare @DBId int
	Set  @DBId = (select Id FROM viEmployee WHERE Id = @Id)

	if (@DBId is not null) 
	begin
		UPDATE [dbo].[Employee]
		SET [DeleteTime] = GETDATE()
		WHERE Id = @Id
	end
	RETURN @DBId
END
GO
