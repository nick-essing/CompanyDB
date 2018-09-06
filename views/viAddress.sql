CREATE VIEW [dbo].[viAddress]
	AS SELECT Id, Postcode, City, Street FROM [Address] WHERE DeleteTime IS NULL
