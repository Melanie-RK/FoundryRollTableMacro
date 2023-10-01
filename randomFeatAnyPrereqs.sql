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
            CASE WHEN [prerequisites] IS NOT NULL THEN LEN([prerequisites]) - LEN(REPLACE([prerequisites], ',', '')) + 1 ELSE 0 END
            --Todo: Make it so that we check for the prerequisite count of the lines below when prerequisites is empty/NULL.
            --+ CASE WHEN [prerequisite_feats] IS NOT NULL THEN LEN([prerequisite_feats]) - LEN(REPLACE([prerequisite_feats], ',', '')) + 1 ELSE 0 END
            --+ CASE WHEN [prerequisite_skills] IS NOT NULL THEN LEN([prerequisite_skills]) - LEN(REPLACE([prerequisite_skills], ',', '')) + 1 ELSE 0 END
        ) AS TotalPrerequisitesCount
    FROM @SelectedRow
)
SELECT TOP (@ResultCount) *
FROM SplitPrerequisites
WHERE TotalPrerequisitesCount = @DesiredPrerequisites
ORDER BY NEWID();