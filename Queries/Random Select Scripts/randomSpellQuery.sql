DECLARE @DesiredSpellLevel INT = 5;

SELECT TOP (1) [name], [sorcerer], [wizard], [cleric], [druid], [ranger], [bard], [alchemist], [summoner], [witch], [inquisitor], [oracle], [antipaladin], [magus], [adept], [bloodrager], [shaman], [medium], [occultist], [mesmerist], [skald], [investigator], [hunter]
FROM [PFDB].[dbo].[Spells]
INNER JOIN [PFDB].[dbo].[Spells_Spell_Level] ON [PFDB].[dbo].[Spells].[Id] = [PFDB].[dbo].[Spells_Spell_Level].[Id]
WHERE @DesiredSpellLevel = (
    SELECT MIN(MIN_VALUE)
    FROM (VALUES
        ([sorcerer]), ([wizard]), ([cleric]), ([druid]), ([ranger]), ([bard]), ([alchemist]), ([summoner]), ([witch]), ([inquisitor]), ([oracle]), ([antipaladin]), ([magus]), ([adept]), ([bloodrager]), ([shaman]), ([medium]), ([occultist]), ([mesmerist]), ([skald]), ([investigator]), ([hunter])
    ) AS AllValues(MIN_VALUE)
);
