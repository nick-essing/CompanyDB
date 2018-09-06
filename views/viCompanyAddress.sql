CREATE VIEW [dbo].[viCompanyAddress]
	AS
	SELECT  c.Id as CompanyId, a.Id as AddressId, Name, Postcode, City, Street FROM [Company] as c
	LEFT JOIN [Address] as a ON c.Id = a.Id
