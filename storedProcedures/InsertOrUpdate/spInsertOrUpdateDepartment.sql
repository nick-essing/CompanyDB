CREATE PROCEDURE spInsertOrUpdateDepartment
	@Id int = -1,
	@name varchar(30)
AS
BEGIN
	declare @InsertOrUpdateDepartmentId int
	Set  @InsertOrUpdateDepartmentId = (select Id FROM Department WHERE Id = @Id)
	if (@InsertOrUpdateDepartmentId is null) 
	begin
		INSERT INTO [dbo].[Department]([Name])
		VALUES (@name)
		Set @InsertOrUpdateDepartmentId = @@IDENTITY
	end
	else
	begin
		UPDATE [dbo].[Department]
		SET [Name] = @name
		WHERE Id = @Id
	end
	RETURN @InsertOrUpdateDepartmentId
END
GO