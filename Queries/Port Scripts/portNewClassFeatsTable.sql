CREATE TABLE [PFDB].[dbo].[ClassFeaturesSource]([class] nvarchar(255),[sub_feature_of] nvarchar(255),
[class_feature] nvarchar(255), [description] nvarchar(MAX), [level] nvarchar(255),
[source] nvarchar(255), [archetype] nvarchar(255))
SET IDENTITY_INSERT [PFDB].[dbo].[ClassFeaturesSource] ON;
INSERT INTO [PFDB].[dbo].[ClassFeaturesSource] 
SELECT [class], [sub_feature_of] ,
[class_feature], [description] , [level] ,
[source], [archetype] FROM [ClassFeats].[dbo].[class_features];
SET IDENTITY_INSERT [PFDB].[dbo].[ClassFeaturesSource] OFF;
