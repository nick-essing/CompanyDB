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
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressToEmployee] wird gelöscht....';


GO
ALTER TABLE [dbo].[AddressToEmployee] DROP CONSTRAINT [DF__tmp_ms_xx__Creat__0C85DE4D];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressToEmployee] wird gelöscht....';


GO
ALTER TABLE [dbo].[AddressToEmployee] DROP CONSTRAINT [FK__AddressTo__Addre__0D7A0286];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressToEmployee] wird gelöscht....';


GO
ALTER TABLE [dbo].[AddressToEmployee] DROP CONSTRAINT [FK__AddressTo__Emplo__0E6E26BF];


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[AddressToEmployee]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_AddressToEmployee] (
    [AddressId]    INT           NOT NULL,
    [EmployeeId]   INT           NOT NULL,
    [CreationTime] DATETIME2 (7) DEFAULT GETDATE() NOT NULL,
    [DeleteTime]   DATETIME2 (7) NULL,
    PRIMARY KEY CLUSTERED ([AddressId] ASC, [EmployeeId] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[AddressToEmployee])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_AddressToEmployee] ([AddressId], [EmployeeId], [CreationTime], [DeleteTime])
        SELECT   [AddressId],
                 [EmployeeId],
                 [CreationTime],
                 [DeleteTime]
        FROM     [dbo].[AddressToEmployee]
        ORDER BY [AddressId] ASC, [EmployeeId] ASC;
    END

DROP TABLE [dbo].[AddressToEmployee];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_AddressToEmployee]', N'AddressToEmployee';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressToEmployee] wird erstellt....';


GO
ALTER TABLE [dbo].[AddressToEmployee] WITH NOCHECK
    ADD FOREIGN KEY ([AddressId]) REFERENCES [dbo].[Address] ([Id]);


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressToEmployee] wird erstellt....';


GO
ALTER TABLE [dbo].[AddressToEmployee] WITH NOCHECK
    ADD FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([Id]);


GO
PRINT N'[dbo].[viAddressToEmployee] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[viAddressToEmployee]';


GO
PRINT N'[dbo].[viEmployeeAddress] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[viEmployeeAddress]';


GO
PRINT N'[dbo].[spAddAddressToCompany] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spAddAddressToCompany]';


GO
PRINT N'[dbo].[spAddDepartmentsToCompany] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spAddDepartmentsToCompany]';


GO
PRINT N'[dbo].[spAddEmployeesToAddresses] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spAddEmployeesToAddresses]';


GO
PRINT N'[dbo].[spAddEmployeesToDepartment] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spAddEmployeesToDepartment]';


GO
PRINT N'[dbo].[spAddManagerFromDepartmentsToEmployee] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spAddManagerFromDepartmentsToEmployee]';


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
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.AddressToEmployee'))
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
