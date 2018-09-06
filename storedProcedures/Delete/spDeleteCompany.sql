CREATE PROCEDURE spDeleteCompany
	@Id int
AS
BEGIN
	declare @DBId int
	Set  @DBId = (select Id FROM viCompany WHERE Id = @Id)
	if (@DBId is not null) 
	begin
		UPDATE [dbo].[Company]
		SET [DeleteTime] = GETDATE()
		WHERE Id = @Id
	end
	RETURN @DBId
END
GO
