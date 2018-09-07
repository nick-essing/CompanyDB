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
PRINT N'unbenannte Einschränkungen auf [dbo].[Address] wird gelöscht....';


GO
ALTER TABLE [dbo].[Address] DROP CONSTRAINT [DF__tmp_ms_xx__Creat__3E52440B];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Company] wird gelöscht....';


GO
ALTER TABLE [dbo].[Company] DROP CONSTRAINT [DF__tmp_ms_xx__Creat__44FF419A];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[department] wird gelöscht....';


GO
ALTER TABLE [dbo].[department] DROP CONSTRAINT [DF__tmp_ms_xx__Creat__47DBAE45];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird gelöscht....';


GO
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT [DF__tmp_ms_xx__Creat__4AB81AF0];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressToEmployee] wird gelöscht....';


GO
ALTER TABLE [dbo].[AddressToEmployee] DROP CONSTRAINT [FK__AddressTo__Addre__4BAC3F29];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AdressToCompany] wird gelöscht....';


GO
ALTER TABLE [dbo].[AdressToCompany] DROP CONSTRAINT [FK__AdressToC__Addre__4CA06362];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AdressToCompany] wird gelöscht....';


GO
ALTER TABLE [dbo].[AdressToCompany] DROP CONSTRAINT [FK__AdressToC__Compa__4E88ABD4];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[department] wird gelöscht....';


GO
ALTER TABLE [dbo].[department] DROP CONSTRAINT [FK__departmen__Compa__4F7CD00D];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[department] wird gelöscht....';


GO
ALTER TABLE [dbo].[department] DROP CONSTRAINT [FK__departmen__Emplo__5070F446];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird gelöscht....';


GO
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT [FK__Employee__Depart__5165187F];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressToEmployee] wird gelöscht....';


GO
ALTER TABLE [dbo].[AddressToEmployee] DROP CONSTRAINT [FK__AddressTo__Emplo__4D94879B];


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[Address]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Address] (
    [Id]                  INT            IDENTITY (1, 1) NOT NULL,
    [Postcode_City]       NVARCHAR (256) NULL,
    [Street_Streetnumber] NVARCHAR (256) NULL,
    [Country]             NVARCHAR (256) NULL,
    [CompanyId]           INT            NULL,
    [CreationTime]        DATETIME2 (7)  DEFAULT GetDate() NOT NULL,
    [DeleteTime]          DATETIME2 (7)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Address])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Address] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Address] ([Id], [Postcode_City], [Street_Streetnumber], [CreationTime], [DeleteTime])
        SELECT   [Id],
                 [Postcode_City],
                 [Street_Streetnumber],
                 [CreationTime],
                 [DeleteTime]
        FROM     [dbo].[Address]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Address] OFF;
    END

DROP TABLE [dbo].[Address];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Address]', N'Address';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[Company]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Company] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (256) NOT NULL,
    [CreationTime] DATETIME2 (7)  DEFAULT GetDate() NOT NULL,
    [DeleteTime]   DATETIME2 (7)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Company])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Company] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Company] ([Id], [Name], [CreationTime], [DeleteTime])
        SELECT   [Id],
                 [Name],
                 [CreationTime],
                 [DeleteTime]
        FROM     [dbo].[Company]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Company] OFF;
    END

DROP TABLE [dbo].[Company];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Company]', N'Company';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[department]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_department] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (256) NOT NULL,
    [CreationTime] DATETIME2 (7)  DEFAULT GetDate() NOT NULL,
    [DeleteTime]   DATETIME2 (7)  NULL,
    [CompanyId]    INT            NULL,
    [EmployeeId]   INT            NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[department])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_department] ON;
        INSERT INTO [dbo].[tmp_ms_xx_department] ([Id], [Name], [CreationTime], [DeleteTime], [CompanyId], [EmployeeId])
        SELECT   [Id],
                 [Name],
                 [CreationTime],
                 [DeleteTime],
                 [CompanyId],
                 [EmployeeId]
        FROM     [dbo].[department]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_department] OFF;
    END

DROP TABLE [dbo].[department];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_department]', N'department';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[Employee]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Employee] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [Name]         NVARCHAR (256) NOT NULL,
    [Salery]       MONEY          NULL,
    [Gender]       INT            NULL,
    [CreationTime] DATETIME2 (7)  DEFAULT GetDate() NOT NULL,
    [DeleteTime]   DATETIME2 (7)  NULL,
    [DepartmentId] INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Employee])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Employee] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Employee] ([Id], [Name], [Salery], [CreationTime], [DeleteTime], [DepartmentId])
        SELECT   [Id],
                 [Name],
                 [Salery],
                 [CreationTime],
                 [DeleteTime],
                 [DepartmentId]
        FROM     [dbo].[Employee]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Employee] OFF;
    END

DROP TABLE [dbo].[Employee];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Employee]', N'Employee';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressToEmployee] wird erstellt....';


GO
ALTER TABLE [dbo].[AddressToEmployee] WITH NOCHECK
    ADD FOREIGN KEY ([AddressId]) REFERENCES [dbo].[Address] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address] wird erstellt....';


