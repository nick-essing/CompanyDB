CREATE PROCEDURE [dbo].[Update] 
	@Id int,
	@salery money
AS
	Update Employee
		SET Salery = @salery
		WHERE Id = @Id
EXEC [dbo].[Update]
