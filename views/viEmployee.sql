CREATE VIEW [dbo].[viEmployee]
	AS 
	SELECT Id, Name, Salery, [dbo].[fnGender](Gender) AS Gender FROM [Employee] WHERE DeleteTime IS NULL

