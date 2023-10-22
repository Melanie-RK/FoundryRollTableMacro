DECLARE @DesiredPrerequisites INT = 0; -- Change this to your desired number of prerequisites
DECLARE @ResultCount INT = 5; -- Change this to your desired result count

DECLARE @SelectedRow TABLE (
   [Id] INT,
   [name] NVARCHAR(MAX),
   [Benefit] NVARCHAR(MAX),
   [Description] NVARCHAR(MAX),
   [prerequisites] NVARCHAR(MAX),
   [prerequisite_feats] NVARCHAR(MAX),
   [prerequisite_skills] NVARCHAR(MAX),
   [TotalPrerequisitesCount] INT,
   [FoundDelimeter] NVARCHAR(3)
);

DECLARE @ValidRow TABLE (
   [Id] INT,
   [name] NVARCHAR(MAX),
   [Benefit] NVARCHAR(MAX),
   [Description] NVARCHAR(MAX),
   [prerequisites] NVARCHAR(MAX),
   [prerequisite_feats] NVARCHAR(MAX),
   [prerequisite_skills] NVARCHAR(MAX),
   [TotalPrerequisitesCount] INT,
   [FoundDelimeter] NVARCHAR(3)
);

-- Populate @SelectedRow with data
INSERT INTO @SelectedRow ([Id], [name], [Benefit], [prerequisites], [prerequisite_feats], [prerequisite_skills])
SELECT [id], [name], [Benefit], [prerequisites], [prerequisite_feats], [prerequisite_skills]
FROM Feats;

-- Update TotalPrerequisiteCount and FoundDelimeter
UPDATE @SelectedRow
SET [TotalPrerequisitesCount] = CASE
    	WHEN [prerequisites] IS NOT NULL AND CHARINDEX(';', [prerequisites]) > 0 THEN LEN([prerequisites]) - LEN(REPLACE([prerequisites], ';', '')) + 1
		WHEN [prerequisites] IS NOT NULL AND CHARINDEX(',', [prerequisites]) > 0 THEN LEN([prerequisites]) - LEN(REPLACE([prerequisites], ',', ''))  + 1
		WHEN [prerequisites] IS NOT NULL AND CHARINDEX(' and ', [prerequisites]) > 0 THEN (LEN([prerequisites]) - LEN(REPLACE([prerequisites], ' and ', '')) + 1) / 3
		WHEN [prerequisites] IS NOT NULL AND LEN([prerequisites]) > 0 THEN 1
		ELSE 0
    END,
    [FoundDelimeter] = CASE
    WHEN CHARINDEX(';', [prerequisites]) > 0 THEN ';'
    WHEN CHARINDEX(',', [prerequisites]) > 0 THEN ','
    WHEN CHARINDEX(' and ', [prerequisites]) > 0 THEN 'and'
    ELSE NULL
END;

--SELECT * FROM @SelectedRow

-- Set up for splitting prerequisite on delimeter
DECLARE @FeatID INT;
DECLARE @Prerequisite NVARCHAR(MAX);
DECLARE @Pattern NVARCHAR(100) = N'%cha [0-9]%';
DECLARE @Pattern1 NVARCHAR(100) = N'%int [0-9]%';
DECLARE @Pattern2 NVARCHAR(100) = N'%con [0-9]%';
DECLARE @Pattern3 NVARCHAR(100) = N'%str [0-9]%';
DECLARE @Pattern4 NVARCHAR(100) = N'%wis [0-9]%';
DECLARE @Pattern5 NVARCHAR(100) = N'%dex [0-9]%';
DECLARE @Pattern6 NVARCHAR(100) = N'%charisma [0-9]%';
DECLARE @Pattern7 NVARCHAR(100) = N'%intelligence [0-9]%';
DECLARE @Pattern8 NVARCHAR(100) = N'%constitution [0-9]%';
DECLARE @Pattern9 NVARCHAR(100) = N'%strength [0-9]%';
DECLARE @Pattern10 NVARCHAR(100) = N'%wisdom [0-9]%';
DECLARE @Pattern11 NVARCHAR(100) = N'%dexterity [0-9]%';
DECLARE @Pattern12 NVARCHAR(100) = N'%BAB %';
DECLARE @Pattern13 NVARCHAR(100) = N'%base attack bonus%';
DECLARE @Pattern14 NVARCHAR(100) = N'%proficient with armor%';
DECLARE @Pattern15 NVARCHAR(100) = N'%proficient with shield%';
DECLARE @Pattern16 NVARCHAR(100) = N'%proficient with weapon%';
DECLARE @Pattern17 NVARCHAR(100) = N'% rank%';

