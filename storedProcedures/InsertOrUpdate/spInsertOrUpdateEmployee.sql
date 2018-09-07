CREATE PROCEDURE spInsertOrUpdateEmployee
	@Id int = -1,
	@name varchar(30),
	@birthdate date = null,
	@salery money = null,
	@gender int = null
AS
BEGIN
	declare @InsertOrUpdateEmployeeId int
	Set  @InsertOrUpdateEmployeeId = (select Id FROM Company WHERE Id = @Id)
	if (@InsertOrUpdateEmployeeId is null) 
	begin
		INSERT INTO [dbo].[Employee]([Name],[Birthdate],[Salery],[Gender])
		VALUES (@name, @birthdate, @salery, @gender)
		Set @InsertOrUpdateEmployeeId = @@IDENTITY
	end
	else
	begin
		UPDATE [dbo].[Employee]
		SET [Name] = @name, [Birthdate] = @birthdate, [Salery] = @salery, [Gender] = @gender
		WHERE Id = @Id
	end
	RETURN @InsertOrUpdateEmployeeId
END
GO