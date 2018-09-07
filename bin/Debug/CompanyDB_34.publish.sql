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
END
GO
PRINT N'[dbo].[spAddManagerFromDepartmentsToEmployee] wird geändert....';


GO
ALTER PROCEDURE [dbo].[spAddManagerFromDepartmentsToEmployee]
	@EmployeeId int,
	@AddressId int
AS
	BEGIN
	declare @IdEmployee int
	declare @IdAddress int
	declare @NULL int
	Set  @IdEmployee = (select Id FROM Employee WHERE Id = @EmployeeId)
	Set  @IdAddress = (select Id FROM Address WHERE Id = @AddressId)
	Set  @NULL = (select EmployeeId FROM AddressToEmployee WHERE EmployeeId = @EmployeeId AND AddressId = @AddressId)
	if (@IdEmployee is not null AND @IdAddress is not null AND @NULL is not null) 
	begin
		INSERT INTO [dbo].[AddressToEmployee]([AddressId],[EmployeeId])
		VALUES (@IdAddress, @IdEmployee)
	end
END
GO
PRINT N'[dbo].[spInsertOrUpdateEmployee] wird geändert....';


GO
ALTER PROCEDURE spInsertOrUpdateEmployee
	@Id int = -1,
	@name varchar(30),
	@birthdate date = null,
	@salery money = null,
	@gender int = null
AS
BEGIN
	declare @InsertOrUpdateEmployeeId int
	Set  @InsertOrUpdateEmployeeId = (select Id FROM Company WHERE Id = @Id)
	if (@InsertOrUpdateEmployeeId is null) 
	begin
		INSERT INTO [dbo].[Employee]([Name],[Birthdate],[Salery],[Gender],[CreationTime])
		VALUES (@name, @birthdate, @salery, @gender, GETDATE())
		Set @InsertOrUpdateEmployeeId = @@IDENTITY
	end
	else
	begin
		UPDATE [dbo].[Employee]
		SET [Name] = @name, [Birthdate] = @birthdate, [Salery] = @salery, [Gender] = @gender
		WHERE Id = @Id
	end
	RETURN @InsertOrUpdateEmployeeId
END
GO
PRINT N'Update abgeschlossen.';


GO
