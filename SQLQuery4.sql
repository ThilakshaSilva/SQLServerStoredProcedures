USE [DSTRAINING]
GO
/****** Object:  StoredProcedure [dbo].[BLD_WRK_OfficeSupplies_TransactionalData]    Script Date: 2017-12-15 12:20:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[BLD_WRK_OfficeSupplies_TransactionalData]
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
IF OBJECT_ID('WRK_OfficeSupplies_TransactionalData') IS NOT NULL
DROP TABLE [WRK_OfficeSupplies_TransactionalData]

-- =============================================
-- CREATE TABLE
-- =============================================
CREATE TABLE [WRK_OfficeSupplies_TransactionalData]
(
	[RowNumber]     INT IDENTITY(1,1)
	,[Order ID]		VARCHAR(100)
	,[Order Date]	DATE
	,[Customer ID]	VARCHAR(100)
	,[Region]		VARCHAR(1)
	,[Rep]			VARCHAR(100)
	,[Item]			VARCHAR(1000)
	,[Units]		INT
	,[Unit Price]	FLOAT
)

-- =============================================
-- TRUNCATE TABLE
-- =============================================
TRUNCATE TABLE [WRK_OfficeSupplies_TransactionalData]

-- =============================================
-- INSERT INTO
-- =============================================
INSERT INTO [WRK_OfficeSupplies_TransactionalData]
(
	[Order ID]		
	,[Order Date]	
	,[Customer ID]	
	,[Region]		
	,[Rep]			
	,[Item]			
	,[Units]		
	,[Unit Price]	
)
SELECT
	[Order ID]
	,[Order Date]
	,[Customer ID]
	,[Region]
	,[Rep]
	,[Item]
	,[Units]
	,[Unit Price]
FROM [RAW_OfficeSupplies_TransactionalData_20171021]
--(43 row(s) affected)


END

/*
	SELECT COUNT(*) FROM [WRK_OfficeSupplies_TransactionalData]
	SELECT * FROM [WRK_OfficeSupplies_TransactionalData]
	SELECT COUNT(*) FROM [dbo].[RAW_OfficeSupplies_TransactionalData_20171021]
	SELECT * FROM [dbo].[RAW_OfficeSupplies_TransactionalData_20171021]
*/