DELETE FROM Feats;
DBCC CHECKIDENT ('[Feats]', RESEED, 0);
GO
INSERT INTO [PFDB].[dbo].[Feats] ([name], [type], [description],
[prerequisites], [prerequisite_feats], [benefit], [normal],
[special], [source], [fulltext], [teamwork], [critical], [grit],
[style], [performance], [racial], [companion_familiar], [race_name],
[note], [goal], [completion_benefit], [multiples], [suggested_traits],
[prerequisite_skills], [panache], [betrayal], [targeting], [esoteric],
[stare], [weapon_mastery], [item_mastery], [armor_mastery], [shield_mastery], [blood_hex],
[trick], [level_increase])
SELECT [name], [type], [description],
[prerequisites], [prerequisite_feats], [benefit], [normal],
[special], [source], [fulltext], [teamwork], [critical], [grit],
[style], [performance], [racial], [companion_familiar], [race_name],
[note], [goal], [completion_benefit], [multiples], [suggested_traits],
[prerequisite_skills], [panache], [betrayal], [targeting], [esoteric],
[stare], [weapon_mastery], [item_mastery], [armor_mastery], [shield_mastery], [blood_hex],
[trick], [level_increase] FROM [PFDB_TEST].[dbo].[feat_test];
SELECT * FROM [PFDB].[dbo].[Feats]
