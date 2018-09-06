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
PRINT N'[dbo].[viEmployee] wird geändert....';


GO
ALTER VIEW [dbo].[viEmployee]
	AS 
SELECT Id, Name, Salery, Gender FROM [Employee] WHERE DeleteTime IS NULL
GO
PRINT N'[dbo].[fnGender] wird erstellt....';


GO
CREATE FUNCTION [dbo].[fnGender](@gender int)
RETURNS nvarchar(256)
AS
BEGIN
declare @DBgender varchar(256)
SET @DBgender = 'fehler'
	if(@gender = 1)
		SET @DBgender = 'männlich'
	else if(@gender = 2)
		SET @DBgender = 'weiblich'
	else if(@gender = 3)
		SET @DBgender =  'sonstiges'
RETURN @DBgender
END
GO
PRINT N'[dbo].[spDeleteAddress] wird erstellt....';


GO
CREATE PROCEDURE spDeleteAddress
	@Id int
AS
BEGIN
	declare @DBId int
	Set  @DBId = (select Id FROM viDepartment WHERE Id = @Id)

	if (@DBId is not null) 
	begin
		UPDATE [dbo].[Department]
		SET [DeleteTime] = GETDATE()
		WHERE Id = @Id
	end
	SELECT @DBId
END
GO
PRINT N'[dbo].[spDeleteCompany] wird erstellt....';


GO
CREATE PROCEDURE spDeleteCompany
	@Id int
AS
BEGIN
	declare @DBId int
	Set  @DBId = (select Id FROM Address WHERE Id = @Id)
	if (@DBId is not null) 
	begin
		UPDATE [dbo].[Address]
		SET [DeleteTime] = GETDATE()
		WHERE Id = @Id
	end
	SELECT @DBId
END
GO
PRINT N'[dbo].[spDeleteDepartment] wird erstellt....';


GO
CREATE PROCEDURE spDeleteDepartment
	@Id int
AS
BEGIN
	declare @DBId int
	Set  @DBId = (select Id FROM viDepartment WHERE Id = @Id)

	if (@DBId is not null) 
	begin
		UPDATE [dbo].[Department]
		SET [DeleteTime] = GETDATE()
		WHERE Id = @Id
	end
	SELECT @DBId
END
GO
PRINT N'[dbo].[spDeleteEmployee] wird erstellt....';


GO
CREATE PROCEDURE spDeleteEmployee
	@Id int
AS
BEGIN
	declare @DBId int
	Set  @DBId = (select Id FROM viDepartment WHERE Id = @Id)

	if (@DBId is not null) 
	begin
		UPDATE [dbo].[Department]
		SET [DeleteTime] = GETDATE()
		WHERE Id = @Id
	end
	SELECT @DBId
END
GO
PRINT N'Update abgeschlossen.';


GO