DECLARE prerequisite_cursor CURSOR FOR
SELECT id, prerequisites
FROM Feats;

OPEN prerequisite_cursor;

FETCH NEXT FROM prerequisite_cursor INTO @FeatID, @Prerequisite;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Split the prerequisites based on the FoundDelimeter
	DECLARE @PrerequisiteArray NVARCHAR(MAX);

	SELECT @PrerequisiteArray = @Prerequisite
	FROM @SelectedRow SR
	WHERE SR.[Id] = @FeatID;

	-- Replace the delimiter with a common one (e.g., comma) to use STRING_SPLIT
	SET @PrerequisiteArray = REPLACE(@PrerequisiteArray, (SELECT FoundDelimeter FROM @SelectedRow WHERE Id = @FeatID), ',');

	-- Split the string using STRING_SPLIT
	DECLARE @PrerequisitesTable TABLE (Prerequisite NVARCHAR(MAX));
	INSERT INTO @PrerequisitesTable (Prerequisite)
	SELECT value
	FROM STRING_SPLIT(@PrerequisiteArray, ',');

	DECLARE @TempPrerequisitesCount BIT;
	SELECT @TempPrerequisitesCount = COUNT(prerequisites) FROM Feats WHERE Id = @FeatID AND prerequisites IS NOT NULL AND LEN(prerequisites) > 0;

	-- Check if the original Prerequisites field should be included
	IF @TempPrerequisitesCount = 1
	BEGIN
		-- Include the original Prerequisites value
		INSERT INTO @PrerequisitesTable (Prerequisite) SELECT prerequisites FROM Feats WHERE Id = @FeatID;
	END

    DECLARE @Substring NVARCHAR(MAX);

	-- Check each substring for the pattern
    DECLARE @IsValid BIT = 1;

	-- Fill in dummy value to make sure each row processes.
	INSERT INTO @PrerequisitesTable (Prerequisite) SELECT 'Cha 1'

	-- SELECT * FROM @PrerequisitesTable

    DECLARE substring_cursor CURSOR FOR
    SELECT Prerequisite
    FROM @PrerequisitesTable;

    OPEN substring_cursor;

    FETCH NEXT FROM substring_cursor INTO @Substring;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF
		LOWER(@Substring) NOT LIKE '%cha 1%' AND
		LOWER(@Substring) NOT LIKE @Pattern AND
		LOWER(@Substring) NOT LIKE @Pattern2 AND
		LOWER(@Substring) NOT LIKE @Pattern3 AND
		LOWER(@Substring) NOT LIKE @Pattern4 AND
		LOWER(@Substring) NOT LIKE @Pattern5 AND
		LOWER(@Substring) NOT LIKE @Pattern6 AND
		LOWER(@Substring) NOT LIKE @Pattern7 AND
		LOWER(@Substring) NOT LIKE @Pattern8 AND
		LOWER(@Substring) NOT LIKE @Pattern9 AND
		LOWER(@Substring) NOT LIKE @Pattern10 AND
		LOWER(@Substring) NOT LIKE @Pattern11 AND
		LOWER(@Substring) NOT LIKE @Pattern12 AND
		LOWER(@Substring) NOT LIKE @Pattern13 AND
		LOWER(@Substring) NOT LIKE @Pattern14 AND
		LOWER(@Substring) NOT LIKE @Pattern15 AND
		LOWER(@Substring) NOT LIKE @Pattern16 AND
		LOWER(@Substring) NOT LIKE @Pattern17
        BEGIN
            SET @IsValid = 0;
            BREAK;
        END

        FETCH NEXT FROM substring_cursor INTO @Substring;
    END

    CLOSE substring_cursor;
    DEALLOCATE substring_cursor;
	DELETE FROM @PrerequisitesTable;

    -- If all substrings conform to the pattern, do further processing
    IF @IsValid = 1
    BEGIN
        -- Add your processing logic here for the rows that meet the criteria
        -- You can use the @FeatID to identify and work with the specific row

        -- Insert valid row
        INSERT INTO @ValidRow (Id, name, Benefit, Description, prerequisites, prerequisite_skills, TotalPrerequisitesCount)
		SELECT F.Id, F.name, F.Benefit, F.Description, F.prerequisites, F.prerequisite_skills, F.TotalPrerequisitesCount
		FROM @SelectedRow F
		WHERE F.id = @FeatID;
    END

	SET @IsValid = 1;

    FETCH NEXT FROM prerequisite_cursor INTO @FeatID, @Prerequisite;
END

CLOSE prerequisite_cursor;
DEALLOCATE prerequisite_cursor;

SELECT * FROM @ValidRow WHERE TotalPrerequisitesCount = @DesiredPrerequisites;