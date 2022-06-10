CREATE OR REPLACE PACKAGE PG_LAND_CONSTRUCTION AS 

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
  );

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
  );

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
  );

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
  );

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
  );

-- **************************************************
-- SP_GET_LAND_CONSTRUCTION_FINANCING
-- Purpose: 查詢【土建融建案主檔】
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB19408         2020.11.10  Create
-- ************************************************** 
PROCEDURE SP_GET_LAND_CONSTRUCTION_FINANCING
  ( i_cust_loan_no  IN NUMBER -- 授信戶主檔序號
  , i_serial_no     IN VARCHAR2 -- 土建融序號
  , o_cur           OUT SYS_REFCURSOR -- 土建融建案主檔序號
  );


-- **************************************************
-- SP_INS_LAND_CONSTRUCTION_FINANCING_CFG
-- Purpose: 新增【土建融建案設定檔】
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
--  ESB14440         2020.11.11  Create
--  ESB19294		 2020.11.17  Modify
-- ************************************************** 
TYPE TB_LAND_CONSTRUCTION_FINANCING_CFG_LIST IS RECORD
( LAND_CONSTRUCTION_FINANCING_SEQ_NO	EDLS.TB_LAND_CONSTRUCTION_FINANCING_CFG.LAND_CONSTRUCTION_FINANCING_SEQ_NO%TYPE
, APPR_DOC_SEQ_NO						EDLS.TB_LAND_CONSTRUCTION_FINANCING_CFG.APPR_DOC_SEQ_NO%TYPE
);

TYPE TB_LAND_CONSTRUCTION_FINANCING_CFG_ARRAY IS TABLE OF TB_LAND_CONSTRUCTION_FINANCING_CFG_LIST;

PROCEDURE SP_INS_LAND_CONSTRUCTION_FINANCING_CFG
( i_lcf_config_list			IN TB_LAND_CONSTRUCTION_FINANCING_CFG_ARRAY -- 【土建融建案設定檔】清單
, o_row_count      			OUT NUMBER -- 新增筆數
);

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
);

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
);

-- **************************************************
-- SP_GET_LCF_BY_LAND_CUST_ID_SNO
-- Purpose: 查詢【土建融建案主檔】與【土建融建案設定檔】BY土建融統編、土建融序號
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
--  ESB19294        2020.11.16  Create
-- **************************************************
PROCEDURE SP_GET_LCF_BY_LAND_CUST_ID_SNO
( i_land_cust_id				IN VARCHAR2 --土建融統編
, i_serial_no					IN VARCHAR2 --土建融序號
, o_cur							OUT SYS_REFCURSOR
);

-- **************************************************
-- SP_GET_LCF_BY_CUST_ID
-- Purpose: 查詢【土建融建案主檔】與【土建融建案設定檔】BY銀行歸戶統編
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
--  ESB19294        2020.11.16  Create
-- **************************************************
PROCEDURE SP_GET_LCF_BY_CUST_ID
( i_cust_id						IN VARCHAR2 --土建融統編
, o_cur							OUT SYS_REFCURSOR 
);

END PG_LAND_CONSTRUCTION;