USE [DSTRAINING]
GO
/****** Object:  StoredProcedure [dbo].[BLD_WRK_OfficeSupplies_CustomerList]    Script Date: 2017-12-15 12:20:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[BLD_WRK_OfficeSupplies_CustomerList]
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
IF OBJECT_ID('WRK_OfficeSupplies_CustomerList') IS NOT NULL
DROP TABLE [WRK_OfficeSupplies_CustomerList]

-- =============================================
-- CREATE TABLE
-- =============================================
CREATE TABLE [WRK_OfficeSupplies_CustomerList]
(
	[RowNumber]     INT IDENTITY(1,1)
	,[Customer ID]  VARCHAR(100)
	,[City]			VARCHAR(1000)
	,[ZipCode]		VARCHAR(5)
	,[Gender]		VARCHAR(1)
	,[Age]			FLOAT
)

-- =============================================
-- TRUNCATE TABLE
-- =============================================
TRUNCATE TABLE [WRK_OfficeSupplies_CustomerList]

-- =============================================
-- INSERT INTO
-- =============================================
INSERT INTO [WRK_OfficeSupplies_CustomerList]
(
	  [Customer ID]
      ,[City]
      ,[ZipCode]
      ,[Gender]
      ,[Age]
)
SELECT
	  RIGHT('0000000'+[Customer ID],7)
      ,[City]
      ,[ZipCode]
      ,[Gender]
      ,[Age]
FROM [RAW_OfficeSupplies_CustomerList_20171021]
--(43 row(s) affected)


END

/*
	SELECT COUNT(*) FROM [WRK_OfficeSupplies_TransactionalData]
	SELECT * FROM [WRK_OfficeSupplies_CustomerList]
	SELECT COUNT(*) FROM [dbo].[RAW_OfficeSupplies_CustomerList_20171021]
	SELECT * FROM [dbo].[RAW_OfficeSupplies_CustomerList_20171021]
*/