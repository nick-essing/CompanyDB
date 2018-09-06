CREATE PROCEDURE spInsertOrUpdateEmployee
	@Id int = -1,
	@name varchar(30),
	@birtdate date,
	@salery money,
	@gender int
AS
BEGIN
	declare @DBId int
	Set  @DBId = (select Id FROM Company WHERE Id = @Id)
	if (@DBId is null) 
	begin
		INSERT INTO [dbo].[Employee]([Name],[Birthdate],[Salery],[Gender])
		VALUES (@name, @birtdate, @salery,@gender)
		Set @DBId = @@IDENTITY
	end
	else
	begin
		UPDATE [dbo].[Employee]
		SET [Name] = @name, [Salery] = @salery, [Gender] = @gender
		WHERE Id = @Id
	end
	RETURN @DBId
END
GO