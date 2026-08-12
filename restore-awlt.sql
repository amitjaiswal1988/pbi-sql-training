-- Restore AdventureWorksLT from the downloaded .bak into the default instance.
-- Logical file names inside AdventureWorksLT2022.bak:
--   Data: AdventureWorksLT2022_Data
--   Log : AdventureWorksLT2022_Log
SET NOCOUNT ON;

DECLARE @bak  NVARCHAR(400) = N'C:\Users\Amit\Documents\pbi-sql-training\AdventureWorksLT2022.bak';
DECLARE @mdf  NVARCHAR(400) = CAST(SERVERPROPERTY('InstanceDefaultDataPath') AS NVARCHAR(400)) + N'AdventureWorksLT.mdf';
DECLARE @ldf  NVARCHAR(400) = CAST(SERVERPROPERTY('InstanceDefaultLogPath')  AS NVARCHAR(400)) + N'AdventureWorksLT.ldf';

IF DB_ID('AdventureWorksLT') IS NOT NULL
BEGIN
    ALTER DATABASE AdventureWorksLT SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE AdventureWorksLT;
END

RESTORE DATABASE AdventureWorksLT
FROM DISK = @bak
WITH MOVE 'AdventureWorksLT2022_Data' TO @mdf,
     MOVE 'AdventureWorksLT2022_Log'  TO @ldf,
     RECOVERY, REPLACE;

PRINT 'Restore complete.';
