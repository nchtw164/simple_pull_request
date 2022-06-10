CREATE OR REPLACE PACKAGE BODY PG_LAND_CONSTRUCTION AS 

-- **************************************************
-- SP_INS_LAND_CONSTRUCTION_FINANCING
-- Purpose: 新增【土建融建案主檔】
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB19408         2020.11.10  Create
-- ESB11798         2022.04.12  [EW2022012700012]增加［預計動工日］欄位
-- ************************************************** 
PROCEDURE SP_INS_LAND_CONSTRUCTION_FINANCING
  ( i_cust_loan_no            IN NUMBER    -- 授信戶主檔序號
  , i_serial_no               IN VARCHAR2  -- 土建融序號
  , i_currency                IN VARCHAR2  -- 土建融幣別
  , i_purpose_code            IN VARCHAR2  -- 土建融用途別
  , i_total_sale_amount       IN NUMBER    -- 總銷金額
  , i_pre_sale_amount         IN NUMBER    -- 預售金額
  , i_building_permit_mk      IN VARCHAR2  -- 興建計畫
  , i_finish_date             IN VARCHAR2  -- 預計完工日
  , i_building_cost           IN NUMBER    -- 工程造價
  , i_distribution_ratio      IN NUMBER    -- 合建完工後分配比例
  , i_building_area_code      IN VARCHAR2  -- 建案座落縣市
  , i_land_eval_net_value     IN NUMBER    -- 土地評估淨值
  , i_land_use_area1          IN VARCHAR2  -- 土地使用分區1
  , i_land_use_area2          IN VARCHAR2  -- 土地使用分區2
  , i_land_use_area3          IN VARCHAR2  -- 土地使用分區3
  , i_building_permit_date    IN VARCHAR2  -- 核發建照日期
  , i_construction_start_date IN VARCHAR2  -- 開工日期
  , i_expect_start_date       IN VARCHAR2  -- 預計動工日
  , o_land_construction_no    OUT NUMBER   -- 土建融建案主檔序號
  ) AS
  BEGIN
  EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LAND_CONSTRUCTION_FINANCING', o_land_construction_no);
  INSERT INTO EDLS.TB_LAND_CONSTRUCTION_FINANCING
    ( LAND_CONSTRUCTION_FINANCING_SEQ_NO
    , CUSTOMER_LOAN_SEQ_NO
    , SERIAL_NO
    , CURRENCY
    , PURPOSE_CODE
    , TOTAL_SALE_AMOUNT
    , PRE_SALE_AMOUNT
    , BUILDING_PERMIT_MK
    , FINISH_DATE
    , BUILDING_COST
    , DISTRIBUTION_RATIO
    , BUILDING_AREA_CODE
    , LAND_EVAL_NET_VALUE
    , LAND_USE_AREA1
    , LAND_USE_AREA2
    , LAND_USE_AREA3
    , BUILDING_PERMIT_DATE
    , CONSTRUCTION_START_DATE
    , EXPECT_START_DATE
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_land_construction_no
    , i_cust_loan_no
    , i_serial_no
    , i_currency
    , i_purpose_code
    , i_total_sale_amount
    , i_pre_sale_amount
    , i_building_permit_mk
    , i_finish_date
    , i_building_cost
    , i_distribution_ratio
    , i_building_area_code
    , i_land_eval_net_value
    , i_land_use_area1
    , i_land_use_area2
    , i_land_use_area3
    , i_building_permit_date
    , i_construction_start_date
    , i_expect_start_date
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
  END SP_INS_LAND_CONSTRUCTION_FINANCING;
  
-- **************************************************
-- SP_INS_LAND_CONSTRUCTION_FINANCING
-- Purpose: 新增【土建融建案主檔】（FOR向下相容，待刪除）
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB19408         2020.11.10  Create
-- ************************************************** 
PROCEDURE SP_INS_LAND_CONSTRUCTION_FINANCING
  ( i_cust_loan_no            IN NUMBER    -- 授信戶主檔序號
  , i_serial_no               IN VARCHAR2  -- 土建融序號
  , i_currency                IN VARCHAR2  -- 土建融幣別
  , i_purpose_code            IN VARCHAR2  -- 土建融用途別
  , i_total_sale_amount       IN NUMBER    -- 總銷金額
  , i_pre_sale_amount         IN NUMBER    -- 預售金額
  , i_building_permit_mk      IN VARCHAR2  -- 興建計畫
  , i_finish_date             IN VARCHAR2  -- 預計完工日
  , i_building_cost           IN NUMBER    -- 工程造價
  , i_distribution_ratio      IN NUMBER    -- 合建完工後分配比例
  , i_building_area_code      IN VARCHAR2  -- 建案座落縣市
  , i_land_eval_net_value     IN NUMBER    -- 土地評估淨值
  , i_land_use_area1          IN VARCHAR2  -- 土地使用分區1
  , i_land_use_area2          IN VARCHAR2  -- 土地使用分區2
  , i_land_use_area3          IN VARCHAR2  -- 土地使用分區3
  , i_building_permit_date    IN VARCHAR2  -- 核發建照日期
  , i_construction_start_date IN VARCHAR2  -- 開工日期
  , o_land_construction_no    OUT NUMBER   -- 土建融建案主檔序號
  ) AS
  BEGIN
  EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LAND_CONSTRUCTION_FINANCING', o_land_construction_no);
  INSERT INTO EDLS.TB_LAND_CONSTRUCTION_FINANCING
    ( LAND_CONSTRUCTION_FINANCING_SEQ_NO
    , CUSTOMER_LOAN_SEQ_NO
    , SERIAL_NO
    , CURRENCY
    , PURPOSE_CODE
    , TOTAL_SALE_AMOUNT
    , PRE_SALE_AMOUNT
    , BUILDING_PERMIT_MK
    , FINISH_DATE
    , BUILDING_COST
    , DISTRIBUTION_RATIO
    , BUILDING_AREA_CODE
    , LAND_EVAL_NET_VALUE
    , LAND_USE_AREA1
    , LAND_USE_AREA2
    , LAND_USE_AREA3
    , BUILDING_PERMIT_DATE
    , CONSTRUCTION_START_DATE
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_land_construction_no
    , i_cust_loan_no
    , i_serial_no
    , i_currency
    , i_purpose_code
    , i_total_sale_amount
    , i_pre_sale_amount
    , i_building_permit_mk
    , i_finish_date
    , i_building_cost
    , i_distribution_ratio
    , i_building_area_code
    , i_land_eval_net_value
    , i_land_use_area1
    , i_land_use_area2
    , i_land_use_area3
    , i_building_permit_date
    , i_construction_start_date
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
  END SP_INS_LAND_CONSTRUCTION_FINANCING;

-- **************************************************
-- SP_UPD_LAND_CONSTRUCTION_FINANCING
-- Purpose: 更新【土建融建案主檔】
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB19408         2020.11.10  Create
-- ESB11798         2022.04.12  [EW2022012700012]增加［預計動工日］欄位
-- **************************************************   
PROCEDURE SP_UPD_LAND_CONSTRUCTION_FINANCING
  ( i_cust_loan_no            IN NUMBER   -- 授信戶主檔序號
  , i_serial_no               IN VARCHAR2 -- 土建融序號
  , i_currency                IN VARCHAR2 -- 土建融幣別
  , i_purpose_code            IN VARCHAR2 -- 土建融用途別
  , i_total_sale_amount       IN NUMBER   -- 總銷金額
  , i_pre_sale_amount         IN NUMBER   -- 預售金額
  , i_building_permit_mk      IN VARCHAR2 -- 興建計畫
  , i_finish_date             IN VARCHAR2 -- 預計完工日
  , i_building_cost           IN NUMBER   -- 工程造價
  , i_distribution_ratio      IN NUMBER   -- 合建完工後分配比例
  , i_building_area_code      IN VARCHAR2 -- 建案座落縣市
  , i_land_eval_net_value     IN NUMBER   -- 土地評估淨值
  , i_land_use_area1          IN VARCHAR2 -- 土地使用分區1
  , i_land_use_area2          IN VARCHAR2 -- 土地使用分區2
  , i_land_use_area3          IN VARCHAR2 -- 土地使用分區3
  , i_building_permit_date    IN VARCHAR2 -- 核發建照日期
  , i_construction_start_date IN VARCHAR2 -- 開工日期
  , i_expect_start_date       IN VARCHAR2 -- 預計動工日
  , o_row_count               OUT NUMBER  -- 更新筆數
  )AS
  BEGIN
  UPDATE EDLS.TB_LAND_CONSTRUCTION_FINANCING
    SET CURRENCY = i_currency
    , PURPOSE_CODE = i_purpose_code
    , TOTAL_SALE_AMOUNT = i_total_sale_amount
    , PRE_SALE_AMOUNT = i_pre_sale_amount
    , BUILDING_PERMIT_MK = i_building_permit_mk
    , FINISH_DATE = i_finish_date
    , BUILDING_COST = i_building_cost
    , DISTRIBUTION_RATIO = i_distribution_ratio
    , BUILDING_AREA_CODE = i_building_area_code
    , LAND_EVAL_NET_VALUE = i_land_eval_net_value
    , LAND_USE_AREA1 = i_land_use_area1
    , LAND_USE_AREA2 = i_land_use_area2
    , LAND_USE_AREA3 = i_land_use_area3
    , BUILDING_PERMIT_DATE = i_building_permit_date
    , CONSTRUCTION_START_DATE = i_construction_start_date
    , EXPECT_START_DATE = i_expect_start_date
    , AMEND_DATE = SYSTIMESTAMP
  WHERE customer_loan_seq_no = i_cust_loan_no
    AND serial_no = i_serial_no;
  o_row_count := SQL%ROWCOUNT;
  END SP_UPD_LAND_CONSTRUCTION_FINANCING;

-- **************************************************
-- SP_UPD_LAND_CONSTRUCTION_FINANCING
-- Purpose: 更新【土建融建案主檔】（FOR向下相容，待刪除）
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB19408         2020.11.10  Create
-- **************************************************   
PROCEDURE SP_UPD_LAND_CONSTRUCTION_FINANCING
  ( i_cust_loan_no            IN NUMBER   -- 授信戶主檔序號
  , i_serial_no               IN VARCHAR2 -- 土建融序號
  , i_currency                IN VARCHAR2 -- 土建融幣別
  , i_purpose_code            IN VARCHAR2 -- 土建融用途別
  , i_total_sale_amount       IN NUMBER   -- 總銷金額
  , i_pre_sale_amount         IN NUMBER   -- 預售金額
  , i_building_permit_mk      IN VARCHAR2 -- 興建計畫
  , i_finish_date             IN VARCHAR2 -- 預計完工日
  , i_building_cost           IN NUMBER   -- 工程造價
  , i_distribution_ratio      IN NUMBER   -- 合建完工後分配比例
  , i_building_area_code      IN VARCHAR2 -- 建案座落縣市
  , i_land_eval_net_value     IN NUMBER   -- 土地評估淨值
  , i_land_use_area1          IN VARCHAR2 -- 土地使用分區1
  , i_land_use_area2          IN VARCHAR2 -- 土地使用分區2
  , i_land_use_area3          IN VARCHAR2 -- 土地使用分區3
  , i_building_permit_date    IN VARCHAR2 -- 核發建照日期
  , i_construction_start_date IN VARCHAR2 -- 開工日期
  , o_row_count               OUT NUMBER  -- 更新筆數
  )AS
  BEGIN
  UPDATE EDLS.TB_LAND_CONSTRUCTION_FINANCING
    SET CURRENCY = i_currency
    , PURPOSE_CODE = i_purpose_code
    , TOTAL_SALE_AMOUNT = i_total_sale_amount
    , PRE_SALE_AMOUNT = i_pre_sale_amount
    , BUILDING_PERMIT_MK = i_building_permit_mk
    , FINISH_DATE = i_finish_date
    , BUILDING_COST = i_building_cost
    , DISTRIBUTION_RATIO = i_distribution_ratio
    , BUILDING_AREA_CODE = i_building_area_code
    , LAND_EVAL_NET_VALUE = i_land_eval_net_value
    , LAND_USE_AREA1 = i_land_use_area1
    , LAND_USE_AREA2 = i_land_use_area2
    , LAND_USE_AREA3 = i_land_use_area3
    , BUILDING_PERMIT_DATE = i_building_permit_date
    , CONSTRUCTION_START_DATE = i_construction_start_date
    , AMEND_DATE = SYSTIMESTAMP
  WHERE customer_loan_seq_no = i_cust_loan_no
    AND serial_no = i_serial_no;
  o_row_count := SQL%ROWCOUNT;
  END SP_UPD_LAND_CONSTRUCTION_FINANCING;

-- **************************************************
-- SP_DEL_LAND_CONSTRUCTION_FINANCING
-- Purpose: 刪除【土建融建案主檔】
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB19408         2020.11.10  Create
-- ************************************************** 
PROCEDURE SP_DEL_LAND_CONSTRUCTION_FINANCING
  ( i_cust_loan_no  IN NUMBER -- 授信戶主檔序號
  , i_serial_no     IN VARCHAR2 -- 土建融序號
  , o_row_count     OUT NUMBER -- 刪除筆數
  )AS
  BEGIN
  DELETE FROM EDLS.TB_LAND_CONSTRUCTION_FINANCING
  WHERE customer_loan_seq_no = i_cust_loan_no
    AND serial_no = i_serial_no;
  o_row_count := SQL%ROWCOUNT;
  END SP_DEL_LAND_CONSTRUCTION_FINANCING;

-- **************************************************
-- SP_GET_LAND_CONSTRUCTION_FINANCING
-- Purpose: 查詢【土建融建案主檔】
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB19408         2020.11.10  Create
-- ESB11798         2022.04.12  [EW2022012700012]增加［預計動工日］欄位
-- ************************************************** 
PROCEDURE SP_GET_LAND_CONSTRUCTION_FINANCING
  ( i_cust_loan_no  IN NUMBER -- 授信戶主檔序號
  , i_serial_no     IN VARCHAR2 -- 土建融序號
  , o_cur           OUT SYS_REFCURSOR -- 土建融建案主檔序號
  )AS
  BEGIN
  OPEN o_cur FOR
  SELECT LAND_CONSTRUCTION_FINANCING_SEQ_NO
    , CUSTOMER_LOAN_SEQ_NO
    , SERIAL_NO
    , CURRENCY
    , PURPOSE_CODE
    , TOTAL_SALE_AMOUNT
    , PRE_SALE_AMOUNT
    , BUILDING_PERMIT_MK
    , FINISH_DATE
    , BUILDING_COST
    , DISTRIBUTION_RATIO
    , BUILDING_AREA_CODE
    , LAND_EVAL_NET_VALUE
    , LAND_USE_AREA1
    , LAND_USE_AREA2
    , LAND_USE_AREA3
    , BUILDING_PERMIT_DATE
    , CONSTRUCTION_START_DATE
    , EXPECT_START_DATE
    FROM EDLS.TB_LAND_CONSTRUCTION_FINANCING
  WHERE customer_loan_seq_no = i_cust_loan_no
    AND serial_no = i_serial_no;
  END SP_GET_LAND_CONSTRUCTION_FINANCING;

-- **************************************************
-- SP_INS_LAND_CONSTRUCTION_FINANCING_CFG
-- Purpose: 新增【土建融建案設定檔】
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
--  ESB14440         2020.11.11  Create
--  ESB19294		 2020.11.17  Modify
-- **************************************************  
PROCEDURE SP_INS_LAND_CONSTRUCTION_FINANCING_CFG
( i_lcf_config_list			IN TB_LAND_CONSTRUCTION_FINANCING_CFG_ARRAY -- 【土建融建案設定檔】清單
, o_row_count      			OUT NUMBER -- 新增筆數
) AS
n_seq_no NUMBER;
BEGIN
	o_row_count := 0;
	IF i_lcf_config_list IS NOT NULL AND i_lcf_config_list.count > 0 THEN
		EDLS.PG_SYS.SP_BH_GET_SEQ_NO_RTN_NUM ('TB_LAND_CONSTRUCTION_FINANCING_CFG', i_lcf_config_list.count, n_seq_no);
		FOR i IN i_lcf_config_list.FIRST .. i_lcf_config_list.LAST
		LOOP
			INSERT INTO EDLS.TB_LAND_CONSTRUCTION_FINANCING_CFG
			( LAND_CONSTRUCTION_FINANCING_CFG_SEQ_NO
			, LAND_CONSTRUCTION_FINANCING_SEQ_NO
			, APPR_DOC_SEQ_NO
			, CREATE_DATE
			, AMEND_DATE
			)
			VALUES
			( n_seq_no
			, i_lcf_config_list(i).LAND_CONSTRUCTION_FINANCING_SEQ_NO
			, i_lcf_config_list(i).APPR_DOC_SEQ_NO
			, SYSTIMESTAMP
			, SYSTIMESTAMP
			);
			n_seq_no := n_seq_no + 1;
			o_row_count := o_row_count + 1;
		END LOOP;
	END IF;
END SP_INS_LAND_CONSTRUCTION_FINANCING_CFG;

-- **************************************************
-- SP_DEL_LAND_CONSTRUCTION_FINANCING_CFG
-- Purpose: 刪除【土建融建案設定檔】
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
--  ESB14440         2020.11.11  Create
--  ESB19294		 2020.11.17  Modify
-- **************************************************
PROCEDURE SP_DEL_LAND_CONSTRUCTION_FINANCING_CFG
( i_lcf_config_seq_no_list	IN ITEM_NUM_ARRAY -- 【土建融建案設定檔序號】清單
, o_row_count     			OUT NUMBER -- 刪除筆數
) AS
BEGIN
	DELETE FROM EDLS.TB_LAND_CONSTRUCTION_FINANCING_CFG
	WHERE LAND_CONSTRUCTION_FINANCING_CFG_SEQ_NO IN (SELECT * FROM TABLE (i_lcf_config_seq_no_list));
	o_row_count := SQL%ROWCOUNT;
END SP_DEL_LAND_CONSTRUCTION_FINANCING_CFG;

-- **************************************************
-- SP_GET_LAND_CONSTRUCTION_FINANCING_CFG_LIST
-- Purpose: 查詢【土建融建案設定檔】
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
--  ESB14440         2020.11.11  Create
-- **************************************************
PROCEDURE SP_GET_LAND_CONSTRUCTION_FINANCING_CFG_LIST
( i_land_construction_no          IN NUMBER -- 土建融建案主檔序號
, o_cur                           OUT SYS_REFCURSOR -- 土建融建案設定檔
)AS
BEGIN
  OPEN o_cur FOR
    SELECT 
      land_construction_financing_cfg_seq_no
      ,land_construction_financing_seq_no
      ,appr_doc_seq_no
    FROM EDLS.TB_LAND_CONSTRUCTION_FINANCING_CFG
    WHERE land_construction_financing_seq_no = i_land_construction_no;
  END SP_GET_LAND_CONSTRUCTION_FINANCING_CFG_LIST;

-- **************************************************
-- SP_GET_LCF_BY_LAND_CUST_ID_SNO
-- Purpose: 查詢【土建融建案主檔】與【土建融建案設定檔】BY土建融統編、土建融序號
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
--  ESB19294        2020.11.16  Create
--  ESB19408        2020.11.25  Modify
--  ESB11798        2022.04.12  [EW2022012700012]增加［預計動工日］欄位
-- **************************************************
PROCEDURE SP_GET_LCF_BY_LAND_CUST_ID_SNO
( i_land_cust_id				IN VARCHAR2 --土建融統編
, i_serial_no					IN VARCHAR2 --土建融序號
, o_cur							OUT SYS_REFCURSOR
) AS
BEGIN
	OPEN o_cur FOR
	SELECT  
	LCF.LAND_CONSTRUCTION_FINANCING_SEQ_NO,
	LCF.CUSTOMER_LOAN_SEQ_NO,
	LCF.SERIAL_NO,
	LCF.CURRENCY,
	LCF.PURPOSE_CODE,
	LCF.TOTAL_SALE_AMOUNT,
	LCF.PRE_SALE_AMOUNT,
	LAND_CL.CUST_ID AS LAND_CUST_ID, 	--土建融統編
    LCF.BUILDING_PERMIT_MK,
    LCF.FINISH_DATE,
    LCF.BUILDING_COST,
    LCF.DISTRIBUTION_RATIO,
    LCF.BUILDING_AREA_CODE,
    LCF.LAND_EVAL_NET_VALUE,
    LCF.LAND_USE_AREA1,
    LCF.LAND_USE_AREA2,
    LCF.LAND_USE_AREA3,
    LCF.BUILDING_PERMIT_DATE,
    LCF.CONSTRUCTION_START_DATE,
    LCF.EXPECT_START_DATE,
	LCFC.LAND_CONSTRUCTION_FINANCING_CFG_SEQ_NO,
	LCFC.APPR_DOC_SEQ_NO,
	AD.APPR_DOC_NO,
	AD.PHASE,		--批覆書狀態
	CL.CUST_ID,		--銀行歸戶統編
    (SELECT CUST_NAME FROM CIFX.TB_CUSTOMER WHERE CIF_VERIFIED_ID = CL.CUST_ID) as CUST_NAME    --客戶名稱
	FROM EDLS.TB_CUSTOMER_LOAN LAND_CL
	INNER JOIN EDLS.TB_LAND_CONSTRUCTION_FINANCING LCF
	ON LAND_CL.CUSTOMER_LOAN_SEQ_NO = LCF.CUSTOMER_LOAN_SEQ_NO
	INNER JOIN EDLS.TB_LAND_CONSTRUCTION_FINANCING_CFG LCFC
	ON LCF.LAND_CONSTRUCTION_FINANCING_SEQ_NO = LCFC.LAND_CONSTRUCTION_FINANCING_SEQ_NO
	INNER JOIN EDLS.TB_APPR_DOC AD
	ON LCFC.APPR_DOC_SEQ_NO = AD.APPR_DOC_SEQ_NO
	INNER JOIN EDLS.TB_CUSTOMER_LOAN CL
	ON AD.CUSTOMER_LOAN_SEQ_NO = CL.CUSTOMER_LOAN_SEQ_NO
	--INNER JOIN CIFX.TB_CUSTOMER CC
    --ON CC.CIF_VERIFIED_ID = CL.CUST_ID
	WHERE LAND_CL.CUST_ID = i_land_cust_id
	AND (i_serial_no IS NULL OR SERIAL_NO = i_serial_no);
END SP_GET_LCF_BY_LAND_CUST_ID_SNO;

-- **************************************************
-- SP_GET_LCF_BY_CUST_ID
-- Purpose: 查詢【土建融建案主檔】與【土建融建案設定檔】BY銀行歸戶統編
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
--  ESB19294        2020.11.16  Create
--  ESB19408        2020.11.25  Modify
--  ESB11798        2022.04.12  [EW2022012700012]增加［預計動工日］欄位
-- **************************************************
PROCEDURE SP_GET_LCF_BY_CUST_ID
( i_cust_id						IN VARCHAR2 --銀行歸戶統編
, o_cur							OUT SYS_REFCURSOR 
) AS
BEGIN
	OPEN o_cur FOR
	SELECT
	LCF.LAND_CONSTRUCTION_FINANCING_SEQ_NO,
	LCF.CUSTOMER_LOAN_SEQ_NO,
	LCF.SERIAL_NO,
	LCF.CURRENCY,
	LCF.PURPOSE_CODE,
	LCF.TOTAL_SALE_AMOUNT,
	LCF.PRE_SALE_AMOUNT,
	LAND_CL.CUST_ID AS LAND_CUST_ID, 	--土建融統編
    LCF.BUILDING_PERMIT_MK,
    LCF.FINISH_DATE,
    LCF.BUILDING_COST,
    LCF.DISTRIBUTION_RATIO,
    LCF.BUILDING_AREA_CODE,
    LCF.LAND_EVAL_NET_VALUE,
    LCF.LAND_USE_AREA1,
    LCF.LAND_USE_AREA2,
    LCF.LAND_USE_AREA3,
    LCF.BUILDING_PERMIT_DATE,
    LCF.CONSTRUCTION_START_DATE,
    LCF.EXPECT_START_DATE,
	LCFC.LAND_CONSTRUCTION_FINANCING_CFG_SEQ_NO,
	LCFC.APPR_DOC_SEQ_NO,
	AD.APPR_DOC_NO,
	AD.PHASE,		--批覆書狀態
	CL.CUST_ID,	--銀行歸戶統編
	(SELECT CUST_NAME FROM CIFX.TB_CUSTOMER WHERE CIF_VERIFIED_ID = CL.CUST_ID) as CUST_NAME	--客戶名稱
	FROM EDLS.TB_LAND_CONSTRUCTION_FINANCING LCF
	INNER JOIN EDLS.TB_LAND_CONSTRUCTION_FINANCING_CFG LCFC
	ON LCF.LAND_CONSTRUCTION_FINANCING_SEQ_NO = LCFC.LAND_CONSTRUCTION_FINANCING_SEQ_NO
	INNER JOIN EDLS.TB_CUSTOMER_LOAN LAND_CL
	ON LCF.CUSTOMER_LOAN_SEQ_NO = LAND_CL.CUSTOMER_LOAN_SEQ_NO
	INNER JOIN EDLS.TB_APPR_DOC AD
	ON LCFC.APPR_DOC_SEQ_NO = AD.APPR_DOC_SEQ_NO
	INNER JOIN EDLS.TB_CUSTOMER_LOAN CL
	ON AD.CUSTOMER_LOAN_SEQ_NO = CL.CUSTOMER_LOAN_SEQ_NO
	--INNER JOIN CIFX.TB_CUSTOMER CC
	--ON CL.CUST_ID = CC.CIF_VERIFIED_ID
	WHERE LCF.LAND_CONSTRUCTION_FINANCING_SEQ_NO IN 
			(SELECT LAND_CONSTRUCTION_FINANCING_SEQ_NO 
			 FROM EDLS.TB_LAND_CONSTRUCTION_FINANCING_CFG LCFC_T
			 INNER JOIN EDLS.TB_APPR_DOC AD_T
			 ON LCFC_T.APPR_DOC_SEQ_NO = AD_T.APPR_DOC_SEQ_NO
			 INNER JOIN EDLS.TB_CUSTOMER_LOAN CL_T
			 ON AD_T.CUSTOMER_LOAN_SEQ_NO = CL_T.CUSTOMER_LOAN_SEQ_NO
			 WHERE CL_T.CUST_ID = i_cust_id);
END SP_GET_LCF_BY_CUST_ID;  

END PG_LAND_CONSTRUCTION;