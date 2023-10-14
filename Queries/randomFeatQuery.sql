SELECT TOP (1) [name], [prerequisites],[prerequisite_feats],[prerequisite_skills] 
	FROM [PFDB].[dbo].[Feats]
	WHERE (prerequisite_feats IS NULL AND prerequisite_skills IS NULL AND prerequisites IS NULL)
  ORDER BY NEWID();
