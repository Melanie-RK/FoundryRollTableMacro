DELETE FROM Feats;
ALTER TABLE [PFDB].[dbo].[Feats]
ADD [level_increase] float;
SET IDENTITY_INSERT [PFDB].[dbo].[Feats] ON
INSERT INTO [PFDB].[dbo].[Feats] ([name], [type], [description],
[prerequisites], [prerequisite_feats], [benefit], [normal],
[special], [source], [fulltext], [teamwork], [critical], [grit],
[style], [performance], [racial], [companion_familiar], [race_name],
[note], [goal], [completion_benefit], [multiples], [suggested_traits],
[prerequisite_skills], [panache], [betrayal], [targeting], [esoteric],
[stare], [weapon_mastery], [item_mastery], [armor_mastery], [shield_mastery], [blood_hex],
[trick], [level_increase], [id])
SELECT [name], [type], [description],
[prerequisites], [prerequisite_feats], [benefit], [normal],
[special], [source], [fulltext], [teamwork], [critical], [grit],
[style], [performance], [racial], [companion_familiar], [race_name],
[note], [goal], [completion_benefit], [multiples], [suggested_traits],
[prerequisite_skills], [panache], [betrayal], [targeting], [esoteric],
[stare], [weapon_mastery], [item_mastery], [armor_mastery], [shield_mastery], [blood_hex],
[trick], [level_increase], [id] FROM [PFDB_TEST].[dbo].[feat_test];
SELECT * FROM [PFDB].[dbo].[Feats]
SET IDENTITY_INSERT [PFDB].[dbo].[Feats] OFF
