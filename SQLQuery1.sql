USE [DSTRAINING]
GO
/****** Object:  StoredProcedure [dbo].[BLD_DRV_OfficeSupplies_RevenueByCustomerGender]    Script Date: 2017-12-15 12:11:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[BLD_DRV_OfficeSupplies_RevenueByCustomerGender]
-- =============================================
-- Author:		Thilaksha Silva	
-- Create date: 20171021
-- Description:	WRK -> DRV
--				COMBINING TABLES: [WRK_OfficeSupplies_CustomerList]
--								  [WRK_OfficeSupplies_TransactionalData]
--				TO UNDERSTAND REVENUE SPLIT BY GENDER
-- MOD Date: 
-- =============================================

AS
BEGIN

SELECT 
	A.[Customer ID]
	,A.Gender
	,B.[Units] * B.[Unit Price] AS Revenue
INTO [DRV_OfficeSupplies_RevenueByCustomerGender]
FROM [dbo].[WRK_OfficeSupplies_CustomerList] A
LEFT JOIN [dbo].[WRK_OfficeSupplies_TransactionalData] B
ON A.[Customer ID] = B.[Customer ID]
--(43 row(s) affected)

END