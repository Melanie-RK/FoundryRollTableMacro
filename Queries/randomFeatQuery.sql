SELECT TOP (1) [name], [prerequisites],[prerequisite_feats],[prerequisite_skills] 
	FROM Feats
  ORDER BY NEWID();
