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
PRINT N'[dbo].[spAddAddressToCompany] wird geändert....';


GO
ALTER PROCEDURE [dbo].[spAddAddressToCompany]
	@EmployeeId int,
	@AddressId int
AS
	BEGIN
	begin
		INSERT INTO [dbo].[AddressToEmployee]([AddressId],[EmployeeId])
		VALUES (@AddressId, @EmployeeId)
	end
END
GO
PRINT N'[dbo].[spAddDepartmentsToCompany] wird geändert....';


GO
ALTER PROCEDURE [dbo].[spAddDepartmentsToCompany]
	@DepartmentId int,
	@CompanyId int
AS
	BEGIN
	begin
		UPDATE [dbo].[Department]
		SET [CompanyId] = @CompanyId
		WHERE Id = @DepartmentId
	end
END
GO
PRINT N'[dbo].[spAddEmployeesToDepartment] wird geändert....';


GO
ALTER PROCEDURE [dbo].[spAddEmployeesToDepartment]
	@EmployeeId int,
	@DepartmentId int
AS
	BEGIN
	begin
		UPDATE [dbo].[Employee]
		SET [DepartmentId] = @DepartmentId
		WHERE Id = @EmployeeId
	end
END
GO
PRINT N'[dbo].[spAddManagerFromDepartmentsToEmployee] wird geändert....';


GO
ALTER PROCEDURE [dbo].[spAddManagerFromDepartmentsToEmployee]
	@ManagerEmployeeId int,
	@DepartmentId int
AS
	BEGIN
	begin
		UPDATE [dbo].[Department]
		SET [EmployeeId] = @ManagerEmployeeId
		WHERE Id = @DepartmentId
	end
END
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
		INSERT INTO [dbo].[Address]([Postcode],[City], [Street],[Country])
		VALUES (@postcode, @city, @street, @country)
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
PRINT N'[dbo].[spInsertOrUpdateCompany] wird geändert....';


GO
ALTER PROCEDURE spInsertOrUpdateCompany
	@Id int = -1,
	@name varchar(30)
AS
BEGIN
	declare @InsertOrUpdateCompanyId int
	Set  @InsertOrUpdateCompanyId = (select Id FROM Company WHERE Id = @Id)
	if (@InsertOrUpdateCompanyId is null) 
	begin
		INSERT INTO [dbo].[Company]([Name])
		VALUES (@name)
		Set @InsertOrUpdateCompanyId = @@IDENTITY
	end
	else
	begin
		UPDATE [dbo].[Company]
		SET [Name] = @name
		WHERE Id = @Id
	end
	RETURN @InsertOrUpdateCompanyId
END
GO
PRINT N'[dbo].[spInsertOrUpdateDepartment] wird geändert....';


GO
ALTER PROCEDURE spInsertOrUpdateDepartment
	@Id int = -1,
	@name varchar(30)
AS
BEGIN
	declare @InsertOrUpdateDepartmentId int
	Set  @InsertOrUpdateDepartmentId = (select Id FROM Department WHERE Id = @Id)
	if (@InsertOrUpdateDepartmentId is null) 
	begin
		INSERT INTO [dbo].[Department]([Name])
		VALUES (@name)
		Set @InsertOrUpdateDepartmentId = @@IDENTITY
	end
	else
	begin
		UPDATE [dbo].[Department]
		SET [Name] = @name
		WHERE Id = @Id
	end
	RETURN @InsertOrUpdateDepartmentId
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
		INSERT INTO [dbo].[Employee]([Name],[Birthdate],[Salery],[Gender])
		VALUES (@name, @birthdate, @salery, @gender)
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
