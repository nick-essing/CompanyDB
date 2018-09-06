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
/*
Die Spalte "[dbo].[AddressToEmployee].[AdressId]" wird gelöscht, es könnte zu einem Datenverlust kommen.

Die Spalte "[dbo].[AddressToEmployee].[Id]" wird gelöscht, es könnte zu einem Datenverlust kommen.

Die Spalte "[dbo].[AddressToEmployee].[AddressId]" in der Tabelle "[dbo].[AddressToEmployee]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.
*/

IF EXISTS (select top 1 1 from [dbo].[AddressToEmployee])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
/*
Die Spalte "[dbo].[AdressToCompany].[AdressId]" wird gelöscht, es könnte zu einem Datenverlust kommen.

Die Spalte "[dbo].[AdressToCompany].[Id]" wird gelöscht, es könnte zu einem Datenverlust kommen.

Die Spalte "[dbo].[AdressToCompany].[AddressId]" in der Tabelle "[dbo].[AdressToCompany]" muss hinzugefügt werden, besitzt jedoch keinen Standardwert und unterstützt keine NULL-Werte. Wenn die Tabelle Daten enthält, funktioniert das ALTER-Skript nicht. Um dieses Problem zu vermeiden, müssen Sie der Spalte einen Standardwert hinzufügen, sie so kennzeichnen, dass NULL-Werte zulässig sind, oder die Generierung von intelligenten Standardwerten als Bereitstellungsoption aktivieren.
*/

IF EXISTS (select top 1 1 from [dbo].[AdressToCompany])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address] wird gelöscht....';


GO
ALTER TABLE [dbo].[Address] DROP CONSTRAINT [DF__tmp_ms_xx__Creat__22AA2996];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Company] wird gelöscht....';


GO
ALTER TABLE [dbo].[Company] DROP CONSTRAINT [DF__Company__Creatio__1367E606];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[department] wird gelöscht....';


GO
ALTER TABLE [dbo].[department] DROP CONSTRAINT [DF__departmen__Creat__276EDEB3];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird gelöscht....';


GO
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT [DF__Employee__Creati__286302EC];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressToEmployee] wird gelöscht....';


GO
ALTER TABLE [dbo].[AddressToEmployee] DROP CONSTRAINT [FK__AddressTo__Adres__36B12243];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AdressToCompany] wird gelöscht....';


GO
ALTER TABLE [dbo].[AdressToCompany] DROP CONSTRAINT [FK__AdressToC__Adres__38996AB5];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressToEmployee] wird gelöscht....';


GO
ALTER TABLE [dbo].[AddressToEmployee] DROP CONSTRAINT [FK__AddressTo__Emplo__37A5467C];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AdressToCompany] wird gelöscht....';


GO
ALTER TABLE [dbo].[AdressToCompany] DROP CONSTRAINT [FK__AdressToC__Compa__398D8EEE];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[department] wird gelöscht....';


GO
ALTER TABLE [dbo].[department] DROP CONSTRAINT [FK__departmen__Compa__300424B4];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[department] wird gelöscht....';


GO
ALTER TABLE [dbo].[department] DROP CONSTRAINT [FK__departmen__Emplo__30F848ED];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Employee] wird gelöscht....';


GO
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT [FK__Employee__Depart__2C3393D0];


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[Address]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Address] (
    [Id]                  INT            IDENTITY (0, 1) NOT NULL,
    [Postcode_City]       NVARCHAR (256) NULL,
    [Street_Streetnumber] NVARCHAR (256) NULL,
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
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[AddressToEmployee]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_AddressToEmployee] (
    [AddressId]  INT NOT NULL,
    [EmployeeId] INT IDENTITY (0, 1) NOT NULL,
    PRIMARY KEY CLUSTERED ([AddressId] ASC, [EmployeeId] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[AddressToEmployee])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_AddressToEmployee] ON;
        INSERT INTO [dbo].[tmp_ms_xx_AddressToEmployee] ([EmployeeId])
        SELECT   [EmployeeId]
        FROM     [dbo].[AddressToEmployee]
        ORDER BY [EmployeeId] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_AddressToEmployee] OFF;
    END

DROP TABLE [dbo].[AddressToEmployee];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_AddressToEmployee]', N'AddressToEmployee';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[AdressToCompany]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_AdressToCompany] (
    [AddressId] INT NOT NULL,
    [CompanyId] INT IDENTITY (0, 1) NOT NULL,
    PRIMARY KEY CLUSTERED ([AddressId] ASC, [CompanyId] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[AdressToCompany])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_AdressToCompany] ON;
        INSERT INTO [dbo].[tmp_ms_xx_AdressToCompany] ([CompanyId])
        SELECT   [CompanyId]
        FROM     [dbo].[AdressToCompany]
        ORDER BY [CompanyId] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_AdressToCompany] OFF;
    END

DROP TABLE [dbo].[AdressToCompany];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_AdressToCompany]', N'AdressToCompany';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[Company]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Company] (
    [Id]           INT            IDENTITY (0, 1) NOT NULL,
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
    [Id]           INT            IDENTITY (0, 1) NOT NULL,
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
    [Id]           INT            IDENTITY (0, 1) NOT NULL,
    [Name]         NVARCHAR (256) NOT NULL,
    [Salery]       MONEY          NULL,
    [CreationTime] DATETIME2 (7)  DEFAULT GetDate() NOT NULL,
    [DeleteTime]   DATETIME2 (7)  NULL,
    [DepartmentId] INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Employee])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Employee] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Employee] ([Id], [Name], [CreationTime], [DeleteTime], [DepartmentId])
        SELECT   [Id],
                 [Name],
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
PRINT N'unbenannte Einschränkungen auf [dbo].[AdressToCompany] wird erstellt....';


GO
ALTER TABLE [dbo].[AdressToCompany] WITH NOCHECK
    ADD FOREIGN KEY ([AddressId]) REFERENCES [dbo].[Address] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressToEmployee] wird erstellt....';


GO
ALTER TABLE [dbo].[AddressToEmployee] WITH NOCHECK
    ADD FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AdressToCompany] wird erstellt....';


GO
ALTER TABLE [dbo].[AdressToCompany] WITH NOCHECK
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
PRINT N'[dbo].[viAddress] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[viAddress]';


GO
PRINT N'[dbo].[viAddressToEmployee] wird geändert....';


GO
ALTER VIEW [dbo].[viAddressToEmployee]
	AS SELECT AddressId, EmployeeId FROM [AddressToEmployee]
GO
PRINT N'[dbo].[viAdressToCompany] wird geändert....';


GO
ALTER VIEW [dbo].[viAdressToCompany]
	AS SELECT AddressId, CompanyId FROM [AdressToCompany]
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
PRINT N'[dbo].[spInsert] wird erstellt....';


GO
CREATE PROCEDURE [dbo].[spInsert]
	@name varchar(30),
	@salery Money
AS
	INSERT INTO Employee(Name,Salery) 
		Values (@name, @salery)
EXEC [dbo].[spInsert]
GO
PRINT N'[dbo].[spUpdate] wird erstellt....';


GO
CREATE PROCEDURE [dbo].[spUpdate] 
	@Id int,
	@salery money
AS
	Update Employee
		SET Salery = @salery
		WHERE Id = @Id
EXEC [dbo].[spUpdate]
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
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.AddressToEmployee'), OBJECT_ID(N'dbo.AdressToCompany'), OBJECT_ID(N'dbo.department'), OBJECT_ID(N'dbo.Employee'))
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
