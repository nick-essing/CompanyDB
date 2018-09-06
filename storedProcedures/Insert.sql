CREATE PROCEDURE [dbo].[Insert]
	@name varchar(30),
	@salery Money
AS
	INSERT INTO Employee(Name,Salery) 
		Values (@name, @salery)
EXEC [dbo].[Insert]
