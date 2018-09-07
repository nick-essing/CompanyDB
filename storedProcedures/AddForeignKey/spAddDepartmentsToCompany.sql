CREATE PROCEDURE [dbo].[spAddDepartmentsToCompany]
	@DepartmentId int,
	@CompanyId int
AS
	BEGIN
	begin
		UPDATE [dbo].[Department]
		SET [CompanyId] = @CompanyId
		WHERE Id = @DepartmentId
	end
END
GO
