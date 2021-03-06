USE [DSTRAINING]
GO
/****** Object:  StoredProcedure [dbo].[BLD_WRK_FakeNamesCanada]    Script Date: 2017-12-15 12:20:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[BLD_WRK_FakeNamesCanada]
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
IF OBJECT_ID('WRK_FakeNamesCanada') IS NOT NULL
DROP TABLE [WRK_FakeNamesCanada]

-- =============================================
-- CREATE TABLE
-- =============================================
CREATE TABLE [WRK_FakeNamesCanada]
(
	[RowNumber]     INT IDENTITY(1,1)
	,[Number]		VARCHAR(100)
	,[Gender]		VARCHAR(10)
	,[GivenName]	VARCHAR(1000)
	,[Surname]		VARCHAR(1000)
	,[StreetAddress]VARCHAR(1000)
	,[City]			VARCHAR(1000)
	,[ZipCode]		VARCHAR(7)
	,[CountryFull]	VARCHAR(100)
	,[Birthday]		DATE
	,[Balance]		FLOAT	
	,[InterestRate]	FLOAT
)

-- =============================================
-- TRUNCATE TABLE
-- =============================================
TRUNCATE TABLE [WRK_FakeNamesCanada]

-- =============================================
-- INSERT INTO
-- =============================================
INSERT INTO [WRK_FakeNamesCanada]
(
	[Number]
	,[Gender]
	,[GivenName]
	,[Surname]
	,[StreetAddress]
	,[City]
	,[ZipCode]
	,[CountryFull]
	,[Birthday]
	,[Balance]
	,[InterestRate]	
)
SELECT
	[Number]
	,[Gender]
	,[GivenName]
	,[Surname]
	,[StreetAddress]
	,[City]
	,[ZipCode]
	,[CountryFull]
	,[Birthday]
	,[Balance]
	,[InterestRate]
FROM [RAW_FakeNamesCanada_20171021]
--FILTERS: Select numeric Balance, ZipCode <= 7 and Birthday is a date
WHERE ISNUMERIC(Balance) = 1 --10 ROWS EXCLUDED
AND LEN(ZipCode) <= 7		 -- 2 ROWS EXCLUDED
AND ISDATE(BIRTHDAY) = 1	 -- 1 ROW EXCLUDED
--(199987 row(s) affected)
--199987 + 10 + 2 + 1 = 200000 VERIFIED

-- =============================================
-- ADDITIONAL EXCLUSIONS
-- =============================================

DELETE
FROM [WRK_FakeNamesCanada]
WHERE [Balance] < 0
--(1 row(s) affected)

DELETE 
FROM [WRK_FakeNamesCanada]
WHERE [ZipCode] NOT LIKE '___ ___'
--(4 row(s) affected)

SELECT *
FROM [WRK_FakeNamesCanada]
WHERE [Birthday] < '1915-08-13'
--N/A

DELETE
FROM [WRK_FakeNamesCanada]
WHERE [Birthday] > '2005-08-13'
--(1 row(s) affected)

END

/*
	SELECT COUNT(*) FROM [WRK_FakeNamesCanada]
	SELECT * FROM [WRK_FakeNamesCanada]
	SELECT COUNT(*) FROM [dbo].[RAW_FakeNamesCanada_20171021]
	SELECT * FROM [dbo].[RAW_FakeNamesCanada_20171021]
*/