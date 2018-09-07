CREATE PROCEDURE [dbo].[spAddManagerFromDepartmentsToEmployee]
	@ManagerEmployeeId int,
	@DepartmentId int
AS
	BEGIN
	begin
		UPDATE [dbo].[Department]
		SET [EmployeeId] = @ManagerEmployeeId
		WHERE Id = @DepartmentId
	end
END
GO
