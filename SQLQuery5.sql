USE [DSTRAINING]
GO
/****** Object:  StoredProcedure [dbo].[BLD_WRK_VehicleService]    Script Date: 2017-12-15 12:20:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[BLD_WRK_VehicleService]
-- =============================================
-- Author:		Thilaksha Silva
-- Create date: 20171021
-- Description:	RAW -> WRK
-- MOD Date: 
-- =============================================

AS
BEGIN

-- =============================================
-- DROP TABLE
-- =============================================
IF OBJECT_ID('WRK_VehicleService') IS NOT NULL
DROP TABLE [WRK_VehicleService]

-- =============================================
-- CREATE TABLE
-- =============================================
CREATE TABLE [WRK_VehicleService]
(
	[RowNumber]			INT IDENTITY(1,1)
	,[CustomerID]		VARCHAR(100)
	,[CustomerSince]	DATE
	,[Vehicle]			VARCHAR(100)
	,[2014]				FLOAT
	,[2015]				FLOAT
	,[2016E]			FLOAT
)

-- =============================================
-- TRUNCATE TABLE
-- =============================================
TRUNCATE TABLE [WRK_VehicleService]

-- =============================================
-- INSERT INTO
-- =============================================
INSERT INTO [WRK_VehicleService]
(
	  [CustomerID]
      ,[CustomerSince]
      ,[Vehicle]
      ,[2014]
      ,[2015]
      ,[2016E]
)
SELECT
	  [CustomerID]
      ,[CustomerSince]
      ,[Vehicle]
      ,[2014]
      ,[2015]
      ,[2016E]
FROM [RAW_VehicleService_20171022]
--FILTERS: Select numeric 2015, empty 2015
WHERE ISNUMERIC([2015]) = 1 --1 ROW EXCLUDED
OR [2015] = ''
--(1049998 row(s) affected) 
-- 1049998 + 1(1 ROW EXCLUDED IN SSIS) + 1 (1 ROW ABOVE) = 1050000 VERIFIED

/*
EXCLUDED ROW:
SELECT *
FROM [DSTRAINING].[dbo].[RAW_VehicleService_20171022]
WHERE ISNUMERIC([2015]) = 0 --non-numeric
AND [2015] <> '' -- and the ones are non-empty
*/

SELECT SUM([2016E])
FROM [WRK_VehicleService]

-- =============================================
-- ADDITIONAL EXCLUSIONS
-- =============================================
/*
SELECT [CustomerID], COUNT(*)
FROM [WRK_VehicleService]
GROUP BY [CustomerID]
HAVING COUNT(*) > 1 --SHOW DUPLICATE CUSTOMER IDs

SELECT *
FROM [WRK_VehicleService]
WHERE [CustomerID] LIKE '3490750'
*/
SELECT *
FROM [WRK_VehicleService]
WHERE [CustomerID] NOT LIKE '3490750'

/*
SELECT *
FROM [WRK_VehicleService]
WHERE CustomerSince < '1965-01-01'
*/
SELECT *
FROM [WRK_VehicleService]
WHERE CustomerSince > '1965-01-01'

/*
SELECT MAX([2014]) --THE VALUE IS TOO HIGH
FROM [WRK_VehicleService]
*/
SELECT *
FROM [WRK_VehicleService]
WHERE [2014] > 800

END

/*
	SELECT COUNT(*) FROM [WRK_VehicleService]
	SELECT * FROM [WRK_VehicleService]
	SELECT COUNT(*) FROM [dbo].[RAW_VehicleService_20171022]
	SELECT * FROM [dbo].[RAW_VehicleService_20171022]
*/