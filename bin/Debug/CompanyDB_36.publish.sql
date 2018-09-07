/*
Bereitstellungsskript für Training-NI-CompanyDB

Dieser Code wurde von einem Tool generiert.
Änderungen an dieser Datei führen möglicherweise zu falschem Verhalten und gehen verloren, falls
der Code neu generiert wird.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Training-NI-CompanyDB"
:setvar DefaultFilePrefix "Training-NI-CompanyDB"
:setvar DefaultDataPath "D:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "D:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Überprüfen Sie den SQLCMD-Modus, und deaktivieren Sie die Skriptausführung, wenn der SQLCMD-Modus nicht unterstützt wird.
Um das Skript nach dem Aktivieren des SQLCMD-Modus erneut zu aktivieren, führen Sie folgenden Befehl aus:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Der SQLCMD-Modus muss aktiviert sein, damit dieses Skript erfolgreich ausgeführt werden kann.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'[dbo].[viCompanyAddress] wird geändert....';


GO
ALTER VIEW [dbo].[viCompanyAddress]
	AS
	SELECT  c.Id as CompanyId, a.Id as AddressId, Name, Postcode, City, Street FROM [Company] as c
	LEFT JOIN [Address] as a ON a.CompanyId = c.Id 
	WHERE c.DeleteTime is NULL AND a.DeleteTime is NULL
GO
PRINT N'[dbo].[viEmployeeAddress] wird geändert....';


GO
ALTER VIEW [dbo].[viEmployeeAddress]
	AS 
	SELECT  e.Id as EmployeeId, a.Id as AddressId, Name, Salery, [dbo].[fnGender](Gender) AS Gender, Postcode, City, Street FROM [Employee] as e
	LEFT JOIN [Address] as a ON e.Id = (SELECT EmployeeId FROM AddressToEmployee) AND a.Id = (SELECT AddressId FROM AddressToEmployee)
	WHERE e.DeleteTime is NULL AND a.DeleteTime is NULL
GO
PRINT N'[dbo].[spInsertOrUpdateAddress] wird geändert....';


GO
ALTER PROCEDURE spInsertOrUpdateAddress
	@Id int = -1,
	@postcode int,
	@city nvarchar(256) = null,
	@street nvarchar(256) = null,
	@country nvarchar(256) = null
AS
BEGIN
	declare @InsertOrUpdateAddressId int
	Set  @InsertOrUpdateAddressId = (select Id FROM Address WHERE Id = @Id)
	if (@InsertOrUpdateAddressId is null) 
	begin
		INSERT INTO [dbo].[Address]([Postcode],[City], [Street],[Country],[CreationTime])
		VALUES (@postcode, @city, @street, @country, GETDATE())
		Set @InsertOrUpdateAddressId = @@IDENTITY
	end
	else
	begin
		UPDATE [dbo].[Address]
		SET [Postcode] = @postcode, [City] = @city, [Street] = @street, [Country] = @country
		WHERE Id = @Id
	end
	RETURN @InsertOrUpdateAddressId
END
GO
PRINT N'Update abgeschlossen.';


GO
