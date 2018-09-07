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
Die Spalte "[dbo].[Address].[Postcode_City]" wird gelöscht, es könnte zu einem Datenverlust kommen.

Die Spalte "[dbo].[Address].[Street_Streetnumber]" wird gelöscht, es könnte zu einem Datenverlust kommen.
*/

IF EXISTS (select top 1 1 from [dbo].[Address])
    RAISERROR (N'Zeilen wurden erkannt. Das Schemaupdate wird beendet, da es möglicherweise zu einem Datenverlust kommt.', 16, 127) WITH NOWAIT

GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address] wird gelöscht....';


GO
ALTER TABLE [dbo].[Address] DROP CONSTRAINT [DF__tmp_ms_xx__Creat__5812160E];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[AddressToEmployee] wird gelöscht....';


GO
ALTER TABLE [dbo].[AddressToEmployee] DROP CONSTRAINT [FK__AddressTo__Addre__619B8048];


GO
PRINT N'unbenannte Einschränkungen auf [dbo].[Address] wird gelöscht....';


GO
ALTER TABLE [dbo].[Address] DROP CONSTRAINT [FK__Address__Company__628FA481];


GO
PRINT N'Das erneute Erstellen der Tabelle "[dbo].[Address]" wird gestartet....';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Address] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [Postcode]     INT            NULL,
    [City]         NVARCHAR (256) NULL,
    [Street]       NVARCHAR (256) NULL,
    [Country]      NVARCHAR (256) NULL,
    [CompanyId]    INT            NULL,
    [CreationTime] DATETIME2 (7)  DEFAULT GETDATE() NOT NULL,
    [DeleteTime]   DATETIME2 (7)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Address])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Address] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Address] ([Id], [Country], [CompanyId], [CreationTime], [DeleteTime])
        SELECT   [Id],
                 [Country],
                 [CompanyId],
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
PRINT N'[dbo].[AddressToEmployee] wird geändert....';


GO
ALTER TABLE [dbo].[AddressToEmployee]
    ADD [CreationTime] DATETIME2 (7) DEFAULT GETDATE() NOT NULL,
        [DeleteTime]   DATETIME2 (7) NULL;


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
PRINT N'[dbo].[viAddress] wird geändert....';


GO
ALTER VIEW [dbo].[viAddress]
	AS 
	SELECT Id, Postcode, City, Street FROM [Address] WHERE DeleteTime IS NULL
GO
PRINT N'[dbo].[viAddressToEmployee] wird aktualisiert....';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[viAddressToEmployee]';


GO
PRINT N'[dbo].[viCompanyAddress] wird erstellt....';


GO
CREATE VIEW [dbo].[viCompanyAddress]
	AS
	SELECT  c.Id as CompanyId, a.Id as AddressId, Name, Postcode, City, Street FROM [Company] as c
	LEFT JOIN [Address] as a ON c.Id = a.Id
	WHERE c.DeleteTime is NULL AND a.DeleteTime is NULL
GO
PRINT N'[dbo].[fnGender] wird geändert....';


GO
ALTER FUNCTION [dbo].[fnGender]
(
	@gender int
)
RETURNS nvarchar(256)
AS
BEGIN
	RETURN CASE @gender
	   When 1 THEN 'männlich'
	   When 2 THEN 'weiblich'
	   When 3 THEN 'kompliziert'
	   Else 'Unbekannt'
	END
END
GO
PRINT N'[dbo].[viEmployeeAddress] wird erstellt....';


GO
CREATE VIEW [dbo].[viEmployeeAddress]
	AS 
	SELECT  e.Id as EmployeeId, a.Id as AddressId, Name, Salery, [dbo].[fnGender](Gender) AS Gender, Postcode, City, Street FROM [Employee] as e
	LEFT JOIN [Address] as a ON e.Id = a.Id 
	WHERE e.DeleteTime is NULL AND a.DeleteTime is NULL
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
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.AddressToEmployee'), OBJECT_ID(N'dbo.Address'))
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
