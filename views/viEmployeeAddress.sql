CREATE VIEW [dbo].[viEmployeeAddress]
	AS 
	SELECT  e.Id as EmployeeId, a.Id as AddressId, Name, Salery,Gender, Postcode, City, Street FROM [Employee] as e
	LEFT JOIN [Address] as a ON e.Id = a.Id
