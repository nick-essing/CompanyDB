CREATE TABLE [dbo].[Address]
(
	[Id] INT NOT NULL Identity(0,1) PRIMARY KEY,
	[Postcode_City] NVARCHAR(256) NULL, 
    [Street_Streetnumber] NVARCHAR(256) NULL,
	[CreationTime] Datetime2(7) not null DEFAULT GetDate(), 
    [DeleteTime] Datetime2(7) NULL
)
