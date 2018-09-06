CREATE TABLE [dbo].[Company]
(
	[Id] INT NOT NULL Identity(0,1) PRIMARY KEY, 
    [Name] NVARCHAR(256) NOT NULL,
	[CreationTime] Datetime2(7) not null DEFAULT GetDate(), 
    [DeleteTime] Datetime2(7) NULL 
)
