CREATE VIEW [dbo].[viDepartment]
	AS
	SELECT Id, Name FROM [Department] WHERE DeleteTime IS Null
