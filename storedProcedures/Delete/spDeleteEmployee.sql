CREATE PROCEDURE spDeleteEmployee
	@Id int
AS
BEGIN
	declare @DeleteEmployeeId int
	Set  @DeleteEmployeeId = (select Id FROM viEmployee WHERE Id = @Id)

	if (@DeleteEmployeeId is not null) 
	begin
		UPDATE [dbo].[Employee]
		SET [DeleteTime] = GETDATE()
		WHERE Id = @Id
	end
	RETURN @DeleteEmployeeId
END
GO
