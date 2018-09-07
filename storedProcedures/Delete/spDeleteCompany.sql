CREATE PROCEDURE spDeleteCompany
	@Id int
AS
BEGIN
	declare @DeleteCompanyId int
	Set  @DeleteCompanyId = (select Id FROM viCompany WHERE Id = @Id)
	if (@DeleteCompanyId is not null) 
	begin
		UPDATE [dbo].[Company]
		SET [DeleteTime] = GETDATE()
		WHERE Id = @Id
	end
	RETURN @DeleteCompanyId
END
GO
