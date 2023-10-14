DECLARE @DesiredPrerequisites INT = 1; -- Change this to your desired number of prerequisites
DECLARE @ResultCount INT = 5; -- Change this to your desired result count

DECLARE @SelectedRow TABLE (
   [name] NVARCHAR(MAX),
   [Benefit] NVARCHAR(MAX),
   [prerequisites] NVARCHAR(MAX),
   [prerequisite_feats] NVARCHAR(MAX),
   [prerequisite_skills] NVARCHAR(MAX)
);

INSERT INTO @SelectedRow ([name], [Benefit], [prerequisites], [prerequisite_feats], [prerequisite_skills])
SELECT [name],[Benefit],[prerequisites],[prerequisite_feats],[prerequisite_skills] FROM Feats;

WITH SplitPrerequisites AS (
    SELECT
        [name],
		[Benefit],
        [prerequisites],
        [prerequisite_feats],
        [prerequisite_skills],
        (
			CASE
				WHEN [prerequisites] IS NOT NULL AND CHARINDEX(';', [prerequisites]) > 0 THEN LEN([prerequisites]) - LEN(REPLACE([prerequisites], ';', '')) + 1
				WHEN [prerequisites] IS NOT NULL AND CHARINDEX(',', [prerequisites]) > 0 THEN LEN([prerequisites]) - LEN(REPLACE([prerequisites], ',', ''))  + 1
				WHEN [prerequisites] IS NOT NULL AND CHARINDEX('and', [prerequisites]) > 0 THEN LEN([prerequisites]) - LEN(REPLACE([prerequisites], 'and', '')) + 1
				WHEN [prerequisites] IS NOT NULL AND LEN([prerequisites]) > 0 THEN 1
				ELSE 0
			END
        ) AS TotalPrerequisitesCount
    FROM @SelectedRow
)
SELECT TOP (@ResultCount) *
FROM SplitPrerequisites
WHERE TotalPrerequisitesCount = @DesiredPrerequisites AND 
(
CHARINDEX(LOWER('Cha '), [prerequisites]) >0 OR CHARINDEX(LOWER('Charisma '), [prerequisites]) >0 OR
CHARINDEX(LOWER('Str '), [prerequisites]) >0 OR CHARINDEX(LOWER('Strength '), [prerequisites]) >0 OR 
CHARINDEX(LOWER('Dex '), [prerequisites]) >0 OR CHARINDEX(LOWER('Dexterity '), [prerequisites]) >0 OR 
CHARINDEX(LOWER('Con '), [prerequisites]) >0 OR CHARINDEX(LOWER('Constitution '), [prerequisites]) >0 OR 
CHARINDEX(LOWER('Int '), [prerequisites]) >0 OR CHARINDEX(LOWER('Intelligence '), [prerequisites]) >0 OR 
CHARINDEX(LOWER('Wis '), [prerequisites]) >0 OR CHARINDEX(LOWER('Wisdom '), [prerequisites]) >0 OR
[prerequisite_skills] IS NOT NULL
) 
ORDER BY NEWID();