CREATE PROCEDURE [dbo].[spAddEmployeesToDepartment]
	@EmployeeId int,
	@DepartmentId int
AS
	BEGIN
	begin
		UPDATE [dbo].[Employee]
		SET [DepartmentId] = @DepartmentId
		WHERE Id = @EmployeeId
	end
END
GO
