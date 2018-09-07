CREATE PROCEDURE spDeleteDepartment
	@Id int
AS
BEGIN
	declare @DeleteDepartmentId int
	Set  @DeleteDepartmentId  = (select Id FROM viDepartment WHERE Id = @Id)

	if (@DeleteDepartmentId  is not null) 
	begin
		UPDATE [dbo].[Department]
		SET [DeleteTime] = GETDATE()
		WHERE Id = @Id
	end
	RETURN @DeleteDepartmentId
END
GO
