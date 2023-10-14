  SELECT TOP (1) [Name], [Description]
	FROM [PFDB].[dbo].[Traits_Drawbacks]
	WHERE [Tag] != 'trait'
  ORDER BY NEWID();