GO
ALTER TABLE [dbo].[Address] WITH NOCHECK
    ADD FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Company] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[department] wird erstellt....';


GO
ALTER TABLE [dbo].[department] WITH NOCHECK
    ADD FOREIGN KEY ([CompanyId]) REFERENCES [dbo].[Company] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[department] wird erstellt....';


GO
ALTER TABLE [dbo].[department] WITH NOCHECK
    ADD FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird erstellt....';


GO
ALTER TABLE [dbo].[Employee] WITH NOCHECK
    ADD FOREIGN KEY ([DepartmentId]) REFERENCES [dbo].[department] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressToEmployee] wird erstellt....';


GO
ALTER TABLE [dbo].[AddressToEmployee] WITH NOCHECK
    ADD FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([Id]);


GO
PRINT N'[dbo].[viAddress] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[viAddress]';


GO
PRINT N'[dbo].[viCompany] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[viCompany]';


GO
PRINT N'[dbo].[viDepartment] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[viDepartment]';


GO
PRINT N'[dbo].[viEmployee] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[viEmployee]';


GO
PRINT N'[dbo].[spInsertEmployee] wird geändert....';


GO
ALTER PROCEDURE spInsertEmployee
	@Id int,
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
PRINT N'[dbo].[spInsertOrUpdateAddress] wird erstellt....';


GO
CREATE PROCEDURE spInsertOrUpdateAddress
	@Id int,
	@name varchar(30),
	@postcode_city nvarchar(256),
	@street_streetnumber nvarchar(256),
	@country nvarchar(256)
AS
BEGIN
	declare @DBId int
	Set  @DBId = (select Id FROM Address WHERE Id = @Id)
	if (@DBId is null) 
	begin
		INSERT INTO [dbo].[Address]([Postcode_City],[Street_Streetnumber],[Country])
		VALUES (@name, @postcode_city, @street_streetnumber, @country)
		Set @DBId = @@IDENTITY
	end
	else
	begin
		UPDATE [dbo].[Address]
		SET [Postcode_City] = @postcode_city, [Street_Streetnumber] = @street_streetnumber, [Country] = @country
		WHERE Id = @Id
	end
	SELECT @DBId
END
GO
PRINT N'[dbo].[spInsertOrUpdateCompany] wird erstellt....';


GO
CREATE PROCEDURE spInsertOrUpdateCompany
	@Id int,
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
	@Id int,
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
PRINT N'Vorhandene Daten werden auf neu erstellte Einschränkungen hin überprüft.';


GO
USE [$(DatabaseName)];


GO
CREATE TABLE [#__checkStatus] (
    id           INT            IDENTITY (1, 1) PRIMARY KEY CLUSTERED,
    [Schema]     NVARCHAR (256),
    [Table]      NVARCHAR (256),
    [Constraint] NVARCHAR (256)
);

SET NOCOUNT ON;

DECLARE tableconstraintnames CURSOR LOCAL FORWARD_ONLY
    FOR SELECT SCHEMA_NAME([schema_id]),
               OBJECT_NAME([parent_object_id]),
               [name],
               0
        FROM   [sys].[objects]
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.AddressToEmployee'), OBJECT_ID(N'dbo.Address'), OBJECT_ID(N'dbo.department'), OBJECT_ID(N'dbo.Employee'))
               AND [type] IN (N'F', N'C')
                   AND [object_id] IN (SELECT [object_id]
                                       FROM   [sys].[check_constraints]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0
                                       UNION
                                       SELECT [object_id]
                                       FROM   [sys].[foreign_keys]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0);

DECLARE @schemaname AS NVARCHAR (256);

DECLARE @tablename AS NVARCHAR (256);

DECLARE @checkname AS NVARCHAR (256);

DECLARE @is_not_trusted AS INT;

DECLARE @statement AS NVARCHAR (1024);

BEGIN TRY
    OPEN tableconstraintnames;
    FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
    WHILE @@fetch_status = 0
        BEGIN
            PRINT N'Einschränkung wird überprüft: ' + @checkname + N' [' + @schemaname + N'].[' + @tablename + N']';
            SET @statement = N'ALTER TABLE [' + @schemaname + N'].[' + @tablename + N'] WITH ' + CASE @is_not_trusted WHEN 0 THEN N'CHECK' ELSE N'NOCHECK' END + N' CHECK CONSTRAINT [' + @checkname + N']';
            BEGIN TRY
                EXECUTE [sp_executesql] @statement;
            END TRY
            BEGIN CATCH
                INSERT  [#__checkStatus] ([Schema], [Table], [Constraint])
                VALUES                  (@schemaname, @tablename, @checkname);
            END CATCH
            FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
        END
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') >= 0
    CLOSE tableconstraintnames;

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') = -1
    DEALLOCATE tableconstraintnames;

SELECT N'Fehler beim Überprüfen der Einschränkung:' + [Schema] + N'.' + [Table] + N',' + [Constraint]
FROM   [#__checkStatus];

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'Fehler beim Überprüfen von Einschränkungen', 16, 127);
    END

SET NOCOUNT OFF;

DROP TABLE [#__checkStatus];


GO
PRINT N'Update abgeschlossen.';


GO
