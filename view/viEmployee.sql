CREATE VIEW [dbo].[viEmployee]
	AS SELECT Id, Name FROM [department] WHERE DeleteTime IS NULL
