CREATE OR REPLACE PACKAGE BODY "EDLS"."PG_LOAN_ACCOUNTING_SETTLEMENT" AS

--**************************************************************************
-- 870 SP_GET_LOAN_CIF_ACCOUNTING
-- Purpose: 查詢授信戶列銷帳主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.19  created
--
--**************************************************************************
  PROCEDURE SP_GET_LOAN_CIF_ACCOUNTING
  ( i_customer_loan_seq_no  IN NUMBER          -- 授信戶主檔序號
  , i_acc_branch            IN VARCHAR2        -- 設帳分行
  , i_acc_category          IN VARCHAR2        -- 設帳科目
  , i_ccy                   IN VARCHAR2        -- 幣別
  , i_type                  IN VARCHAR2        -- 種類
  , i_fee_code              IN VARCHAR2        -- 費用代碼
  , i_amt                   IN NUMBER          -- 金額
  , o_cur                   OUT SYS_REFCURSOR  -- o_cur
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT CIF_ACCOUNTING_SEQ_NO
         , CUSTOMER_LOAN_SEQ_NO
         , ACC_BRANCH
         , ACC_CATEGORY
         , CCY
         , TYPE
         , FEE_CODE
         , AMT
      FROM EDLS.TB_LOAN_CIF_ACCOUNTING 
     WHERE (i_customer_loan_seq_no is null or CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no)
       AND (i_acc_branch is null or ACC_BRANCH = i_acc_branch)
       AND (i_ccy is null or CCY = i_ccy)
       AND (i_type is null or TYPE = i_type)
       AND (i_acc_category is null or ACC_CATEGORY = i_acc_category)
       AND (i_fee_code is null or FEE_CODE = i_fee_code)
       AND (i_amt is null or AMT = i_amt)
     ORDER BY AMEND_DATE DESC;
  END SP_GET_LOAN_CIF_ACCOUNTING;
 
--**************************************************************************
-- 878 SP_UPD_LOAN_CIF_ACCOUNTING
-- Purpose:   更新授信戶列銷帳主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.19  created
--
--**************************************************************************
  PROCEDURE SP_UPD_LOAN_CIF_ACCOUNTING
  ( i_cif_accounting_seq_no IN NUMBER          -- 授信戶列帳主檔序號
  , i_customer_loan_seq_no  IN NUMBER          -- 授信戶主檔序號
  , i_acc_branch            IN VARCHAR2        -- 設帳分行
  , i_acc_category          IN VARCHAR2        -- 設帳科目
  , i_ccy                   IN VARCHAR2        -- 幣別
  , i_type                  IN VARCHAR2        -- 種類
  , i_fee_code              IN VARCHAR2        -- 費用代碼
  , i_amt                   IN NUMBER          -- 金額
  , o_row_count             OUT NUMBER         -- o_row_count
  ) AS
  BEGIN
    UPDATE EDLS.TB_LOAN_CIF_ACCOUNTING 
       SET CUSTOMER_LOAN_SEQ_NO    = i_customer_loan_seq_no
         , ACC_BRANCH              = i_acc_branch
         , ACC_CATEGORY            = i_acc_category
         , CCY                     = i_ccy
         , TYPE                    = i_type
         , FEE_CODE                = i_fee_code
         , AMT                     = i_amt
         , AMEND_DATE              = SYSTIMESTAMP
    WHERE CIF_ACCOUNTING_SEQ_NO    = i_cif_accounting_seq_no ;
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_LOAN_CIF_ACCOUNTING;

--**************************************************************************
-- 879 SP_INS_LOAN_CIF_ACCOUNTING
-- Purpose:   新增授信戶列銷帳主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.19  created
--
--**************************************************************************
  PROCEDURE SP_INS_LOAN_CIF_ACCOUNTING
  ( i_customer_loan_seq_no  IN NUMBER          -- 授信戶主檔序號
  , i_acc_branch            IN VARCHAR2        -- 設帳分行
  , i_acc_category          IN VARCHAR2        -- 設帳科目
  , i_ccy                   IN VARCHAR2        -- 幣別
  , i_type                  IN VARCHAR2        -- 種類
  , i_fee_code              IN VARCHAR2        -- 費用代碼
  , i_amt                   IN NUMBER          -- 金額
  , o_cur                   OUT NUMBER         -- O_SEQ_NO
  ) AS
  BEGIN 
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LOAN_CIF_ACCOUNTING', o_cur);
    INSERT INTO EDLS.TB_LOAN_CIF_ACCOUNTING
    ( CIF_ACCOUNTING_SEQ_NO
    , CUSTOMER_LOAN_SEQ_NO
    , ACC_BRANCH
    , ACC_CATEGORY
    , CCY
    , TYPE
    , FEE_CODE
    , AMT
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES 
    ( o_cur
    , i_customer_loan_seq_no
    , i_acc_branch
    , i_acc_category
    , i_ccy
    , i_type
    , i_fee_code
    , i_amt
    , systimestamp
    , systimestamp
    );
  END SP_INS_LOAN_CIF_ACCOUNTING;
    
--**************************************************************************
-- 880 SP_INS_LOAN_EACH_SETTLEMENT
-- Purpose: 新增授信戶列銷帳交易明細
-- 
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.11  created
-- 
--************************************************************************** 
  PROCEDURE SP_INS_LOAN_EACH_SETTLEMENT
  ( i_loan_accounting_seq_no IN NUMBER   -- 列帳主檔序號
  , i_sno                    IN NUMBER   -- 序號
  , i_txn_date               IN VARCHAR2 -- 交易日期
  , i_txn_time               IN VARCHAR2 -- 交易時間
  , i_txn_branch             IN VARCHAR2 -- 交易分行
  , i_txn_memo               IN VARCHAR2 -- 交易摘要
  , i_sup_emp_id             IN VARCHAR2 -- 授權主管員編
  , i_teller_emp_id          IN VARCHAR2 -- 執行櫃員員編
  , i_sup_card               IN VARCHAR2 -- 授權主管卡號
  , i_dc_code                IN VARCHAR2 -- 借貸別
  , i_txn_amt                IN NUMBER   -- 交易金額
  , i_is_ec                  IN VARCHAR2 -- 是否為沖正交易
  , i_invoice_no             IN VARCHAR2 -- 發票號碼
  , i_host_sno               IN VARCHAR2 -- 主機交易序號
  , i_memo                   IN VARCHAR2 -- 摘要
  , O_SEQ_NO                 OUT NUMBER  -- O_SEQ_NO
  ) AS
  BEGIN 
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LOAN_EACH_SETTLEMENT', O_SEQ_NO);
    INSERT INTO EDLS.TB_LOAN_EACH_SETTLEMENT
    ( EACH_SETTLEMENT_SEQ_NO
    , LOAN_ACCOUNTING_SEQ_NO
    , SNO
    , TXN_DATE
    , TXN_TIME
    , TXN_BRANCH
    , TXN_MEMO
    , SUP_EMP_ID
    , TELLER_EMP_ID
    , SUP_CARD
    , DC_CODE
    , TXN_AMT
    , IS_EC
    , INVOICE_NO
    , HOST_SNO
    , MEMO
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES 
    ( O_SEQ_NO
    , i_loan_accounting_seq_no
    , i_sno
    , i_txn_date
    , i_txn_time
    , i_txn_branch
    , i_txn_memo
    , i_sup_emp_id
    , i_teller_emp_id
    , i_sup_card 
    , i_dc_code
    , i_txn_amt
    , i_is_ec
    , i_invoice_no
    , i_host_sno
    , i_memo
    , systimestamp
    , systimestamp
    );
  END SP_INS_LOAN_EACH_SETTLEMENT;

--**************************************************************************
-- 881 SP_GET_MAX_EACHSETTLEMENTSEQNO
-- Purpose: 取得授信戶主檔序號對應的授信戶列銷帳交易明細，取當日最大的交易日期序號
-- 
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.12  created
-- 
--************************************************************************** 
  PROCEDURE SP_GET_MAX_EACHSETTLEMENTSEQNO
  ( i_customer_loan_seq_no      IN NUMBER     -- 授信戶主檔序號
  , i_txn_date                  IN VARCHAR2   -- 交易日期                                                                               
  , o_cur                       OUT NUMBER    -- 當日最大的交易日期序號
  ) AS
  BEGIN
    SELECT MAX(TLES.SNO) INTO o_cur
      FROM EDLS.TB_LOAN_EACH_ACCOUNTING TLEA
      LEFT JOIN EDLS.TB_LOAN_EACH_SETTLEMENT TLES 
        ON TLEA.LOAN_ACCOUNTING_SEQ_NO = TLES.LOAN_ACCOUNTING_SEQ_NO 
     WHERE TLEA.CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
       AND TLES.TXN_DATE = i_txn_date;
  END SP_GET_MAX_EACHSETTLEMENTSEQNO;
  
--**************************************************************************
-- 882 SP_GET_LOAN_EACH_SETTLEMENT
-- Purpose: 取得列銷帳交易明細
-- 
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.12  created
-- 
--************************************************************************** 
  PROCEDURE SP_GET_LOAN_EACH_SETTLEMENT
  ( i_customer_loan_seq_no        IN NUMBER            -- 授信戶主檔序號
  , i_txn_date                    IN VARCHAR2          -- 交易日期     
  , i_host_sno                    IN VARCHAR2          -- 主機交易序號
  , o_cur                         OUT SYS_REFCURSOR    -- 授信戶列銷帳交易明細
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT TLES.EACH_SETTLEMENT_SEQ_NO  -- 列帳明細檔序號
         , TLES.LOAN_ACCOUNTING_SEQ_NO  -- 列帳主檔序號
         , TLES.SNO                     -- 序號
         , TLES.TXN_DATE                -- 交易日期
         , TLES.TXN_TIME                -- 交易時間
         , TLES.TXN_BRANCH              -- 交易分行
         , TLES.TXN_MEMO                -- 交易摘要
         , TLES.SUP_EMP_ID              -- 授權主管員編
         , TLES.TELLER_EMP_ID           -- 執行櫃員員編
         , TLES.SUP_CARD                -- 授權主管卡號
         , TLES.DC_CODE                 -- 借貸別
         , TLES.TXN_AMT                 -- 交易金額
         , TLES.IS_EC                   -- 是否為沖正交易
         , TLES.INVOICE_NO              -- 發票號碼
         , TLES.HOST_SNO                -- 主機交易序號
         , TLES.MEMO                    -- 摘要
      FROM EDLS.TB_LOAN_EACH_SETTLEMENT TLES
      JOIN EDLS.TB_LOAN_EACH_ACCOUNTING TLEA 
        ON TLES.LOAN_ACCOUNTING_SEQ_NO = TLEA.LOAN_ACCOUNTING_SEQ_NO 
     WHERE TLEA.CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
       AND TLES.TXN_DATE = i_txn_date
       AND TLES.HOST_SNO = i_host_sno
       AND TLES.IS_EC = 'X'
     ORDER BY TXN_DATE DESC, SNO DESC
     FETCH FIRST 1 ROWS ONLY;
  END SP_GET_LOAN_EACH_SETTLEMENT;

--**************************************************************************
-- 883 SP_UPD_LOAN_EACH_SETTLEMENT
-- Purpose: 更新列銷帳交易明細
-- 
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.12  created
-- 
--************************************************************************** 
  PROCEDURE SP_UPD_LOAN_EACH_SETTLEMENT
  ( i_each_settlement_seq_no   IN NUMBER   -- 列帳明細檔序號
  , i_loan_accounting_seq_no   IN NUMBER   -- 列帳主檔序號
  , i_sno                      IN NUMBER   -- 序號
  , i_txn_date                 IN VARCHAR2 -- 交易日期
  , i_txn_time                 IN VARCHAR2 -- 交易時間
  , i_txn_branch               IN VARCHAR2 -- 交易分行
  , i_txn_memo                 IN VARCHAR2 -- 交易摘要
  , i_sup_emp_id               IN VARCHAR2 -- 授權主管員編
  , i_teller_emp_id            IN VARCHAR2 -- 執行櫃員員編
  , i_sup_card                 IN VARCHAR2 -- 授權主管卡號
  , i_dc_code                  IN VARCHAR2 -- 借貸別
  , i_txn_amt                  IN NUMBER   -- 交易金額
  , i_is_ec                    IN VARCHAR2 -- 是否為沖正交易
  , i_invoice_no               IN VARCHAR2 -- 發票號碼
  , i_host_sno                 IN VARCHAR2 -- 主機交易序號
  , i_memo                     IN VARCHAR2 -- 摘要
  , o_row_count                OUT NUMBER  -- 授信戶列銷帳交易明細
  ) AS
  BEGIN
    UPDATE EDLS.TB_LOAN_EACH_SETTLEMENT
       SET LOAN_ACCOUNTING_SEQ_NO  = i_loan_accounting_seq_no
         , SNO                    = i_sno
         , TXN_DATE               = i_txn_date
         , TXN_TIME               = i_txn_time
         , TXN_BRANCH             = i_txn_branch
         , TXN_MEMO               = i_txn_memo
         , SUP_EMP_ID             = i_sup_emp_id
         , TELLER_EMP_ID          = i_teller_emp_id
         , SUP_CARD               = i_sup_card
         , DC_CODE                = i_dc_code
         , TXN_AMT                = i_txn_amt
         , IS_EC                  = i_is_ec
         , INVOICE_NO             = i_invoice_no
         , HOST_SNO               = i_host_sno
         , MEMO                   = i_memo
         , AMEND_DATE             = SYSTIMESTAMP
     WHERE EACH_SETTLEMENT_SEQ_NO  = i_each_settlement_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_LOAN_EACH_SETTLEMENT;

--**************************************************************************
-- 885 SP_GET_LOAN_CIF_ACCOUNTING_CNT
-- Purpose: 查詢同一個授信戶主檔序號下授信戶列銷帳主檔的所有設帳分行的各交易明細資料筆數
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.12  created
--
--**************************************************************************
  PROCEDURE SP_GET_LOAN_CIF_ACCOUNTING_CNT
  ( i_customer_loan_seq_no   IN NUMBER     -- 授信戶主檔序號
  , i_acc_branch             IN VARCHAR2   -- 設帳分行
  , i_ccy                    IN VARCHAR2   -- 幣別
  , i_type                   IN VARCHAR2   -- 種類
  , i_fee_code               IN VARCHAR2   -- 費用代碼
  , o_row_count              OUT NUMBER    -- 各交易明細資料筆數
  ) AS
  BEGIN
    SELECT COUNT(CUSTOMER_LOAN_SEQ_NO) INTO o_row_count
      FROM EDLS.TB_LOAN_CIF_SETTLEMENT
     WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
       AND ACC_BRANCH           = i_acc_branch
       AND CCY                  = i_ccy
       AND TYPE                 = i_type
       AND Fee_Code             = i_fee_code;
  END SP_GET_LOAN_CIF_ACCOUNTING_CNT;

--**************************************************************************
-- 886 SP_GET_LOAN_CIF_ACCOUNTING_REC
-- Purpose: 查詢同一個授信戶主檔序號下授信戶列銷帳主檔的所有設帳分行的各交易明細資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.12  created
--
--**************************************************************************
  PROCEDURE SP_GET_LOAN_CIF_ACCOUNTING_REC
  ( i_customer_loan_seq_no   IN NUMBER           -- 授信戶主檔序號
  , i_acc_branch             IN VARCHAR2         -- 設帳分行
  , i_ccy                    IN VARCHAR2         -- 幣別
  , i_type                   IN VARCHAR2         -- 種類
  , i_fee_code               IN VARCHAR2         -- 費用代碼
  , i_begin_idx              IN NUMBER           -- oracle offset 筆數
  , i_count                  IN NUMBER           -- oracle fetch next 筆數
  , o_cur                    OUT SYS_REFCURSOR   -- o_cur
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT ACC_BRANCH
         , CCY
         , SUM(AMT) AMT
      FROM EDLS.TB_LOAN_CIF_ACCOUNTING
     WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no  
       AND ACC_BRANCH           = i_acc_branch   
       AND CCY                  = i_ccy
       AND TYPE                 = i_type
       AND Fee_Code             = i_fee_code
     GROUP BY CUSTOMER_LOAN_SEQ_NO , ACC_BRANCH, CCY
     ORDER BY CUSTOMER_LOAN_SEQ_NO , ACC_BRANCH, CCY
    OFFSET (i_begin_idx-1) ROWS Fetch NEXT (i_count) ROWS ONLY;  
  END SP_GET_LOAN_CIF_ACCOUNTING_REC; 
   
--**************************************************************************
-- 905 SP_INS_LOAN_EACH_ACCOUNTING
-- Purpose: 新增列帳主檔
-- 
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.11  created
-- 
--************************************************************************** 
  PROCEDURE SP_INS_LOAN_EACH_ACCOUNTING
  ( i_accounting_no          IN VARCHAR2 -- 列帳主檔鍵值
  , i_customer_loan_seq_no   IN NUMBER   -- 授信戶主檔序號
  , i_acc_branch             IN VARCHAR2 -- 設帳分行
  , i_acc_category           IN VARCHAR2 -- 設帳科目
  , i_ccy                    IN VARCHAR2 -- 幣別
  , i_txn_branch             IN VARCHAR2 -- 交易分行
  , i_accounting_date        IN VARCHAR2 -- 列帳日期
  , i_accounting_amt         IN NUMBER   -- 列帳金額
  , i_settlement_amt         IN NUMBER   -- 銷帳金額
  , i_cust_center_branch     IN VARCHAR2 -- 顧客所屬企金中心
  , i_acc_center_branch      IN VARCHAR2 -- 帳號所屬中心
  , i_invoice_no             IN VARCHAR2 -- 發票號碼
  , i_loan_no                IN VARCHAR2 -- 放款帳號
  , i_paymt_type             IN VARCHAR2 -- 還款種類
  , i_dw_source              IN VARCHAR2 -- 扣款來源
  , i_from_acct_no           IN VARCHAR2 -- 轉出帳號
  , i_tel_no                 IN VARCHAR2 -- 電話
  , i_host_sno               IN VARCHAR2 -- 主機交易序號
  , i_remark                 IN VARCHAR2 -- 備註
  , i_fee_code               IN VARCHAR2 -- 費用代碼  
  , i_ref_no                 IN VARCHAR2 -- REF_NO
  , i_accounting_serial_no   IN NUMBER   -- 列帳序號  
  , o_cur                    OUT NUMBER  -- O_SEQ_NO
  ) AS
  BEGIN 
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LOAN_EACH_ACCOUNTING', o_cur);
    INSERT INTO EDLS.TB_LOAN_EACH_ACCOUNTING
    ( LOAN_ACCOUNTING_SEQ_NO
    , ACCOUNTING_NO
    , CUSTOMER_LOAN_SEQ_NO
    , ACC_BRANCH
    , ACC_CATEGORY
    , CCY
    , TXN_BRANCH
    , ACCOUNTING_DATE
    , ACCOUNTING_AMT
    , SETTLEMENT_AMT
    , CUST_CENTER_BRANCH
    , ACC_CENTER_BRANCH
    , INVOICE_NO
    , LOAN_NO
    , PAYMT_TYPE
    , DW_SOURCE
    , FROM_ACCT_NO
    , TEL_NO
    , HOST_SNO
    , REMARK
    , CREATE_DATE
    , AMEND_DATE
    , FEE_CODE
    , REF_NO
    , ACCOUNTING_SERIAL_NO
    )
    VALUES 
    ( o_cur
    , i_accounting_no
    , i_customer_loan_seq_no
    , i_acc_branch
    , i_acc_category
    , i_ccy
    , i_txn_branch
    , i_accounting_date
    , i_accounting_amt
    , i_settlement_amt
    , i_cust_center_branch
    , i_acc_center_branch
    , i_invoice_no
    , i_loan_no
    , i_paymt_type
    , i_dw_source
    , i_from_acct_no
    , i_tel_no
    , i_host_sno
    , i_remark
    , systimestamp
    , systimestamp
    , i_fee_code
    , i_ref_no
    , i_accounting_serial_no
    );
  END SP_INS_LOAN_EACH_ACCOUNTING;
  
--**************************************************************************
-- 912 SP_GET_LOAN_EACH_ACCOUNTING
-- Purpose: 取得列帳主檔(PK查尋)
-- 
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.11  created
-- 
--************************************************************************** 
  PROCEDURE SP_GET_LOAN_EACH_ACCOUNTING
  ( i_loan_accounting_seq_no IN NUMBER           -- 列帳主檔序號
  , o_cur                    OUT SYS_REFCURSOR   -- O_SEQ_NO
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LOAN_ACCOUNTING_SEQ_NO  -- 列帳主檔序號
         , ACCOUNTING_NO            -- 列帳主檔鍵值
         , CUSTOMER_LOAN_SEQ_NO     -- 授信戶主檔序號
         , ACC_BRANCH               -- 設帳分行
         , ACC_CATEGORY             -- 設帳科目
         , CCY                      -- 幣別
         , FEE_CODE                 -- 費用代碼
         , TXN_BRANCH               -- 交易分行
         , ACCOUNTING_DATE          -- 列帳日期
         , ACCOUNTING_AMT           -- 列帳金額
         , SETTLEMENT_AMT           -- 銷帳金額
         , CUST_CENTER_BRANCH       -- 顧客所屬企金中心
         , ACC_CENTER_BRANCH        -- 帳號所屬中心
         , INVOICE_NO               -- 發票號碼
         , LOAN_NO                  -- 放款帳號
         , PAYMT_TYPE               -- 還款種類
         , DW_SOURCE                -- 扣款來源
         , FROM_ACCT_NO             -- 轉出帳號
         , TEL_NO                   -- 電話
         , HOST_SNO                 -- 主機交易序號
         , REMARK                   -- 備註
         , REF_NO                   -- REF_NO
         , ACCOUNTING_SERIAL_NO     -- 列帳序號           
      FROM EDLS.TB_LOAN_EACH_ACCOUNTING 
     WHERE LOAN_ACCOUNTING_SEQ_NO = i_loan_accounting_seq_no;
  END SP_GET_LOAN_EACH_ACCOUNTING;

--**************************************************************************
-- 914 SP_DEL_LOAN_EACH_ACCOUNTING
-- Purpose: 刪除列帳主檔
-- 
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.11  created
-- 
--************************************************************************** 
  PROCEDURE SP_DEL_LOAN_EACH_ACCOUNTING
  ( i_loan_accounting_seq_no IN NUMBER      -- 列帳主檔序號
  , o_row_count              OUT NUMBER     -- o_row_count 
  ) AS
  BEGIN
    DELETE EDLS.TB_LOAN_EACH_ACCOUNTING
     WHERE LOAN_ACCOUNTING_SEQ_NO = i_loan_accounting_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_LOAN_EACH_ACCOUNTING; 
  
--**************************************************************************
-- 936 SP_GET_LOAN_EACH_ACC_BY_VALUES
-- Purpose: 取得列帳主檔
-- 
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.11  created
-- 1.1 康晉維     2019.10.30  modified
-- 1.2 康晉維     2019.12.16  modified
--************************************************************************** 
  PROCEDURE SP_GET_LOAN_EACH_ACC_BY_VALUES
  ( i_accounting_no        IN VARCHAR2         -- 列帳主檔鍵值
  , i_customer_loan_seq_no IN NUMBER           -- 授信戶主檔序號
  , i_acc_branch           IN VARCHAR2         -- 設帳分行
  , i_acc_category         IN VARCHAR2         -- 設帳科目
  , i_ccy                  IN VARCHAR2         -- 幣別
  , i_fee_code             IN VARCHAR2         -- 費用代碼
  , i_accounting_date      IN VARCHAR2         -- 列帳日期
  , i_accounting_serial_no IN NUMBER           -- 列帳序號
  , i_ref_no               IN VARCHAR2         -- Reference No
  , i_host_sno             IN VARCHAR2         -- 主機交易序號
  , o_cur                  OUT SYS_REFCURSOR   -- O_SEQ_NO
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LOAN_ACCOUNTING_SEQ_NO -- 列帳主檔序號
         , ACCOUNTING_NO          -- 列帳主檔鍵值
         , CUSTOMER_LOAN_SEQ_NO   -- 授信戶主檔序號
         , ACC_BRANCH             -- 設帳分行
         , ACC_CATEGORY           -- 設帳科目
         , CCY                    -- 幣別
         , TXN_BRANCH             -- 交易分行
         , ACCOUNTING_DATE        -- 列帳日期
         , ACCOUNTING_AMT         -- 列帳金額
         , SETTLEMENT_AMT         -- 銷帳金額
         , CUST_CENTER_BRANCH     -- 顧客所屬企金中心
         , ACC_CENTER_BRANCH      -- 帳號所屬中心
         , INVOICE_NO             -- 發票號碼
         , LOAN_NO                -- 放款帳號
         , PAYMT_TYPE             -- 還款種類
         , DW_SOURCE              -- 扣款來源
         , FROM_ACCT_NO           -- 轉出帳號
         , TEL_NO                 -- 電話
         , HOST_SNO               -- 主機交易序號
         , REMARK                 -- 備註
         , FEE_CODE               -- 費用代碼
         , REF_NO                 -- REF_NO
         , ACCOUNTING_SERIAL_NO   -- 列帳序號        
      FROM EDLS.TB_LOAN_EACH_ACCOUNTING 
     WHERE CUSTOMER_LOAN_SEQ_NO  = i_customer_loan_seq_no
       AND ACC_CATEGORY = i_acc_category
       AND (i_accounting_no        is null or ACCOUNTING_NO = i_accounting_no)
       AND (i_ccy                  is null or CCY = i_ccy) 
       AND (i_fee_code             is null or FEE_CODE = i_fee_code)
       AND (i_acc_branch           is null or ACC_BRANCH = i_acc_branch)
       AND (i_accounting_date      is null or ACCOUNTING_DATE = i_accounting_date)
       AND (i_accounting_serial_no is null or ACCOUNTING_SERIAL_NO = i_accounting_serial_no)
       AND (i_ref_no               is null or REF_NO = i_ref_no)
       AND (i_host_sno             IS NULL OR HOST_SNO = i_host_sno);
  END SP_GET_LOAN_EACH_ACC_BY_VALUES; 
  
--**************************************************************************
-- 939 SP_UPD_LOAN_EACH_ACCOUNTING
-- Purpose: 修改列帳主檔
-- 
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.11  created
-- 
--************************************************************************** 
  PROCEDURE SP_UPD_LOAN_EACH_ACCOUNTING
  ( i_loan_accounting_seq_no  IN NUMBER   -- 列帳主檔序號
  , i_accounting_no           IN VARCHAR2 -- 列帳主檔鍵值
  , i_customer_loan_seq_no    IN NUMBER   -- 授信戶主檔序號
  , i_acc_branch              IN VARCHAR2 -- 設帳分行
  , i_acc_category            IN VARCHAR2 -- 設帳科目
  , i_ccy                     IN VARCHAR2 -- 幣別
  , i_fee_code                IN VARCHAR2 -- 費用代碼                                                                                                                    
  , i_txn_branch              IN VARCHAR2 -- 交易分行
  , i_accounting_date         IN VARCHAR2 -- 列帳日期
  , i_accounting_amt          IN NUMBER   -- 列帳金額
  , i_settlement_amt          IN NUMBER   -- 銷帳金額
  , i_cust_center_branch      IN VARCHAR2 -- 顧客所屬企金中心
  , i_acc_center_branch       IN VARCHAR2 -- 帳號所屬中心
  , i_invoice_no              IN VARCHAR2 -- 發票號碼
  , i_loan_no                 IN VARCHAR2 -- 放款帳號
  , i_paymt_type              IN VARCHAR2 -- 還款種類
  , i_dw_source               IN VARCHAR2 -- 扣款來源
  , i_from_acct_no            IN VARCHAR2 -- 轉出帳號
  , i_tel_no                  IN VARCHAR2 -- 電話
  , i_host_sno                IN VARCHAR2 -- 主機交易序號
  , i_remark                  IN VARCHAR2 -- 備註
  , i_ref_no                  IN VARCHAR2 -- REF_NO
  , i_accounting_serial_no    IN NUMBER   -- 列帳序號   
  , o_row_count               OUT NUMBER  -- o_row_count
  ) AS
   BEGIN
    UPDATE EDLS.TB_LOAN_EACH_ACCOUNTING
       SET ACCOUNTING_NO         = i_accounting_no
         , CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
         , ACC_BRANCH           = i_acc_branch
         , ACC_CATEGORY         = i_acc_category
         , CCY                  = i_ccy
         , FEE_CODE             = i_fee_code
         , TXN_BRANCH           = i_txn_branch
         , ACCOUNTING_DATE      = i_accounting_date
         , ACCOUNTING_AMT       = i_accounting_amt
         , SETTLEMENT_AMT       = i_settlement_amt
         , CUST_CENTER_BRANCH   = i_cust_center_branch
         , ACC_CENTER_BRANCH    = i_acc_center_branch
         , INVOICE_NO           = i_invoice_no
         , LOAN_NO              = i_loan_no
         , PAYMT_TYPE           = i_paymt_type
         , DW_SOURCE            = i_dw_source
         , FROM_ACCT_NO         = i_from_acct_no
         , TEL_NO               = i_tel_no
         , HOST_SNO             = i_host_sno
         , REMARK               = i_remark
         , REF_NO               = i_ref_no
         , ACCOUNTING_SERIAL_NO = i_accounting_serial_no
         , AMEND_DATE           = SYSTIMESTAMP
     WHERE LOAN_ACCOUNTING_SEQ_NO = i_loan_accounting_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_LOAN_EACH_ACCOUNTING;

--**************************************************************************
-- 940 SP_GET_MAX_CIFSETTLEMENTSEQNO
-- Purpose: 取得授信戶主檔序號對應的授信戶列銷帳交易明細，取當日最大的交易日期序號
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.19  created
--
--**************************************************************************
  PROCEDURE SP_GET_MAX_CIFSETTLEMENTSEQNO
  ( i_customer_loan_seq_no  IN NUMBER     -- 授信戶主檔序號
  , i_txn_date              IN VARCHAR2   -- 交易日期
  , o_cur                  OUT NUMBER     -- 當日最大的交易日期序號
  ) AS
  BEGIN
    SELECT MAX(TLCS.TXN_DATE_SNO) INTO o_cur
      FROM EDLS.TB_LOAN_CIF_ACCOUNTING TLCA                 
      LEFT JOIN EDLS.TB_LOAN_CIF_SETTLEMENT TLCS 
        ON TLCA.CUSTOMER_LOAN_SEQ_NO = TLCS.CUSTOMER_LOAN_SEQ_NO 
      WHERE TLCA.CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
        AND TLCS.TXN_DATE = i_txn_date;
  END SP_GET_MAX_CIFSETTLEMENTSEQNO;
   
--**************************************************************************
-- 944 SP_INS_LOAN_CIF_SETTLEMENT
-- Purpose: 新增授信戶銷帳交易明細
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.19  created
-- 1.1 康晉維     2019.12.16  modified
--**************************************************************************
  PROCEDURE  SP_INS_LOAN_CIF_SETTLEMENT 
  ( i_customer_loan_seq_no     IN NUMBER     --授信戶主檔序號
  , i_txn_date                 IN NUMBER     --交易日期
  , i_txn_date_sno             IN VARCHAR2   --交易日期序號
  , i_txn_time                 IN VARCHAR2   --交易時間
  , i_txn_branch               IN VARCHAR2   --交易分行
  , i_txn_id                   IN VARCHAR2   --交易代碼
  , i_txn_type                 IN VARCHAR2   --交易分類
  , i_txn_memo                 IN VARCHAR2   --交易摘要               
  , i_sup_emp_id               IN VARCHAR2   --授權主管員編
  , i_teller_emp_id            IN VARCHAR2   --執行櫃員員編
  , i_sup_card                 IN VARCHAR2   --授權主管卡號
  , i_dc_code                  IN VARCHAR2   --借貸別                                  
  , i_acc_branch               IN VARCHAR2   --設帳分行
  , i_acc_category             IN VARCHAR2   --設帳科目                                     
  , i_fee_code                 IN VARCHAR2   --費用代碼
  , i_ccy                      IN VARCHAR2   --幣別
  , i_txn_amt                  IN NUMBER     --交易金額
  , i_ec_mk                    IN VARCHAR2   --是否為沖正交易
  , i_host_sno                 IN VARCHAR2   --主機交易序號                                      
  , i_memo                     IN VARCHAR2   --全形摘要
  , i_appr_doc_no              IN VARCHAR2   --批覆書編號
  , i_type                     IN VARCHAR2   --種類
  , i_loan_no                  IN VARCHAR2   --放款帳號
  , i_eval_company_code        IN VARCHAR2   --鑑估機構                                     
  , i_eval_no                  IN VARCHAR2   --鑑估編號
  , i_action_code              IN VARCHAR2   --執行動作
  , i_exec_tell                IN VARCHAR2   --執行櫃員代碼
  , i_draft_pay_bank           IN VARCHAR2   --票據付款行                                      
  , i_draft_no                 IN VARCHAR2   --票據號碼
  , i_coll_cr_acc_no           IN VARCHAR2   --託收存入帳號
  , i_boun_cheq_mk             IN VARCHAR2   --退票註記
  , i_info_asset_no            IN VARCHAR2   --資訊資產代號
  , i_fahgu_id                 IN VARCHAR2   --全域流水號
  , i_action_type              IN VARCHAR2   --執行類別
  , i_draft_mk                 IN VARCHAR2   --票據註記
  , o_seq_no                   OUT NUMBER    -- o_seq_no
) AS
  BEGIN 
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LOAN_CIF_SETTLEMENT', o_seq_no);
    INSERT INTO EDLS.TB_LOAN_CIF_SETTLEMENT
    ( CIF_SETTLEMENT_SEQ_NO
    , CUSTOMER_LOAN_SEQ_NO
    , TXN_DATE
    , TXN_DATE_SNO
    , TXN_TIME
    , TXN_BRANCH
    , TXN_ID
    , TXN_TYPE
    , TXN_MEMO
    , SUP_EMP_ID
    , TELLER_EMP_ID
    , SUP_CARD
    , DC_CODE
    , ACC_BRANCH
    , ACC_CATEGORY
    , FEE_CODE
    , CCY
    , TXN_AMT
    , EC_MK
    , HOST_SNO
    , MEMO
    , APPR_DOC_NO
    , TYPE
    , LOAN_NO
    , EVAL_COMPANY_CODE
    , EVAL_NO
    , ACTION_CODE
    , EXEC_TELLER_ID
    , CREATE_DATE
    , AMEND_DATE
    , DRAFT_PAY_BANK
    , DRAFT_NO
    , COLLECTOR_ACC
    , RTN_CHECK_MK
    , INFO_ASSET_NO
    , FAHGU_ID
    , ACTION_TYPE
    , DRAFT_MK
    )
    VALUES 
    ( o_seq_no
    , i_customer_loan_seq_no
    , i_txn_date
    , i_txn_date_sno
    , i_txn_time
    , i_txn_branch
    , i_txn_id
    , i_txn_type
    , i_txn_memo
    , i_sup_emp_id
    , i_teller_emp_id
    , i_sup_card
    , i_dc_code
    , i_acc_branch
    , i_acc_category
    , i_fee_code
    , i_ccy
    , i_txn_amt
    , i_ec_mk
    , i_host_sno
    , i_memo
    , i_appr_doc_no
    , i_type
    , i_loan_no
    , i_eval_company_code
    , i_eval_no
    , i_action_code
    , i_exec_tell
    , systimestamp
    , systimestamp
    , i_draft_pay_bank
    , i_draft_no
    , i_coll_cr_acc_no
    , i_boun_cheq_mk
    , i_info_asset_no
    , i_fahgu_id
    , i_action_type
    , i_draft_mk
    );
  END SP_INS_LOAN_CIF_SETTLEMENT;

--**************************************************************************
-- 1172 SP_GET_LOAN_CIF_ACC_ALL_REC
-- Purpose:   以銀行歸戶統編、設帳分行、幣別、種類、費用代碼查詢授信戶列銷帳主檔全部的資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.20  created
--
--**************************************************************************
  PROCEDURE SP_GET_LOAN_CIF_ACC_ALL_REC
  (  i_cust_id               IN VARCHAR2         --銀行歸戶統編
   , i_customer_loan_seq_no  IN NUMBER           --授信戶主檔序號  
   , i_acc_branch            IN VARCHAR2         --設帳分行
   , i_ccy                   IN VARCHAR2         --幣別
   , i_type                  IN VARCHAR2         --種類
   , i_fee_code              IN VARCHAR2         --費用代碼
  , o_cur                    OUT SYS_REFCURSOR   -- o_cur
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LCA.CIF_ACCOUNTING_SEQ_NO
         , LCA.CUSTOMER_LOAN_SEQ_NO
         , LCA.ACC_BRANCH
         , LCA.ACC_CATEGORY
         , LCA.CCY
         , LCA.TYPE
         , LCA.FEE_CODE
         , LCA.AMT
      FROM EDLS.TB_LOAN_CIF_ACCOUNTING LCA                          -- 授信戶列銷帳主檔
      JOIN EDLS.TB_CUSTOMER_LOAN  CL                                -- 授信戶主檔
        ON LCA.CUSTOMER_LOAN_SEQ_NO = CL.CUSTOMER_LOAN_SEQ_NO       -- 授信戶主檔序號 
     WHERE ( i_customer_loan_seq_no is null or LCA.CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no )
       AND ( i_acc_branch is null or LCA.ACC_BRANCH = i_acc_branch )
       AND ( i_ccy is null or LCA.CCY = i_ccy )
       AND ( i_type       is null or LCA.TYPE = i_type )
       AND ( i_fee_code is null or  LCA.FEE_CODE = i_fee_code )
       AND ( i_cust_id is null or CL.CUST_ID = i_cust_id )
     ORDER BY LCA.AMEND_DATE DESC;             
  END SP_GET_LOAN_CIF_ACC_ALL_REC; 

--**************************************************************************
-- 1242 SP_GET_LAW_AMOUNT_BY_ALL_BANK
-- Purpose: 訴訟代墊款全行查詢
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.21  created
--
--**************************************************************************
  PROCEDURE SP_GET_LAW_AMOUNT_BY_ALL_BANK
  ( i_customer_loan_seq_no    IN NUMBER          --授信戶主檔序號
  , i_acc_branch              IN VARCHAR2        --設帳分行
  , i_ccy                     IN VARCHAR2        --幣別
  , i_type                    IN VARCHAR2        --種類
  , i_fee_code                IN VARCHAR2        --費用代碼
  , i_begin_idx               IN NUMBER          --oracle offset 筆數
  , i_count                   IN NUMBER          --oracle fetch next 筆數
  , o_cur                     OUT SYS_REFCURSOR  --o_cur
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LOAN_CIF_ACCOUNTING.ACC_BRANCH 
         , LOAN_CIF_ACCOUNTING.CCY
         , SUM(DECODE(LOAN_CIF_ACCOUNTING.TYPE, '1', AMT, 0)) NORMAL_LAW_AOMOUNT
         , SUM(DECODE(LOAN_CIF_ACCOUNTING.TYPE, '2', AMT, 0)) ADV_LAW_AMOUNT
         , SUM(DECODE(LOAN_CIF_ACCOUNTING.TYPE, '3', AMT, 0)) CASH_CARD_LAW_AMOUNT
         , SUM(DECODE(LOAN_CIF_ACCOUNTING.TYPE, '1', AMT, 0)) +  
           SUM(DECODE(LOAN_CIF_ACCOUNTING.TYPE, '2', AMT, 0)) + 
           SUM(DECODE(LOAN_CIF_ACCOUNTING.TYPE, '3', AMT, 0)) TOTAL_AMOUNT
      FROM (SELECT ACC_BRANCH
                 , CCY
                 , TYPE
                 , AMT
              FROM EDLS.TB_LOAN_CIF_ACCOUNTING
             WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
               AND ( i_acc_branch is null or ACC_BRANCH = i_acc_branch )
               AND ( i_ccy is null        or CCY        = i_ccy )
               AND ( i_type is null       or TYPE       = i_type )
               AND ( i_fee_code is null   or FEE_CODE   = i_fee_code )
             GROUP BY ACC_BRANCH, CCY, TYPE, AMT 
           ) LOAN_CIF_ACCOUNTING 
     GROUP by LOAN_CIF_ACCOUNTING.ACC_BRANCH, LOAN_CIF_ACCOUNTING.CCY
     ORDER BY LOAN_CIF_ACCOUNTING.ACC_BRANCH
    OFFSET (i_begin_idx-1) ROWS    --略過 n-1 筆, 也就是從第 n 筆開始
     FETCH NEXT i_count ROWS ONLY; --取幾筆資料, n ~ m 共有 (m - n + 1) 筆
  END SP_GET_LAW_AMOUNT_BY_ALL_BANK;   

--**************************************************************************
-- 1243 SP_GET_LAW_AMOUNT_TXN_DETAIL
-- Purpose: 訴訟代墊款交易明細查詢
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.21  created
-- 1.1 康晉維     2019.06.12  modified
-- 1.2 康晉維     2019.10.25  modified
-- 1.3 康晉維     2019.12.26  modified
--**************************************************************************
  PROCEDURE SP_GET_LAW_AMOUNT_TXN_DETAIL
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , i_txn_date             IN VARCHAR2       -- 交易日期
  , i_fee_code             IN VARCHAR2       -- 費用代碼
  , i_ccy                  IN VARCHAR2       -- 幣別
  , i_type                 IN VARCHAR2       -- 種類
  , i_start_date           IN VARCHAR2       -- 查詢起日 
  , i_end_date             IN VARCHAR2       -- 查詢迄日
  , o_cur                  OUT SYS_REFCURSOR -- o_cur
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT TXN_DATE 
         , TYPE                       -- 種類
         , (CASE
                WHEN DC_CODE = 'D' AND (EC_MK = 'X' OR EC_MK = 'N')
                     THEN '1'
                WHEN DC_CODE = 'C' AND (EC_MK = 'X' OR EC_MK = 'N')
                     THEN '2'
                WHEN DC_CODE = 'D' AND (EC_MK = 'Y' OR EC_MK = 'Y')
                     THEN '3'
                WHEN DC_CODE = 'C' AND (EC_MK = 'Y' OR EC_MK = 'Y')
                     THEN '4'
            END) EXECUTE_ACTION       --執行類別
         , ACTION_CODE                --執行動作
         , CCY
         , TXN_AMT
         , MEMO
         , ACC_BRANCH
         , TXN_BRANCH
         , EXEC_TELLER_ID
      FROM EDLS.TB_LOAN_CIF_SETTLEMENT
     WHERE CUSTOMER_LOAN_SEQ_NO              = i_customer_loan_seq_no
       AND CCY                               = i_ccy
       AND FEE_CODE                          = i_fee_code
       AND (i_type       IS NULL OR TYPE     = i_type)
       AND (i_start_date IS NULL OR TXN_DATE >= i_start_date)
       AND (i_end_date   IS NULL OR TXN_DATE <= i_end_date)
       ORDER BY TXN_DATE,TXN_TIME;
  END SP_GET_LAW_AMOUNT_TXN_DETAIL;  
  
--**************************************************************************
-- 1382 SP_GET_TXN_COUNT_IN_TODAY
-- Purpose: 透過授信戶主檔序號取得當日交易筆數
-- 
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.12  created
-- 
--************************************************************************** 
  PROCEDURE  SP_GET_TXN_COUNT_IN_TODAY 
  ( i_customer_loan_seq_no   IN NUMBER     -- 授信戶主檔序號
  , i_acc_category           IN VARCHAR2   -- 設帳科目
  , i_accounting_date        IN VARCHAR2   -- 現在交易日
  , o_row_count              OUT NUMBER    -- o_row_count
  ) AS
  BEGIN
    SELECT count(LOAN_ACCOUNTING_SEQ_NO) INTO o_row_count
      FROM EDLS.TB_LOAN_EACH_ACCOUNTING
     WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
       AND ACC_CATEGORY = i_acc_category
       AND ACCOUNTING_DATE = i_accounting_date;
  END SP_GET_TXN_COUNT_IN_TODAY;   

--**************************************************************************
-- 1384 SP_GET_SETTLEMENT_DTL_NO
-- Purpose: 透過列帳主檔序號取得銷帳明細最大序號
-- 
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.12  created
-- 
--************************************************************************** 
  PROCEDURE  SP_GET_SETTLEMENT_DTL_NO 
  ( i_acccounting_seq_no     IN NUMBER   -- 列帳主檔序號
  , o_row_count              OUT NUMBER  -- 銷帳明細序號最大號
  ) AS
  BEGIN
    SELECT MAX(SNO) MAX_SNO INTO o_row_count
      FROM EDLS.TB_LOAN_EACH_SETTLEMENT LES
     WHERE LES.LOAN_ACCOUNTING_SEQ_NO = i_acccounting_seq_no;
  END SP_GET_SETTLEMENT_DTL_NO; 

--**************************************************************************
-- 1386 SP_GET_SETTLEMENT_DTL
-- Purpose: 透過多種參數查詢銷帳明細
-- 
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.12  created
-- 
--**************************************************************************   
  PROCEDURE  SP_GET_SETTLEMENT_DTL 
  ( i_each_settlement_seq_no IN NUMBER         -- 列帳明細檔序號
  , i_loan_accounting_seq_no IN NUMBER         -- 列帳主檔序號
  , i_sno                    IN NUMBER         -- 序號
  , i_txn_date               IN VARCHAR2       -- 交易日期
  , i_txn_time               IN VARCHAR2       -- 交易時間
  , i_txn_branch             IN VARCHAR2       -- 交易分行
  , i_txn_memo               IN VARCHAR2       -- 交易摘要
  , i_sup_emp_id             IN VARCHAR2       -- 授權主管員編
  , i_teller_emp_id          IN VARCHAR2       -- 執行櫃員員編
  , i_sup_card               IN VARCHAR2       -- 授權主管卡號
  , i_dc_code                IN VARCHAR2       -- 借貸別
  , i_txn_amt                IN NUMBER         -- 交易金額
  , i_is_ec                  IN VARCHAR2       -- 是否為沖正交易
  , i_invoice_no             IN VARCHAR2       -- 發票號碼
  , i_host_sno               IN VARCHAR2       -- 主機交易序號
  , i_memo                   IN VARCHAR2       -- 摘要
  , O_CUR                    OUT SYS_REFCURSOR -- o_cur
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT EACH_SETTLEMENT_SEQ_NO -- 列帳明細檔序號
         , LOAN_ACCOUNTING_SEQ_NO -- 列帳主檔序號
         , SNO                    -- 序號
         , TXN_DATE               -- 交易日期
         , TXN_TIME               -- 交易時間
         , TXN_BRANCH             -- 交易分行
         , TXN_MEMO               -- 交易摘要
         , SUP_EMP_ID             -- 授權主管員編
         , TELLER_EMP_ID          -- 執行櫃員員編
         , SUP_CARD               -- 授權主管卡號
         , DC_CODE                -- 借貸別
         , TXN_AMT                -- 交易金額
         , IS_EC                  -- 是否為沖正交易
         , INVOICE_NO             -- 發票號碼
         , HOST_SNO               -- 主機交易序號
         , MEMO                   -- 摘要 
      FROM EDLS.TB_LOAN_EACH_SETTLEMENT
     WHERE (i_each_settlement_seq_no IS NULL OR EACH_SETTLEMENT_SEQ_NO = i_each_settlement_seq_no)
       AND (i_loan_accounting_seq_no IS NULL OR LOAN_ACCOUNTING_SEQ_NO = i_loan_accounting_seq_no)
       AND (i_sno IS NULL OR SNO = i_sno)
       AND (i_txn_date IS NULL OR TXN_DATE = i_txn_date)
       AND (i_txn_time IS NULL OR TXN_TIME = i_txn_time)
       AND (i_txn_branch IS NULL OR TXN_BRANCH = i_txn_branch)
       AND (i_txn_memo IS NULL OR TXN_MEMO = i_txn_memo)
       AND (i_sup_emp_id IS NULL OR SUP_EMP_ID = i_sup_emp_id)
       AND (i_teller_emp_id IS NULL OR TELLER_EMP_ID = i_teller_emp_id)
       AND (i_sup_card IS NULL OR SUP_CARD = i_sup_card)
       AND (i_dc_code IS NULL OR DC_CODE = i_dc_code)
       AND (i_txn_amt IS NULL OR TXN_AMT = i_txn_amt)
       AND (i_is_ec IS NULL OR IS_EC = i_is_ec)
       AND (i_invoice_no IS NULL OR INVOICE_NO = i_invoice_no)
       AND (i_host_sno IS NULL OR HOST_SNO = I_Host_Sno)
       AND (i_memo IS NULL OR MEMO = i_memo);
  END SP_GET_SETTLEMENT_DTL;
 
 --**************************************************************************
-- 1388 SP_GET_LOAN_CIF_ACC_FOR_UPD
-- Purpose: 查詢授信戶列銷帳主檔 FOR_UPD
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.19  created
--
--**************************************************************************
  PROCEDURE SP_GET_LOAN_CIF_ACC_FOR_UPD
  ( i_customer_loan_seq_no   IN NUMBER           -- 授信戶主檔序號
   , i_acc_branch            IN VARCHAR2         -- 設帳分行
   , i_acc_category          IN VARCHAR2         -- 設帳科目
   , i_ccy                   IN VARCHAR2         -- 幣別
   , i_type                  IN VARCHAR2         -- 種類
   , i_fee_code              IN VARCHAR2         -- 費用代碼
   , i_amt                   IN NUMBER           -- 金額
   , o_cur                   OUT SYS_REFCURSOR   -- o_cur
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT CIF_ACCOUNTING_SEQ_NO
         , CUSTOMER_LOAN_SEQ_NO
         , ACC_BRANCH
         , ACC_CATEGORY
         , CCY
         , TYPE
         , FEE_CODE
         , AMT
      FROM EDLS.TB_LOAN_CIF_ACCOUNTING 
     WHERE (i_customer_loan_seq_no is null or CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no)
       AND (i_acc_branch is null or ACC_BRANCH = i_acc_branch)
       AND (i_ccy is null or CCY = i_ccy)
       AND (i_type is null or TYPE = i_type)
       AND (i_acc_category is null or ACC_CATEGORY = i_acc_category)
       AND (i_fee_code is null or FEE_CODE = i_fee_code)
       AND (i_amt is null or AMT = i_amt)
       FOR UPDATE
     ORDER BY AMEND_DATE DESC;
  END SP_GET_LOAN_CIF_ACC_FOR_UPD;
    
--**************************************************************************
-- 1389 SP_GET_SETTLEMENT_DTL_FOR_UPD
-- Purpose: 透過多種參數查詢銷帳明細 FOR_UPD
-- 
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.12  created
-- 
--************************************************************************** 
  PROCEDURE  SP_GET_SETTLEMENT_DTL_FOR_UPD 
  ( i_each_settlement_seq_no    IN NUMBER   -- 列帳明細檔序號
  , i_loan_accounting_seq_no    IN NUMBER   -- 列帳主檔序號
  , i_sno                       IN NUMBER   -- 序號
  , i_txn_date                  IN VARCHAR2 -- 交易日期
  , i_txn_time                  IN VARCHAR2 -- 交易時間
  , i_txn_branch                IN VARCHAR2 -- 交易分行
  , i_txn_memo                  IN VARCHAR2 -- 交易摘要
  , i_sup_emp_id                IN VARCHAR2 -- 授權主管員編
  , i_teller_emp_id             IN VARCHAR2 -- 執行櫃員員編
  , i_sup_card                  IN VARCHAR2 -- 授權主管卡號
  , i_dc_code                   IN VARCHAR2 -- 借貸別
  , i_txn_amt                   IN NUMBER   -- 交易金額
  , i_is_ec                     IN VARCHAR2 -- 是否為沖正交易
  , i_invoice_no                IN VARCHAR2 -- 發票號碼
  , i_host_sno                  IN VARCHAR2 -- 主機交易序號
  , i_memo                      IN VARCHAR2 -- 摘要
  , O_CUR                       OUT SYS_REFCURSOR  
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT EACH_SETTLEMENT_SEQ_NO -- 列帳明細檔序號
         , LOAN_ACCOUNTING_SEQ_NO       -- 列帳主檔序號
         , SNO                          -- 序號
         , TXN_DATE                     -- 交易日期
         , TXN_TIME                     -- 交易時間
         , TXN_BRANCH                   -- 交易分行
         , TXN_MEMO                     -- 交易摘要
         , SUP_EMP_ID                   -- 授權主管員編
         , TELLER_EMP_ID                -- 執行櫃員員編
         , SUP_CARD                     -- 授權主管卡號
         , DC_CODE                      -- 借貸別
         , TXN_AMT                      -- 交易金額
         , IS_EC                        -- 是否為沖正交易
         , INVOICE_NO                   -- 發票號碼
         , HOST_SNO                     -- 主機交易序號
         , MEMO                         -- 摘要 
      FROM EDLS.TB_LOAN_EACH_SETTLEMENT
     WHERE (i_each_settlement_seq_no IS NULL OR EACH_SETTLEMENT_SEQ_NO = i_each_settlement_seq_no)
       AND (i_loan_accounting_seq_no IS NULL OR LOAN_ACCOUNTING_SEQ_NO = i_loan_accounting_seq_no)
       AND (i_sno IS NULL OR SNO = i_sno)
       AND (i_txn_date IS NULL OR TXN_DATE = i_txn_date)
       AND (i_txn_time IS NULL OR TXN_TIME = i_txn_time)
       AND (i_txn_branch IS NULL OR TXN_BRANCH = i_txn_branch)
       AND (i_txn_memo IS NULL OR TXN_MEMO = i_txn_memo)
       AND (i_sup_emp_id IS NULL OR SUP_EMP_ID = i_sup_emp_id)
       AND (i_teller_emp_id IS NULL OR TELLER_EMP_ID = i_teller_emp_id)
       AND (i_sup_card IS NULL OR SUP_CARD = i_sup_card)
       AND (i_dc_code IS NULL OR DC_CODE = i_dc_code)
       AND (i_txn_amt IS NULL OR TXN_AMT = i_txn_amt)
       AND (i_is_ec IS NULL OR IS_EC = i_is_ec)
       AND (i_invoice_no IS NULL OR INVOICE_NO = i_invoice_no)
       AND (i_host_sno IS NULL OR HOST_SNO = I_Host_Sno)
       AND (I_Memo IS NULL OR MEMO = i_memo)
       FOR UPDATE;
  END SP_GET_SETTLEMENT_DTL_FOR_UPD;

--**************************************************************************
-- 1393 SP_GET_EACH_ACC_ACCOUNT_DATA
-- Purpose: 查詢列帳主檔帳務資料(含授信戶主檔檢核是否有該授信戶存在)
-- 
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.13  created
-- 
--************************************************************************** 
  PROCEDURE  SP_GET_EACH_ACC_ACCOUNT_DATA 
  (   i_cust_id              IN  VARCHAR2  -- 銀行歸戶統編
    , i_acc_branch           IN  VARCHAR2  -- 設帳分行
    , i_acc_category         IN  VARCHAR2  -- 設帳科目
    , i_ccy                  IN  VARCHAR2  -- 幣別
    , i_fee_code             IN  VARCHAR2  -- 費用代碼                                                                                 
    , i_start_date           IN  VARCHAR2  -- 查詢起日
    , i_end_date             IN  VARCHAR2  -- 查詢訖日
    , O_CUR                  OUT SYS_REFCURSOR  
  ) AS
  cnt         BINARY_INTEGER;
  I_CCY_LIST  dbms_utility.uncl_array;
  BEGIN
    if length(i_ccy) > 1 then 
       dbms_utility.comma_to_table(i_ccy, cnt, I_CCY_LIST);
    else
       I_CCY_LIST(1) := i_ccy;
    end if;
    
    OPEN o_cur FOR
    Select LEA.LOAN_ACCOUNTING_SEQ_NO -- 列帳主檔序號
         , LEA.ACCOUNTING_NO         -- 列帳主檔鍵值
         , LEA.CUSTOMER_LOAN_SEQ_NO  -- 授信戶主檔序號
         , LEA.ACC_BRANCH            -- 設帳分行
         , LEA.ACC_CATEGORY          -- 設帳科目
         , LEA.CCY                   -- 幣別
         , LEA.TXN_BRANCH            -- 交易分行
         , LEA.ACCOUNTING_DATE       -- 列帳日期
         , LEA.ACCOUNTING_AMT        -- 列帳金額
         , LEA.SETTLEMENT_AMT        -- 銷帳金額
         , LEA.CUST_CENTER_BRANCH    -- 顧客所屬企金中心
         , LEA.ACC_CENTER_BRANCH     -- 帳號所屬中心
         , LEA.INVOICE_NO            -- 發票號碼
         , LEA.LOAN_NO               -- 放款帳號
         , LEA.PAYMT_TYPE            -- 還款種類
         , LEA.DW_SOURCE             -- 扣款來源
         , LEA.FROM_ACCT_NO          -- 轉出帳號
         , LEA.TEL_NO                -- 電話
         , LEA.HOST_SNO              -- 主機交易序號
         , LEA.REMARK                -- 備註 
         , LEA.FEE_CODE              -- 費用代碼 
         , LEA.REF_NO                -- REF_NO
         , LEA.ACCOUNTING_SERIAL_NO  -- 列帳序號 
         , CL.CUST_ID                -- 銀行歸戶統編
      FROM EDLS.TB_LOAN_EACH_ACCOUNTING LEA
     RIGHT JOIN (SELECT CUSTOMER_LOAN_SEQ_NO 
                       , CUST_ID 
                    FROM EDLS.TB_CUSTOMER_LOAN 
                   WHERE CUST_ID = i_cust_id) CL 
        ON CL.CUSTOMER_LOAN_SEQ_NO = LEA.CUSTOMER_LOAN_SEQ_NO
     WHERE (i_acc_category IS NULL OR LEA.ACC_CATEGORY = i_acc_category)
       AND (I_CCY IS NULL OR CCY in (SELECT *  FROM table(I_CCY_LIST)))
       AND (i_acc_branch IS NULL OR LEA.ACC_BRANCH = i_acc_branch)
       AND (i_fee_code IS NULL OR LEA.FEE_CODE = i_fee_code)
       AND (i_start_date IS NULL OR LEA.ACCOUNTING_DATE >= i_start_date)
       AND (i_end_date IS NULL OR LEA.ACCOUNTING_DATE <= i_end_date)
       AND (LEA.ACCOUNTING_AMT > LEA.SETTLEMENT_AMT AND ACCOUNTING_AMT > 0);
  END SP_GET_EACH_ACC_ACCOUNT_DATA;
  
--**************************************************************************
-- 1402 SP_GET_CIF_ACC_TXN_DTL
-- Purpose: 查詢授信戶列銷帳交易明細
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.20  created
-- 1.1 康晉維     2019.12.13  modifed
--**************************************************************************
  PROCEDURE  SP_GET_CIF_ACC_TXN_DTL
  ( i_customer_loan_seq_no  IN NUMBER         -- 授信戶主檔序號
  , i_acc_branch            IN VARCHAR2       -- 設帳分行
  , i_fee_code              IN VARCHAR2       -- 費用代碼
  , i_ccy                   IN VARCHAR2       -- 幣別
  , i_type                  IN VARCHAR2       -- 種類
  , i_enquiryStartDate      IN VARCHAR2       -- 查詢起日
  , i_enquiryEndDate        IN VARCHAR2       -- 查詢訖日
  , o_cur                   OUT SYS_REFCURSOR -- o_cur
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT TXN_DATE
         , CCY
         , TXN_AMT
         , EVAL_NO
         , MEMO
         , ACC_BRANCH
         , EVAL_COMPANY_CODE
         , CASE 
           WHEN (LCS.DC_CODE = 'D' AND LCS.EC_MK = 'X') OR (LCS.DC_CODE = 'D' AND LCS.EC_MK = 'N')
           THEN '1'
           WHEN (LCS.DC_CODE = 'C' AND LCS.EC_MK = 'X') OR (LCS.DC_CODE = 'C' AND LCS.EC_MK = 'N')
           THEN '2'
           WHEN LCS.EC_MK = 'Y'
           THEN '3'
           END ACTION_TYPE
      FROM EDLS.TB_LOAN_CIF_SETTLEMENT LCS
     WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
       AND (I_ACC_BRANCH IS NULL OR ACC_BRANCH = i_acc_branch)
       AND CCY = i_ccy
       AND (TYPE IS NULL OR TYPE = i_type)
       AND FEE_CODE = i_fee_code
       AND ((i_enquiryStartDate IS NULL AND i_enquiryEndDate IS NULL )
            OR (TXN_DATE BETWEEN i_enquiryStartDate AND i_enquiryEndDate))
    ORDER BY CIF_SETTLEMENT_SEQ_NO asc;
  END SP_GET_CIF_ACC_TXN_DTL;  

--**************************************************************************
-- 1410 SP_GET_CIF_SET_BY_CUST_ID
-- Purpose: 依照銀行歸戶統編、交易日期、主機交易序號、沖正交易註記查詢授信戶列銷帳主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.20  created
--
--**************************************************************************
  PROCEDURE SP_GET_CIF_SET_BY_CUST_ID
  ( i_cust_id   IN VARCHAR2       -- 銀行歸戶統編
  , i_txn_date  IN VARCHAR2       -- 交易日期
  , i_host_sno  IN VARCHAR2       -- 主機交易序號
  , i_ec_mk     IN VARCHAR2       -- 沖正交易註記
  , o_cur       OUT SYS_REFCURSOR -- o_cur
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LCS.CIF_SETTLEMENT_SEQ_NO
         , LCS.CUSTOMER_LOAN_SEQ_NO
         , LCS.TXN_DATE
         , LCS.TXN_DATE_SNO
         , LCS.TXN_TIME
         , LCS.TXN_BRANCH
         , LCS.TXN_ID
         , LCS.TXN_TYPE
         , LCS.TXN_MEMO
         , LCS.SUP_EMP_ID
         , LCS.TELLER_EMP_ID
         , LCS.SUP_CARD
         , LCS.DC_CODE
         , LCS.ACC_BRANCH
         , LCS.ACC_CATEGORY
         , LCS.FEE_CODE
         , LCS.CCY
         , LCS.TXN_AMT
         , LCS.EC_MK
         , LCS.HOST_SNO
         , LCS.MEMO
         , LCS.APPR_DOC_NO
         , LCS.TYPE
         , LCS.LOAN_NO
         , LCS.EVAL_COMPANY_CODE
         , LCS.EVAL_NO
         , LCS.ACTION_CODE
         , LCS.EXEC_TELLER_ID
         , LCS.DRAFT_PAY_BANK
         , LCS.DRAFT_NO
         , LCS.COLLECTOR_ACC
         , LCS.RTN_CHECK_MK
         , LCS.INFO_ASSET_NO
         , LCS.FAHGU_ID
         , LCS.ACTION_TYPE
         , LCS.DRAFT_MK
      FROM EDLS.TB_LOAN_CIF_SETTLEMENT LCS
      JOIN EDLS.TB_CUSTOMER_LOAN CL 
        ON LCS.CUSTOMER_LOAN_SEQ_NO = CL.CUSTOMER_LOAN_SEQ_NO 
       AND (i_cust_id is null or CL.CUST_ID = i_cust_id) 
     WHERE (i_txn_date IS NULL OR LCS.TXN_DATE = i_txn_date)
       AND (i_host_sno IS NULL OR LCS.HOST_SNO = i_host_sno)
       AND (i_ec_mk    IS NULL OR LCS.EC_MK    = i_ec_mk)
       FOR UPDATE;
  END SP_GET_CIF_SET_BY_CUST_ID;   

--**************************************************************************
-- 1413 SP_GET_LOAN_CIF_ACC_TOTAL_AMT
-- Purpose: 取得授信戶列銷帳主檔資料依照不同幣別加總
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.20  created
--
--**************************************************************************
  PROCEDURE SP_GET_LOAN_CIF_ACC_TOTAL_AMT
  ( i_customer_loan_seq_no  IN NUMBER         -- 授信戶主檔序號
  , i_acc_branch            IN VARCHAR2       -- 設帳分行
  , i_ccy                   IN VARCHAR2       -- 幣別
  , i_type                  IN VARCHAR2       -- 種類
  , i_fee_code              IN VARCHAR2       -- 費用代碼
  , o_cur                   OUT SYS_REFCURSOR -- o_cur
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LCA.ACC_BRANCH    -- 設帳分行
         , LCA.CCY           -- 幣別
         , SUM(LCA.AMT) AMT  -- 待整理授信餘額
      FROM EDLS.TB_LOAN_CIF_ACCOUNTING LCA 
     WHERE LCA.CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
       AND (i_acc_branch IS NULL OR LCA.ACC_BRANCH = i_acc_branch)
       AND LCA.CCY                  = i_ccy
       AND LCA.TYPE                 = i_type
       AND LCA.FEE_CODE             = i_fee_code
     GROUP BY LCA.ACC_BRANCH,LCA.CCY;
  END SP_GET_LOAN_CIF_ACC_TOTAL_AMT;   

--**************************************************************************
-- 1414 SP_GET_LOAN_CIF_SET_TXN_DTL
-- Purpose: 授信戶列銷帳交易明細查詢
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.20  created
-- 1.1 葉庭宇     2019.12.11  modified
--
--**************************************************************************
  PROCEDURE SP_GET_LOAN_CIF_SET_TXN_DTL
  ( i_customer_loan_seq_no  IN NUMBER         -- 授信戶主檔序號
  , i_acc_branch            IN VARCHAR2       -- 設帳分行
  , i_fee_code              IN VARCHAR2       -- 費用代碼
  , i_ccy                   IN VARCHAR2       -- 幣別
  , i_type                  IN VARCHAR2       -- 種類
  , i_start_date            IN VARCHAR2       -- 查詢起日
  , i_end_date              IN VARCHAR2       -- 查詢訖日
  , o_cur                   OUT SYS_REFCURSOR -- o_cur
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT CIF_SETTLEMENT_SEQ_NO
         , CUSTOMER_LOAN_SEQ_NO
         , TXN_DATE
         , TXN_DATE_SNO
         , TXN_TIME
         , TXN_BRANCH
         , TXN_ID
         , TXN_TYPE
         , TXN_MEMO
         , SUP_EMP_ID
         , TELLER_EMP_ID
         , SUP_CARD
         , DC_CODE
         , ACC_BRANCH
         , ACC_CATEGORY
         , FEE_CODE
         , CCY
         , TXN_AMT
         , EC_MK
         , HOST_SNO
         , MEMO
         , APPR_DOC_NO
         , TYPE
         , LOAN_NO
         , EVAL_COMPANY_CODE
         , EVAL_NO
         , ACTION_CODE
         , EXEC_TELLER_ID
         , DRAFT_PAY_BANK
         , DRAFT_NO
         , COLLECTOR_ACC
         , RTN_CHECK_MK
         , INFO_ASSET_NO
         , FAHGU_ID
         , ACTION_TYPE -- 執行類別
         , DRAFT_MK    -- 票據註記
      FROM EDLS.TB_LOAN_CIF_SETTLEMENT
     WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
       AND (i_acc_branch           IS NULL OR ACC_BRANCH           = i_acc_branch)
       AND (i_ccy                  IS NULL OR CCY                  = i_ccy)
       AND ((i_type <> '99' AND (i_type IS NULL OR TYPE = i_type)) OR (i_type = '99' AND (TYPE IS NULL OR TYPE = i_type)))
       AND (i_fee_code             IS NULL OR FEE_CODE             = i_fee_code)
       AND (i_start_date           IS NULL OR TXN_DATE            >= i_start_date )
       AND (i_end_date             IS NULL OR TXN_DATE            <= i_end_date)
     ORDER BY to_number(TXN_DATE),to_number(TXN_TIME);
  END SP_GET_LOAN_CIF_SET_TXN_DTL;

--**************************************************************************
-- 1418 SP_UPD_LOAN_CIF_SETTLEMENT
-- Purpose: 更新授信戶銷帳交易明細。
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.19  created
--
--**************************************************************************
  PROCEDURE SP_UPD_LOAN_CIF_SETTLEMENT 
  ( i_cif_settlement_seq_no  IN NUMBER     -- 授信戶列銷帳交易明細序號
  , i_customer_loan_seq_no   IN NUMBER     -- 授信戶主檔序號
  , i_txn_date               IN NUMBER     -- 交易日期
  , i_txn_date_sno           IN VARCHAR2   -- 交易日期序號
  , i_txn_time               IN VARCHAR2   -- 交易時間
  , i_txn_branch             IN VARCHAR2   -- 交易分行
  , i_txn_id                 IN VARCHAR2   -- 交易代碼
  , i_txn_type               IN VARCHAR2   -- 交易分類
  , i_txn_memo               IN VARCHAR2   -- 交易摘要               
  , i_sup_emp_id             IN VARCHAR2   -- 授權主管員編
  , i_teller_emp_id          IN VARCHAR2   -- 執行櫃員員編
  , i_sup_card               IN VARCHAR2   -- 授權主管卡號
  , i_dc_code                IN VARCHAR2   -- 借貸別
  , i_acc_branch             IN VARCHAR2   -- 設帳分行
  , i_acc_category           IN VARCHAR2   -- 設帳科目
  , i_fee_code               IN VARCHAR2   -- 費用代碼
  , i_ccy                    IN VARCHAR2   -- 幣別
  , i_txn_amt                IN NUMBER     -- 交易金額
  , i_ec_mk                  IN VARCHAR2   -- 是否為沖正交易
  , i_host_sno               IN VARCHAR2   -- 主機交易序號
  , i_memo                   IN VARCHAR2   -- 全形摘要
  , i_appr_doc_no            IN VARCHAR2   -- 批覆書編號
  , i_type                   IN VARCHAR2   -- 種類
  , i_loan_no                IN VARCHAR2   -- 放款帳號
  , i_eval_company_code      IN VARCHAR2   -- 鑑估機構
  , i_eval_no                IN VARCHAR2   -- 鑑估編號
  , i_action_code            IN VARCHAR2   -- 執行動作
  , i_exec_tell              IN VARCHAR2   -- 執行櫃員代碼
  , i_draft_pay_bank         IN VARCHAR2   -- 票據付款行
  , i_draft_no               IN VARCHAR2   -- 票據號碼
  , i_coll_cr_acc_no         IN VARCHAR2   -- 託收存入帳號
  , i_boun_cheq_mk           IN VARCHAR2   -- 退票註記
  , i_info_asset_no          IN VARCHAR2   -- 資訊資產代號 
  , i_fahgu_id               IN VARCHAR2   -- 全域流水號
  , o_row_count              OUT NUMBER    -- o_row_count
  ) AS
  BEGIN
    UPDATE EDLS.TB_LOAN_CIF_SETTLEMENT
      SET CUSTOMER_LOAN_SEQ_NO   = i_customer_loan_seq_no
        , TXN_DATE   = i_txn_date
        , TXN_DATE_SNO =   i_txn_date_sno
        , TXN_TIME = i_txn_time
        , TXN_BRANCH = i_txn_branch
        , TXN_ID = i_txn_id
        , TXN_TYPE   = i_txn_type
        , TXN_MEMO   = i_txn_memo
        , SUP_EMP_ID =   i_sup_emp_id
        , TELLER_EMP_ID   = i_teller_emp_id
        , SUP_CARD =    i_sup_card
        , DC_CODE   = i_dc_code
        , ACC_BRANCH =   i_acc_branch
        , ACC_CATEGORY =   i_acc_category
        , FEE_CODE   = i_fee_code
        , CCY = i_ccy
        , TXN_AMT = i_txn_amt
        , EC_MK = i_ec_mk
        , HOST_SNO =   i_host_sno
        , MEMO   = i_memo
        , APPR_DOC_NO = i_appr_doc_no
        , TYPE   = i_type
        , LOAN_NO = i_loan_no
        , EVAL_COMPANY_CODE   = i_eval_company_code
        , EVAL_NO = i_eval_no
        , ACTION_CODE = i_action_code
        , EXEC_TELLER_ID = i_exec_tell
        , AMEND_DATE = Systimestamp
        , DRAFT_PAY_BANK = i_draft_pay_bank
        , DRAFT_NO =   i_draft_no
        , COLLECTOR_ACC =   i_coll_cr_acc_no
        , RTN_CHECK_MK =   i_boun_cheq_mk
        , INFO_ASSET_NO   = i_info_asset_no
        , FAHGU_ID = i_fahgu_id
    WHERE CIF_SETTLEMENT_SEQ_NO = i_cif_settlement_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_LOAN_CIF_SETTLEMENT;

--**************************************************************************
-- 1594 SP_GET_CIF_SETTEMENT_ON_CUSTOMER
-- Purpose: 訴訟代墊款歸戶查詢。
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.03.12  created
--
--**************************************************************************
  PROCEDURE SP_GET_CIF_SETTEMENT_ON_CUST
  ( i_customer_loan_seq_no   IN NUMBER          -- 授信戶主檔序號
  , i_acc_branch             IN VARCHAR2        -- 設帳分行
  , i_ccy                    IN VARCHAR2        -- 幣別
  , i_type                   IN VARCHAR2        -- 種類
  , i_fee_code               IN VARCHAR2        -- 費用代碼
  , o_cur                    OUT SYS_REFCURSOR  -- o_cur
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT SUM(DECODE(LOAN_CIF_ACCOUNTING.TYPE,'1',AMT,0)) NORMAL_LAW_AOMOUNT
         , SUM(DECODE(LOAN_CIF_ACCOUNTING.TYPE,'2',AMT,0)) ADV_LAW_AMOUNT
         , SUM(DECODE(LOAN_CIF_ACCOUNTING.TYPE,'3',AMT,0)) CASH_CARD_LAW_AMOUNT
         , SUM(DECODE(LOAN_CIF_ACCOUNTING.TYPE,'1',AMT,0)) +  SUM(DECODE(LOAN_CIF_ACCOUNTING.TYPE,'2',AMT,0)) + SUM(DECODE(LOAN_CIF_ACCOUNTING.TYPE,'3',AMT,0)) TOTAL_AMOUNT
         , CUSTOMER.OVERDUE_SPECIAL_MK
         , CUSTOMER.CUSTOMER_LOAN_SEQ_NO
      FROM (SELECT ACC_BRANCH
                 , CCY
                 , TYPE
                 , AMT
                 , CUSTOMER_LOAN_SEQ_NO
              FROM EDLS.TB_LOAN_CIF_ACCOUNTING
             WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
               AND (i_acc_branch is null or ACC_BRANCH = i_acc_branch  )
               AND (CCY        = i_ccy)
               AND (i_type       is null or TYPE       = i_type        )
               AND (FEE_CODE   = i_fee_code)
             GROUP BY ACC_BRANCH, CCY, TYPE, AMT, CUSTOMER_LOAN_SEQ_NO 
            )LOAN_CIF_ACCOUNTING 
     JOIN EDLS.TB_CUSTOMER_LOAN CUSTOMER
       ON CUSTOMER.CUSTOMER_LOAN_SEQ_NO = LOAN_CIF_ACCOUNTING.CUSTOMER_LOAN_SEQ_NO
    GROUP by CUSTOMER.OVERDUE_SPECIAL_MK, CUSTOMER.CUSTOMER_LOAN_SEQ_NO;  
  END SP_GET_CIF_SETTEMENT_ON_CUST;

--**************************************************************************
-- 1674 SP_GET_EACH_ACC_BY_STATUS
-- Purpose: 列帳主檔資料查詢
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.03.21  created
-- 1.1 康晉維     2019.10.29  modified
-- 1.2 康晉維     2019.12.16  modified
-- 1.3 康晉維     2020.02.20  modified
-- 1.4 林萬哲     2021.05.10  modified
--**************************************************************************
  PROCEDURE SP_GET_EACH_ACC_BY_STATUS
  ( i_customer_loan_seq_no  IN NUMBER          -- 授信戶主檔序號
  , i_txn_branch            IN VARCHAR2        -- 設帳分行
  , i_ccy                   IN VARCHAR2        -- 幣別
  , i_fee_code              IN VARCHAR2        -- 費用代碼
  , i_status                IN VARCHAR2        -- 狀態
  , i_start_date            IN VARCHAR2        -- 查詢起日
  , i_end_date              IN VARCHAR2        -- 查詢訖日
  , o_cur                   OUT SYS_REFCURSOR  -- o_cur
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT ACCOUNTING_DATE
         , ACCOUNTING_NO
         , LOAN_NO
         , PAYMT_TYPE
         , CCY
         , ACCOUNTING_AMT
         , SETTLEMENT_AMT
         , TXN_BRANCH
         , ACC_BRANCH
         , DECODE((ACCOUNTING_AMT - SETTLEMENT_AMT), 0 , '2','1') STATUS
         , TEL_NO
         , REMARK
      FROM EDLS.TB_LOAN_EACH_ACCOUNTING
     WHERE (i_customer_loan_seq_no IS NULL OR CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no)
       AND CCY = i_ccy
       AND FEE_CODE = i_fee_code
       AND (ACC_BRANCH = i_txn_branch OR i_txn_branch IS NULL)
       AND ((i_status = '0' AND ACCOUNTING_AMT > SETTLEMENT_AMT) OR i_status = '1')
       AND ((i_start_date IS NULL AND i_end_date IS NULL ) 
             OR (i_start_date IS NOT NULL AND i_end_date IS NOT NULL AND ACCOUNTING_DATE BETWEEN i_start_date AND i_end_date)
             OR (i_end_date   IS NULL AND to_number(i_start_date) <= to_number(ACCOUNTING_DATE))
             OR (i_start_date IS NULL AND to_number(ACCOUNTING_DATE) <= to_number(i_end_date))
           )
       ORDER BY ACCOUNTING_DATE ASC ,SUBSTR(ACCOUNTING_NO, 3, LENGTH(ACCOUNTING_NO)) ASC;
  END SP_GET_EACH_ACC_BY_STATUS;
   
--**************************************************************************
-- SP_SUM_LOAN_CIF_ACCOUNTING
-- Purpose: 以條件查詢授信戶列銷帳主檔金額加總
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 謝宇倫     2019.05.15  created
--
--**************************************************************************
  PROCEDURE SP_SUM_LOAN_CIF_ACCOUNTING
  ( i_cif_accounting_seq_no IN NUMBER   -- 授信戶列帳主檔序號
  , i_customer_loan_seq_no  IN NUMBER   -- 授信戶主檔序號
  , i_acc_branch            IN VARCHAR2 -- 設帳分行
  , i_acc_category          IN VARCHAR2 -- 設帳科目
  , i_ccy                   IN VARCHAR2 -- 幣別 
  , i_type                  IN VARCHAR2 -- 種類
  , i_fee_code              IN VARCHAR2 -- 費用代碼
  , i_amt                   IN NUMBER   -- 金額
  , o_amt                   OUT NUMBER  -- 金額(out)
  ) AS 
  BEGIN
    IF (i_cif_accounting_seq_no IS NOT NULL) THEN
      SELECT SUM(AMT) into o_amt
          FROM EDLS.TB_LOAN_CIF_ACCOUNTING
        WHERE CIF_ACCOUNTING_SEQ_NO = i_cif_accounting_seq_no
          AND (i_customer_loan_seq_no is null or CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no)
          AND (i_acc_branch is null or ACC_BRANCH = i_acc_branch)
          AND (i_ccy is null or CCY = i_ccy)
          AND (i_type is null or TYPE = i_type)
          AND (i_acc_category is null or ACC_CATEGORY = i_acc_category)
          AND (i_fee_code is null or FEE_CODE = i_fee_code)
          AND (i_amt is null or AMT = i_amt);
    ELSIF (i_customer_loan_seq_no IS NOT NULL) THEN
      SELECT SUM(AMT) into o_amt
          FROM EDLS.TB_LOAN_CIF_ACCOUNTING
        WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
          AND (i_acc_branch is null or ACC_BRANCH = i_acc_branch)
          AND (i_ccy is null or CCY = i_ccy)
          AND (i_type is null or TYPE = i_type)
          AND (i_acc_category is null or ACC_CATEGORY = i_acc_category)
          AND (i_fee_code is null or FEE_CODE = i_fee_code)
          AND (i_amt is null or AMT = i_amt);
    END IF;
  END SP_SUM_LOAN_CIF_ACCOUNTING;

--**************************************************************************
-- SP_GET_MAX_CIFSETTLEMENT_DATE_NO
-- Purpose: 取得當日授信戶列銷帳交易明細.交易日期序號最大者
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0  康晉維     2019.05.31  created
--
--**************************************************************************
  PROCEDURE SP_GET_MAX_CIFSETTLEMENT_DATE_NO
  (  i_customer_loan_seq_no  IN NUMBER   -- 授信戶主檔序號
   , i_txn_date              IN VARCHAR2 -- 交易日期
   , o_cur                   OUT NUMBER  -- o_cur
  ) AS
  BEGIN
    SELECT MAX(TXN_DATE_SNO) into o_cur 
      FROM EDLS.TB_LOAN_CIF_SETTLEMENT 
     WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
       AND TXN_DATE  = i_txn_date;
  END SP_GET_MAX_CIFSETTLEMENT_DATE_NO;
  
--**************************************************************************
-- 1410 SP_GET_EACH_ACC_BY_ACCNO
-- Purpose: 以列帳主檔建值查詢列帳主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 葉庭宇    2019.07.29  created
-- 1.1 林萬哲    2021.06.23  deprecated
--**************************************************************************
  PROCEDURE SP_GET_EACH_ACC_BY_ACCNO
  ( i_accounting_no   IN VARCHAR2       -- 列帳主檔鍵值
  , o_cur       OUT SYS_REFCURSOR       -- o_cur
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LOAN_ACCOUNTING_SEQ_NO  --列帳主檔序號
         , ACCOUNTING_NO           --列帳主檔鍵值
         , CUSTOMER_LOAN_SEQ_NO    --授信戶主檔序號
         , ACC_BRANCH              --設帳分行
         , ACC_CATEGORY            --設帳科目
         , CCY                     --幣別
         , TXN_BRANCH              --交易分行
         , ACCOUNTING_DATE         --列帳日期
         , ACCOUNTING_AMT          --列帳金額
         , SETTLEMENT_AMT          --銷帳金額
         , CUST_CENTER_BRANCH      --顧客所屬企金中心
         , ACC_CENTER_BRANCH       --帳號所屬中心
         , INVOICE_NO              --發票號碼
         , LOAN_NO                 --放款帳號
         , PAYMT_TYPE              --還款種類
         , DW_SOURCE               --扣款來源
         , FROM_ACCT_NO            --轉出帳號
         , TEL_NO                  --電話
         , HOST_SNO                --主機交易序號
         , REMARK                  --備註
         , FEE_CODE                --費用代碼
         , REF_NO                  --Reference No
         , ACCOUNTING_SERIAL_NO    --列帳序號
      FROM EDLS.TB_LOAN_EACH_ACCOUNTING
     WHERE ACCOUNTING_NO = i_accounting_no;
  END SP_GET_EACH_ACC_BY_ACCNO;   

--**************************************************************************
-- 1410 SP_GET_EACH_ACC_BY_ACCNO
-- Purpose: 以列帳主檔建值、設帳分行查詢列帳主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 謝宇倫    2020.09.02  created
-- 1.1 林萬哲    2021.06.23  deprecated
--**************************************************************************
  PROCEDURE SP_GET_EACH_ACC_BY_ACCNO
  ( i_accounting_no   IN VARCHAR2       -- 列帳主檔鍵值
  , i_acc_branch	  IN VARCHAR2   	-- 設帳分行
  , o_cur       OUT SYS_REFCURSOR       -- o_cur
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LOAN_ACCOUNTING_SEQ_NO  --列帳主檔序號
         , ACCOUNTING_NO           --列帳主檔鍵值
         , CUSTOMER_LOAN_SEQ_NO    --授信戶主檔序號
         , ACC_BRANCH              --設帳分行
         , ACC_CATEGORY            --設帳科目
         , CCY                     --幣別
         , TXN_BRANCH              --交易分行
         , ACCOUNTING_DATE         --列帳日期
         , ACCOUNTING_AMT          --列帳金額
         , SETTLEMENT_AMT          --銷帳金額
         , CUST_CENTER_BRANCH      --顧客所屬企金中心
         , ACC_CENTER_BRANCH       --帳號所屬中心
         , INVOICE_NO              --發票號碼
         , LOAN_NO                 --放款帳號
         , PAYMT_TYPE              --還款種類
         , DW_SOURCE               --扣款來源
         , FROM_ACCT_NO            --轉出帳號
         , TEL_NO                  --電話
         , HOST_SNO                --主機交易序號
         , REMARK                  --備註
         , FEE_CODE                --費用代碼
         , REF_NO                  --Reference No
         , ACCOUNTING_SERIAL_NO    --列帳序號
      FROM EDLS.TB_LOAN_EACH_ACCOUNTING
     WHERE ACCOUNTING_NO = i_accounting_no
	   AND ACC_BRANCH = i_acc_branch;
  END SP_GET_EACH_ACC_BY_ACCNO;   
  
--**************************************************************************
-- 1410 SP_GET_EACH_ACC_BY_ACCNO
-- Purpose: 以列帳主檔建值、設帳分行查詢列帳主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 林萬哲    2021.06.23  created
--**************************************************************************
  PROCEDURE SP_GET_EACH_ACC_BY_ACCNO
  (  i_customer_loan_seq_no IN VARCHAR2         -- 授信戶主檔序號
   , i_accounting_no        IN VARCHAR2         -- 列帳主檔鍵值
   , i_acc_branch	        IN VARCHAR2         -- 設帳分行
   , o_cur                  OUT SYS_REFCURSOR   -- o_cur
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LOAN_ACCOUNTING_SEQ_NO  --列帳主檔序號
         , ACCOUNTING_NO           --列帳主檔鍵值
         , CUSTOMER_LOAN_SEQ_NO    --授信戶主檔序號
         , ACC_BRANCH              --設帳分行
         , ACC_CATEGORY            --設帳科目
         , CCY                     --幣別
         , TXN_BRANCH              --交易分行
         , ACCOUNTING_DATE         --列帳日期
         , ACCOUNTING_AMT          --列帳金額
         , SETTLEMENT_AMT          --銷帳金額
         , CUST_CENTER_BRANCH      --顧客所屬企金中心
         , ACC_CENTER_BRANCH       --帳號所屬中心
         , INVOICE_NO              --發票號碼
         , LOAN_NO                 --放款帳號
         , PAYMT_TYPE              --還款種類
         , DW_SOURCE               --扣款來源
         , FROM_ACCT_NO            --轉出帳號
         , TEL_NO                  --電話
         , HOST_SNO                --主機交易序號
         , REMARK                  --備註
         , FEE_CODE                --費用代碼
         , REF_NO                  --Reference No
         , ACCOUNTING_SERIAL_NO    --列帳序號
      FROM EDLS.TB_LOAN_EACH_ACCOUNTING
     WHERE (i_customer_loan_seq_no IS NULL OR CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no )
	   AND ACCOUNTING_NO = i_accounting_no
	   AND (i_acc_branch IS NULL OR ACC_BRANCH = i_acc_branch);
  END SP_GET_EACH_ACC_BY_ACCNO;   
  
--**************************************************************************
-- SP_GET_LOAN_EACH_ACC_BY_CLSEQ
-- Purpose: 查詢列帳主檔透過授信戶主檔序號
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0  康晉維    2019.09.24  created
--
--**************************************************************************
  PROCEDURE SP_GET_LOAN_EACH_ACC_BY_CLSEQ
  (  i_customer_loan_seq_no   IN VARCHAR2         -- 授信戶主檔序號
   , o_cur                   OUT SYS_REFCURSOR    -- o_cur
  )AS
  BEGIN
    OPEN o_cur FOR
    SELECT LOAN_ACCOUNTING_SEQ_NO  --列帳主檔序號
         , ACCOUNTING_NO           --列帳主檔鍵值
         , CUSTOMER_LOAN_SEQ_NO    --授信戶主檔序號
         , ACC_BRANCH              --設帳分行
         , ACC_CATEGORY            --設帳科目
         , CCY                     --幣別
         , TXN_BRANCH              --交易分行
         , ACCOUNTING_DATE         --列帳日期
         , ACCOUNTING_AMT          --列帳金額
         , SETTLEMENT_AMT          --銷帳金額
         , CUST_CENTER_BRANCH      --顧客所屬企金中心
         , ACC_CENTER_BRANCH       --帳號所屬中心
         , INVOICE_NO              --發票號碼
         , LOAN_NO                 --放款帳號
         , PAYMT_TYPE              --還款種類
         , DW_SOURCE               --扣款來源
         , FROM_ACCT_NO            --轉出帳號
         , TEL_NO                  --電話
         , HOST_SNO                --主機交易序號
         , REMARK                  --備註
         , FEE_CODE                --費用代碼
         , REF_NO                  --Reference No
         , ACCOUNTING_SERIAL_NO    --列帳序號
      FROM EDLS.TB_LOAN_EACH_ACCOUNTING
     WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
  END SP_GET_LOAN_EACH_ACC_BY_CLSEQ;

--**************************************************************************
-- 936 SP_GET_Q63_SET_LOAN_EACH_ACC
-- Purpose: 
--          依照Q63銷帳作業核心服務取得對應放款列帳資料
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 葉庭宇    2020.05.18  created
--************************************************************************** 
  PROCEDURE SP_GET_Q63_SET_LOAN_EACH_ACC
  ( i_accounting_no        IN VARCHAR2         -- 列帳主檔鍵值
  , i_customer_loan_seq_no IN NUMBER           -- 授信戶主檔序號
  , i_acc_branch           IN VARCHAR2         -- 設帳分行
  , i_acc_category         IN VARCHAR2         -- 設帳科目
  , i_ccy                  IN VARCHAR2         -- 幣別
  , i_fee_code             IN VARCHAR2         -- 費用代碼
  , i_loan_no              IN VARCHAR2         -- 放款帳號
  , i_acc_amt              IN NUMBER           -- 列帳金額
  , o_cur                  OUT SYS_REFCURSOR   -- O_SEQ_NO
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LOAN_ACCOUNTING_SEQ_NO -- 列帳主檔序號
         , ACCOUNTING_NO          -- 列帳主檔鍵值
         , CUSTOMER_LOAN_SEQ_NO   -- 授信戶主檔序號
         , ACC_BRANCH             -- 設帳分行
         , ACC_CATEGORY           -- 設帳科目
         , CCY                    -- 幣別
         , TXN_BRANCH             -- 交易分行
         , ACCOUNTING_DATE        -- 列帳日期
         , ACCOUNTING_AMT         -- 列帳金額
         , SETTLEMENT_AMT         -- 銷帳金額
         , CUST_CENTER_BRANCH     -- 顧客所屬企金中心
         , ACC_CENTER_BRANCH      -- 帳號所屬中心
         , INVOICE_NO             -- 發票號碼
         , LOAN_NO                -- 放款帳號
         , PAYMT_TYPE             -- 還款種類
         , DW_SOURCE              -- 扣款來源
         , FROM_ACCT_NO           -- 轉出帳號
         , TEL_NO                 -- 電話
         , HOST_SNO               -- 主機交易序號
         , REMARK                 -- 備註
         , FEE_CODE               -- 費用代碼
         , REF_NO                 -- REF_NO
         , ACCOUNTING_SERIAL_NO   -- 列帳序號        
      FROM EDLS.TB_LOAN_EACH_ACCOUNTING 
     WHERE (ACCOUNTING_NO         LIKE i_accounting_no || '%') -- 列帳主檔鍵值 
       AND CUSTOMER_LOAN_SEQ_NO  = i_customer_loan_seq_no    -- 授信戶主檔序號
       AND ACC_CATEGORY          = i_acc_category            -- 設帳科目
       AND CCY                   = i_ccy                     -- 幣別
       AND FEE_CODE              = i_fee_code                -- 費用代碼
       AND (ACC_BRANCH            = i_acc_branch OR i_acc_branch IS NULL)             -- 設帳分行
       AND LOAN_NO               = i_loan_no                 -- 放款帳號
       AND ACCOUNTING_AMT        = i_acc_amt;                -- 列帳金額
  END SP_GET_Q63_SET_LOAN_EACH_ACC; 

END PG_LOAN_ACCOUNTING_SETTLEMENT;