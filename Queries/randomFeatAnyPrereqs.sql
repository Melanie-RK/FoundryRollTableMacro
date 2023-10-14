DECLARE @DesiredPrerequisites INT = 0; -- Change this to your desired number of prerequisites
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
				WHEN [prerequisites] IS NOT NULL AND CHARINDEX('or', [prerequisites]) > 0 THEN LEN([prerequisites]) - LEN(REPLACE([prerequisites], 'or', '')) + 1
				WHEN [prerequisites] IS NOT NULL AND LEN([prerequisites]) > 0 THEN 1
				ELSE 0
			END
        ) AS TotalPrerequisitesCount
    FROM @SelectedRow
)
SELECT TOP (@ResultCount) *
FROM SplitPrerequisites
WHERE TotalPrerequisitesCount = @DesiredPrerequisites
ORDER BY NEWID();