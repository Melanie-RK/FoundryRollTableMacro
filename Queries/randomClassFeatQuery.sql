  SELECT TOP (1) [class], [class_feature] AS feature_name, [description], [archetype], [sub_feature_of]
  FROM ClassFeaturesSource
  ORDER BY NEWID();

