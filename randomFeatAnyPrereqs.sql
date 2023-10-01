DECLARE @Count INT;
SET @Count = 0;

WHILE (@Count <= 0)
BEGIN
   -- Declare a table variable to store the selected row
   DECLARE @SelectedRow TABLE (
       [name] NVARCHAR(MAX),
       [prerequisites] NVARCHAR(MAX),
       [prerequisite_feats] NVARCHAR(MAX),
       [prerequisite_skills] NVARCHAR(MAX),
       NonNullColumnCount INT
   );

   -- Insert the selected row into the table variable
   INSERT INTO @SelectedRow
   SELECT TOP (1) 
       [name], [prerequisites], [prerequisite_feats], [prerequisite_skills],
       (CASE WHEN prerequisites IS NOT NULL THEN 1 ELSE 0 END +
        CASE WHEN prerequisite_feats IS NOT NULL THEN 1 ELSE 0 END +
        CASE WHEN prerequisite_skills IS NOT NULL THEN 1 ELSE 0 END) AS NonNullColumnCount
   FROM [PFDB].[dbo].[Feats]
   ORDER BY NEWID();

   -- Fetch the value of NonNullColumnCount into @Count
   SELECT TOP 1 @Count = NonNullColumnCount FROM @SelectedRow;

   -- Display @Count for verification (you can remove this line in your final query)
   PRINT 'Count: ' + CAST(@Count AS NVARCHAR(10));

   -- Display the selected record
   SELECT [name], [prerequisites], [prerequisite_feats], [prerequisite_skills]
   FROM @SelectedRow;
   
   -- DROP TABLE #TempTable (if not needed)
END
