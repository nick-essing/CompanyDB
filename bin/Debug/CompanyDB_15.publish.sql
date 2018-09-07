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
PRINT N'[dbo].[spDeleteAddress] wird geändert....';


GO
ALTER PROCEDURE spDeleteAddress
	@Id int
AS
BEGIN
	declare @DBId int
	Set  @DBId = (select Id FROM viAddress WHERE Id = @Id)

	if (@DBId is not null) 
	begin
		UPDATE [dbo].[Address]
		SET [DeleteTime] = GETDATE()
		WHERE Id = @Id
	end
	SELECT @DBId
END
GO
PRINT N'[dbo].[spDeleteCompany] wird geändert....';


GO
ALTER PROCEDURE spDeleteCompany
	@Id int
AS
BEGIN
	declare @DBId int
	Set  @DBId = (select Id FROM viCompany WHERE Id = @Id)
	if (@DBId is not null) 
	begin
		UPDATE [dbo].[Company]
		SET [DeleteTime] = GETDATE()
		WHERE Id = @Id
	end
	SELECT @DBId
END
GO
PRINT N'[dbo].[spDeleteEmployee] wird geändert....';


GO
ALTER PROCEDURE spDeleteEmployee
	@Id int
AS
BEGIN
	declare @DBId int
	Set  @DBId = (select Id FROM viEmployee WHERE Id = @Id)

	if (@DBId is not null) 
	begin
		UPDATE [dbo].[Employee]
		SET [DeleteTime] = GETDATE()
		WHERE Id = @Id
	end
	SELECT @DBId
END
GO
PRINT N'Update abgeschlossen.';


GO
