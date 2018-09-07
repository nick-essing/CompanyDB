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
PRINT N'[dbo].[spAddEmployeesToAddresses] wird geändert....';


GO
ALTER PROCEDURE [dbo].[spAddEmployeesToAddresses]
	@EmployeeId int,
	@AddressId int
AS
	BEGIN
	declare @DBIdEmployee int
	declare @DBIdAddress int
	declare @DBNULL int
	Set  @DBIdEmployee = (select Id FROM Employee WHERE Id = @EmployeeId)
	Set  @DBIdAddress = (select Id FROM Address WHERE Id = @AddressId)
	Set  @DBNULL = (select EmployeeId FROM AddressToEmployee WHERE EmployeeId = @EmployeeId AND AddressId = @AddressId)
	if (@DBIdEmployee is not null AND @DBIdAddress is not null AND @DBNULL is not null) 
	begin
		INSERT INTO [dbo].[AddressToEmployee]([AddressId], [EmployeeId], [CreationTime])
		VALUES (@DBIdAddress, @DBIdEmployee, GETDATE())
	end
	RETURN @DBIdEmployee
END
GO
PRINT N'Update abgeschlossen.';


GO
