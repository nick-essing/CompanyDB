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
PRINT N'[dbo].[spInsertEmployee] wird geändert....';


GO
ALTER PROCEDURE spInsertEmployee
	@Id int = -1,
	@name varchar(30),
	@salery Money,
	@gender int
AS
BEGIN
	declare @DBId int
	Set  @DBId = (select Id FROM Company WHERE Id = @Id)
	if (@DBId is null) 
	begin
		INSERT INTO [dbo].[Employee]([Name],[Salery],[Gender])
		VALUES (@name,@salery,@gender)
		Set @DBId = @@IDENTITY
	end
	else
	begin
		UPDATE [dbo].[Employee]
		SET [Name] = @name, [Salery] = @salery, [Gender] = @gender
		WHERE Id = @Id
	end
	SELECT @DBId
END
GO
PRINT N'[dbo].[spInsertOrUpdateCompany] wird erstellt....';


GO
CREATE PROCEDURE spInsertOrUpdateCompany
	@Id int = -1,
	@name varchar(30)
AS
BEGIN
	declare @DBId int
	Set  @DBId = (select Id FROM Company WHERE Id = @Id)
	if (@DBId is null) 
	begin
		INSERT INTO [dbo].[Company]([Name])
		VALUES (@name)
		Set @DBId = @@IDENTITY
	end
	else
	begin
		UPDATE [dbo].[Company]
		SET [Name] = @name
		WHERE Id = @Id
	end
	SELECT @DBId
END
GO
PRINT N'[dbo].[spInsertOrUpdateDepartment] wird erstellt....';


GO
CREATE PROCEDURE spInsertOrUpdateDepartment
	@Id int = -1,
	@name varchar(30)
AS
BEGIN
	declare @DBId int
	Set  @DBId = (select Id FROM Department WHERE Id = @Id)
	if (@DBId is null) 
	begin
		INSERT INTO [dbo].[Department]([Name])
		VALUES (@name)
		Set @DBId = @@IDENTITY
	end
	else
	begin
		UPDATE [dbo].[Department]
		SET [Name] = @name
		WHERE Id = @Id
	end
	SELECT @DBId
END
GO
PRINT N'Update abgeschlossen.';


GO
