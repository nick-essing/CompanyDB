CREATE FUNCTION [dbo].[fnGender]
(
	@gender int
)
RETURNS nvarchar(256)
AS
BEGIN
declare @DBgender nvarchar(256)
	CASE @gender
	   When 1 THEN SET @DBGender = 'männlich'
	   When 2 THEN SET @DBGender = 'weiblich'
	   When 3 THEN SET @DBGender = 'kompliziert'
	   Else SET @DBgender = 'Unbekannt'
  END
  RETURN @DBgender
END
