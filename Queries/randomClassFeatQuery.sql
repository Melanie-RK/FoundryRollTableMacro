  SELECT TOP (1) [class], [class_feature] AS feature_name, [description], [archetype], [sub_feature_of]
  FROM [PFDB].[dbo].[ClassFeaturesSource]
  ORDER BY NEWID();

