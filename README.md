# How to use FoundryRollTableMacro:

## Macros

Change this value to change the number of times you draw from a rolltable:

    numberOfDraws = 8;
	
Change these values to your desired image size:

    imageWidth = 250;
    imageHeight = 500;
	
Change this value to the name of the table you draw from:

    tableName = 'tableName'
	
Use the DeleteAllTilesMacro to delete all of the tiles you spawned.

## Queries

Run the following script to generate the database:

    GeneratePFDB.sql
	
### Random Select Scripts

#### Selecting a rancom class feat

Run randomClassFeat.sql to select a random Pathfinder class feature.
If you want to select more than one class feat, you can change this value:

    SELECT TOP(1)
	
#### Selecting a random drawback

Run randomDrawbackQuery.sql to select a random drawback.
If you want to select more than one drawback, you can change this value:

    SELECT TOP(1)
	
#### Selecting a random trait

Run randomTraitQuery.sql to select a random trait.
If you want to select more than one trait, you can change this value:

    SELECT TOP(1)
	
#### Selecting a random drawback or trait

Run randomTraitDrawbackQuery.sql to select a random trait or drawback.
If you want to select more than one, you can change this value:

    SELECT TOP(1)
	
#### Selecting a feat with certain prerequisites

Run randomFeatAbilitySkillBABPreqeq.sql to select a random feat that can have prerequisites from the following: ability scores, skills, BAB

Change this to your desired number of prerequisites:

    DECLARE @DesiredPrerequisites INT = 0;
	
Change this to your desired result count:
 
    DECLARE @ResultCount INT = 5;
	
#### Selecting a feat with any type of prerequisites

Run randomFeatAnyPreqeq.sql to select a random feat that can have any type of prerequisites

Change this to your desired number of prerequisites:

    DECLARE @DesiredPrerequisites INT = 0;
	
Change this to your desired result count:
 
    DECLARE @ResultCount INT = 5;
	
#### Selecting a random feat

Run randomFeatQuery to select a random feat. 
If you want to select more than one feat, you can change this value:

    SELECT TOP(1)
