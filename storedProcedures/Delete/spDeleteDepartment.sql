CREATE PROCEDURE spDeleteDepartment
	@Id int
AS
BEGIN
	declare @DBId int
	Set  @DBId = (select Id FROM viDepartment WHERE Id = @Id)

	if (@DBId is not null) 
	begin
		UPDATE [dbo].[Department]
		SET [DeleteTime] = GETDATE()
		WHERE Id = @Id
	end
	RETURN @DBId
END
GO
