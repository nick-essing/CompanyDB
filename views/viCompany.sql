CREATE VIEW [dbo].[viCompany]
	AS 
	SELECT Id, Name FROM [Company] where DeleteTime is null
