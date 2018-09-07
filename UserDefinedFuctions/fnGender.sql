CREATE FUNCTION [dbo].[fnGender]
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