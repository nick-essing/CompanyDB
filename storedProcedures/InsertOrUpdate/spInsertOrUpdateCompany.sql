CREATE PROCEDURE spInsertOrUpdateCompany
	@Id int = -1,
	@name varchar(30)
AS
BEGIN
	declare @InsertOrUpdateCompanyId int
	Set  @InsertOrUpdateCompanyId = (select Id FROM Company WHERE Id = @Id)
	if (@InsertOrUpdateCompanyId is null) 
	begin
		INSERT INTO [dbo].[Company]([Name])
		VALUES (@name)
		Set @InsertOrUpdateCompanyId = @@IDENTITY
	end
	else
	begin
		UPDATE [dbo].[Company]
		SET [Name] = @name
		WHERE Id = @Id
	end
	RETURN @InsertOrUpdateCompanyId
END
GO