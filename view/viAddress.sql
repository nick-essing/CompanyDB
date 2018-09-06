CREATE VIEW [dbo].[viAddress]
	AS SELECT Id, Postcode_City, Street_Streetnumber FROM [Address] WHERE DeleteTime IS NULL
