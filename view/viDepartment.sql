CREATE VIEW [dbo].[viDepartment]
	AS SELECT Id, Name FROM [department] WHERE DeleteTime IS Null
