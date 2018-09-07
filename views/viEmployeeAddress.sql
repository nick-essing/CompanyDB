CREATE VIEW [dbo].[viEmployeeAddress]
	AS 
	SELECT  e.Id as EmployeeId, a.Id as AddressId, Name, Salery, [dbo].[fnGender](Gender) AS Gender, Postcode, City, Street FROM [Employee] as e
	LEFT JOIN [Address] as a ON e.Id = (SELECT EmployeeId FROM AddressToEmployee) AND a.Id = (SELECT AddressId FROM AddressToEmployee)
	WHERE e.DeleteTime is NULL AND a.DeleteTime is NULL
