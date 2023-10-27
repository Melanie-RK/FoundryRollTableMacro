  SELECT TOP (1) [Name], [Description]
	FROM Traits_Drawbacks
	WHERE [Tag] != 'trait'
  ORDER BY NEWID();

