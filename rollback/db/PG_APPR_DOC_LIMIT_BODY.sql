CREATE OR REPLACE PACKAGE BODY "EDLS"."PG_APPR_DOC_LIMIT" AS

--**************************************************************************
-- SP_UPD_APPR_DOC
-- Purpose: 更新批覆書主檔 
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.17  performance adjust
--**************************************************************************
  PROCEDURE SP_UPD_APPR_DOC 
  ( i_appr_doc_seq_no IN NUMBER                -- 批覆書主檔序號
  , i_customer_loan_seq_no IN NUMBER           -- 授信戶主檔序號
  , i_appr_doc_no IN VARCHAR2                  -- 批覆書編號
  , i_phase IN VARCHAR2                        -- 批覆書狀態
  , i_apprd_date IN VARCHAR2                   -- 批覆書核準日
  , i_matu_date IN VARCHAR2                    -- 批覆書到期日
  , i_first_drawdown_edate IN VARCHAR2         -- 第一次動用截止日
  , i_total_appr_amt IN NUMBER                 -- 總額度
  , i_total_appr_ccy IN VARCHAR2               -- 總額度幣別
  , i_channel_code IN VARCHAR2                 -- 通路
  , i_appr_drawdown_type IN VARCHAR2           -- 本批覆書動用方式
  , i_loan_purpose IN VARCHAR2                 -- 借款用途
  , i_loan_attributes IN VARCHAR2              -- 授信性質
  , i_ccl_mk IN VARCHAR2                       -- 綜合額度註記
  , i_source_code IN VARCHAR2                  -- 案件來源
  , i_data_convert_source IN VARCHAR2          -- 資料轉換來源
  , i_acc_branch IN VARCHAR2                   -- 記帳單位
  , i_oper_branch IN VARCHAR2                  -- 作業單位
  , i_under_center  IN VARCHAR2                -- 批覆書所屬中心
  , i_approver_id IN VARCHAR2                  -- 核貸者統編
  , i_apprd_type IN VARCHAR2                   -- 核貸權限別
  , i_effec_period IN NUMBER                   -- 批覆書有效期間
  , i_effec_unit IN VARCHAR2                   -- 批覆書有效期間單位
  , i_contract_sdate IN VARCHAR2               -- 契約起始日
  , i_contract_period IN NUMBER                -- 契約有效期間
  , i_contract_unit IN VARCHAR2                -- 契約有效期間單位
  , i_from_appr_doc_no IN VARCHAR2             -- 來源批覆書
  , i_to_appr_doc_no IN VARCHAR2               -- 目的批覆書
  , i_last_txn_date IN VARCHAR2                -- 上次交易日
  , i_inter_media_branch IN VARCHAR2           -- 轉介單位
  , i_report_branch IN VARCHAR2                -- 報表單位
  , i_profit_branch IN VARCHAR2                -- 利潤單位
  , i_first_drawdown_date IN VARCHAR2          -- 首次動撥日
  , i_auth_date IN VARCHAR2                    -- 批覆書放行日
  , i_appr_doc_edate IN VARCHAR2               -- 批覆書結束日
  , i_mpl_mort_overdue_cancel_mk IN VARCHAR2   -- 月繳月省房貸因逾期取消功能註記
  , i_appr_doc_source IN VARCHAR2              -- 批覆書來源
  , i_system_id IN VARCHAR2                    -- 鍵檔平台
  , i_modifiable IN VARCHAR2                   -- 可執行變更交易
  , i_cross_border_shared_limit_mk IN VARCHAR2 -- 跨境共用額度註記
  , o_row_count OUT NUMBER                     -- 回傳更新筆數 
  ) AS
  BEGIN 
    UPDATE EDLS.TB_APPR_DOC SET 
    APPR_DOC_SEQ_NO = i_appr_doc_seq_no, 
    CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no, 
    APPR_DOC_NO = i_appr_doc_no, 
    PHASE = i_phase, 
    APPRD_DATE = i_apprd_date, 
    MATU_DATE = i_matu_date, 
    FIRST_DRAWDOWN_EDATE = i_first_drawdown_edate, 
    TOTAL_APPR_AMT = i_total_appr_amt, 
    TOTAL_APPR_CCY = i_total_appr_ccy, 
    CHANNEL_CODE = i_channel_code, 
    APPR_DRAWDOWN_TYPE = i_appr_drawdown_type, 
    LOAN_PURPOSE = i_loan_purpose, 
    LOAN_ATTRIBUTES = i_loan_attributes, 
    CCL_MK = i_ccl_mk, 
    SOURCE_CODE = i_source_code, 
    DATA_CONVERT_SOURCE = i_data_convert_source, 
    ACC_BRANCH = i_acc_branch, 
    OPER_BRANCH = i_oper_branch, 
    UNDER_CENTER = i_under_center, 
    APPROVER_ID = i_approver_id, 
    APPRD_TYPE = i_apprd_type, 
    EFFEC_PERIOD = i_effec_period, 
    EFFEC_UNIT = i_effec_unit, 
    CONTRACT_SDATE = i_contract_sdate, 
    CONTRACT_PERIOD = i_contract_period, 
    CONTRACT_UNIT = i_contract_unit, 
    FROM_APPR_DOC_NO = i_from_appr_doc_no, 
    TO_APPR_DOC_NO = i_to_appr_doc_no, 
    LAST_TXN_DATE = i_last_txn_date, 
    INTER_MEDIA_BRANCH = i_inter_media_branch, 
    REPORT_BRANCH = i_report_branch, 
    PROFIT_BRANCH = i_profit_branch, 
    FIRST_DRAWDOWN_DATE = i_first_drawdown_date, 
    AUTH_DATE = i_auth_date, 
    APPR_DOC_EDATE = i_appr_doc_edate, 
    MPL_MORT_OVERDUE_CANCEL_MK = i_mpl_mort_overdue_cancel_mk, 
    APPR_DOC_SOURCE = i_appr_doc_source, 
    SYSTEM_ID = i_system_id, 
    MODIFIABLE = i_modifiable, 
    CROSS_BORDER_SHARED_LIMIT_MK = i_cross_border_shared_limit_mk, 
    AMEND_DATE = SYSTIMESTAMP
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_APPR_DOC;

 --**************************************************************************
-- SP_GET_APPR_DOC_LIST
-- Purpose: 查詢批覆書主檔列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.17  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_APPR_DOC_LIST
  ( i_cust_id      IN VARCHAR2       -- 銀行歸戶統編
  , i_appr_doc_no  IN VARCHAR2       -- 批覆書編號
  , i_phase_marker IN VARCHAR2       -- 批覆書狀態註記
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料 
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT ad.APPR_DOC_SEQ_NO
      , ad.CUSTOMER_LOAN_SEQ_NO
      , ad.APPR_DOC_NO
      , ad.PHASE
      , ad.APPRD_DATE
      , ad.MATU_DATE
      , ad.FIRST_DRAWDOWN_EDATE
      , ad.TOTAL_APPR_AMT
      , ad.TOTAL_APPR_CCY
      , ad.CHANNEL_CODE
      , ad.APPR_DRAWDOWN_TYPE
      , ad.LOAN_PURPOSE
      , ad.LOAN_ATTRIBUTES
      , ad.CCL_MK
      , ad.SOURCE_CODE
      , ad.DATA_CONVERT_SOURCE
      , ad.ACC_BRANCH
      , ad.OPER_BRANCH
      , ad.UNDER_CENTER
      , ad.APPROVER_ID
      , ad.APPRD_TYPE
      , ad.EFFEC_PERIOD
      , ad.EFFEC_UNIT
      , ad.CONTRACT_SDATE
      , ad.CONTRACT_PERIOD
      , ad.CONTRACT_UNIT
      , ad.FROM_APPR_DOC_NO
      , ad.TO_APPR_DOC_NO
      , ad.LAST_TXN_DATE
      , ad.INTER_MEDIA_BRANCH
      , ad.REPORT_BRANCH
      , ad.PROFIT_BRANCH
      , ad.FIRST_DRAWDOWN_DATE
      , ad.AUTH_DATE
      , ad.APPR_DOC_EDATE
      , ad.MPL_MORT_OVERDUE_CANCEL_MK
      , ad.APPR_DOC_SOURCE
      , ad.SYSTEM_ID
      , ad.MODIFIABLE
      , ad.CROSS_BORDER_SHARED_LIMIT_MK
      , ad.CREATE_DATE
      , ad.AMEND_DATE
   FROM EDLS.TB_CUSTOMER_LOAN cl
   INNER JOIN EDLS.TB_APPR_DOC ad
     ON ad.CUSTOMER_LOAN_SEQ_NO = cl.CUSTOMER_LOAN_SEQ_NO
   WHERE cl.CUST_ID = i_cust_id
   AND (i_appr_doc_no IS NULL OR ad.APPR_DOC_NO = i_appr_doc_no)
   AND (i_phase_marker IS NULL OR i_phase_marker = '0' OR
     (i_phase_marker = '1' AND ad.phase IN('0', 'N')) OR
     (i_phase_marker = 'A' AND ad.phase = '1') OR
     (i_phase_marker = 'B' AND ad.phase IN('0', 'N', '1', '2')) OR
     (i_phase_marker = 'C' AND ad.phase IN('0', 'N', '1')) OR 
     (i_phase_marker = 'D' AND ad.phase IN('0', 'X', 'N', '1')) OR
     (i_phase_marker = 'E' AND ad.phase IN('0', '1', '2')) OR
     (i_phase_marker = 'F' AND ad.phase IN('0', '1')) OR
     (i_phase_marker = 'G' AND ad.phase IN('0', 'X', 'N')) OR
     (i_phase_marker = 'H' AND ad.phase IN('0', '1')) OR
     (i_phase_marker = 'X' AND ad.phase = 'X'));
  END SP_GET_APPR_DOC_LIST;

--**************************************************************************
-- SP_GET_APPR_DOC_LIST_U
-- Purpose: 查詢批覆書主檔列表(有鎖)
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 ESB20276  2019.11.01  created
--**************************************************************************
  PROCEDURE SP_GET_APPR_DOC_LIST_U
  ( i_cust_id      IN VARCHAR2       -- 銀行歸戶統編
  , i_appr_doc_no  IN VARCHAR2       -- 批覆書編號
  , i_phase_marker IN VARCHAR2       -- 批覆書狀態註記
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料 
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT ad.APPR_DOC_SEQ_NO
      , ad.CUSTOMER_LOAN_SEQ_NO
      , ad.APPR_DOC_NO
      , ad.PHASE
      , ad.APPRD_DATE
      , ad.MATU_DATE
      , ad.FIRST_DRAWDOWN_EDATE
      , ad.TOTAL_APPR_AMT
      , ad.TOTAL_APPR_CCY
      , ad.CHANNEL_CODE
      , ad.APPR_DRAWDOWN_TYPE
      , ad.LOAN_PURPOSE
      , ad.LOAN_ATTRIBUTES
      , ad.CCL_MK
      , ad.SOURCE_CODE
      , ad.DATA_CONVERT_SOURCE
      , ad.ACC_BRANCH
      , ad.OPER_BRANCH
      , ad.UNDER_CENTER
      , ad.APPROVER_ID
      , ad.APPRD_TYPE
      , ad.EFFEC_PERIOD
      , ad.EFFEC_UNIT
      , ad.CONTRACT_SDATE
      , ad.CONTRACT_PERIOD
      , ad.CONTRACT_UNIT
      , ad.FROM_APPR_DOC_NO
      , ad.TO_APPR_DOC_NO
      , ad.LAST_TXN_DATE
      , ad.INTER_MEDIA_BRANCH
      , ad.REPORT_BRANCH
      , ad.PROFIT_BRANCH
      , ad.FIRST_DRAWDOWN_DATE
      , ad.AUTH_DATE
      , ad.APPR_DOC_EDATE
      , ad.MPL_MORT_OVERDUE_CANCEL_MK
      , ad.APPR_DOC_SOURCE
      , ad.SYSTEM_ID
      , ad.MODIFIABLE
      , ad.CROSS_BORDER_SHARED_LIMIT_MK
      , ad.CREATE_DATE
      , ad.AMEND_DATE
   FROM EDLS.TB_CUSTOMER_LOAN cl
   INNER JOIN EDLS.TB_APPR_DOC ad
     ON ad.CUSTOMER_LOAN_SEQ_NO = cl.CUSTOMER_LOAN_SEQ_NO
   WHERE cl.CUST_ID = i_cust_id
   AND (i_appr_doc_no IS NULL OR ad.APPR_DOC_NO = i_appr_doc_no)
   AND (i_phase_marker IS NULL OR i_phase_marker = '0' OR
     (i_phase_marker = '1' AND ad.phase IN('0', 'N')) OR
     (i_phase_marker = 'A' AND ad.phase = '1') OR
     (i_phase_marker = 'B' AND ad.phase IN('0', 'N', '1', '2')) OR
     (i_phase_marker = 'C' AND ad.phase IN('0', 'N', '1')) OR 
     (i_phase_marker = 'D' AND ad.phase IN('0', 'X', 'N', '1')) OR
     (i_phase_marker = 'E' AND ad.phase IN('0', '1', '2')) OR
     (i_phase_marker = 'F' AND ad.phase IN('0', '1')) OR
     (i_phase_marker = 'G' AND ad.phase IN('0', 'X', 'N')) OR
     (i_phase_marker = 'H' AND ad.phase IN('0', '1')) OR
     (i_phase_marker = 'X' AND ad.phase = 'X'))
	FOR UPDATE;
  END SP_GET_APPR_DOC_LIST_U;
  
--**************************************************************************
-- SP_GET_LIMIT_LIST_NU
-- Purpose: 查詢分項額度主檔與分項批示條件設定檔資訊(無鎖)
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 ESB20276  2019.11.05  create
--**************************************************************************  
  PROCEDURE SP_GET_LIMIT_LIST_NU
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , i_limit_type      IN VARCHAR2       -- 額度種類
  , i_serial_no       IN VARCHAR2       -- 序號
  , i_ccy_type        IN VARCHAR2       -- 幣別種類
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT lt.LIMIT_SEQ_NO
      , lt.APPR_DOC_SEQ_NO
      , lt.LIMIT_TYPE
      , lt.SERIAL_NO
      , lt.BUSINESS_TYPE
      , lt.BUSINESS_CODE
      , lt.PERIOD_TYPE
      , lt.IS_GUARANTEED
      , lt.CCY_TYPE
      , lt.RIGHT_MK
      , lt.IS_FORWARD
      , lt.CURRENCY
      , lt.APPRD_SUB_LIMIT_AMT
      , lt.LIMIT_DRAWDOWN_TYPE
      , lt.PHASE
      , lp.LIMIT_PROFILE_SEQ_NO
      , lp.BASE_RATE_TYPE
      , lp.SPREAD_RATE
      , lp.INTEREST_RATE
      , lp.FEE_RATE
      , lp.JCIC_LOAN_BIZ_CODE
      , lp.INTEREST_RATE_TYPE
      , lp.INTEREST_SCHEDULE_TYPE
      , lp.APPRD_DRAWDOWN_UNIT
      , lp.APPRD_DRAWDOWN_PERIOD
      , lp.PURPOSE_CODE
      , lp.LOAN_SUBCATEGORY
      , lp.CREDIT_LOAN_PROD_CODE
      , lp.REPAYMT_SOURCE
      , lp.PRNP_GRACE_PERIOD
      , lp.ALLOW_DRAWDOWN_MK
      , lp.COLLATERAL_TYPE
      , lp.APPR_INTST_RATE
      , lp.DEPOSIT_PLEDGE_MK
      , lp.PD_VALUE
      , lp.LGD_VALUE
      , lp.FIRST_DRAWDOWN_DATE
      , lp.OVERDRAFT_EXT_MK
      , lp.CREDIT_GUARA_FEE_RATE
      , lp.PAYMT_TYPE
      , lp.CONSIGN_PAYMT_ACC
      , lp.INTST_UPPER_RATE
      , lp.INTST_LOWER_RATE
      , lp.GUARA_CALC_TYPE
      , lp.TRANS_ACCEPT_FEE_RATE
      , lp.SERVICE_FEE_DATA
    FROM EDLS.TB_LIMIT lt 
    INNER JOIN EDLS.TB_LIMIT_PROFILE lp
      ON lt.LIMIT_SEQ_NO = lp.LIMIT_SEQ_NO
    WHERE (APPR_DOC_SEQ_NO = i_appr_doc_seq_no)
    AND (i_limit_type IS NULL OR i_limit_type = '00' OR i_limit_type = LIMIT_TYPE)
    AND (i_serial_no IS NULL OR i_serial_no = SERIAL_NO)
    AND (i_ccy_type IS NULL OR i_ccy_type = CCY_TYPE);
  END SP_GET_LIMIT_LIST_NU;

--**************************************************************************
-- SP_GET_LIMIT_LIST
-- Purpose: 查詢分項額度主檔與分項批示條件設定檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.17  performance adjust
--**************************************************************************  
  PROCEDURE SP_GET_LIMIT_LIST
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , i_limit_type      IN VARCHAR2       -- 額度種類
  , i_serial_no       IN VARCHAR2       -- 序號
  , i_ccy_type        IN VARCHAR2       -- 幣別種類
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT lt.LIMIT_SEQ_NO
      , lt.APPR_DOC_SEQ_NO
      , lt.LIMIT_TYPE
      , lt.SERIAL_NO
      , lt.BUSINESS_TYPE
      , lt.BUSINESS_CODE
      , lt.PERIOD_TYPE
      , lt.IS_GUARANTEED
      , lt.CCY_TYPE
      , lt.RIGHT_MK
      , lt.IS_FORWARD
      , lt.CURRENCY
      , lt.APPRD_SUB_LIMIT_AMT
      , lt.LIMIT_DRAWDOWN_TYPE
      , lt.PHASE
      , lp.LIMIT_PROFILE_SEQ_NO
      , lp.BASE_RATE_TYPE
      , lp.SPREAD_RATE
      , lp.INTEREST_RATE
      , lp.FEE_RATE
      , lp.JCIC_LOAN_BIZ_CODE
      , lp.INTEREST_RATE_TYPE
      , lp.INTEREST_SCHEDULE_TYPE
      , lp.APPRD_DRAWDOWN_UNIT
      , lp.APPRD_DRAWDOWN_PERIOD
      , lp.PURPOSE_CODE
      , lp.LOAN_SUBCATEGORY
      , lp.CREDIT_LOAN_PROD_CODE
      , lp.REPAYMT_SOURCE
      , lp.PRNP_GRACE_PERIOD
      , lp.ALLOW_DRAWDOWN_MK
      , lp.COLLATERAL_TYPE
      , lp.APPR_INTST_RATE
      , lp.DEPOSIT_PLEDGE_MK
      , lp.PD_VALUE
      , lp.LGD_VALUE
      , lp.FIRST_DRAWDOWN_DATE
      , lp.OVERDRAFT_EXT_MK
      , lp.CREDIT_GUARA_FEE_RATE
      , lp.PAYMT_TYPE
      , lp.CONSIGN_PAYMT_ACC
      , lp.INTST_UPPER_RATE
      , lp.INTST_LOWER_RATE
      , lp.GUARA_CALC_TYPE
      , lp.TRANS_ACCEPT_FEE_RATE
      , lp.SERVICE_FEE_DATA
    FROM EDLS.TB_LIMIT lt 
    INNER JOIN EDLS.TB_LIMIT_PROFILE lp
      ON lt.LIMIT_SEQ_NO = lp.LIMIT_SEQ_NO
    WHERE (APPR_DOC_SEQ_NO = i_appr_doc_seq_no)
    AND (i_limit_type IS NULL OR i_limit_type = '00' OR i_limit_type = LIMIT_TYPE)
    AND (i_serial_no IS NULL OR i_serial_no = SERIAL_NO)
    AND (i_ccy_type IS NULL OR i_ccy_type = CCY_TYPE)
    FOR UPDATE;
  END SP_GET_LIMIT_LIST;

--**************************************************************************
-- SP_GET_LIMIT_PROJ_COND_PROF
-- Purpose: 查詢分項額度下的所有專案屬性註記
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.17  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_PROJ_COND_PROF
  ( i_limit_seq_no IN VARCHAR2       -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT pcp.PROJ_CONDI_PROF_SEQ_NO
      , pcp.LIMIT_PROFILE_SEQ_NO
      , pcp.PROJECT_CODE, pcp.create_date, pcp.amend_date
    FROM EDLS.TB_LIMIT_PROFILE lb 
    INNER JOIN EDLS.TB_LIMIT_PROJ_COND_PROF pcp
      ON lb.LIMIT_PROFILE_SEQ_NO = pcp.LIMIT_PROFILE_SEQ_NO
    WHERE lb.LIMIT_SEQ_NO = i_limit_seq_no;
   END SP_GET_LIMIT_PROJ_COND_PROF;

--**************************************************************************
-- SP_GET_LIMIT_BOOKING_LIST
-- Purpose: 查詢分項額度下所有預佔額度資訊列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BOOKING_LIST
  ( i_limit_seq_no        IN NUMBER         -- 分項額度主檔序號
  , i_serial_no           IN VARCHAR2       -- 預佔序號
  , i_book_amount_marker  IN VARCHAR2       -- 預佔額度註記
  , i_proj_condition_list IN VARCHAR2       -- 專案屬性註記
  , i_business_type_list  IN VARCHAR2       -- 業務類別
  , o_cur                 OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
   SELECT DISTINCT lb.LIMIT_BOOKING_SEQ_NO
      ,lb.LIMIT_SEQ_NO
      ,lb.CCY
      ,lb.SERIAL_NO
      ,lb.LAST_TXN_DATE
      ,lb.TOTAL_DRAWDOWN_AMT
      ,lb.TOTAL_TODAY_REPAYMT_AMT
      ,lb.DRAWDOWN_BRANCH
      ,lb.TOTAL_DRAWDOWN_APPR_DOC_AMT
      ,lb.INTST_SDATE
      ,lb.MATU_DATE
      ,lb.IS_BOOK
      ,lb.TELLER_EMP_ID
      ,lb.SUP_EMP_ID
      ,lb.HOST_SNO
      ,lb.TXN_TIME
    FROM EDLS.TB_LIMIT lt 
    INNER JOIN EDLS.TB_LIMIT_PROFILE lp
      ON lt.LIMIT_SEQ_NO = lp.LIMIT_SEQ_NO
    INNER JOIN EDLS.TB_LIMIT_BOOKING lb 
      ON lp.LIMIT_SEQ_NO = lb.LIMIT_SEQ_NO
	LEFT JOIN EDLS.TB_LIMIT_PROJ_COND_PROF lpcp
      ON lp.LIMIT_PROFILE_SEQ_NO=lpcp.LIMIT_PROFILE_SEQ_NO
    WHERE lb.LIMIT_SEQ_NO = i_limit_seq_no
    AND (i_serial_no IS NULL OR i_serial_no = lb.SERIAL_NO)
    AND (i_proj_condition_list IS NULL OR lpcp.PROJECT_CODE IN(SELECT COLUMN_VALUE FROM TABLE(fn_split_string(i_proj_condition_list, ','))))
    AND (i_business_type_list IS NULL OR lt.BUSINESS_TYPE IN(SELECT COLUMN_VALUE FROM TABLE(fn_split_string(i_business_type_list, ','))))
    AND (i_book_amount_marker IS NULL OR (i_book_amount_marker = 1 AND lb.TOTAL_DRAWDOWN_AMT > 0));
  END SP_GET_LIMIT_BOOKING_LIST;

--**************************************************************************
-- SP_GET_LIMIT_BOOK_LIST_BY_LT
-- Purpose: 查詢分項額度下所有預佔額度資訊列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 謝宇倫     2019.09.10  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
PROCEDURE SP_GET_LIMIT_BOOK_LIST_BY_LT
  ( i_limit_seq_no        IN NUMBER         -- 分項額度主檔序號
  , o_cur                 OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LIMIT_BOOKING_SEQ_NO
         , LIMIT_SEQ_NO
         , CCY
         , SERIAL_NO
         , LAST_TXN_DATE
         , TOTAL_DRAWDOWN_AMT
         , TOTAL_TODAY_REPAYMT_AMT
         , DRAWDOWN_BRANCH
         , TOTAL_DRAWDOWN_APPR_DOC_AMT
         , INTST_SDATE
         , MATU_DATE
         , IS_BOOK
         , TELLER_EMP_ID
         , SUP_EMP_ID
         , HOST_SNO
         , TXN_TIME
    FROM EDLS.TB_LIMIT_BOOKING
    WHERE LIMIT_SEQ_NO = i_limit_seq_no;
END SP_GET_LIMIT_BOOK_LIST_BY_LT;

--**************************************************************************
-- SP_INS_LIMIT_BOOKING
-- Purpose: 新增預佔額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_LIMIT_BOOKING
  ( i_limit_seq_no                IN NUMBER   -- 分項額度主檔序號
  , i_ccy                         IN VARCHAR2 -- 幣別
  , i_serial_no                   IN VARCHAR2 -- 預佔序號
  , i_last_txn_date               IN VARCHAR2 -- 上次交易日
  , i_total_drawdown_amt          IN NUMBER   -- 預佔累積動用金額
  , i_total_today_repaymt_amt     IN NUMBER   -- 當日累積還款金額
  , i_drawdown_branch             IN VARCHAR2 -- 動用分行
  , i_total_drawdown_appr_doc_amt IN NUMBER   -- 預佔佔用批覆書額度累積金額
  , i_intst_sdate                 IN VARCHAR2 -- 放款起息日
  , i_matu_date                   IN VARCHAR2 -- 放款到期日
  , i_is_book                     IN VARCHAR2 -- 預佔註記
  , i_teller_emp_id               IN VARCHAR2 -- 經辦員編
  , i_sup_emp_id                  IN VARCHAR2 -- 主管員編
  , i_host_sno                    IN VARCHAR2 -- 主機交易序號
  , i_txn_time                    IN VARCHAR2 -- 交易時間
  , o_limit_booking_seq_no        OUT NUMBER  -- 預佔額度檔序號
  ) AS 
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LIMIT_BOOKING', o_limit_booking_seq_no);
    INSERT INTO EDLS.TB_LIMIT_BOOKING(
      LIMIT_BOOKING_SEQ_NO,
      LIMIT_SEQ_NO,
      CCY,
      SERIAL_NO,
      LAST_TXN_DATE,
      TOTAL_DRAWDOWN_AMT,
      TOTAL_TODAY_REPAYMT_AMT,
      DRAWDOWN_BRANCH,
      TOTAL_DRAWDOWN_APPR_DOC_AMT,
      INTST_SDATE,
      MATU_DATE,
      IS_BOOK,
      TELLER_EMP_ID,
      SUP_EMP_ID,
      HOST_SNO,
      TXN_TIME,
      CREATE_DATE,
      AMEND_DATE)
    values(o_limit_booking_seq_no, 
      i_limit_seq_no,
      i_ccy,
      i_serial_no,
      i_last_txn_date,
      i_total_drawdown_amt,
      i_total_today_repaymt_amt,
      i_drawdown_branch,
      i_total_drawdown_appr_doc_amt,
      i_intst_sdate,
      i_matu_date,
      i_is_book,
      i_teller_emp_id,
      i_sup_emp_id,
      i_host_sno,
      i_txn_time,
      systimestamp, systimestamp);
  END SP_INS_LIMIT_BOOKING;

--**************************************************************************
-- SP_UPD_LIMIT_BOOKING
-- Purpose: 更新預佔額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_UPD_LIMIT_BOOKING
  ( i_limit_booking_seq_no             IN NUMBER    -- 預佔額度檔序號
  , i_limit_seq_no                     IN NUMBER    -- 分項額度主檔序號
  , i_ccy                              IN VARCHAR2  -- 幣別
  , i_serial_no                        IN VARCHAR2  -- 預佔序號
  , i_last_txn_date                    IN VARCHAR2  -- 上次交易日
  , i_total_drawdown_amt               IN NUMBER    -- 預佔累積動用金額
  , i_total_today_repaymt_amt          IN NUMBER    -- 當日累積還款金額
  , i_drawdown_branch                  IN VARCHAR2  -- 動用分行
  , i_total_drawdown_appr_doc_amt      IN NUMBER    -- 預佔佔用批覆書額度累積金額
  , i_intst_sdate                      IN VARCHAR2  -- 放款起息日
  , i_matu_date                        IN VARCHAR2  -- 放款到期日
  , i_is_book                          IN VARCHAR2  -- 預佔註記
  , i_teller_emp_id                    IN VARCHAR2  -- 經辦員編
  , i_sup_emp_id                       IN VARCHAR2  -- 主管員編
  , i_host_sno                         IN VARCHAR2  -- 主機交易序號
  , i_txn_time                         IN VARCHAR2  -- 交易時間
  , o_row_count                        OUT NUMBER    -- 回傳更新筆數
    ) AS
  BEGIN
    UPDATE EDLS.TB_LIMIT_BOOKING SET 
      LIMIT_SEQ_NO = i_limit_seq_no,
      CCY = i_ccy,
      SERIAL_NO = i_serial_no,
      LAST_TXN_DATE = i_last_txn_date,
      TOTAL_DRAWDOWN_AMT = i_total_drawdown_amt,
      TOTAL_TODAY_REPAYMT_AMT = i_total_today_repaymt_amt,
      DRAWDOWN_BRANCH = i_drawdown_branch,
      TOTAL_DRAWDOWN_APPR_DOC_AMT = i_total_drawdown_appr_doc_amt,
      INTST_SDATE = i_intst_sdate,
      MATU_DATE = i_matu_date,
      IS_BOOK = i_is_book,
      TELLER_EMP_ID = i_teller_emp_id,
      SUP_EMP_ID = i_sup_emp_id,
      HOST_SNO = i_host_sno,
      TXN_TIME = i_txn_time,
      AMEND_DATE = SYSTIMESTAMP
    WHERE LIMIT_BOOKING_SEQ_NO = i_limit_booking_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_LIMIT_BOOKING;

--**************************************************************************
-- SP_GET_LIMIT_BOOKING
-- Purpose: 查詢特定的預佔額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BOOKING
  ( i_cust_id     IN VARCHAR2       -- 銀行歸戶統編
  , i_appr_doc_no IN VARCHAR2       -- 批覆書編號
  , i_limit_type  IN VARCHAR2       -- 額度種類
  , i_currency    IN VARCHAR2       -- 幣別
  , i_serial_no   IN VARCHAR2       -- 序號
  , o_cur         OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT lb.LIMIT_BOOKING_SEQ_NO
    , lb.LIMIT_SEQ_NO
    , lb.CCY
    , lb.SERIAL_NO
    , lb.LAST_TXN_DATE
    , lb.TOTAL_DRAWDOWN_AMT
    , lb.TOTAL_TODAY_REPAYMT_AMT
    , lb.DRAWDOWN_BRANCH
    , lb.TOTAL_DRAWDOWN_APPR_DOC_AMT
    , lb.INTST_SDATE
    , lb.MATU_DATE
    , lb.IS_BOOK
    , lb.TELLER_EMP_ID
    , lb.SUP_EMP_ID
    , lb.HOST_SNO
    , lb.TXN_TIME
   FROM EDLS.TB_CUSTOMER_LOAN cl 
   INNER JOIN EDLS.TB_APPR_DOC ad
     ON cl.CUSTOMER_LOAN_SEQ_NO = ad.CUSTOMER_LOAN_SEQ_NO
   INNER JOIN EDLS.TB_LIMIT lt
     ON ad.APPR_DOC_SEQ_NO = lt.APPR_DOC_SEQ_NO
   INNER JOIN EDLS.TB_LIMIT_BOOKING lb
     ON lt.LIMIT_SEQ_NO = lb.LIMIT_SEQ_NO
   WHERE cl.CUST_ID = i_cust_id
   AND ad.APPR_DOC_NO = i_appr_doc_no
   AND lt.LIMIT_TYPE = i_limit_type
   AND lb.SERIAL_NO = i_serial_no
   AND lb.CCY = i_currency
   FOR UPDATE;
  END SP_GET_LIMIT_BOOKING;

--**************************************************************************
-- SP_DEL_LIMIT_BOOKING
-- Purpose: 刪除特定的預佔額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_BOOKING
  ( i_limit_booking_seq_no IN VARCHAR2 -- 預佔額度檔序號
  , o_row_count            OUT NUMBER  -- 回傳筆數
  ) AS
  BEGIN
    DELETE EDLS.TB_LIMIT_BOOKING lb
    WHERE lb.LIMIT_BOOKING_SEQ_NO = i_limit_booking_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_LIMIT_BOOKING;

--**************************************************************************
-- SP_GET_OVERDRAFT_LIST
-- Purpose: 查詢分項額度透支資訊檔列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_OVERDRAFT_LIST
  ( i_limit_seq_no      IN NUMBER         -- 分項額度主檔序號
  , i_ccy               IN VARCHAR2       -- 幣別
  , i_overdraft_account IN NUMBER         -- 帳號序號
  , i_acc_type          IN VARCHAR2       -- 帳號類別
  , o_cur               OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    IF i_limit_seq_no IS NOT NULL THEN
      OPEN o_cur FOR
      SELECT OVERDRAFT_SEQ_NO
           , LIMIT_SEQ_NO
           , ACC_NO
           , ACC_TYPE
           , CCY
           , OVERDRAFT_BALANCE_AMT
           , ACCOUNT_STATUS
        FROM EDLS.TB_OVERDRAFT
       WHERE LIMIT_SEQ_NO = i_limit_seq_no
	       AND (i_acc_type IS NULL OR ACC_TYPE = i_acc_type)
	       AND (i_overdraft_account IS NULL OR ACC_NO = i_overdraft_account)
         AND (i_ccy IS NULL OR CCY = i_ccy) 
       FOR UPDATE;
    ELSE
    OPEN o_cur FOR
      SELECT OVERDRAFT_SEQ_NO
           , LIMIT_SEQ_NO
           , ACC_NO
           , ACC_TYPE
           , CCY
           , OVERDRAFT_BALANCE_AMT
           , ACCOUNT_STATUS
        FROM EDLS.TB_OVERDRAFT
       WHERE (i_acc_type IS NULL OR ACC_TYPE = i_acc_type)
         AND (i_overdraft_account IS NULL OR ACC_NO = i_overdraft_account)
         AND (i_ccy IS NULL OR CCY = i_ccy) 
     FOR UPDATE;
    END IF;
  END SP_GET_OVERDRAFT_LIST;

--**************************************************************************
-- SP_UPD_OVERDRAFT
-- Purpose: 
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_UPD_OVERDRAFT
  ( i_overdraft_seq_no      IN NUMBER   -- 分項額度透支資訊檔序號
  , i_limit_seq_no          IN NUMBER   -- 分項額度主檔序號
  , i_acc_type              IN VARCHAR2 -- 帳號類別
  , i_acc_no                IN NUMBER   -- 帳號序號
  , i_ccy                   IN VARCHAR2 -- 幣別
  , i_overdraft_balance_amt IN NUMBER   -- 透支餘額
  , i_account_status        IN VARCHAR2 -- 帳號狀態
  , o_row_count             OUT NUMBER  -- 回傳更新筆數
  ) AS
  BEGIN
    UPDATE EDLS.TB_OVERDRAFT SET 
      LIMIT_SEQ_NO = i_limit_seq_no, 
      ACC_TYPE = i_acc_type, 
      ACC_NO = i_acc_no, 
      CCY = i_ccy, 
      OVERDRAFT_BALANCE_AMT = i_overdraft_balance_amt, 
      ACCOUNT_STATUS = i_account_status,
      AMEND_DATE = SYSTIMESTAMP
    WHERE OVERDRAFT_SEQ_NO = i_overdraft_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_OVERDRAFT;

--**************************************************************************
-- SP_UPD_LIMIT
-- Purpose: 
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_UPD_LIMIT
  ( i_limit_seq_no         IN NUMBER   -- 分項額度主檔序號
  , i_appr_doc_seq_no      IN NUMBER   -- 批覆書主檔序號
  , i_limit_type           IN VARCHAR2 -- 額度種類
  , i_serial_no            IN NUMBER   -- 序號
  , i_business_type        IN VARCHAR2 -- 業務類別
  , i_business_code        IN VARCHAR2 -- 業務代碼
  , i_period_type          IN VARCHAR2 -- 融資期間種類
  , i_is_guaranteed        IN VARCHAR2 -- 有無擔保註記
  , i_ccy_type             IN VARCHAR2 -- 幣別種類
  , i_right_mk             IN VARCHAR2 -- 追索權註記
  , i_is_forward           IN VARCHAR2 -- 即遠期註記
  , i_currency             IN VARCHAR2 -- 分項額度幣別
  , i_apprd_sub_limit_amt  IN NUMBER   -- 分項核准額度
  , i_limit_drawdown_type  IN VARCHAR2 -- 動用方式
  , i_phase                IN VARCHAR2 -- 分項額度狀態
  , o_row_count            OUT NUMBER  -- 回傳更新筆數
    ) AS
  BEGIN
    UPDATE EDLS.TB_LIMIT 
    SET APPR_DOC_SEQ_NO = i_appr_doc_seq_no, 
    LIMIT_TYPE = i_limit_type, 
    SERIAL_NO = i_serial_no, 
    BUSINESS_TYPE = i_business_type, 
    BUSINESS_CODE = i_business_code, 
    PERIOD_TYPE = i_period_type, 
    IS_GUARANTEED = i_is_guaranteed, 
    CCY_TYPE = i_ccy_type, 
    RIGHT_MK = i_right_mk, 
    IS_FORWARD = i_is_forward, 
    CURRENCY = i_currency, 
    APPRD_SUB_LIMIT_AMT = i_apprd_sub_limit_amt, 
    LIMIT_DRAWDOWN_TYPE = i_limit_drawdown_type, 
    PHASE = i_phase, 
    AMEND_DATE = systimestamp
    WHERE LIMIT_SEQ_NO = i_limit_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_LIMIT;

--**************************************************************************
-- SP_INS_LIMIT_DTL
-- Purpose: 新增分項額度彙計檔資訊 
--          刪除會計科目(ERD調整_20190327)
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_LIMIT_DTL
  ( i_limit_seq_no                IN NUMBER   -- 分項額度彙計檔序號
  , i_ccy                         IN VARCHAR2 -- 幣別
  , i_last_txn_date               IN VARCHAR2 -- 最後交易日
  , i_total_drawdown_amt          IN NUMBER   -- 累積動用金額
  , i_total_payment_amt           IN NUMBER   -- 累積還款金額
  , i_total_appr_doc_drawdown_amt IN NUMBER   -- 佔用批覆書累積額度
  , i_total_nego_amt              IN NUMBER   -- 累積和解總額 
  , i_forign_business_type        IN VARCHAR2 -- 外匯業務別 
  , o_limit_dtl_seq_no            OUT NUMBER  -- 分項額度彙計檔序號  
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LIMIT_DTL', o_limit_dtl_seq_no);
    INSERT INTO EDLS.TB_LIMIT_DTL
    ( LIMIT_DTL_SEQ_NO
    , LIMIT_SEQ_NO
    , CCY
    , LAST_TXN_DATE
    , TOTAL_DRAWDOWN_AMT
    , TOTAL_REPAYMT_AMT
    , TOTAL_APPR_DOC_DRAWDOWN_AMT
    , TOTAL_NEGO_AMT
    , FORIGN_BUSINESS_TYPE
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_limit_dtl_seq_no
    , i_limit_seq_no
    , i_ccy
    , i_last_txn_date
    , i_total_drawdown_amt
    , i_total_payment_amt
    , i_total_appr_doc_drawdown_amt
    , i_total_nego_amt
    , i_forign_business_type
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
  END SP_INS_LIMIT_DTL;

 --**************************************************************************
-- SP_INS_OVERDRAFT
-- Purpose: 
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_OVERDRAFT
  ( i_limit_seq_no           IN NUMBER    -- 分項額度主檔序號
  , i_acc_type               IN VARCHAR2  -- 帳號類別
  , i_acc_no                 IN NUMBER    -- 帳號序號
  , i_ccy                    IN VARCHAR2  -- 幣別
  , i_overdraft_balance_amt  IN NUMBER    -- 透支餘額
  , i_account_status         IN VARCHAR2  -- 帳號狀態
  , o_overdraft_seq_no       OUT NUMBER   -- 分項額度透支資訊檔序號  
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_OVERDRAFT', o_overdraft_seq_no);
    INSERT INTO EDLS.TB_OVERDRAFT
    ( OVERDRAFT_SEQ_NO
    , LIMIT_SEQ_NO
    , ACC_TYPE
    , ACC_NO
    , CCY
    , OVERDRAFT_BALANCE_AMT
    , ACCOUNT_STATUS
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_overdraft_seq_no
    , i_limit_seq_no
    , i_acc_type
    , i_acc_no
    , i_ccy
    , i_overdraft_balance_amt
    , i_account_status
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
  END SP_INS_OVERDRAFT;

--*************************************************************************
-- SP_GET_LIMIT_COMBINED_P
-- Purpose: 查詢組合額度主檔與組合額度資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.01.08  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_COMBINED_P
  ( i_appr_doc_seq_no IN NUMBER   -- 批覆書主檔序號
  , o_cur       OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT lt.LIMIT_TYPE          -- 額度種類
       , lc.LIMIT_COMBINED_SEQ_NO -- 組合額度主檔序號
       , lc.APPR_DOC_SEQ_NO       -- 批覆書主檔序號
       , lc.COMBINED_NO           -- 組合額度編號
       , lc.CCY                   -- 組合額度幣別
       , lc.APPRD_AMT             -- 組合額度核准金額
       , lcp.LIMIT_SEQ_NO         -- 分項額度主檔序號
    FROM EDLS.TB_LIMIT_COMBINED lc
    INNER JOIN EDLS.TB_LIMIT_COMBINED_PROFILE lcp
      ON lc.LIMIT_COMBINED_SEQ_NO = lcp.LIMIT_COMBINED_SEQ_NO
    INNER JOIN EDLS.TB_LIMIT lt
      ON lcp.LIMIT_SEQ_NO = lt.LIMIT_SEQ_NO
    WHERE lc.APPR_DOC_SEQ_NO = i_appr_doc_seq_no
    ORDER BY lc.COMBINED_NO ASC;
  END SP_GET_LIMIT_COMBINED_P;

--*************************************************************************
-- SP_INS_LIMIT_COMBINED
-- Purpose: 新增組合額度主檔資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.01.08   created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_LIMIT_COMBINED
  ( i_appr_doc_seq_no       IN NUMBER   -- 批覆書主檔序號
  , i_no                    IN VARCHAR2 -- 組合額度編號
  , i_ccy                   IN VARCHAR2 -- 組合額度幣別
  , i_amt                   IN NUMBER   -- 組合額度金額
  , o_limit_combined_seq_no OUT NUMBER  -- 組合額度主檔序號
  ) AS 
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LIMIT_COMBINED', o_limit_combined_seq_no);
    INSERT INTO EDLS.TB_LIMIT_COMBINED
    ( LIMIT_COMBINED_SEQ_NO
    , APPR_DOC_SEQ_NO
    , COMBINED_NO
    , CCY
    , APPRD_AMT
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES 
    ( o_limit_combined_seq_no
    , i_appr_doc_seq_no
    , i_no
    , i_ccy
    , i_amt
    , systimestamp
    , systimestamp
    );
  END SP_INS_LIMIT_COMBINED;

--*************************************************************************
-- SP_DEL_LIMIT_COMBINED
-- Purpose: 刪除組合額度主檔資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.01.08   created
-- 1.1 佑慈     2019.01.29   Modified 回傳異動筆數
-- 1.2 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_COMBINED
  ( i_limit_combined_seq_no IN NUMBER  -- 組合額度主檔序號
  , o_row_count             OUT NUMBER -- 回傳筆數
  ) AS
  BEGIN
    DELETE EDLS.TB_LIMIT_COMBINED
    WHERE LIMIT_COMBINED_SEQ_NO = i_limit_combined_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_LIMIT_COMBINED;

--*************************************************************************
-- SP_DEL_LIMIT_COMBINED_PROFILE
-- Purpose: 刪除組合額度設定檔資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.01.08   created
-- 1.1 劉佑慈   2019.01.29   Modified 回傳異動筆數
-- 1.2 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_COMBINED_PROFILE
  ( i_limit_combined_seq_no IN NUMBER  -- 組合額度主檔序號
  , o_row_count             OUT NUMBER -- 回傳筆數
  ) AS
  BEGIN
     DELETE EDLS.TB_LIMIT_COMBINED_PROFILE
     WHERE LIMIT_COMBINED_SEQ_NO = i_limit_combined_seq_no;
     o_row_count := SQL%ROWCOUNT;
  END SP_DEL_LIMIT_COMBINED_PROFILE;

--*************************************************************************
-- SP_INS_LIMIT_COMBINED_PROFILE
-- Purpose: 新增組合額度設定檔資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.01.08   created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_LIMIT_COMBINED_PROFILE
  ( i_limit_combined_seq_no  IN NUMBER   --組合額度主檔序號
  , i_limit_seq_no           IN NUMBER   --分項額度主檔序號
  , o_seq_no                 OUT NUMBER  --組合額度設定檔序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LIMIT_COMBINED_PROFILE', o_seq_no);

    INSERT INTO EDLS.TB_LIMIT_COMBINED_PROFILE
    ( LIMIT_COMBINED_PROFILE_SEQ_NO
    , LIMIT_COMBINED_SEQ_NO
    , LIMIT_SEQ_NO
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES 
    ( o_seq_no
    , i_limit_combined_seq_no
    , i_limit_seq_no
    , systimestamp
    , systimestamp
    );
  END SP_INS_LIMIT_COMBINED_PROFILE;

--*************************************************************************
-- SP_GET_LIMIT_COMBINED
-- Purpose: 查詢組合額度主檔資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.01.08  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_COMBINED
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LIMIT_COMBINED_SEQ_NO   -- 組合額度主檔序號
       , APPR_DOC_SEQ_NO           -- 批覆書主檔序號
       , COMBINED_NO               -- 組合額度編號
       , CCY                       -- 組合額度幣別
       , APPRD_AMT                 -- 組合額度核准金額
    FROM EDLS.TB_LIMIT_COMBINED
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no;
  END SP_GET_LIMIT_COMBINED;

--*************************************************************************
-- SP_GET_LIMIT_COMBINED_PROFILE
-- Purpose: 查詢組合額度設定檔資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.01.08  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_COMBINED_PROFILE
  ( i_limit_combined_seq_no IN NUMBER         -- 組合額度主檔序號
  , o_cur                   OUT SYS_REFCURSOR -- 回傳資訊
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LIMIT_COMBINED_PROFILE_SEQ_NO   -- 組合額度設定檔序號
       , LIMIT_COMBINED_SEQ_NO             -- 組合額度主檔序號
       , LIMIT_SEQ_NO                      -- 分項額度主檔序號
    FROM EDLS.TB_LIMIT_COMBINED_PROFILE
    WHERE LIMIT_COMBINED_SEQ_NO = i_limit_combined_seq_no;
  END SP_GET_LIMIT_COMBINED_PROFILE;

--*************************************************************************
-- SP_INS_APPR_DOC_HISTORY
-- Purpose: 新增批覆書變更紀錄
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.01.10  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_APPR_DOC_HISTORY
  ( i_appr_doc_seq_no         IN NUMBER   -- 批覆書主檔序號
  , i_txn_date                IN VARCHAR2 -- 交易日期
  , i_txn_branch              IN VARCHAR2 -- 交易分行
  , i_host_sno                IN VARCHAR2 -- 主機交易序號
  , i_txn_time                IN VARCHAR2 -- 交易時間
  , i_sup_card                IN VARCHAR2 -- 主管授權代號
  , i_info_asset_no           IN VARCHAR2 -- 資訊資產代號
  , i_teller_emp_id           IN VARCHAR2 -- 櫃員員編
  , i_sup_emp_id              IN VARCHAR2 -- 主管員編
  , i_txn_id                  IN VARCHAR2 -- 交易代號
  , i_txn_type                IN VARCHAR2 -- 交易分類
  , o_appr_doc_history_seq_no OUT NUMBER  -- 批覆書變更記錄主檔序號
  ) AS
  BEGIN
    EDLS.PG_SYS.sp_get_seq_no('TB_APPR_DOC_HISTORY', o_appr_doc_history_seq_no);
    INSERT INTO EDLS.TB_APPR_DOC_HISTORY
    ( APPR_DOC_HISTORY_SEQ_NO
    , APPR_DOC_SEQ_NO
    , TXN_DATE
    , TXN_BRANCH
    , HOST_SNO
    , TXN_TIME
    , SUP_CARD
    , INFO_ASSET_NO
    , TELLER_EMP_ID
    , SUP_EMP_ID
    , TXN_ID
    , TXN_TYPE
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_appr_doc_history_seq_no
    , i_appr_doc_seq_no
    , i_txn_date
    , i_txn_branch
    , i_host_sno
    , i_txn_time
    , i_sup_card
    , i_info_asset_no
    , i_teller_emp_id
    , i_sup_emp_id
    , i_txn_id
    , i_txn_type
    , systimestamp
    , systimestamp
    );
  END SP_INS_APPR_DOC_HISTORY;

--**************************************************************************
-- SP_GET_APPR_DOC_HISTORY
-- Purpose: 查詢批覆書變更紀錄
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************

  PROCEDURE SP_GET_APPR_DOC_HISTORY
  ( i_appr_doc_seq_no IN NUMBER             -- 批覆書主檔序號
  , i_transaction_type_operator IN VARCHAR2 -- 交易代號運算子
  , i_transaction_type IN VARCHAR2          -- 交易分類
  , i_modify_code_operator IN VARCHAR2      -- 變更代號運算子
  , i_modify_code IN VARCHAR2               -- 變更代號
  , i_offset IN NUMBER                      -- 偏移設定
  , i_page_size IN NUMBER                   -- 分頁大小
  , o_cur OUT SYS_REFCURSOR                 -- 回傳資料
  ) AS
  BEGIN
   OPEN o_cur FOR
   SELECT adh.APPR_DOC_HISTORY_SEQ_NO
    ,adh.APPR_DOC_SEQ_NO
    ,adh.TXN_DATE
    ,adh.TXN_BRANCH
    ,adh.HOST_SNO
    ,adh.TXN_TIME
    ,adh.SUP_CARD
    ,adh.TELLER_EMP_ID
    ,adh.SUP_EMP_ID
    ,adh.TXN_ID
    ,ADH.TXN_TYPE
    ,adhl.APPR_DOC_HISTORY_DTL_SEQ_NO
    ,adhl.MODIFY_MEMO
    ,adhl.MODIFY_OLD_DATA
    ,adhl.MODIFY_NEW_DATA
    ,adhl.MODIFY_CODE
    ,adhl.MODIFY_TABLE
    ,adhl.MODIFY_FIELD
    ,adhl.BEFORE_MODIFY_VALUE
    ,adhl.AFTER_MODIFY_VALUE
    ,adh.INFO_ASSET_NO
   FROM TB_APPR_DOC_HISTORY adh INNER JOIN TB_APPR_DOC_HISTORY_DTL adhl ON adh.APPR_DOC_HISTORY_SEQ_NO = adhl.APPR_DOC_HISTORY_SEQ_NO
   WHERE adh.APPR_DOC_SEQ_NO = i_appr_doc_seq_no 
   AND ( i_transaction_type_operator IS NULL 
     OR (i_transaction_type_operator = '0' AND adh.TXN_TYPE NOT IN(SELECT COLUMN_VALUE FROM TABLE(FN_SPLIT_STRING(i_transaction_type, ',')))) 
     OR (i_transaction_type_operator = '1' AND adh.TXN_TYPE IN(SELECT COLUMN_VALUE FROM TABLE(FN_SPLIT_STRING(i_transaction_type, ',')))))
   And (i_modify_code_operator IS NULL 
     OR (i_modify_code_operator = '0' AND adhl.MODIFY_CODE NOT IN(SELECT COLUMN_VALUE FROM TABLE(FN_SPLIT_STRING(i_modify_code, ',')))) 
     OR (i_modify_code_operator = '1' AND adhl.MODIFY_CODE IN(SELECT COLUMN_VALUE FROM TABLE(FN_SPLIT_STRING(i_modify_code, ',')))))
   ORDER BY adh.TXN_DATE, adh.TXN_TIME, adhl.MODIFY_CODE, adhl.APPR_DOC_HISTORY_DTL_SEQ_NO
   OFFSET i_offset ROWS FETCH NEXT i_page_size ROWS ONLY;
  END SP_GET_APPR_DOC_HISTORY;

--*************************************************************************
-- SP_INS_APPR_DOC_HISTORY_DTL
-- Purpose: 新增批覆書變更紀錄明細檔
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.01.10  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--************************************************************************** 
  PROCEDURE SP_INS_APPR_DOC_HISTORY_DTL
  ( i_appr_doc_history_seq_no     IN NUMBER   -- 批覆書變更紀錄檔序號
  , i_modify_memo                 IN VARCHAR2 -- 變更說明
  , i_modifiy_old_data            IN VARCHAR2 -- 變更前資料
  , i_modify_new_data             IN VARCHAR2 -- 變更後資料
  , i_modify_code                 IN VARCHAR2 -- 變更代號
  , i_modify_table                IN VARCHAR2 -- 變更資料表名稱
  , i_modify_field                IN VARCHAR2 -- 變更資料表欄位名稱
  , i_before_modify_value         IN VARCHAR2 -- 變更前欄位內容
  , i_after_modify_value          IN VARCHAR2 -- 變更後欄位內容
  , o_appr_doc_history_dtl_seq_no OUT NUMBER  -- 批覆書變更記錄明細檔序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_APPR_DOC_HISTORY_DTL', o_appr_doc_history_dtl_seq_no);  
    INSERT INTO EDLS.TB_APPR_DOC_HISTORY_DTL
    ( APPR_DOC_HISTORY_DTL_SEQ_NO
    , APPR_DOC_HISTORY_SEQ_NO
    , MODIFY_MEMO
    , MODIFY_OLD_DATA
    , MODIFY_NEW_DATA
    , MODIFY_TABLE
    , MODIFY_FIELD
    , BEFORE_MODIFY_VALUE
    , AFTER_MODIFY_VALUE
    , MODIFY_CODE
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_appr_doc_history_dtl_seq_no
    , i_appr_doc_history_seq_no
    , i_modify_memo
    , i_modifiy_old_data
    , i_modify_new_data
    , i_modify_table
    , i_modify_field
    , i_before_modify_value
    , i_after_modify_value
    , i_modify_code
    , systimestamp
    , systimestamp
    );
  END SP_INS_APPR_DOC_HISTORY_DTL;

--**************************************************************************
-- SP_GET_APPR_DOC_HISTORY_DTL
-- Purpose: 查詢批覆書變更紀錄明細檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************  
  PROCEDURE SP_GET_APPR_DOC_HISTORY_DTL
  ( i_appr_doc_history_seq_no IN NUMBER         -- 批覆書變更記錄主檔序號
  , i_modify_code_operator    IN VARCHAR2       -- 變更代號運算子
  , i_modify_code             IN VARCHAR2       -- 變更代號 
  , i_offset                  IN NUMBER         -- 偏移設定
  , i_page_size               IN NUMBER         -- 分頁大小
  , o_cur                     OUT SYS_REFCURSOR -- 回傳資料 
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT APPR_DOC_HISTORY_DTL_SEQ_NO
     , APPR_DOC_HISTORY_SEQ_NO
     , MODIFY_MEMO
     , MODIFY_OLD_DATA
     , MODIFY_NEW_DATA
     , MODIFY_TABLE
     , MODIFY_FIELD
     , BEFORE_MODIFY_VALUE
     , AFTER_MODIFY_VALUE
     , MODIFY_CODE
     , CREATE_DATE
     , AMEND_DATE
    FROM EDLS.TB_APPR_DOC_HISTORY_DTL
    WHERE APPR_DOC_HISTORY_SEQ_NO = i_appr_doc_history_seq_no 
    AND ( i_modify_code_operator IS NULL 
     OR ( i_modify_code_operator = 0 AND MODIFY_CODE NOT IN (SELECT COLUMN_VALUE FROM TABLE(FN_SPLIT_STRING(i_modify_code, ','))))
     OR ( i_modify_code_operator = 1 AND MODIFY_CODE IN (SELECT COLUMN_VALUE FROM TABLE(FN_SPLIT_STRING(i_modify_code, ','))))
        )
    OFFSET i_offset ROWS FETCH NEXT i_page_size ROWS ONLY;
  END SP_GET_APPR_DOC_HISTORY_DTL;

--*************************************************************************
-- SP_GET_LIMIT_SHARE_BY_CUST
-- Purpose: 透過銀行歸戶統編查詢共用額度資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.07.30  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_SHARE_BY_CUST
  ( i_customer_id         IN VARCHAR2        -- 銀行歸戶統編
  , i_appr_doc_no         IN VARCHAR2        -- 批覆書編號
  , o_cur                 OUT SYS_REFCURSOR  -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
	SELECT ad.APPR_DOC_NO
    , lt.LIMIT_TYPE
    , cl2.CUST_ID
    , ls.CUSTOMER_LOAN_SEQ_NO
    , ls.SERIAL_NO
    , ls.CCY
    , ls.APPRD_AMT
    , lsp.LIMIT_SHARE_PROFILE_SEQ_NO
    , lsp.LIMIT_SHARE_SEQ_NO
    , lsp.APPR_DOC_SEQ_NO
    , lsp.LIMIT_SEQ_NO
    FROM EDLS.TB_CUSTOMER_LOAN cl
    INNER JOIN EDLS.TB_APPR_DOC ad
      ON ad.CUSTOMER_LOAN_SEQ_NO = cl.CUSTOMER_LOAN_SEQ_NO
    INNER JOIN EDLS.TB_LIMIT_SHARE_PROFILE lsp
      ON lsp.APPR_DOC_SEQ_NO = ad.APPR_DOC_SEQ_NO
    INNER JOIN EDLS.TB_LIMIT_SHARE ls
      ON ls.LIMIT_SHARE_SEQ_NO = lsp.LIMIT_SHARE_SEQ_NO  
    INNER JOIN EDLS.TB_CUSTOMER_LOAN cl2
      ON ls.CUSTOMER_LOAN_SEQ_NO=cl2.CUSTOMER_LOAN_SEQ_NO
    LEFT JOIN EDLS.TB_LIMIT lt 
      ON lsp.LIMIT_SEQ_NO = lt.LIMIT_SEQ_NO
    WHERE i_customer_id = cl.CUST_ID
      AND (i_appr_doc_no is null OR i_appr_doc_no = ad.APPR_DOC_NO)
    FOR UPDATE;
  END SP_GET_LIMIT_SHARE_BY_CUST;

--*************************************************************************
-- SP_GET_LIMIT_SHARE
-- Purpose: 查詢共用額度主檔資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.01.25  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_SHARE
  ( i_customer_loan_seq_no IN NUMBER          -- 授信戶主檔序號
  , i_serial_no            IN VARCHAR2        -- 共用額度序號
  , o_cur                  OUT SYS_REFCURSOR  -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LIMIT_SHARE_SEQ_NO
       , CUSTOMER_LOAN_SEQ_NO
       , SERIAL_NO
       , CCY
       , APPRD_AMT     
    FROM EDLS.TB_LIMIT_SHARE
    WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
    AND(i_serial_no is null OR SERIAL_NO = i_serial_no)   
    FOR UPDATE;
  END SP_GET_LIMIT_SHARE;

--*************************************************************************
-- SP_INS_LIMIT_SHARE
-- Purpose: 新增共用額度主檔資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.01.25  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_LIMIT_SHARE
  ( i_customer_loan_seq_no  IN NUMBER   -- 授信戶主檔序號
  , i_serial_no             IN VARCHAR2 -- 共用額度序號
  , i_ccy                   IN VARCHAR2 -- 共用額度幣別
  , i_apprd_amt             IN NUMBER   -- 共用額度金額
  , o_limit_share_seq_no    OUT NUMBER  -- 共用額度主檔序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LIMIT_SHARE', o_limit_share_seq_no);  
    INSERT INTO EDLS.TB_LIMIT_SHARE
    ( LIMIT_SHARE_SEQ_NO
    , CUSTOMER_LOAN_SEQ_NO
    , SERIAL_NO
    , CCY
    , APPRD_AMT
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_limit_share_seq_no
    , i_customer_loan_seq_no
    , i_serial_no
    , i_ccy
    , i_apprd_amt
    , systimestamp
    , systimestamp);
  END SP_INS_LIMIT_SHARE;

--*************************************************************************
-- SP_DEL_LIMIT_SHARE
-- Purpose: 刪除共用額度主檔資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.01.25   created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_SHARE
  ( i_limit_share_seq_no  IN NUMBER  --共用額度主檔序號
  ) AS
  BEGIN
    DELETE EDLS.TB_LIMIT_SHARE
    WHERE LIMIT_SHARE_SEQ_NO = i_limit_share_seq_no;
  END SP_DEL_LIMIT_SHARE;

--*************************************************************************
-- SP_GET_LIMIT_SHARE_PROFILE
-- Purpose: 查詢共用額度設定檔資訊列表
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.01.25  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_SHARE_PROFILE
  ( i_limit_share_seq_no IN NUMBER         -- 共用額度主檔序號
  , o_cur                OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LIMIT_SHARE_PROFILE_SEQ_NO
       , LIMIT_SHARE_SEQ_NO
       , APPR_DOC_SEQ_NO
       , LIMIT_SEQ_NO 
    FROM EDLS.TB_LIMIT_SHARE_PROFILE
    WHERE LIMIT_SHARE_SEQ_NO= i_limit_share_seq_no
    FOR UPDATE;
  END SP_GET_LIMIT_SHARE_PROFILE;

--*************************************************************************
-- SP_INS_LIMIT_SHARE_PROFILE
-- Purpose: 新增共用額度設定檔資訊列表
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.01.25  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_LIMIT_SHARE_PROFILE
  ( i_limit_share_seq_no         IN NUMBER  -- 共用額度主檔序號
  , i_appr_doc_seq_no            IN NUMBER  -- 批覆書主檔序號
  , i_limit_seq_no               IN NUMBER  -- 分項額度主檔序號
  , o_limit_share_profile_seq_no OUT NUMBER -- 回傳序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LIMIT_SHARE_PROFILE', o_limit_share_profile_seq_no);
    INSERT INTO EDLS.TB_LIMIT_SHARE_PROFILE
    ( LIMIT_SHARE_PROFILE_SEQ_NO
    , LIMIT_SHARE_SEQ_NO
    , APPR_DOC_SEQ_NO
    , LIMIT_SEQ_NO
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_limit_share_profile_seq_no
    , i_limit_share_seq_no
    , i_appr_doc_seq_no
    , i_limit_seq_no
    , systimestamp
    , systimestamp
    );
  END SP_INS_LIMIT_SHARE_PROFILE;

--*************************************************************************
-- SP_DEL_LIMIT_SHARE_PROFILE
-- Purpose: 刪除共用額度設定檔資訊列表
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.01.25   created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_SHARE_PROFILE
  ( i_limit_share_seq_no   IN NUMBER  -- 共用額度設定檔序號
  ) AS
  BEGIN
    DELETE EDLS.TB_LIMIT_SHARE_PROFILE
    WHERE LIMIT_SHARE_SEQ_NO = i_limit_share_seq_no;
  END SP_DEL_LIMIT_SHARE_PROFILE;

--*************************************************************************
-- SP_FILTER_LIMIT_SHARE_PROFILE
-- Purpose: 過濾查詢共用額度設定檔資料
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.01.28   created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_FILTER_LIMIT_SHARE_PROFILE
  ( i_limit_share_seq_no IN NUMBER         -- 共用額度主檔序號
  , i_appr_doc_seq_no    IN NUMBER         -- 批覆書主檔序號
  , i_limit_seq_no       IN NUMBER         -- 分項額度主檔序號
  , o_cur                OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT lsp.LIMIT_SHARE_PROFILE_SEQ_NO -- 共用額度設定檔序號
      , lsp.LIMIT_SHARE_SEQ_NO            -- 共用額度主檔序號
      , lsp.APPR_DOC_SEQ_NO               -- 批覆書主檔序號
      , lsp.LIMIT_SEQ_NO                  -- 分項額度主檔序號
      , ad.APPR_DOC_SEQ_NO                -- 批覆書主檔序號
      , ad.CUSTOMER_LOAN_SEQ_NO           -- 授信戶主檔序號
      , ad.APPR_DOC_NO                    -- 批覆書編號
      , ad.PHASE                          -- 批覆書狀態
      , ad.APPRD_DATE                     -- 批覆書核準日
      , ad.MATU_DATE                      -- 批覆書到期日
      , ad.FIRST_DRAWDOWN_EDATE           -- 第一次動用截止日
      , ad.TOTAL_APPR_AMT                 -- 總額度
      , ad.TOTAL_APPR_CCY                 -- 總額度幣別
      , ad.CHANNEL_CODE                   -- 通路
      , ad.APPR_DRAWDOWN_TYPE             -- 本批覆書動用方式
      , ad.LOAN_PURPOSE                   -- 借款用途
      , ad.LOAN_ATTRIBUTES                -- 授信性質
      , ad.CCL_MK                         -- 綜合額度註記
      , ad.SOURCE_CODE                    -- 案件來源
      , ad.ACC_BRANCH                     -- 記帳單位
      , ad.OPER_BRANCH                    -- 作業單位
      , ad.APPROVER_ID                    -- 核貸者統編
      , ad.APPRD_TYPE                     -- 核貸權限別
      , ad.EFFEC_PERIOD                   -- 批覆書有效期間
      , ad.EFFEC_UNIT                     -- 批覆書有效期間單位
      , ad.CONTRACT_SDATE                 -- 契約起始日
      , ad.CONTRACT_PERIOD                -- 契約有效期間
      , ad.CONTRACT_UNIT                  -- 契約有效期間單位
      , ad.FROM_APPR_DOC_NO               -- 來源批覆書
      , ad.TO_APPR_DOC_NO                 -- 目的批覆書
      , ad.LAST_TXN_DATE                  -- 上次交易日
      , ad.INTER_MEDIA_BRANCH             -- 轉介單位
      , ad.REPORT_BRANCH                  -- 報表單位
      , ad.PROFIT_BRANCH                  -- 利潤單位
      , ad.FIRST_DRAWDOWN_DATE            -- 首次動撥日
      , ad.AUTH_DATE                      -- 批覆書放行日
      , ad.APPR_DOC_EDATE                 -- 批覆書結束日
      , ad.MPL_MORT_OVERDUE_CANCEL_MK     -- 月繳月省房貸因逾期取消功能註記
      , ad.APPR_DOC_SOURCE                -- 批覆書來源
      , ad.SYSTEM_ID                      -- 鍵檔平台
      , ad.MODIFIABLE                     -- 可執行變更交易
      , ad.CROSS_BORDER_SHARED_LIMIT_MK   -- 跨境共用額度註記
      , ad.UNDER_CENTER                   -- 批覆書所屬中心
      , lt.LIMIT_SEQ_NO                   -- 分項額度主檔序號
      , lt.APPR_DOC_SEQ_NO                -- 批覆書主檔序號
      , lt.LIMIT_TYPE                     -- 額度種類
      , lt.SERIAL_NO                      -- 序號
      , lt.BUSINESS_TYPE                  -- 業務類別
      , lt.BUSINESS_CODE                  -- 業務代碼
      , lt.PERIOD_TYPE                    -- 融資期間種類
      , lt.IS_GUARANTEED                  -- 有無擔保註記
      , lt.CCY_TYPE                       -- 幣別種類
      , lt.RIGHT_MK                       -- 追索權註記
      , lt.IS_FORWARD                     -- 即遠期註記
      , lt.CURRENCY                       -- 分項額度幣別
      , lt.APPRD_SUB_LIMIT_AMT            -- 分項核准額度
      , lt.LIMIT_DRAWDOWN_TYPE            -- 動用方式
      , lt.PHASE                          -- 分項額度狀態      
    FROM EDLS.TB_LIMIT_SHARE_PROFILE lsp
    INNER JOIN EDLS.TB_APPR_DOC ad
      ON lsp.APPR_DOC_SEQ_NO = ad.APPR_DOC_SEQ_NO
     LEFT JOIN EDLS.TB_LIMIT lt
      ON lsp.LIMIT_SEQ_NO = lt.LIMIT_SEQ_NO   
    WHERE ad.APPR_DOC_SEQ_NO = i_appr_doc_seq_no
    AND (i_limit_seq_no is null OR lt.LIMIT_SEQ_NO = i_limit_seq_no)
    AND (i_limit_share_seq_no is null OR lsp.limit_Share_Seq_No != i_limit_share_seq_no)
    FOR UPDATE;
  END SP_FILTER_LIMIT_SHARE_PROFILE;

--**************************************************************************
-- SP_GET_LIMIT_LIST_N_SYND_LOAN
-- Purpose: 查詢分項額度主檔與分項批示條件設定檔資訊且專案屬性註記非聯貸案06, 12。
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************  
  PROCEDURE SP_GET_LIMIT_LIST_N_SYND_LOAN
  ( i_appr_doc_seq_no IN VARCHAR2       -- 批覆書主檔序號
  , i_limit_type      IN VARCHAR2       -- 額度種類
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT lt.LIMIT_SEQ_NO
     , lt.APPR_DOC_SEQ_NO
     , lt.LIMIT_TYPE
     , lt.SERIAL_NO
     , lt.BUSINESS_TYPE
     , lt.BUSINESS_CODE
     , lt.PERIOD_TYPE
     , lt.IS_GUARANTEED
     , lt.CCY_TYPE
     , lt.RIGHT_MK
     , lt.IS_FORWARD
     , lt.CURRENCY
     , lt.APPRD_SUB_LIMIT_AMT
     , lt.LIMIT_DRAWDOWN_TYPE
     , lt.PHASE
     , lp.CREATE_DATE
     , lp.AMEND_DATE
     , lp.LIMIT_PROFILE_SEQ_NO
     , lp.BASE_RATE_TYPE
     , lp.SPREAD_RATE
     , lp.INTEREST_RATE
     , lp.FEE_RATE
     , lp.JCIC_LOAN_BIZ_CODE
     , lp.INTEREST_RATE_TYPE
     , lp.INTEREST_SCHEDULE_TYPE
     , lp.APPRD_DRAWDOWN_UNIT
     , lp.APPRD_DRAWDOWN_PERIOD
     , lp.PURPOSE_CODE
     , lp.LOAN_SUBCATEGORY
     , lp.CREDIT_LOAN_PROD_CODE
     , lp.REPAYMT_SOURCE
     , lp.PRNP_GRACE_PERIOD
     , lp.ALLOW_DRAWDOWN_MK
     , lp.COLLATERAL_TYPE
     , lp.APPR_INTST_RATE
     , lp.DEPOSIT_PLEDGE_MK
     , lp.PD_VALUE
     , lp.LGD_VALUE
     , lp.FIRST_DRAWDOWN_DATE
     , lp.OVERDRAFT_EXT_MK
     , lp.CREDIT_GUARA_FEE_RATE
     , lp.PAYMT_TYPE
     , lp.CONSIGN_PAYMT_ACC
     , lp.INTST_UPPER_RATE
     , lp.INTST_LOWER_RATE
     , lp.GUARA_CALC_TYPE
     , lp.TRANS_ACCEPT_FEE_RATE
     , lp.CREATE_DATE
     , lp.AMEND_DATE
     , lp.SERVICE_FEE_DATA
    FROM EDLS.TB_LIMIT lt 
    INNER JOIN EDLS.TB_LIMIT_PROFILE lp
      ON lt.LIMIT_SEQ_NO = lp.LIMIT_SEQ_NO
    INNER JOIN EDLS.TB_LIMIT_PROJ_COND_PROF lpcp
      ON lp.LIMIT_PROFILE_SEQ_NO = lpcp.LIMIT_PROFILE_SEQ_NO
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no 
    AND (i_limit_type = '00' OR i_limit_type = LIMIT_TYPE)
    AND lpcp.PROJECT_CODE != '06'
    AND lpcp.PROJECT_CODE != '12'
    FOR UPDATE;
  END SP_GET_LIMIT_LIST_N_SYND_LOAN;

--************************************************************************* 
-- SP_UPD_LIMIT_SHARE
-- Purpose: 更新共用額度主檔資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.01.25  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_UPD_LIMIT_SHARE
  ( i_limit_share_seq_no   IN NUMBER   -- 共用額度主檔序號
  , i_customer_loan_seq_no IN NUMBER   -- 授信戶主檔序號
  , i_serial_no            IN VARCHAR2 -- 共用額度序號
  , i_ccy                  IN VARCHAR2 -- 共用額度幣別
  , i_apprd_amt            IN NUMBER   -- 共用額度金額
  , o_count                OUT NUMBER  -- 執行筆數
  ) AS
  BEGIN   
  UPDATE EDLS.TB_LIMIT_SHARE
  SET CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
     , SERIAL_NO = i_serial_no
     , CCY = i_ccy
     , APPRD_AMT = i_apprd_amt
     , AMEND_DATE = systimestamp
      WHERE LIMIT_SHARE_SEQ_NO = i_limit_share_seq_no;
     o_count := sql%rowcount;
  END SP_UPD_LIMIT_SHARE;

--*************************************************************************
-- SP_GET_LIMIT_SHARE_BY_SEQ
-- Purpose: 查詢共用額度主檔資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.01.28  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_SHARE_BY_SEQ 
  ( i_limit_share_seq_no IN NUMBER         -- 共用額度主檔序號
  , o_cur                OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LIMIT_SHARE_SEQ_NO
       , CUSTOMER_LOAN_SEQ_NO
       , SERIAL_NO
       , CCY
       , APPRD_AMT
    FROM EDLS.TB_LIMIT_SHARE
    WHERE LIMIT_SHARE_SEQ_NO = i_limit_share_seq_no
    FOR UPDATE;
  END SP_GET_LIMIT_SHARE_BY_SEQ;

--*************************************************************************
-- SP_GET_LIMIT_SHARE_RELATED
-- Purpose: 取得關聯批覆書與分項額度的所有共用額度資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.01.28  created
-- 1.1 ESB18627 2019.10.18  performance adjust AND 修正只有綁定批覆書主檔的共用額度沒join到的問題
-- 1.2 ESB18757 2020.04.29  移除i_start、i_end(檢視目前無人使用)
-- 1.3 ESB18757 2020.05.15  批覆書主檔序號不須用LIST傳入
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_SHARE_RELATED 
  ( i_appr_doc_seq_no IN VARCHAR2      -- 批覆書主檔序號
  , i_limit_seq_list  IN VARCHAR2      -- 分項額度主檔序號列表
  , o_cur            OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT cl.CUST_ID
       , ls.LIMIT_SHARE_SEQ_NO
       , ls.CUSTOMER_LOAN_SEQ_NO
       , ls.SERIAL_NO
       , ls.CCY
       , ls.APPRD_AMT
       , lsp.LIMIT_SHARE_PROFILE_SEQ_NO
       , lsp.APPR_DOC_SEQ_NO
       , lsp.LIMIT_SEQ_NO
       , lt.LIMIT_TYPE
       , ad.APPR_DOC_NO
    FROM EDLS.TB_LIMIT_SHARE ls
   INNER JOIN EDLS.TB_LIMIT_SHARE_PROFILE lsp
      ON ls.LIMIT_SHARE_SEQ_NO = lsp.LIMIT_SHARE_SEQ_NO    
   INNER JOIN EDLS.TB_APPR_DOC ad
      ON lsp.APPR_DOC_SEQ_NO = ad.APPR_DOC_SEQ_NO
    LEFT JOIN EDLS.TB_LIMIT lt
      ON lt.LIMIT_SEQ_NO = lsp.LIMIT_SEQ_NO
   INNER JOIN EDLS.TB_CUSTOMER_LOAN cl
      ON cl.CUSTOMER_LOAN_SEQ_NO = ls.CUSTOMER_LOAN_SEQ_NO
   WHERE (
           lsp.LIMIT_SEQ_NO IS NULL
       AND lsp.APPR_DOC_SEQ_NO = i_appr_doc_seq_no
       )
      OR (
           lsp.LIMIT_SEQ_NO IN (SELECT TRIM(REGEXP_SUBSTR(i_limit_seq_list, '[^,]+', 1, LEVEL)) code FROM dual 
             CONNECT BY LEVEL <= REGEXP_COUNT(i_limit_seq_list, ',') + 1)
       );
  END SP_GET_LIMIT_SHARE_RELATED;

--**************************************************************************
-- SP_GET_LIMIT_BY_SEQ
-- Purpose: 查詢分項額度主檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.18  performance adjust
-- 1.2 MARS      2019.11.20  移除FOR UPDATE
--**************************************************************************  
  PROCEDURE SP_GET_LIMIT_BY_SEQ
  ( i_limit_seq_no IN NUMBER         -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
   OPEN o_cur FOR
   SELECT lt.LIMIT_SEQ_NO
        , lt.APPR_DOC_SEQ_NO
        , lt.LIMIT_TYPE
        , lt.SERIAL_NO
        , lt.BUSINESS_TYPE
        , lt.BUSINESS_CODE
        , lt.PERIOD_TYPE
        , lt.IS_GUARANTEED
        , lt.CCY_TYPE
        , lt.RIGHT_MK
        , lt.IS_FORWARD
        , lt.CURRENCY
        , lt.APPRD_SUB_LIMIT_AMT
        , lt.LIMIT_DRAWDOWN_TYPE
        , lt.PHASE
     FROM EDLS.TB_LIMIT lt
    WHERE lt.LIMIT_SEQ_NO = i_limit_seq_no;
  END SP_GET_LIMIT_BY_SEQ;

--**************************************************************************
-- SP_GET_APPR_DOC_BY_SEQ_NU
-- Purpose: 查詢批覆書主檔(無鎖)
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 ESB20276  2019.11.05  created
--**************************************************************************
  PROCEDURE SP_GET_APPR_DOC_BY_SEQ_NU
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號 
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
     SELECT ad.APPR_DOC_SEQ_NO
     , ad.CUSTOMER_LOAN_SEQ_NO
     , ad.APPR_DOC_NO
     , ad.PHASE
     , ad.APPRD_DATE
     , ad.MATU_DATE
     , ad.FIRST_DRAWDOWN_EDATE
     , ad.TOTAL_APPR_AMT
     , ad.TOTAL_APPR_CCY
     , ad.CHANNEL_CODE
     , ad.APPR_DRAWDOWN_TYPE
     , ad.LOAN_PURPOSE
     , ad.LOAN_ATTRIBUTES
     , ad.CCL_MK
     , ad.SOURCE_CODE
     , ad.DATA_CONVERT_SOURCE
     , ad.ACC_BRANCH
     , ad.OPER_BRANCH
     , ad.UNDER_CENTER
     , ad.APPROVER_ID
     , ad.APPRD_TYPE
     , ad.EFFEC_PERIOD
     , ad.EFFEC_UNIT
     , ad.CONTRACT_SDATE
     , ad.CONTRACT_PERIOD
     , ad.CONTRACT_UNIT
     , ad.FROM_APPR_DOC_NO
     , ad.TO_APPR_DOC_NO
     , ad.LAST_TXN_DATE
     , ad.INTER_MEDIA_BRANCH
     , ad.REPORT_BRANCH
     , ad.PROFIT_BRANCH
     , ad.FIRST_DRAWDOWN_DATE
     , ad.AUTH_DATE
     , ad.APPR_DOC_EDATE
     , ad.MPL_MORT_OVERDUE_CANCEL_MK
     , ad.APPR_DOC_SOURCE
     , ad.SYSTEM_ID
     , ad.MODIFIABLE
     , ad.CROSS_BORDER_SHARED_LIMIT_MK
     , ad.create_date 
     , ad.amend_date 
     , cl.cust_id 
    FROM EDLS.TB_CUSTOMER_LOAN cl
    INNER JOIN EDLS.TB_APPR_DOC ad 
      ON cl.customer_loan_seq_no = ad.customer_loan_seq_no
    WHERE (ad.APPR_DOC_SEQ_NO= i_appr_doc_seq_no);
  END SP_GET_APPR_DOC_BY_SEQ_NU;

--**************************************************************************
-- SP_GET_APPR_DOC_BY_SEQ
-- Purpose: 查詢批覆書主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_APPR_DOC_BY_SEQ
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號 
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
     SELECT ad.APPR_DOC_SEQ_NO
     , ad.CUSTOMER_LOAN_SEQ_NO
     , ad.APPR_DOC_NO
     , ad.PHASE
     , ad.APPRD_DATE
     , ad.MATU_DATE
     , ad.FIRST_DRAWDOWN_EDATE
     , ad.TOTAL_APPR_AMT
     , ad.TOTAL_APPR_CCY
     , ad.CHANNEL_CODE
     , ad.APPR_DRAWDOWN_TYPE
     , ad.LOAN_PURPOSE
     , ad.LOAN_ATTRIBUTES
     , ad.CCL_MK
     , ad.SOURCE_CODE
     , ad.DATA_CONVERT_SOURCE
     , ad.ACC_BRANCH
     , ad.OPER_BRANCH
     , ad.UNDER_CENTER
     , ad.APPROVER_ID
     , ad.APPRD_TYPE
     , ad.EFFEC_PERIOD
     , ad.EFFEC_UNIT
     , ad.CONTRACT_SDATE
     , ad.CONTRACT_PERIOD
     , ad.CONTRACT_UNIT
     , ad.FROM_APPR_DOC_NO
     , ad.TO_APPR_DOC_NO
     , ad.LAST_TXN_DATE
     , ad.INTER_MEDIA_BRANCH
     , ad.REPORT_BRANCH
     , ad.PROFIT_BRANCH
     , ad.FIRST_DRAWDOWN_DATE
     , ad.AUTH_DATE
     , ad.APPR_DOC_EDATE
     , ad.MPL_MORT_OVERDUE_CANCEL_MK
     , ad.APPR_DOC_SOURCE
     , ad.SYSTEM_ID
     , ad.MODIFIABLE
     , ad.CROSS_BORDER_SHARED_LIMIT_MK
     , ad.create_date 
     , ad.amend_date 
     , cl.cust_id 
    FROM EDLS.TB_CUSTOMER_LOAN cl
    INNER JOIN EDLS.TB_APPR_DOC ad 
      ON cl.customer_loan_seq_no = ad.customer_loan_seq_no
    WHERE (ad.APPR_DOC_SEQ_NO= i_appr_doc_seq_no)
    FOR UPDATE;
  END SP_GET_APPR_DOC_BY_SEQ;  

--*************************************************************************
-- SP_INS_LIMIT_DTL_HISTORY
-- Purpose: 新增額度更新軌跡檔
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.05.22  created
-- 1.1 ESB18627  2019.10.18  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_LIMIT_DTL_HISTORY
  ( i_limit_dtl_seq_no                  IN NUMBER    -- 分項額度彙計檔序號
  , i_txn_date                         IN VARCHAR2 -- 交易日期
  , i_txn_sno                          IN NUMBER   -- 交易日期序號
  , i_txn_time                         IN VARCHAR2 -- 交易時間
  , i_opertaion_type                   IN VARCHAR2 -- 作業類別
  , i_is_ec                            IN VARCHAR2 -- 沖正註記
  , i_currency                         IN VARCHAR2 -- 幣別
  , i_business_code                    IN VARCHAR2 -- 業務代碼
  , i_business_type                    IN VARCHAR2 -- 業務別
  , i_txn_amt                          IN NUMBER   -- 交易金額
  , i_total_drawdown_amount            IN NUMBER   -- 累積動用金額
  , i_total_paymt                      IN NUMBER   -- 累積還款金額
  , i_total_appr_doc_drawdown_amount   IN NUMBER   -- 佔用批覆書額度金額
  , i_total_nego_amt                   IN NUMBER   -- 累積和解總額
  , o_limit_dtl_history_seq_no         OUT NUMBER  -- 額度更新軌跡檔主檔序號
  ) AS
  BEGIN
  EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LIMIT_DTL_HISTORY', o_limit_dtl_history_seq_no);  
    INSERT INTO EDLS.TB_LIMIT_DTL_HISTORY
    ( LIMIT_DTL_HISTORY_SEQ_NO
    , LIMIT_DTL_SEQ_NO
    , TXN_DATE
    , TXN_SNO
    , TXN_TIME
    , OPERTAION_TYPE
    , IS_EC
    , CURRENCY
    , BUSINESS_CODE
    , BUSINESS_TYPE
    , TXN_AMT
    , TOTAL_DRAWDOWN_AMOUNT
    , TOTAL_PAYMT
    , TOTAL_APPR_DOC_DRAWDOWN_AMOUNT
    , TOTAL_NEGO_AMT
    , CREATE_DATE
    , AMEND_DATE)
    VALUES
    ( o_limit_dtl_history_seq_no
    , i_limit_dtl_seq_no, i_txn_date
    , (SELECT NVL(MAX(TXN_SNO )+1,1) FROM TB_LIMIT_DTL_HISTORY WHERE (LIMIT_DTL_SEQ_NO = i_limit_dtl_seq_no AND TXN_DATE = i_txn_date ))
    , i_txn_time
    , i_opertaion_type
    , i_is_ec
    , i_currency
    , i_business_code
    , i_business_type
    , i_txn_amt
    , i_total_drawdown_amount
    , i_total_paymt
    , i_total_appr_doc_drawdown_amount
    , i_total_nego_amt 
    , systimestamp 
    , systimestamp
    );
  END SP_INS_LIMIT_DTL_HISTORY;


--**************************************************************************
-- SP_GET_LIMIT_BUYER
-- Purpose: 查詢買方額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER 
  ( i_cust_id IN VARCHAR2       -- 銀行歸戶統編
  , o_cur     OUT SYS_REFCURSOR -- 回傳資料  
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT lb.LIMIT_BUYER_SEQ_NO
    , lb.CUSTOMER_LOAN_SEQ_NO
    , lb.LIMIT_BUYER_SHARE_SEQ_NO
    , lb.BUYER_APPR_LIMIT_AMT
    , lb.TOTAL_DRAWDOWN_AMT
    , lb.MATU_DATE
    , lb.STANDARD_MK
    , lb.EVAL_MK
    , lb.CANCEL_LIMIT_REASON_MK
    , lb.CANCEL_LIMIT_REASON
    FROM EDLS.TB_LIMIT_BUYER lb INNER JOIN EDLS.TB_CUSTOMER_LOAN cl
    ON lb.CUSTOMER_LOAN_SEQ_NO = cl.CUSTOMER_LOAN_SEQ_NO
    WHERE cl.CUST_ID = i_cust_id
    FOR UPDATE;
  END SP_GET_LIMIT_BUYER;

--**************************************************************************
-- SP_GET_LIMIT_BUYER_LIST
-- Purpose: 查詢買方額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER_LIST 
  ( i_cust_id_list_str IN VARCHAR2       -- 銀行歸戶統編
  , o_cur              OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT lb.LIMIT_BUYER_SEQ_NO
     , lb.CUSTOMER_LOAN_SEQ_NO
     , lb.LIMIT_BUYER_SHARE_SEQ_NO
     , lb.BUYER_APPR_LIMIT_AMT
     , lb.TOTAL_DRAWDOWN_AMT
     , lb.MATU_DATE
     , lb.STANDARD_MK
     , lb.EVAL_MK
     , lb.CANCEL_LIMIT_REASON_MK
     , lb.CANCEL_LIMIT_REASON
    FROM EDLS.TB_LIMIT_BUYER lb 
    INNER JOIN EDLS.TB_CUSTOMER_LOAN cl
      ON lb.CUSTOMER_LOAN_SEQ_NO = cl.CUSTOMER_LOAN_SEQ_NO
    WHERE cl.CUST_ID IN 
          ( SELECT TRIM(REGEXP_SUBSTR(i_cust_id_list_str, '[^,]+', 1, LEVEL)) code FROM dual 
            CONNECT BY LEVEL <= REGEXP_COUNT(i_cust_id_list_str, ',') + 1)
    FOR UPDATE;
  END SP_GET_LIMIT_BUYER_LIST;

--**************************************************************************
-- SP_INS_LIMIT_BUYER
-- Purpose: 新增買方額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************  
  PROCEDURE SP_INS_LIMIT_BUYER
  ( i_customer_loan_seq_no     IN NUMBER   -- 授信戶主檔序號
  , i_limit_buyer_share_seq_no IN NUMBER   -- 買方共用額度主檔序號
  , i_buyer_appr_limit_amt     IN NUMBER   -- 買方核准額度
  , i_total_drawdown_amt       IN NUMBER   -- 預佔累積動用金額
  , i_matu_date                IN VARCHAR2 -- 買方額度核准到期日
  , i_standard_mk              IN VARCHAR2 -- 核予標準註記
  , i_eval_mk                  IN VARCHAR2 -- 核予評等註記
  , i_cancel_limit_reason_mk   IN VARCHAR2 -- 取消額度原因註記
  , i_cancel_limit_reason      IN VARCHAR2 -- 取消額度原因
  , o_limit_buyer_seq_no       OUT NUMBER  -- 買方額度序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LIMIT_BUYER', o_limit_buyer_seq_no);
    INSERT INTO EDLS.TB_LIMIT_BUYER
    ( LIMIT_BUYER_SEQ_NO
    , CUSTOMER_LOAN_SEQ_NO
    , LIMIT_BUYER_SHARE_SEQ_NO
    , BUYER_APPR_LIMIT_AMT
    , TOTAL_DRAWDOWN_AMT
    , MATU_DATE
    , STANDARD_MK
    , EVAL_MK
    , CANCEL_LIMIT_REASON_MK
    , CANCEL_LIMIT_REASON
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_limit_buyer_seq_no
    , i_customer_loan_seq_no
    , i_limit_buyer_share_seq_no
    , i_buyer_appr_limit_amt
    , i_total_drawdown_amt
    , i_matu_date
    , i_standard_mk
    , i_eval_mk
    , i_cancel_limit_reason_mk
    , i_cancel_limit_reason
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
  END SP_INS_LIMIT_BUYER;

--**************************************************************************
-- SP_DEL_LIMIT_BUYER
-- Purpose: 刪除買方額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_BUYER
  ( i_limit_buyer_seq_no IN VARCHAR2  -- 買方額度序號
  ) AS
  BEGIN
    DELETE EDLS.TB_LIMIT_BUYER
    WHERE LIMIT_BUYER_SEQ_NO = i_limit_buyer_seq_no;
  END SP_DEL_LIMIT_BUYER;

--**************************************************************************
-- SP_UPD_LIMIT_BUYER
-- Purpose: 更新買方額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************
  PROCEDURE SP_UPD_LIMIT_BUYER
  ( i_limit_buyer_seq_no       IN NUMBER   -- 買方額度序號
  , i_consumer_loan_seq_no     IN NUMBER   -- 授信戶主檔序號
  , i_limit_buyer_share_seq_no IN NUMBER   -- 買方共用額度主檔序號
  , i_buyer_appr_limit_amt     IN NUMBER   -- 買方核准額度
  , i_total_drawdown_amt       IN NUMBER   -- 預佔累積動用金額
  , i_matu_date                IN VARCHAR2 -- 買方額度核准到期日
  , i_standard_mk              IN VARCHAR2 -- 核予標準註記
  , i_eval_mk                  IN VARCHAR2 -- 核予評等註記
  , i_cancel_limit_reason_mk   IN VARCHAR2 -- 取消額度原因註記
  , i_cancel_limit_reason      IN VARCHAR2 -- 取消額度原因
  , o_limit_buyer_seq_no       OUT NUMBER  -- 異動筆數
  ) AS
  BEGIN
    o_limit_buyer_seq_no := i_limit_buyer_seq_no;
    UPDATE EDLS.TB_LIMIT_BUYER
    SET CUSTOMER_LOAN_SEQ_NO = i_consumer_loan_seq_no
     , LIMIT_BUYER_SHARE_SEQ_NO = i_limit_buyer_share_seq_no
     , BUYER_APPR_LIMIT_AMT = i_buyer_appr_limit_amt
     , TOTAL_DRAWDOWN_AMT = i_total_drawdown_amt
     , MATU_DATE = i_matu_date
     , STANDARD_MK = i_standard_mk
     , EVAL_MK = i_eval_mk
     , CANCEL_LIMIT_REASON_MK = i_cancel_limit_reason_mk
     , CANCEL_LIMIT_REASON = i_cancel_limit_reason
     , AMEND_DATE = SYSTIMESTAMP
    WHERE LIMIT_BUYER_SEQ_NO = i_limit_buyer_seq_no;
  END SP_UPD_LIMIT_BUYER;

--**************************************************************************
-- SP_GET_LIMIT_BUYER_SHARE
-- Purpose: 查詢買方共用額度
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER_SHARE
  ( i_cust_id IN VARCHAR2       -- 銀行歸戶統編
  , o_cur     OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT lbs.LIMIT_BUYER_SHARE_SEQ_NO
    , lbs.CUSTOMER_LOAN_SEQ_NO
    , lbs.APPR_LIMIT_AMT
    , lbs.MATU_DATE
    FROM EDLS.TB_LIMIT_BUYER_SHARE lbs 
    INNER JOIN EDLS.TB_CUSTOMER_LOAN cl 
    ON lbs.CUSTOMER_LOAN_SEQ_NO = cl.CUSTOMER_LOAN_SEQ_NO
    WHERE cl.CUST_ID = i_cust_id
    FOR UPDATE;
  END SP_GET_LIMIT_BUYER_SHARE;

--**************************************************************************
-- SP_GET_LIMIT_BUYER_SHARE_LIST
-- Purpose: 查詢買方共用額度
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER_SHARE_LIST
  ( i_cust_id_list_str IN VARCHAR2       -- 銀行歸戶統編
  , o_cur              OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT lbs.LIMIT_BUYER_SHARE_SEQ_NO
    , lbs.CUSTOMER_LOAN_SEQ_NO
    , lbs.APPR_LIMIT_AMT
    , lbs.MATU_DATE
    FROM EDLS.TB_LIMIT_BUYER_SHARE lbs 
    INNER JOIN EDLS.TB_CUSTOMER_LOAN cl 
    ON lbs.CUSTOMER_LOAN_SEQ_NO = cl.CUSTOMER_LOAN_SEQ_NO
    WHERE cl.CUST_ID IN ( SELECT TRIM(REGEXP_SUBSTR(i_cust_id_list_str, '[^,]+', 1, LEVEL)) code FROM dual 
                          CONNECT BY LEVEL <= REGEXP_COUNT(i_cust_id_list_str, ',') + 1 )
    FOR UPDATE;
  END SP_GET_LIMIT_BUYER_SHARE_LIST;

--**************************************************************************
-- Purpose: 新增買方共用額度
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_LIMIT_BUYER_SHARE
  ( i_customer_loan_seq_no     IN VARCHAR2 -- 授信戶主檔序號
  , i_appr_limit_amt           IN NUMBER   -- 買方共用核准額度
  , i_matu_date                IN VARCHAR2 -- 買方共用額度核准到期日
  , o_limit_buyer_share_seq_no OUT NUMBER  -- 買方共用額度主檔序號 
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LIMIT_BUYER_SHARE', o_limit_buyer_share_seq_no);
    INSERT INTO EDLS.TB_LIMIT_BUYER_SHARE
    ( LIMIT_BUYER_SHARE_SEQ_NO
    , CUSTOMER_LOAN_SEQ_NO
    , APPR_LIMIT_AMT
    , MATU_DATE
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_limit_buyer_share_seq_no
    , i_customer_loan_seq_no
    , i_appr_limit_amt
    , i_matu_date
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
  END SP_INS_LIMIT_BUYER_SHARE;

--**************************************************************************
-- SP_UPD_LIMIT_BUYER_SHARE
-- Purpose: 更新買方共用額度
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************
  PROCEDURE SP_UPD_LIMIT_BUYER_SHARE
  ( i_limit_buyer_share_seq_no IN NUMBER   -- 買方共用額度主檔序號
  , i_customer_loan_seq_no     IN NUMBER   -- 授信戶主檔序號
  , i_appr_limit_amt           IN NUMBER   -- 買方共用核准額度
  , i_matu_date                IN VARCHAR2 -- 買方共用額度核准到期日
  , o_limit_buyer_share_seq_no OUT NUMBER  -- 更新筆數
  ) AS
  BEGIN
    o_limit_buyer_share_seq_no := i_limit_buyer_share_seq_no;
    UPDATE EDLS.TB_LIMIT_BUYER_SHARE
    SET CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
     , APPR_LIMIT_AMT = i_appr_limit_amt
     , MATU_DATE = i_matu_date
     , AMEND_DATE = SYSTIMESTAMP
    WHERE LIMIT_BUYER_SHARE_SEQ_NO = i_limit_buyer_share_seq_no;
  END SP_UPD_LIMIT_BUYER_SHARE;

--**************************************************************************
-- SP_DEL_LIMIT_BUYER_SHARE
-- Purpose: 刪除買方共用額度
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_BUYER_SHARE
  ( i_limit_buyer_share_seq_no IN VARCHAR2 -- 買方共用額度主檔序號
  ) AS
  BEGIN
    DELETE EDLS.TB_LIMIT_BUYER_SHARE
    WHERE LIMIT_BUYER_SHARE_SEQ_NO = i_limit_buyer_share_seq_no;
  END SP_DEL_LIMIT_BUYER_SHARE;


--**************************************************************************
-- SP_GET_LIMIT_BUYER_BOOKING
-- Purpose: 查詢買方預佔額度資訊
-- 1.1 ESB18627  2019.10.21  performance adjust
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER_BOOKING
  ( i_cust_id  IN VARCHAR2       -- 銀行歸戶統編
  , i_txn_date IN VARCHAR2       -- 登錄日期
  , i_txn_sno  IN NUMBER         -- 交易日期序號
  , o_cur      OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LBB.LIMIT_BUYER_BOOKING_SEQ_NO
     , LBB.CUSTOMER_LOAN_SEQ_NO
     , LBB.TXN_DATE
     , LBB.TXN_SNO
     , LBB.TXN_TIME
     , LBB.TXN_BRANCH
     , LBB.HOST_SNO
     , LBB.SUP_CARD
     , LBB.TXN_ID
     , LBB.TXN_MEMO
     , LBB.BUYER_BOOKING_AMT
     , LBB.BUYER_BOOKING_DRAWDOWN_AMT
     , LBB.DRAWDOWN_EDATE
     , LBB.DRAWDOWN_DATE
    FROM EDLS.TB_CUSTOMER_LOAN cl
	INNER JOIN EDLS.TB_LIMIT_BUYER_BOOKING lbb ON lbb.CUSTOMER_LOAN_SEQ_NO = cl.CUSTOMER_LOAN_SEQ_NO
    WHERE cl.CUST_ID = i_cust_id
    AND LBB.TXN_DATE = i_txn_date
    AND LBB.TXN_SNO = i_txn_sno
    FOR UPDATE;
  END SP_GET_LIMIT_BUYER_BOOKING;

--**************************************************************************
-- SP_GET_LIMIT_BUYER_BY_SHARE
-- Purpose: 查詢買方共用額度下的買方額度
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER_BY_SHARE
  ( i_limit_buyer_share_seq_no IN NUMBER         -- 買方共用額度主檔序號
  , o_cur                      OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT lb.LIMIT_BUYER_SEQ_NO
      , lb.CUSTOMER_LOAN_SEQ_NO
      , lb.LIMIT_BUYER_SHARE_SEQ_NO
      , lb.BUYER_APPR_LIMIT_AMT
      , lb.TOTAL_DRAWDOWN_AMT
      , lb.MATU_DATE
      , lb.STANDARD_MK
      , lb.EVAL_MK
      , lb.CANCEL_LIMIT_REASON_MK
      , lb.CANCEL_LIMIT_REASON
      , cl.CUST_ID
    FROM EDLS.TB_LIMIT_BUYER lb 
    INNER JOIN EDLS.TB_CUSTOMER_LOAN cl
      ON lb.CUSTOMER_LOAN_SEQ_NO = cl.CUSTOMER_LOAN_SEQ_NO
    WHERE LIMIT_BUYER_SHARE_SEQ_NO = i_limit_buyer_share_seq_no
    FOR UPDATE;
  END SP_GET_LIMIT_BUYER_BY_SHARE;

--**************************************************************************
-- SP_GET_LIMIT_BUYER_S_BY_SEQ
-- Purpose: 查詢買方共用主檔序號對應的買方共用額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER_S_BY_SEQ
  ( i_limit_buyer_share_seq_no IN NUMBER         -- 買方共用額度主檔序號
  , o_cur                      OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT lbs.LIMIT_BUYER_SHARE_SEQ_NO
     , lbs.CUSTOMER_LOAN_SEQ_NO
     , lbs.APPR_LIMIT_AMT
     , lbs.MATU_DATE
     , cl.CUST_ID
    FROM EDLS.TB_LIMIT_BUYER_SHARE lbs 
    INNER JOIN EDLS.TB_CUSTOMER_LOAN cl
      ON lbs.CUSTOMER_LOAN_SEQ_NO = cl.CUSTOMER_LOAN_SEQ_NO
    WHERE lbs.LIMIT_BUYER_SHARE_SEQ_NO= i_limit_buyer_share_seq_no;
  END SP_GET_LIMIT_BUYER_S_BY_SEQ;

--**************************************************************************
-- SP_GET_LIMIT_BUYER_BK_LIST
-- Purpose: 查詢買方預佔額度資訊列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER_BK_LIST
  ( i_cust_id IN VARCHAR2       -- 銀行歸戶統編
  , o_cur     OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT lbb.LIMIT_BUYER_BOOKING_SEQ_NO
    , lbb.CUSTOMER_LOAN_SEQ_NO
    , lbb.TXN_DATE
    , lbb.TXN_SNO
    , lbb.TXN_TIME
    , lbb.TXN_BRANCH
    , lbb.HOST_SNO
    , lbb.SUP_CARD
    , lbb.TXN_ID
    , lbb.TXN_MEMO
    , lbb.BUYER_BOOKING_AMT
    , lbb.BUYER_BOOKING_DRAWDOWN_AMT
    , lbb.DRAWDOWN_EDATE
    , lbb.DRAWDOWN_DATE
    FROM EDLS.TB_LIMIT_BUYER_BOOKING lbb 
    INNER JOIN EDLS.TB_CUSTOMER_LOAN cl
      ON lbb.CUSTOMER_LOAN_SEQ_NO = cl.CUSTOMER_LOAN_SEQ_NO
    WHERE cl.CUST_ID = i_cust_id
    ORDER BY LIMIT_BUYER_BOOKING_SEQ_NO ASC
    FOR UPDATE;
  END SP_GET_LIMIT_BUYER_BK_LIST;

--**************************************************************************
-- SP_INS_LIMIT_BUYER_BOOKING
-- Purpose: Insert買方預佔額度資訊列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************
   PROCEDURE SP_INS_LIMIT_BUYER_BOOKING
  ( i_customer_loan_seq_no       IN NUMBER   -- 授信戶主檔序號
  , i_txn_date                   IN VARCHAR2 -- 交易日期
  , i_txn_sno                    IN NUMBER   -- 交易日期序號
  , i_txn_time                   IN VARCHAR2 -- 交易時間
  , i_txn_branch                 IN VARCHAR2 -- 交易分行
  , i_host_sno                   IN VARCHAR2 -- 主機交易序號
  , i_sup_card                   IN VARCHAR2 -- 授權主管卡號
  , i_txn_id                     IN VARCHAR2 -- 交易代號
  , i_txn_memo                   IN VARCHAR2 -- 交易摘要
  , i_buyer_booking_amt          IN NUMBER   -- 買方預佔額度
  , i_buyer_booking_drawdown_amt IN NUMBER   -- 買方預佔額度已動用金額
  , i_drawdown_edate             IN VARCHAR2 -- 最晚動用日期
  , i_drawdown_date              IN VARCHAR2 -- 動用日期
  , o_cur                  OUT SYS_REFCURSOR -- 買方預佔額度序號
  ) AS
    v_limit_buyer_booking_seq_no EDLS.TB_LIMIT_BUYER_BOOKING.limit_buyer_booking_seq_no%type;
    v_txn_date_sno EDLS.TB_LIMIT_BUYER_BOOKING.txn_sno%type;
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LIMIT_BUYER_BOOKING', v_limit_buyer_booking_seq_no);
    SELECT NVL(MAX(txn_sno), 0) + 1 INTO v_txn_date_sno FROM EDLS.TB_LIMIT_BUYER_BOOKING WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no AND txn_date = i_txn_date ;
    INSERT INTO EDLS.TB_LIMIT_BUYER_BOOKING
    ( LIMIT_BUYER_BOOKING_SEQ_NO
    , CUSTOMER_LOAN_SEQ_NO
    , TXN_DATE
    , TXN_SNO
    , TXN_TIME
    , TXN_BRANCH
    , HOST_SNO
    , SUP_CARD
    , TXN_ID
    , TXN_MEMO
    , BUYER_BOOKING_AMT
    , BUYER_BOOKING_DRAWDOWN_AMT
    , DRAWDOWN_EDATE
    , DRAWDOWN_DATE
    , CREATE_DATE
    , AMEND_DATE 
    )
    VALUES
    ( v_limit_buyer_booking_seq_no
    , i_customer_loan_seq_no
    , i_txn_date
    , v_txn_date_sno
    , i_txn_time
    , i_txn_branch
    , i_host_sno
    , i_sup_card
    , i_txn_id
    , i_txn_memo
    , i_buyer_booking_amt
    , i_buyer_booking_drawdown_amt
    , i_drawdown_edate
    , i_drawdown_date
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );

  OPEN o_cur FOR
  SELECT LIMIT_BUYER_BOOKING_SEQ_NO, CUSTOMER_LOAN_SEQ_NO, TXN_DATE, TXN_SNO, TXN_TIME, TXN_BRANCH
    , HOST_SNO, SUP_CARD, TXN_ID, TXN_MEMO, BUYER_BOOKING_AMT, BUYER_BOOKING_DRAWDOWN_AMT
    , DRAWDOWN_EDATE, DRAWDOWN_DATE
  FROM TB_LIMIT_BUYER_BOOKING
  WHERE LIMIT_BUYER_BOOKING_SEQ_NO = v_limit_buyer_booking_seq_no;

 END SP_INS_LIMIT_BUYER_BOOKING;


--**************************************************************************
-- SP_DEL_LIMIT_BUYER_BOOKING
-- Purpose: 刪除買方預佔額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_BUYER_BOOKING
  ( i_limit_buyer_booking_seq_no IN NUMBER  -- 買方預佔額度序號
  ) AS
  BEGIN
    DELETE EDLS.TB_LIMIT_BUYER_BOOKING
    WHERE LIMIT_BUYER_BOOKING_SEQ_NO= i_limit_buyer_booking_seq_no;
  END SP_DEL_LIMIT_BUYER_BOOKING;

--**************************************************************************
-- SP_UPD_LIMIT_BUYER_BOOKING
-- Purpose: 更新買方預佔額度
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************
  PROCEDURE SP_UPD_LIMIT_BUYER_BOOKING
  ( i_limit_buyer_booking_seq_no       IN NUMBER    -- 買方預佔額度序號
  , i_customer_loan_seq_no             IN NUMBER    -- 授信戶主檔序號
  , i_txn_date                         IN VARCHAR2  -- 交易日期
  , i_txn_sno                          IN NUMBER    -- 交易日期序號
  , i_txn_time                         IN VARCHAR2  -- 交易時間
  , i_txn_branch                       IN VARCHAR2  -- 交易分行
  , i_host_sno                         IN VARCHAR2  -- 主機交易序號
  , i_sup_card                         IN VARCHAR2  -- 授權主管卡號
  , i_txn_id                           IN VARCHAR2  -- 交易代號
  , i_txn_memo                         IN VARCHAR2  -- 交易摘要
  , i_buyer_booking_amt                IN NUMBER    -- 買方預佔額度
  , i_buyer_booking_drawdown_amt       IN NUMBER    -- 買方預佔額度已動用金額
  , i_drawdown_edate                   IN VARCHAR2  -- 最晚動用日期
  , i_drawdown_date                    IN VARCHAR2  -- 動用日期
  , o_limit_buyer_booking_seq_no       OUT NUMBER   -- 買方預佔額度序號
  ) AS
  BEGIN
    o_limit_buyer_booking_seq_no := i_limit_buyer_booking_seq_no;
    UPDATE EDLS.TB_LIMIT_BUYER_BOOKING
    SET CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
    , TXN_DATE = i_txn_date
    , TXN_SNO = i_txn_sno
    , TXN_TIME = i_txn_time
    , TXN_BRANCH = i_txn_branch
    , HOST_SNO = i_host_sno
    , SUP_CARD = i_sup_card
    , TXN_ID = i_txn_id
    , TXN_MEMO = i_txn_memo
    , BUYER_BOOKING_AMT = i_buyer_booking_amt
    , BUYER_BOOKING_DRAWDOWN_AMT = i_buyer_booking_drawdown_amt
    , DRAWDOWN_EDATE = i_drawdown_edate
    , DRAWDOWN_DATE = i_drawdown_date
    , AMEND_DATE = SYSTIMESTAMP
    WHERE LIMIT_BUYER_BOOKING_SEQ_NO = i_limit_buyer_booking_seq_no;
  END SP_UPD_LIMIT_BUYER_BOOKING;

--**************************************************************************
-- SP_GET_LIMIT_BUYER_S_RELATED
-- Purpose: 查詢關聯的買方共用額度，並排除自身更新前關聯
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER_S_RELATED
  ( i_limit_buyer_share_seq_no IN NUMBER         -- 買方共用額度主檔序號
  , i_cust_id                  IN VARCHAR2       -- 銀行歸戶統編
  , o_cur                      OUT SYS_REFCURSOR -- 回傳資料 
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT lbs.LIMIT_BUYER_SHARE_SEQ_NO
    , lbs.CUSTOMER_LOAN_SEQ_NO
    , lbs.APPR_LIMIT_AMT
    , lbs.MATU_DATE
    FROM EDLS.TB_LIMIT_BUYER_SHARE lbs 
    INNER JOIN EDLS.TB_CUSTOMER_LOAN cl
      ON lbs.CUSTOMER_LOAN_SEQ_NO = cl.CUSTOMER_LOAN_SEQ_NO
     WHERE cl.CUST_ID = i_cust_id
     AND LIMIT_BUYER_SHARE_SEQ_NO != i_limit_buyer_share_seq_no
     FOR UPDATE;
  END SP_GET_LIMIT_BUYER_S_RELATED;

--**************************************************************************
-- SP_GET_LIMIT_BUYER_BK_BY_CUST
-- Purpose: 查詢歸戶下買方預佔額度
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER_BK_BY_CUST
  ( i_cust_id IN VARCHAR2       -- 銀行歸戶統編
  , o_cur     OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT lbb.LIMIT_BUYER_BOOKING_SEQ_NO
      , lbb.CUSTOMER_LOAN_SEQ_NO
      , lbb.TXN_DATE
      , lbb.TXN_SNO
      , lbb.TXN_TIME
      , lbb.TXN_BRANCH
      , lbb.HOST_SNO
      , lbb.SUP_CARD
      , lbb.TXN_ID
      , lbb.TXN_MEMO
      , lbb.BUYER_BOOKING_AMT
      , lbb.BUYER_BOOKING_DRAWDOWN_AMT
      , lbb.DRAWDOWN_EDATE
      , lbb.DRAWDOWN_DATE
      , lbb.CREATE_DATE
      , lbb.AMEND_DATE
    FROM EDLS.TB_LIMIT_BUYER_BOOKING lbb 
    INNER JOIN EDLS.TB_CUSTOMER_LOAN cl
      ON lbb.CUSTOMER_LOAN_SEQ_NO = cl.CUSTOMER_LOAN_SEQ_NO
    WHERE cl.CUST_ID=i_cust_id
    FOR UPDATE;
  END SP_GET_LIMIT_BUYER_BK_BY_CUST;

--**************************************************************************
-- SP_SEL_ADVHANDFEE_FK
-- Purpose: 以放款主檔序號(外鍵)查詢預收手續費資訊。
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.21  performance adjust
--**************************************************************************
  PROCEDURE SP_SEL_ADVHANDFEE_FK 
  ( i_loan_seq_no IN NUMBER         -- 放款主檔序號
  , o_cur         OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT loan_adv_handling_fee_seq_no
      , loan_seq_no
      , last_amort_date
      , total_amort_fee
      , monthly_amort_amt 
      , ccy
      , reg_doc_no
      , reg_date
      , reg_host_sno
      , reg_txn_branch
      , reg_sup_emp_id
      , reg_teller_emp_id
      , reg_time
      , reg_sup_card
      , adv_category
      , adv_amrtiz_category
      , recov_type
      , fee_code
    --,create_date, amend_date 
    FROM EDLS.TB_LOAN_ADV_HANDLING_FEE
    WHERE loan_seq_no = i_loan_seq_no
    ORDER BY amend_date DESC;
  END SP_SEL_ADVHANDFEE_FK;

--**************************************************************************
-- SP_INS_LOAN_ADV_HANDLING_FEE
-- Purpose: 
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_LOAN_ADV_HANDLING_FEE 
  ( i_loan_seq_no          IN NUMBER   -- 放款主檔序號
  , i_last_amort_date      IN VARCHAR2 -- 最近一次的攤銷日期
  , i_total_amort_fee      IN NUMBER   -- 本帳號累積攤銷的手續費
  , i_monthly_amort_amt    IN NUMBER   -- 當月內累積攤銷的手續費
  , i_ccy                  IN VARCHAR2 -- 幣別
  , i_reg_doc_no           IN VARCHAR2 -- 登錄文件號碼
  , i_reg_date             IN VARCHAR2 -- 登錄日期
  , i_reg_host_sno         IN VARCHAR2 -- 登錄主機交易序號
  , i_reg_txn_branch       IN VARCHAR2 -- 登錄交易分行
  , i_reg_sup_emp_id       IN VARCHAR2 -- 登錄交易主管員編
  , i_reg_teller_emp_id    IN VARCHAR2 -- 登錄交易櫃員員編
  , i_reg_time             IN VARCHAR2 -- 登錄時間
  , i_reg_sup_card         IN VARCHAR2 -- 登錄授權主管卡號
  , i_adv_category         IN VARCHAR2 -- 預收手續費科目
  , i_adv_amrtiz_category  IN VARCHAR2 -- 預收攤提收入科目
  , i_recov_type           IN VARCHAR2 -- 聯貸收回方式
  , i_fee_code             IN VARCHAR2 -- 手續費代碼
  , o_seq_no               OUT NUMBER  -- 預收手續費資訊序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO ('TB_LOAN_ADV_HANDLING_FEE', o_seq_no);
    INSERT INTO EDLS.TB_loan_adv_handling_fee 
    ( LOAN_ADV_HANDLING_FEE_SEQ_NO
    , LOAN_SEQ_NO
    , LAST_AMORT_DATE
    , TOTAL_AMORT_FEE
    , MONTHLY_AMORT_AMT
    , CCY
    , REG_DOC_NO
    , REG_DATE
    , REG_HOST_SNO
    , REG_TXN_BRANCH
    , REG_SUP_EMP_ID
    , REG_TELLER_EMP_ID
    , REG_TIME
    , REG_SUP_CARD
    , ADV_CATEGORY
    , ADV_AMRTIZ_CATEGORY
    , RECOV_TYPE
    , FEE_CODE
    , create_date
    , amend_date
    )
    VALUES 
    ( o_seq_no
    , i_loan_seq_no
    , i_last_amort_date
    , i_total_amort_fee
    , i_monthly_amort_amt
    , i_ccy
    , i_reg_doc_no
    , i_reg_date
    , i_reg_host_sno
    , i_reg_txn_branch
    , i_reg_sup_emp_id
    , i_reg_teller_emp_id
    , i_reg_time
    , i_reg_sup_card
    , i_adv_category
    , i_adv_amrtiz_category
    , i_recov_type
    , i_fee_code
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
  END SP_INS_LOAN_ADV_HANDLING_FEE;

--**************************************************************************
-- SP_UPD_LOAN_ADV_HANDLING_FEE
-- Purpose: 
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************    
  PROCEDURE SP_UPD_LOAN_ADV_HANDLING_FEE 
  ( i_loan_adv_handling_fee_seq_no IN NUMBER   -- 預收手續費資訊序號
  , i_loan_seq_no                  IN NUMBER   -- 放款主檔序號
  , i_last_amort_date              IN VARCHAR2 -- 最近一次的攤銷日期
  , i_total_amort_fee              IN NUMBER   -- 本帳號累積攤銷的手續費
  , i_monthly_amort_amt            IN NUMBER   -- 當月內累積攤銷的手續費
  , i_ccy                          IN VARCHAR2 -- 幣別
  , i_reg_doc_no                   IN VARCHAR2 -- 登錄文件號碼
  , i_reg_date                     IN VARCHAR2 -- 登錄日期
  , i_reg_host_sno                 IN VARCHAR2 -- 登錄主機交易序號
  , i_reg_txn_branch               IN VARCHAR2 -- 登錄交易分行
  , i_reg_sup_emp_id               IN VARCHAR2 -- 登錄交易主管員編
  , i_reg_teller_emp_id            IN VARCHAR2 -- 登錄交易櫃員員編
  , i_reg_time                     IN VARCHAR2 -- 登錄時間
  , i_reg_sup_card                 IN VARCHAR2 -- 登錄授權主管卡號
  , i_adv_category                 IN VARCHAR2 -- 預收手續費科目
  , i_adv_amrtiz_category          IN VARCHAR2 -- 預收攤提收入科目
  , i_recov_type                   IN VARCHAR2 -- 聯貸收回方式
  , i_fee_code                     IN VARCHAR2 -- 手續費代碼
  , o_row_count                    OUT NUMBER  -- 異動筆數
  ) AS
  BEGIN
    UPDATE EDLS.TB_LOAN_ADV_HANDLING_FEE 
    SET LOAN_SEQ_NO = i_loan_seq_no
    , LAST_AMORT_DATE = i_last_amort_date
    , TOTAL_AMORT_FEE = i_total_amort_fee
    , MONTHLY_AMORT_AMT = i_monthly_amort_amt
    , CCY = i_ccy
    , REG_DOC_NO = i_reg_doc_no
    , REG_DATE = i_reg_date
    , REG_HOST_SNO = i_reg_host_sno
    , REG_TXN_BRANCH = i_reg_txn_branch
    , REG_SUP_EMP_ID = i_reg_sup_emp_id
    , REG_TELLER_EMP_ID = i_reg_teller_emp_id
    , REG_TIME = i_reg_time
    , REG_SUP_CARD = i_reg_sup_card
    , ADV_CATEGORY = i_adv_category
    , ADV_AMRTIZ_CATEGORY = i_adv_amrtiz_category
    , RECOV_TYPE = i_recov_type
    , FEE_CODE = i_fee_code
    , AMEND_DATE = SYSTIMESTAMP
    WHERE LOAN_ADV_HANDLING_FEE_SEQ_NO = i_loan_adv_handling_fee_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_LOAN_ADV_HANDLING_FEE;

--**************************************************************************
-- SP_INS_LOAN_SYNDEST_RECOV_PRNP
-- Purpose: 
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_LOAN_SYNDEST_RECOV_PRNP 
  ( i_join_bank_fee_amortiz_seq_no IN NUMBER   -- 預收手續費資訊序號
  , i_sno                          IN NUMBER   -- 序號
  , i_est_recov_prnp_sdate         IN VARCHAR2 -- 預估本金收回起始日期
  , i_est_recov_prnp_amt           IN NUMBER   -- 預估本金收回金額
  , i_est_recov_prnp_perc          IN NUMBER   -- 預估本金收回百分比
  , i_est_recov_prnp_cnt           IN NUMBER   -- 預估本金還款次數
  , i_est_recov_prnp_freq          IN NUMBER   -- 預估本金收回週期
  , o_row_count                    OUT NUMBER  -- 聯貸案預估可回收本金資料檔序號
  )AS
  BEGIN
    INSERT INTO EDLS.TB_synd_est_recov_prnp 
    ( join_bank_fee_amortiz_seq_no
    , sno
    , est_recov_prnp_sdate
    , est_recov_prnp_amt
    , est_recov_prnp_perc
    , est_recov_prnp_cnt
    , est_recov_prnp_freq
    , create_date
    , amend_date
    )
    VALUES 
    ( i_join_bank_fee_amortiz_seq_no
    , i_sno
    , i_est_recov_prnp_sdate
    , i_est_recov_prnp_amt
    , i_est_recov_prnp_perc
    , i_est_recov_prnp_cnt
    , i_est_recov_prnp_freq
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
    o_row_count := SQL%ROWCOUNT;
  END SP_INS_LOAN_SYNDEST_RECOV_PRNP;

--**************************************************************************
-- SP_UPD_LOAN_SYNDEST_RECOV_PRNP
-- Purpose: 
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_UPD_LOAN_SYNDEST_RECOV_PRNP 
  ( i_join_bank_fee_amortiz_seq_no IN NUMBER   -- 預收手續費資訊序號
  , i_sno                          IN NUMBER   -- 序號
  , i_est_recov_prnp_sdate         IN VARCHAR2 -- 預估本金收回起始日期
  , i_est_recov_prnp_amt           IN NUMBER   -- 預估本金收回金額
  , i_est_recov_prnp_perc          IN NUMBER   -- 預估本金收回百分比
  , i_est_recov_prnp_cnt           IN NUMBER   -- 預估本金還款次數
  , i_est_recov_prnp_freq          IN NUMBER   -- 預估本金收回週期
  , o_row_count                    OUT NUMBER  -- 更新筆數
  ) AS
  BEGIN
    UPDATE EDLS.TB_synd_est_recov_prnp 
    SET 
      sno = i_sno
    , est_recov_prnp_sdate = i_est_recov_prnp_sdate
    , est_recov_prnp_amt = i_est_recov_prnp_amt
    , est_recov_prnp_perc = i_est_recov_prnp_perc
    , est_recov_prnp_cnt = i_est_recov_prnp_cnt
    , est_recov_prnp_freq = i_est_recov_prnp_freq
    , amend_date = SYSTIMESTAMP
    WHERE join_bank_fee_amortiz_seq_no = i_join_bank_fee_amortiz_seq_no
      AND sno = i_sno;
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_LOAN_SYNDEST_RECOV_PRNP;


--**************************************************************************
-- SP_GET_LOAN_SYNDEST_RECOV_PRNP
-- Purpose: 
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LOAN_SYNDEST_RECOV_PRNP 
  ( i_join_bank_fee_amortiz_seq_no IN NUMBER         -- 預收手續費資訊序號
  , o_cur                          OUT SYS_REFCURSOR -- 回傳資料 
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT join_bank_fee_amortiz_seq_no, sno
       , est_recov_prnp_sdate
       , est_recov_prnp_amt
       , est_recov_prnp_perc
       , est_recov_prnp_cnt
       , est_recov_prnp_freq
       , create_date
       , amend_date
    FROM EDLS.TB_SYND_EST_RECOV_PRNP
    WHERE JOIN_BANK_FEE_AMORTIZ_SEQ_NO = i_join_bank_fee_amortiz_seq_no;
  END SP_GET_LOAN_SYNDEST_RECOV_PRNP;

--**************************************************************************
-- SP_GET_ADVHANDFEE_FK_FCODE
-- Purpose: 查詢預收手續費資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--************************************************************************** 
  PROCEDURE SP_GET_ADVHANDFEE_FK_FCODE 
  ( i_loan_seq_no IN NUMBER         -- 預收手續費資訊序號
  , i_fee_code    IN VARCHAR2       -- 手續費代碼
  , o_cur         OUT SYS_REFCURSOR -- 回傳資料
  ) AS
 BEGIN
  OPEN o_cur FOR
  SELECT LOAN_ADV_HANDLING_FEE_SEQ_NO
        , LOAN_SEQ_NO
        , LAST_AMORT_DATE
        , TOTAL_AMORT_FEE
        , MONTHLY_AMORT_AMT
        , CCY
        , REG_DOC_NO
        , REG_DATE
        , REG_HOST_SNO
        , REG_TXN_BRANCH
        , REG_SUP_EMP_ID
        , REG_TELLER_EMP_ID
        , REG_TIME
        , REG_SUP_CARD
        , ADV_CATEGORY
        , ADV_AMRTIZ_CATEGORY
        , RECOV_TYPE
        , FEE_CODE
        , create_date
        , amend_date
   FROM EDLS.TB_loan_adv_handling_fee
   WHERE loan_seq_no = i_loan_seq_no
    AND fee_code = i_fee_code;
 END SP_GET_ADVHANDFEE_FK_FCODE;

 -- PROCEDURE SP_DEL_LOAN_SYNDEST_RECOV_PRNP (i_join_bank_fee_amortiz_seq_no IN NUMBER, i_sno IN NUMBER, i_est_recov_prnp_sdate IN VARCHAR2, i_est_recov_prnp_amt IN NUMBER, i_est_recov_prnp_perc IN NUMBER, i_est_recov_prnp_cnt IN NUMBER, i_est_recov_prnp_freq IN NUMBER, o_row_count OUT NUMBER) AS
--**************************************************************************
-- SP_DEL_LOAN_SYNDEST_RECOV_PRNP
-- Purpose: 刪除聯貸案預估可回收本金資料檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_LOAN_SYNDEST_RECOV_PRNP 
  ( i_join_bank_fee_amortiz_seq_no IN NUMBER  -- 預收手續費資訊序號
  , o_row_count                    OUT NUMBER -- 刪除筆數
  ) AS
  BEGIN
    DELETE FROM EDLS.TB_synd_est_recov_prnp
    WHERE join_bank_fee_amortiz_seq_no = i_join_bank_fee_amortiz_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_LOAN_SYNDEST_RECOV_PRNP;

--**************************************************************************
-- SP_INS_RRSAC_AUTO_TRANS
-- Purpose: 新增備償專戶自動轉帳登錄
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_RRSAC_AUTO_TRANS 
  ( i_customer_loan_seq_no IN NUMBER   -- 授信戶主檔序號
  , i_rrsac_acc_no         IN VARCHAR2 -- 備償專戶帳號
  , i_to_saving_acc_no     IN VARCHAR2 -- 轉入帳號
  , i_the_lowest_trans_amt IN NUMBER   -- 最低轉帳金額
  , i_open_setting         IN VARCHAR2 -- 開放設定
  , i_open_setting_date    IN VARCHAR2 -- 開放設定日期
  , i_trans_unit           IN VARCHAR2 -- 每筆轉帳單位
  , i_net_notes            IN NUMBER   -- 票據淨額
  , o_seq_no               OUT NUMBER  -- 備償專戶自動轉帳登錄序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO ('TB_RRSAC_AUTO_TRANSFER', o_seq_no);

    INSERT INTO EDLS.TB_RRSAC_AUTO_TRANSFER
    ( RRSAC_AUTO_TRANSFER_SEQ_NO
    , CUSTOMER_LOAN_SEQ_NO
    , RRSAC_ACC_SEQ_NO
    , TO_SAVING_ACC_SEQ_NO
    , THE_LOWEST_TRANS_AMT
    , OPEN_SETTING
    , OPEN_SETTING_DATE
    , TRANS_UNIT
    , NET_NOTES
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_seq_no
    , i_customer_loan_seq_no
    , i_rrsac_acc_no
    , i_to_saving_acc_no
    , i_the_lowest_trans_amt
    , i_open_setting
    , i_open_setting_date
    , i_trans_unit
    , i_net_notes
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
  END SP_INS_RRSAC_AUTO_TRANS;

--**************************************************************************
-- SP_GET_RRSAC_AUTO_TRANS
-- Purpose: 以備償帳號查詢授信戶主檔下關聯之備償專戶自動轉帳登錄資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_RRSAC_AUTO_TRANS 
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , i_rrsac_acc_no         IN VARCHAR2       -- 備償專戶帳號
  , o_cur                  OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT RRSAC_AUTO_TRANSFER_SEQ_NO
     , CUSTOMER_LOAN_SEQ_NO
     , RRSAC_ACC_SEQ_NO
     , TO_SAVING_ACC_SEQ_NO
     , THE_LOWEST_TRANS_AMT
     , OPEN_SETTING
     , OPEN_SETTING_DATE
     , TRANS_UNIT
     , NET_NOTES
     , CREATE_DATE
     , AMEND_DATE
    FROM EDLS.TB_RRSAC_AUTO_TRANSFER
    WHERE CUSTOMER_LOAN_SEQ_NO = nvl(i_customer_loan_seq_no, CUSTOMER_LOAN_SEQ_NO) 
    AND RRSAC_ACC_SEQ_NO = nvl(i_rrsac_acc_no, RRSAC_ACC_SEQ_NO);
  END SP_GET_RRSAC_AUTO_TRANS;

--**************************************************************************
-- SP_GET_RRSAC_AUTO_TRANS_U
-- Purpose: 以備償帳號查詢授信戶主檔下關聯之備償專戶自動轉帳登錄資料 FOR UPDATE
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_RRSAC_AUTO_TRANS_U 
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , i_rrsac_acc_no         IN VARCHAR2       -- 備償專戶帳號
  , o_cur                  OUT SYS_REFCURSOR -- 回傳資料 
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT RRSAC_AUTO_TRANSFER_SEQ_NO
      , CUSTOMER_LOAN_SEQ_NO
      , RRSAC_ACC_SEQ_NO
      , TO_SAVING_ACC_SEQ_NO
      , THE_LOWEST_TRANS_AMT
      , OPEN_SETTING
      , OPEN_SETTING_DATE
      , TRANS_UNIT
      , NET_NOTES
      , CREATE_DATE
      , AMEND_DATE
    FROM EDLS.TB_RRSAC_AUTO_TRANSFER
    WHERE CUSTOMER_LOAN_SEQ_NO = nvl(i_customer_loan_seq_no, CUSTOMER_LOAN_SEQ_NO) 
    AND RRSAC_ACC_SEQ_NO = i_rrsac_acc_no
    FOR UPDATE;
  END SP_GET_RRSAC_AUTO_TRANS_U;

--**************************************************************************
-- SP_UPD_RRSAC_AUTO_TRANS
-- Purpose: 更新備償專戶自動轉帳登錄資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_UPD_RRSAC_AUTO_TRANS 
  ( i_rrsac_auto_transfer_seq_no IN NUMBER   -- 備償專戶自動轉帳登錄序號
  , i_customer_loan_seq_no       IN NUMBER   -- 授信戶主檔序號
  , i_rrsac_acc_no               IN VARCHAR2 -- 備償專戶帳號
  , i_to_saving_acc_no           IN VARCHAR2 -- 轉入帳號
  , i_the_lowest_trans_amt       IN NUMBER   -- 最低轉帳金額
  , i_open_setting               IN VARCHAR2 -- 開放設定
  , i_open_setting_date          IN VARCHAR2 -- 開放設定日期
  , i_trans_unit                 IN VARCHAR2 -- 每筆轉帳單位
  , i_net_notes                  IN NUMBER   -- 票據淨額
  , o_row_count                  OUT NUMBER  -- 異動筆數 
  ) AS
  BEGIN
    UPDATE EDLS.TB_RRSAC_AUTO_TRANSFER SET 
    CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no,
    RRSAC_ACC_SEQ_NO = i_rrsac_acc_no,
    TO_SAVING_ACC_SEQ_NO = i_to_saving_acc_no,
    THE_LOWEST_TRANS_AMT = i_the_lowest_trans_amt,
    OPEN_SETTING = i_open_setting,
    OPEN_SETTING_DATE = i_open_setting_date,
    TRANS_UNIT = i_trans_unit,
    NET_NOTES = i_net_notes,
    AMEND_DATE = SYSTIMESTAMP
    WHERE RRSAC_AUTO_TRANSFER_SEQ_NO = i_rrsac_auto_transfer_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_RRSAC_AUTO_TRANS; 

--**************************************************************************
-- SP_DEL_RRSAC_AUTO_TRANS
-- Purpose: 刪除備償專戶自動轉帳登錄資料(修改STATUS)
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_RRSAC_AUTO_TRANS 
  ( i_rrsac_auto_transfer_seq_no IN NUMBER  -- 備償專戶自動轉帳登錄序號
  , o_row_count                  OUT NUMBER -- 刪除筆數
  ) AS
  BEGIN
    DELETE EDLS.TB_RRSAC_AUTO_TRANSFER
    WHERE RRSAC_AUTO_TRANSFER_SEQ_NO = i_rrsac_auto_transfer_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_RRSAC_AUTO_TRANS; 

--**************************************************************************
-- SP_INS_RRSAC_AUTO_TRANS_PROF
-- Purpose: 新增備償專戶自動轉帳設定資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_RRSAC_AUTO_TRANS_PROF 
  ( i_rrsac_auto_transfer_seq_no IN NUMBER   -- 備償專戶自動轉帳登錄序號
  , i_limit_seq_no               IN NUMBER   -- 分項額度主檔序號 
  , i_appr_doc_seq_no            IN NUMBER   -- 批覆書主檔序號
  , i_first_level_amt            IN NUMBER   -- 第一層金額
  , i_first_level_percent        IN NUMBER   -- 第一層成數
  , i_second_level_amt           IN NUMBER   -- 第二層金額 
  , i_second_level_percent       IN NUMBER   -- 第二層成數
  , i_ccy                        IN VARCHAR2 -- 幣別
  , o_seq_no                     OUT NUMBER  -- 備償專戶自動轉帳設定檔序號 
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO ('TB_RRSAC_AUTO_TRANSFER_PROF', o_seq_no);
    INSERT INTO EDLS.TB_RRSAC_AUTO_TRANSFER_PROF
    ( RRSAC_AUTO_TRANS_PROF_SEQ_NO
    , RRSAC_AUTO_TRANSFER_SEQ_NO
    , LIMIT_SEQ_NO
    , APPR_DOC_SEQ_NO
    , FIRST_LEVEL_AMT
    , FIRST_LEVEL_PERCENT
    , SECOND_LEVEL_AMT
    , SECOND_LEVEL_PERCENT
    , CCY
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_seq_no
    , i_rrsac_auto_transfer_seq_no
    , i_limit_seq_no
    , i_appr_doc_seq_no
    , i_first_level_amt
    , i_first_level_percent
    , i_second_level_amt
    , i_second_level_percent
    , i_ccy
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
  END SP_INS_RRSAC_AUTO_TRANS_PROF;

--**************************************************************************
-- SP_GET_RRSAC_AUTO_TRANS_PROF
-- Purpose: 以批覆書及分項額度查詢備償專戶自動轉帳登錄下關聯之備償專戶自動轉帳設定資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_RRSAC_AUTO_TRANS_PROF 
  ( i_rrsac_auto_transfer_seq_no IN NUMBER         -- 備償專戶自動轉帳登錄序號
  , i_limit_seq_no               IN NUMBER         -- 分項額度主檔序號
  , i_appr_doc_seq_no            IN NUMBER         -- 批覆書主檔序號
  , o_cur                        OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT RRSAC_AUTO_TRANS_PROF_SEQ_NO
     , RRSAC_AUTO_TRANSFER_SEQ_NO
      , LIMIT_SEQ_NO
      , APPR_DOC_SEQ_NO
      , FIRST_LEVEL_AMT
      , FIRST_LEVEL_PERCENT
      , SECOND_LEVEL_AMT
      , SECOND_LEVEL_PERCENT
      , CCY
      , CREATE_DATE
      , AMEND_DATE
    FROM EDLS.TB_RRSAC_AUTO_TRANSFER_PROF
    WHERE RRSAC_AUTO_TRANSFER_SEQ_NO = i_rrsac_auto_transfer_seq_no AND
    APPR_DOC_SEQ_NO = i_appr_doc_seq_no 
	AND LIMIT_SEQ_NO = i_limit_seq_no;
  END SP_GET_RRSAC_AUTO_TRANS_PROF;

--**************************************************************************
-- SP_GET_RRSAC_AUTO_TRANS_PROF_U
-- Purpose: 以批覆書及分項額度查詢備償專戶自動轉帳登錄下關聯之備償專戶自動轉帳設定資料 FOR UPDATE
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_RRSAC_AUTO_TRANS_PROF_U 
  ( i_rrsac_auto_transfer_seq_no IN NUMBER         -- 備償專戶自動轉帳登錄序號
  , i_limit_seq_no               IN NUMBER         -- 分項額度主檔序號
  , i_appr_doc_seq_no            IN NUMBER         -- 批覆書主檔序號
  , o_cur                        OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT RRSAC_AUTO_TRANS_PROF_SEQ_NO
      , RRSAC_AUTO_TRANSFER_SEQ_NO
      , LIMIT_SEQ_NO
      , APPR_DOC_SEQ_NO
      , FIRST_LEVEL_AMT
      , FIRST_LEVEL_PERCENT
      , SECOND_LEVEL_AMT
      , SECOND_LEVEL_PERCENT
      , CCY
      , CREATE_DATE
      , AMEND_DATE
    FROM EDLS.TB_RRSAC_AUTO_TRANSFER_PROF
    WHERE RRSAC_AUTO_TRANSFER_SEQ_NO = i_rrsac_auto_transfer_seq_no 
    AND APPR_DOC_SEQ_NO = i_appr_doc_seq_no 
    AND LIMIT_SEQ_NO = i_limit_seq_no 
    FOR UPDATE;
  END SP_GET_RRSAC_AUTO_TRANS_PROF_U;

--**************************************************************************
-- SP_GET_RRSAC_AUTO_TRANS_PROFS
-- Purpose: 取得備償專戶自動轉帳登錄下所有自動轉帳設定資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_RRSAC_AUTO_TRANS_PROFS
  ( i_rrsac_auto_transfer_seq_no IN NUMBER         -- 備償專戶自動轉帳登錄序號
  , o_cur                        OUT SYS_REFCURSOR -- 回傳資料  
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT RRSAC_AUTO_TRANS_PROF_SEQ_NO
     , RRSAC_AUTO_TRANSFER_SEQ_NO
     , LIMIT_SEQ_NO
     , APPR_DOC_SEQ_NO
     , FIRST_LEVEL_AMT
     , FIRST_LEVEL_PERCENT
     , SECOND_LEVEL_AMT
     , SECOND_LEVEL_PERCENT
     , CCY
     , CREATE_DATE
     , AMEND_DATE
    FROM EDLS.TB_RRSAC_AUTO_TRANSFER_PROF
    WHERE RRSAC_AUTO_TRANSFER_SEQ_NO = i_rrsac_auto_transfer_seq_no;
  END SP_GET_RRSAC_AUTO_TRANS_PROFS;

--**************************************************************************
-- SP_UPD_RRSAC_AUTO_TRANS_PROF
-- Purpose: 更新備償專戶自動轉帳設定資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_UPD_RRSAC_AUTO_TRANS_PROF 
  ( i_rrsac_auto_trans_prof_seq_no IN NUMBER   -- 備償專戶自動轉帳設定檔序號
  , i_rrsac_auto_transfer_seq_no   IN NUMBER   -- 備償專戶自動轉帳登錄序號
  , i_limit_seq_no                 IN NUMBER   -- 分項額度主檔序號
  , i_appr_doc_seq_no              IN NUMBER   -- 批覆書主檔序號
  , i_first_level_amt              IN NUMBER   -- 第一層金額
  , i_first_level_percent          IN NUMBER   -- 第一層成數
  , i_second_level_amt             IN NUMBER   -- 第二層金額 
  , i_second_level_percent         IN NUMBER   -- 第二層成數
  , i_ccy                          IN VARCHAR2 -- 幣別
  , o_row_count                    OUT NUMBER  -- 異動筆數
  ) AS
  BEGIN
    UPDATE EDLS.TB_RRSAC_AUTO_TRANSFER_PROF SET 
    RRSAC_AUTO_TRANSFER_SEQ_NO = i_rrsac_auto_transfer_seq_no,
    LIMIT_SEQ_NO = i_limit_seq_no,
    APPR_DOC_SEQ_NO = i_appr_doc_seq_no,
    FIRST_LEVEL_AMT = i_first_level_amt,
    FIRST_LEVEL_PERCENT = i_first_level_percent,
    SECOND_LEVEL_AMT = i_second_level_amt,
    SECOND_LEVEL_PERCENT = i_second_level_percent,
    CCY = i_ccy,
    AMEND_DATE = SYSTIMESTAMP
    WHERE RRSAC_AUTO_TRANS_PROF_SEQ_NO = i_rrsac_auto_trans_prof_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_RRSAC_AUTO_TRANS_PROF;

--**************************************************************************
-- SP_DEL_RRSAC_AUTO_TRANS_PROF
-- Purpose: 刪除備償專戶自動轉帳登錄項下所有備償專戶自動轉帳設定資料(修改STATUS)
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_RRSAC_AUTO_TRANS_PROF 
  ( i_rrsac_auto_transfer_seq_no IN NUMBER  -- 備償專戶自動轉帳設定檔序號
  , o_row_count                  OUT NUMBER -- 刪除筆數
  ) AS
  BEGIN
    DELETE EDLS.TB_RRSAC_AUTO_TRANSFER_PROF
    WHERE RRSAC_AUTO_TRANSFER_SEQ_NO = i_rrsac_auto_transfer_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_RRSAC_AUTO_TRANS_PROF;

--*************************************************************************
-- SP_INS_GUARANTOR
-- Purpose: 新增[保證人資料檔]資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2018.11.26  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_GUARANTOR
  ( i_appr_doc_seq_no                  IN NUMBER   -- 批覆書主檔序號
  , i_limit_seq_no                     IN NUMBER   -- 分項額度主檔序號
  , i_customer_loan_seq_no             IN NUMBER   -- 授信戶主檔序號
  , i_identity_code                    IN VARCHAR2 -- 相關身份代號
  , i_country                          IN VARCHAR2 -- 保證人國別
  , i_phase                            IN VARCHAR2 -- 保證狀態
  , i_cancel_reason_mk                 IN VARCHAR2 -- 解除原因註記
  , i_percentage                       IN NUMBER   -- 保證比率
  , i_relationship_code                IN VARCHAR2 -- 與主債務人關係
  , i_relation_with_min_debtor         IN VARCHAR2 -- 與主債務人次要關係
  , i_is_finan_instit                  IN VARCHAR2 -- 金融機構註記
  , i_change_date                      IN VARCHAR2 -- 異動日期
  , i_bind_all_mark                    IN VARCHAR2 -- 綁定整張註記
  , o_guarantor_seq_no                 OUT  NUMBER -- 回傳保證人序號
  )AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_GUARANTOR', o_guarantor_seq_no);
    INSERT INTO EDLS.TB_GUARANTOR
    ( GUARANTOR_SEQ_NO
    , APPR_DOC_SEQ_NO
    , LIMIT_SEQ_NO
    , CUSTOMER_LOAN_SEQ_NO
    , IDENTITY_CODE
    , COUNTRY
    , PHASE
    , CANCEL_REASON_MK
    , PERCENTAGE
    , RELATIONSHIP_CODE
    , RELATION_WITH_MIN_DEBTOR
    , IS_FINAN_INSTIT
    , BIND_ALL_MARK 
    , CHANGE_DATE
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES 
    ( o_guarantor_seq_no
    , i_appr_doc_seq_no
    , i_limit_seq_no
    , i_customer_loan_seq_no
    , i_identity_code
    , i_country
    , i_phase
    , i_cancel_reason_mk
    , i_percentage
    , i_relationship_code
    , i_relation_with_min_debtor
    , i_is_finan_instit
    , i_bind_all_mark
    , i_change_date
    , systimestamp
    , systimestamp
    );
  END SP_INS_GUARANTOR;

--*************************************************************************
-- SP_GET_GUARANTOR_BY_PK
-- Purpose: 使用保證人資料檔序號取得[保證人資料檔]資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2018.11.26  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_GUARANTOR_BY_PK
  ( i_guarantor_seq_no IN      NUMBER         --保證人資料檔序號
  , o_cur              OUT     SYS_REFCURSOR  --回傳資料
  ) AS
  BEGIN
    open o_cur FOR
    SELECT GUARANTOR_SEQ_NO
    , APPR_DOC_SEQ_NO
    , LIMIT_SEQ_NO
    , CUSTOMER_LOAN_SEQ_NO
    , IDENTITY_CODE
    , COUNTRY
    , PHASE
    , CANCEL_REASON_MK
    , PERCENTAGE
    , RELATIONSHIP_CODE
    , RELATION_WITH_MIN_DEBTOR
    , IS_FINAN_INSTIT
    , CHANGE_DATE
    , BIND_ALL_MARK
    FROM EDLS.TB_GUARANTOR
    WHERE GUARANTOR_SEQ_NO = i_guarantor_seq_no
    FOR UPDATE;
  END SP_GET_GUARANTOR_BY_PK; 

--*************************************************************************
-- SP_GET_GUARANTOR
-- Purpose: 取得[保證人資料檔]資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2018.11.26  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_GUARANTOR
  ( i_appr_doc_seq_no IN  NUMBER        --批覆書主檔序號
  , i_limit_seq_no    IN  NUMBER        --分項額度主檔序號
  , o_cur             OUT SYS_REFCURSOR --回傳資料
  ) AS
  BEGIN
    open o_cur FOR
    SELECT GUARANTOR_SEQ_NO
      , APPR_DOC_SEQ_NO
      , LIMIT_SEQ_NO
      , CUSTOMER_LOAN_SEQ_NO
      , IDENTITY_CODE
      , COUNTRY
      , PHASE
      , CANCEL_REASON_MK
      , PERCENTAGE
      , RELATIONSHIP_CODE
      , RELATION_WITH_MIN_DEBTOR
      , IS_FINAN_INSTIT
      , CHANGE_DATE
      , BIND_ALL_MARK
    FROM EDLS.TB_GUARANTOR
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no
     AND (i_limit_seq_no IS NULL OR LIMIT_SEQ_NO = i_limit_seq_no)
    ORDER BY GUARANTOR_SEQ_NO, APPR_DOC_SEQ_NO, LIMIT_SEQ_NO;
  END SP_GET_GUARANTOR; 

--*************************************************************************
-- SP_UPD_GUARANTOR
-- Purpose: 更新[保證人資料檔]資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 吳筠宜   2018.11.26 created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_UPD_GUARANTOR
  ( i_guarantor_seq_no                 IN NUMBER   -- 保證人資料檔序號
  , i_appr_doc_seq_no                  IN NUMBER   -- 批覆書主檔序號
  , i_limit_seq_no                     IN NUMBER   -- 分項額度主檔序號
  , i_customer_loan_seq_no             IN NUMBER   -- 授信戶主檔序號
  , i_identity_code                    IN VARCHAR2 -- 相關身份代號
  , i_country                          IN VARCHAR2 -- 保證人國別
  , i_phase                            IN VARCHAR2 -- 保證狀態
  , i_cancel_reason_mk                 IN VARCHAR2 -- 解除原因註記
  , i_percentage                       IN NUMBER   -- 保證比率
  , i_relationship_code                IN VARCHAR2 -- 與主債務人關係
  , i_relation_with_min_debtor         IN VARCHAR2 -- 與主債務人次要關係
  , i_is_finan_instit                  IN VARCHAR2 -- 金融機構註記
  , i_change_date                      IN VARCHAR2 -- 異動日期
  , i_bind_all_mark                    IN VARCHAR2 -- 綁定整張註記
  , o_modify_count              out  NUMBER        -- 回傳更新筆數
  ) AS
  BEGIN
   UPDATE EDLS.TB_GUARANTOR
   SET APPR_DOC_SEQ_NO = i_appr_doc_seq_no, 
    LIMIT_SEQ_NO = i_limit_seq_no, 
    CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no, 
    IDENTITY_CODE = i_identity_code, 
    COUNTRY = i_country, 
    PHASE = i_phase, 
    CANCEL_REASON_MK = i_cancel_reason_mk, 
    PERCENTAGE = i_percentage, 
    RELATIONSHIP_CODE = i_relationship_code, 
    RELATION_WITH_MIN_DEBTOR = i_relation_with_min_debtor, 
    IS_FINAN_INSTIT = i_is_finan_instit, 
    CHANGE_DATE = i_change_date, 
    BIND_ALL_MARK = i_bind_all_mark, 
   AMEND_DATE = systimestamp
   WHERE GUARANTOR_SEQ_NO = i_guarantor_seq_no;
   o_modify_count:=SQL%ROWCOUNT;
  END SP_UPD_GUARANTOR;   


--*************************************************************************
-- SP_DEL_GUARANTOR_BY_PK
-- Purpose: 刪除[保證人資料檔]資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2018.11.26  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_GUARANTOR_BY_PK
  ( i_guarantor_seq_no             IN      NUMBER -- 保證人資料檔序號
  , o_count                        OUT     NUMBER -- 回傳更新筆數
  ) AS
  BEGIN
    DELETE 
    FROM EDLS.TB_GUARANTOR
    WHERE GUARANTOR_SEQ_NO = i_guarantor_seq_no;
    o_count:=SQL%ROWCOUNT;
  END SP_DEL_GUARANTOR_BY_PK; 

--**************************************************************************
-- SP_GET_LIMIT_BY_FK
-- Purpose: 透過[批覆書主檔序號]取得分項額度主檔資訊。
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************  
  PROCEDURE SP_GET_LIMIT_BY_FK
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  ,  o_cur            OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    open o_cur FOR
    SELECT LIMIT_SEQ_NO
      , APPR_DOC_SEQ_NO
      , LIMIT_TYPE
      , SERIAL_NO
      , BUSINESS_TYPE
      , BUSINESS_CODE
      , PERIOD_TYPE
      , IS_GUARANTEED
      , CCY_TYPE
      , RIGHT_MK
      , IS_FORWARD
      , CURRENCY
      , APPRD_SUB_LIMIT_AMT
      , LIMIT_DRAWDOWN_TYPE
      , PHASE
    FROM EDLS.TB_LIMIT
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no;
  END SP_GET_LIMIT_BY_FK; 

--**************************************************************************
-- SP_GET_APPR_DOC_BY_CUST_KEY
-- Purpose: 查詢批覆書主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************  
  PROCEDURE SP_GET_APPR_DOC_BY_CUST_KEY
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , i_appr_doc_no          IN VARCHAR2       -- 批覆書編號
  , o_cur                  OUT SYS_REFCURSOR -- 回傳資料
  ) as
  BEGIN
    OPEN o_cur For
    Select ad.APPR_DOC_SEQ_NO
     , cl.CUSTOMER_LOAN_SEQ_NO
     , ad.APPR_DOC_NO
     , ad.PHASE
     , ad.APPRD_DATE
     , ad.MATU_DATE
     , ad.FIRST_DRAWDOWN_EDATE
     , ad.TOTAL_APPR_AMT
     , ad.TOTAL_APPR_CCY
     , ad.CHANNEL_CODE
     , ad.APPR_DRAWDOWN_TYPE
     , ad.LOAN_PURPOSE
     , ad.LOAN_ATTRIBUTES
     , ad.CCL_MK
     , ad.SOURCE_CODE
     , ad.DATA_CONVERT_SOURCE
     , ad.ACC_BRANCH
     , ad.OPER_BRANCH
     , ad.UNDER_CENTER
     , ad.APPROVER_ID
     , ad.APPRD_TYPE
     , ad.EFFEC_PERIOD
     , ad.EFFEC_UNIT
     , ad.CONTRACT_SDATE
     , ad.CONTRACT_PERIOD
     , ad.CONTRACT_UNIT
     , ad.FROM_APPR_DOC_NO
     , ad.TO_APPR_DOC_NO
     , ad.LAST_TXN_DATE
     , ad.INTER_MEDIA_BRANCH
     , ad.REPORT_BRANCH
     , ad.PROFIT_BRANCH
     , ad.FIRST_DRAWDOWN_DATE
     , ad.AUTH_DATE
     , ad.APPR_DOC_EDATE
     , ad.MPL_MORT_OVERDUE_CANCEL_MK
     , ad.APPR_DOC_SOURCE
     , ad.SYSTEM_ID
     , ad.MODIFIABLE
     , ad.CROSS_BORDER_SHARED_LIMIT_MK
     , ad.CREATE_DATE
     , ad.AMEND_DATE
    FROM TB_CUSTOMER_LOAN cl INNER JOIN EDLS.TB_APPR_DOC ad ON
	ad.CUSTOMER_LOAN_SEQ_NO = cl.CUSTOMER_LOAN_SEQ_NO
    Where 
	ad.APPR_DOC_NO = i_appr_doc_no
	AND ad.CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
  END SP_GET_APPR_DOC_BY_CUST_KEY; 

--**************************************************************************
-- SP_GET_APPR_DOC_ACTIVITYLIST
-- Purpose: 取得批覆書活動設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
-- 1.2 MARS      2019.11.20  移除FOR UPDATE
--**************************************************************************  
  PROCEDURE SP_GET_APPR_DOC_ACTIVITYLIST
  ( i_appr_doc_seq_no IN NUMBER          -- 批覆書主檔序號
  , o_cur             OUT SYS_REFCURSOR  -- 回傳資料
  ) AS
  BEGIN
    open o_cur FOR
    SELECT APPR_DOC_ACTIVITY_PRO_SEQ_NO
         , APPR_DOC_SEQ_NO
         , ACTIVITY_CODE, CREATE_DATE, AMEND_DATE
      FROM EDLS.TB_APPR_DOC_ACTIVITY_PROFILE 
     WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no;
  END SP_GET_APPR_DOC_ACTIVITYLIST;

--**************************************************************************
-- SP_GET_LIMIT_PROFILE
-- Purpose: 取得分項批示條件設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************  
  PROCEDURE SP_GET_LIMIT_PROFILE
  ( i_limit_seq_no IN NUMBER         -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    open o_cur FOR
    SELECT LIMIT_PROFILE_SEQ_NO,
      LIMIT_SEQ_NO,
      BASE_RATE_TYPE,
      SPREAD_RATE,
      INTEREST_RATE,
      FEE_RATE,
      JCIC_LOAN_BIZ_CODE,
      INTEREST_RATE_TYPE,
      INTEREST_SCHEDULE_TYPE,
      APPRD_DRAWDOWN_UNIT,
      APPRD_DRAWDOWN_PERIOD,
      PURPOSE_CODE,
      LOAN_SUBCATEGORY,
      CREDIT_LOAN_PROD_CODE,
      REPAYMT_SOURCE,
      PRNP_GRACE_PERIOD,
      ALLOW_DRAWDOWN_MK,
      COLLATERAL_TYPE,
      APPR_INTST_RATE,
      PD_VALUE,
      LGD_VALUE,
      FIRST_DRAWDOWN_DATE,
      OVERDRAFT_EXT_MK,
      CREDIT_GUARA_FEE_RATE,
      PAYMT_TYPE,
      CONSIGN_PAYMT_ACC,
      INTST_UPPER_RATE,
      INTST_LOWER_RATE,
      GUARA_CALC_TYPE,
      TRANS_ACCEPT_FEE_RATE,
      SERVICE_FEE_DATA,
      DEPOSIT_PLEDGE_MK,
      CREATE_DATE,
      AMEND_DATE
    FROM TB_LIMIT_PROFILE
    WHERE limit_seq_no = i_limit_seq_no;
  END SP_GET_LIMIT_PROFILE;

--**************************************************************************
-- SP_GET_LIMIT_PROFILE
-- Purpose: 取得分項批示條件設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 ESB19400  2020.05.12  created
-- 
--**************************************************************************  
  PROCEDURE SP_GET_LIMIT_PROFILE
  ( i_limit_seq_no             IN NUMBER         -- 分項額度主檔序號
  , i_include_service_fee_data IN VARCHAR2       -- 是否包含手續費設定條款(此欄位為clob,查詢performance很差)
  , o_cur                      OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    open o_cur FOR
    SELECT LIMIT_PROFILE_SEQ_NO,
      LIMIT_SEQ_NO,
      BASE_RATE_TYPE,
      SPREAD_RATE,
      INTEREST_RATE,
      FEE_RATE,
      JCIC_LOAN_BIZ_CODE,
      INTEREST_RATE_TYPE,
      INTEREST_SCHEDULE_TYPE,
      APPRD_DRAWDOWN_UNIT,
      APPRD_DRAWDOWN_PERIOD,
      PURPOSE_CODE,
      LOAN_SUBCATEGORY,
      CREDIT_LOAN_PROD_CODE,
      REPAYMT_SOURCE,
      PRNP_GRACE_PERIOD,
      ALLOW_DRAWDOWN_MK,
      COLLATERAL_TYPE,
      APPR_INTST_RATE,
      PD_VALUE,
      LGD_VALUE,
      FIRST_DRAWDOWN_DATE,
      OVERDRAFT_EXT_MK,
      CREDIT_GUARA_FEE_RATE,
      PAYMT_TYPE,
      CONSIGN_PAYMT_ACC,
      INTST_UPPER_RATE,
      INTST_LOWER_RATE,
      GUARA_CALC_TYPE,
      TRANS_ACCEPT_FEE_RATE,
      (CASE WHEN i_include_service_fee_data = 'Y' THEN SERVICE_FEE_DATA ELSE NULL END) AS SERVICE_FEE_DATA,
      DEPOSIT_PLEDGE_MK,
      CREATE_DATE,
      AMEND_DATE
    FROM TB_LIMIT_PROFILE
    WHERE limit_seq_no = i_limit_seq_no;
  END SP_GET_LIMIT_PROFILE;

--**************************************************************************
-- SP_GET_LIMITP
-- Purpose: 查詢分項額度主檔與分項批示條件設定檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************  
  PROCEDURE SP_GET_LIMITP
  ( i_limit_seq_no IN NUMBER          -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR  -- 回傳資料
  ) AS
  BEGIN
    open o_cur FOR
    Select lt.LIMIT_SEQ_NO
      , lt.APPR_DOC_SEQ_NO
      , lt.LIMIT_TYPE
      , lt.SERIAL_NO
      , lt.BUSINESS_TYPE
      , lt.BUSINESS_CODE
      , lt.PERIOD_TYPE
      , lt.IS_GUARANTEED
      , lt.CCY_TYPE
      , lt.RIGHT_MK
      , lt.IS_FORWARD
      , lt.CURRENCY
      , lt.APPRD_SUB_LIMIT_AMT
      , lt.LIMIT_DRAWDOWN_TYPE
      , lt.PHASE
      , lp.LIMIT_PROFILE_SEQ_NO
      , lp.BASE_RATE_TYPE
      , lp.SPREAD_RATE
      , lp.INTEREST_RATE
      , lp.FEE_RATE
      , lp.JCIC_LOAN_BIZ_CODE
      , lp.INTEREST_RATE_TYPE
      , lp.INTEREST_SCHEDULE_TYPE
      , lp.APPRD_DRAWDOWN_UNIT
      , lp.APPRD_DRAWDOWN_PERIOD
      , lp.PURPOSE_CODE
      , lp.LOAN_SUBCATEGORY
      , lp.CREDIT_LOAN_PROD_CODE
      , lp.REPAYMT_SOURCE
      , lp.PRNP_GRACE_PERIOD
      , lp.ALLOW_DRAWDOWN_MK
      , lp.COLLATERAL_TYPE
      , lp.APPR_INTST_RATE
      , lp.DEPOSIT_PLEDGE_MK 
      , lp.PD_VALUE
      , lp.LGD_VALUE
      , lp.FIRST_DRAWDOWN_DATE
      , lp.OVERDRAFT_EXT_MK
      , lp.CREDIT_GUARA_FEE_RATE
      , lp.SERVICE_FEE_DATA
      , lp.PAYMT_TYPE
      , lp.CONSIGN_PAYMT_ACC
      , lp.INTST_UPPER_RATE
      , lp.INTST_LOWER_RATE
      , lp.GUARA_CALC_TYPE
      , lp.TRANS_ACCEPT_FEE_RATE
    FROM EDLS.TB_LIMIT lt JOIN EDLS.TB_LIMIT_PROFILE lp
    ON lt.LIMIT_SEQ_NO = lp.LIMIT_SEQ_NO
    WHERE lt.LIMIT_SEQ_NO = i_limit_seq_no
    FOR UPDATE;
  END SP_GET_LIMITP;

--**************************************************************************
-- SP_GET_LIMITP_NO_LOCK
-- Purpose: 查詢分項額度主檔與分項批示條件設定檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************  
  PROCEDURE SP_GET_LIMITP_NO_LOCK
  ( i_limit_seq_no IN NUMBER          -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR  -- 回傳資料
  ) AS
  BEGIN
    open o_cur FOR
    Select lt.LIMIT_SEQ_NO
      , lt.APPR_DOC_SEQ_NO
      , lt.LIMIT_TYPE
      , lt.SERIAL_NO
      , lt.BUSINESS_TYPE
      , lt.BUSINESS_CODE
      , lt.PERIOD_TYPE
      , lt.IS_GUARANTEED
      , lt.CCY_TYPE
      , lt.RIGHT_MK
      , lt.IS_FORWARD
      , lt.CURRENCY
      , lt.APPRD_SUB_LIMIT_AMT
      , lt.LIMIT_DRAWDOWN_TYPE
      , lt.PHASE
      , lp.LIMIT_PROFILE_SEQ_NO
      , lp.BASE_RATE_TYPE
      , lp.SPREAD_RATE
      , lp.INTEREST_RATE
      , lp.FEE_RATE
      , lp.JCIC_LOAN_BIZ_CODE
      , lp.INTEREST_RATE_TYPE
      , lp.INTEREST_SCHEDULE_TYPE
      , lp.APPRD_DRAWDOWN_UNIT
      , lp.APPRD_DRAWDOWN_PERIOD
      , lp.PURPOSE_CODE
      , lp.LOAN_SUBCATEGORY
      , lp.CREDIT_LOAN_PROD_CODE
      , lp.REPAYMT_SOURCE
      , lp.PRNP_GRACE_PERIOD
      , lp.ALLOW_DRAWDOWN_MK
      , lp.COLLATERAL_TYPE
      , lp.APPR_INTST_RATE
      , lp.DEPOSIT_PLEDGE_MK 
      , lp.PD_VALUE
      , lp.LGD_VALUE
      , lp.FIRST_DRAWDOWN_DATE
      , lp.OVERDRAFT_EXT_MK
      , lp.CREDIT_GUARA_FEE_RATE
      , lp.SERVICE_FEE_DATA
      , lp.PAYMT_TYPE
      , lp.CONSIGN_PAYMT_ACC
      , lp.INTST_UPPER_RATE
      , lp.INTST_LOWER_RATE
      , lp.GUARA_CALC_TYPE
      , lp.TRANS_ACCEPT_FEE_RATE
    FROM EDLS.TB_LIMIT lt
    JOIN EDLS.TB_LIMIT_PROFILE lp ON (lt.LIMIT_SEQ_NO = lp.LIMIT_SEQ_NO)
    WHERE lt.LIMIT_SEQ_NO = i_limit_seq_no;
  END SP_GET_LIMITP_NO_LOCK;

--**************************************************************************
-- SP_GET_LIMITP_NO_LOCK
-- Purpose: 查詢分項額度主檔與分項批示條件設定檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 ESB19400  2020.05.12  created
--
--**************************************************************************  
  PROCEDURE SP_GET_LIMITP_NO_LOCK
  ( i_limit_seq_no             IN NUMBER          -- 分項額度主檔序號
  , i_include_service_fee_data IN VARCHAR2        -- 是否包含手續費設定條款(此欄位為clob,查詢performance很差)
  , o_cur                      OUT SYS_REFCURSOR  -- 回傳資料
  ) AS
  BEGIN
    open o_cur FOR
    Select lt.LIMIT_SEQ_NO
      , lt.APPR_DOC_SEQ_NO
      , lt.LIMIT_TYPE
      , lt.SERIAL_NO
      , lt.BUSINESS_TYPE
      , lt.BUSINESS_CODE
      , lt.PERIOD_TYPE
      , lt.IS_GUARANTEED
      , lt.CCY_TYPE
      , lt.RIGHT_MK
      , lt.IS_FORWARD
      , lt.CURRENCY
      , lt.APPRD_SUB_LIMIT_AMT
      , lt.LIMIT_DRAWDOWN_TYPE
      , lt.PHASE
      , lp.LIMIT_PROFILE_SEQ_NO
      , lp.BASE_RATE_TYPE
      , lp.SPREAD_RATE
      , lp.INTEREST_RATE
      , lp.FEE_RATE
      , lp.JCIC_LOAN_BIZ_CODE
      , lp.INTEREST_RATE_TYPE
      , lp.INTEREST_SCHEDULE_TYPE
      , lp.APPRD_DRAWDOWN_UNIT
      , lp.APPRD_DRAWDOWN_PERIOD
      , lp.PURPOSE_CODE
      , lp.LOAN_SUBCATEGORY
      , lp.CREDIT_LOAN_PROD_CODE
      , lp.REPAYMT_SOURCE
      , lp.PRNP_GRACE_PERIOD
      , lp.ALLOW_DRAWDOWN_MK
      , lp.COLLATERAL_TYPE
      , lp.APPR_INTST_RATE
      , lp.DEPOSIT_PLEDGE_MK 
      , lp.PD_VALUE
      , lp.LGD_VALUE
      , lp.FIRST_DRAWDOWN_DATE
      , lp.OVERDRAFT_EXT_MK
      , lp.CREDIT_GUARA_FEE_RATE
      , (CASE WHEN i_include_service_fee_data = 'Y' THEN lp.SERVICE_FEE_DATA ELSE NULL END) AS SERVICE_FEE_DATA
      , lp.PAYMT_TYPE
      , lp.CONSIGN_PAYMT_ACC
      , lp.INTST_UPPER_RATE
      , lp.INTST_LOWER_RATE
      , lp.GUARA_CALC_TYPE
      , lp.TRANS_ACCEPT_FEE_RATE
    FROM EDLS.TB_LIMIT lt
    JOIN EDLS.TB_LIMIT_PROFILE lp ON (lt.LIMIT_SEQ_NO = lp.LIMIT_SEQ_NO)
    WHERE lt.LIMIT_SEQ_NO = i_limit_seq_no;
  END SP_GET_LIMITP_NO_LOCK;

--**************************************************************************
-- SP_UPD_APPR_DOC_FDD
-- Purpose: 批覆書主檔首次動撥日以及狀態
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************  
  PROCEDURE SP_UPD_APPR_DOC_FDD
  ( i_appr_doc_seq_no IN NUMBER   -- 批覆書主檔序號
  , i_date            IN VARCHAR2 -- 第一次動用截止日
  ) AS
  BEGIN
    UPDATE EDLS.TB_APPR_DOC SET
    FIRST_DRAWDOWN_DATE = i_date, 
    LAST_TXN_DATE = i_date, 
    PHASE = '0',
    AMEND_DATE = SYSTIMESTAMP
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no AND FIRST_DRAWDOWN_DATE is null;
  END SP_UPD_APPR_DOC_FDD;

--**************************************************************************
-- SP_UPD_LIMIT_FDD
-- Purpose: 更新分項額度主檔首次動用
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************  
  PROCEDURE SP_UPD_LIMIT_FDD
  ( i_limit_seq_no IN NUMBER -- 分項額度主檔序號
  ) AS
  BEGIN
    UPDATE EDLS.TB_LIMIT SET 
    PHASE = '0',
    AMEND_DATE = SYSTIMESTAMP
    WHERE LIMIT_SEQ_NO = i_limit_seq_no;
  END SP_UPD_LIMIT_FDD;

--**************************************************************************
-- SP_UPD_LIMIT_PROFILE
-- Purpose: 更新分項批示條件設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************  
  PROCEDURE SP_UPD_LIMIT_PROFILE
  ( i_limit_profile_seq_no             IN NUMBER   -- 分項批示條件檔序號
  , i_limit_seq_no                     IN NUMBER   -- 分項額度主檔序號
  , i_base_rate_type                   IN VARCHAR2 -- 基放類別
  , i_spread_rate                      IN NUMBER   -- 放款利率加減碼值
  , i_interest_rate                    IN NUMBER   -- 放款利率
  , i_fee_rate                         IN NUMBER   -- 手續費率
  , i_jcic_loan_biz_code               IN VARCHAR2 -- 融資業務分類
  , i_interest_rate_type               IN VARCHAR2 -- 利率類別
  , i_interest_schedule_type           IN VARCHAR2 -- 利率計劃類別
  , i_apprd_drawdown_unit              IN VARCHAR2 -- 核准動用期間單位
  , i_apprd_drawdown_period            IN NUMBER   -- 核准動用期間
  , i_purpose_code                     IN VARCHAR2 -- 用途別
  , i_loan_subcategory                 IN VARCHAR2 -- 貸放細目
  , i_credit_loan_prod_code            IN VARCHAR2 -- 信貸產品編號
  , i_repaymt_source                   IN VARCHAR2 -- 償還來源
  , i_prnp_grace_period                IN NUMBER   -- 還本寬限期
  , i_allow_drawdown_mk                IN VARCHAR2 -- 是否可動用註記
  , i_collateral_type                  IN VARCHAR2 -- 擔保品種類
  , i_appr_intst_rate                  IN NUMBER   -- 批覆時核貸利率
  , i_pd_value                         IN NUMBER   -- PD值
  , i_lgd_value                        IN NUMBER   -- LGD值
  , i_first_drawdown_date              IN VARCHAR2 -- 分項首次動撥日
  , i_overdraft_ext_mk                 IN VARCHAR2 -- 自動展期註記
  , i_credit_guara_fee_rate            IN NUMBER   -- 信保手續費率 
  , i_paymt_type                       IN VARCHAR2 -- 償還方法
  , i_consign_paymt_acc                IN VARCHAR2 -- 委託繳息帳號
  , i_intst_upper_rate                 IN NUMBER   -- 上限利率
  , i_intst_lower_rate                 IN NUMBER   -- 下限利率
  , i_guara_calc_type                  IN VARCHAR2 -- 保證計費方式
  , i_trans_accept_fee_rate            IN NUMBER   -- 信用狀轉承兌費率
  , i_service_fee_data                 IN VARCHAR2 -- 手續費設定條款
  , i_deposit_pledge_mk                IN VARCHAR2 -- 存單質借註記
  ) AS
  BEGIN
    UPDATE EDLS.TB_LIMIT_PROFILE SET
      LIMIT_SEQ_NO = i_limit_seq_no
      ,BASE_RATE_TYPE = i_base_rate_type
      ,SPREAD_RATE =   i_spread_rate
      ,INTEREST_RATE = i_interest_rate
      ,FEE_RATE = i_fee_rate
      ,JCIC_LOAN_BIZ_CODE = i_jcic_loan_biz_code
      ,INTEREST_RATE_TYPE = i_interest_rate_type
      ,INTEREST_SCHEDULE_TYPE = i_interest_schedule_type
      ,APPRD_DRAWDOWN_UNIT = i_apprd_drawdown_unit
      ,APPRD_DRAWDOWN_PERIOD = i_apprd_drawdown_period
      ,PURPOSE_CODE = i_purpose_code
      ,LOAN_SUBCATEGORY = i_loan_subcategory
      ,CREDIT_LOAN_PROD_CODE = i_credit_loan_prod_code
      ,REPAYMT_SOURCE = i_repaymt_source
      ,PRNP_GRACE_PERIOD = i_prnp_grace_period
      ,ALLOW_DRAWDOWN_MK = i_allow_drawdown_mk
      ,COLLATERAL_TYPE = i_collateral_type
      ,APPR_INTST_RATE = i_appr_intst_rate
      ,DEPOSIT_PLEDGE_MK = i_deposit_pledge_mk 
      ,PD_VALUE = i_pd_value
      ,LGD_VALUE = i_lgd_value
      ,FIRST_DRAWDOWN_DATE = i_first_drawdown_date
      ,OVERDRAFT_EXT_MK = i_overdraft_ext_mk
      ,CREDIT_GUARA_FEE_RATE = i_credit_guara_fee_rate
      ,PAYMT_TYPE = i_paymt_type
      ,CONSIGN_PAYMT_ACC = i_consign_paymt_acc
      ,INTST_UPPER_RATE = i_intst_upper_rate
      ,INTST_LOWER_RATE = i_intst_lower_rate
      ,GUARA_CALC_TYPE = i_guara_calc_type
      ,TRANS_ACCEPT_FEE_RATE = i_trans_accept_fee_rate
      ,SERVICE_FEE_DATA = i_service_fee_data
      ,AMEND_DATE = systimestamp
    WHERE LIMIT_PROFILE_SEQ_NO= i_limit_profile_seq_no;
  END SP_UPD_LIMIT_PROFILE;

--**************************************************************************
-- SP_GET_PROD_MORTGAGE_PROF
-- Purpose: 查詢分項額度下的所有房貸種類註記
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************  
  PROCEDURE SP_GET_PROD_MORTGAGE_PROF
  ( i_limit_seq_no IN NUMBER         -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    open o_cur FOR
     Select pmp.PROD_MORTGAG_PROFILE_SEQ_NO
     , pmp.LIMIT_PROFILE_SEQ_NO
     , pmp.MORTGAGE_PRODUCT
     FROM EDLS.TB_LIMIT_PROFILE lp JOIN EDLS.TB_PROD_MORTGAGE_PROFILE pmp
     ON lp.LIMIT_PROFILE_SEQ_NO = pmp.LIMIT_PROFILE_SEQ_NO
     WHERE lp.LIMIT_SEQ_NO = i_limit_seq_no
     FOR UPDATE;
  END SP_GET_PROD_MORTGAGE_PROF;

--**************************************************************************
-- SP_INS_LIMIT_PROFILE
-- Purpose: 新增分項批示條件設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************   
  PROCEDURE SP_INS_LIMIT_PROFILE
  ( i_limit_seq_no                     IN NUMBER   -- 分項額度主檔序號
  , i_base_rate_type                   IN VARCHAR2 -- 基放類別
  , i_spread_rate                      IN NUMBER   -- 放款利率加減碼值
  , i_interest_rate                    IN NUMBER   -- 放款利率
  , i_fee_rate                         IN NUMBER   -- 手續費率
  , i_jcic_loan_biz_code               IN VARCHAR2 -- 融資業務分類
  , i_interest_rate_type               IN VARCHAR2 -- 利率類別
  , i_interest_schedule_type           IN VARCHAR2 -- 利率計劃類別
  , i_apprd_drawdown_unit              IN VARCHAR2 -- 核准動用期間單位
  , i_apprd_drawdown_period            IN NUMBER   -- 核准動用期間
  , i_purpose_code                     IN VARCHAR2 -- 用途別
  , i_loan_subcategory                 IN VARCHAR2 -- 貸放細目
  , i_credit_loan_prod_code            IN VARCHAR2 -- 信貸產品編號
  , i_repaymt_source                   IN VARCHAR2 -- 償還來源
  , i_prnp_grace_period                IN NUMBER   -- 還本寬限期
  , i_allow_drawdown_mk                IN VARCHAR2 -- 是否可動用註記
  , i_collateral_type                  IN VARCHAR2 -- 擔保品種類
  , i_appr_intst_rate                  IN NUMBER   -- 批覆時核貸利率
  , i_pd_value                         IN NUMBER   -- PD值
  , i_lgd_value                        IN NUMBER   -- LGD值
  , i_first_drawdown_date              IN VARCHAR2 -- 分項首次動撥日
  , i_overdraft_ext_mk                 IN VARCHAR2 -- 自動展期註記
  , i_credit_guara_fee_rate            IN NUMBER   -- 信保手續費率 
  , i_paymt_type                       IN VARCHAR2 -- 償還方法
  , i_consign_paymt_acc                IN VARCHAR2 -- 委託繳息帳號
  , i_intst_upper_rate                 IN NUMBER   -- 上限利率
  , i_intst_lower_rate                 IN NUMBER   -- 下限利率
  , i_guara_calc_type                  IN VARCHAR2 -- 保證計費方式
  , i_trans_accept_fee_rate            IN NUMBER   -- 信用狀轉承兌費率
  , i_service_fee_data                 IN VARCHAR2 -- 手續費設定條款
  , i_deposit_pledge_mk                IN VARCHAR2 -- 存單質借註記
  , o_seq_no                           OUT NUMBER  -- 分項批示條件檔序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LIMIT_PROFILE', o_seq_no);
    INSERT INTO EDLS.TB_LIMIT_PROFILE
    ( LIMIT_PROFILE_SEQ_NO
    , LIMIT_SEQ_NO
    , BASE_RATE_TYPE
    , SPREAD_RATE
    , INTEREST_RATE
    , FEE_RATE
    , JCIC_LOAN_BIZ_CODE
    , INTEREST_RATE_TYPE
    , INTEREST_SCHEDULE_TYPE
    , APPRD_DRAWDOWN_UNIT
    , APPRD_DRAWDOWN_PERIOD
    , PURPOSE_CODE
    , LOAN_SUBCATEGORY
    , CREDIT_LOAN_PROD_CODE
    , REPAYMT_SOURCE
    , PRNP_GRACE_PERIOD
    , ALLOW_DRAWDOWN_MK
    , COLLATERAL_TYPE
    , APPR_INTST_RATE
    , PD_VALUE
    , LGD_VALUE
    , FIRST_DRAWDOWN_DATE
    , OVERDRAFT_EXT_MK
    , CREDIT_GUARA_FEE_RATE
    , PAYMT_TYPE
    , CONSIGN_PAYMT_ACC
    , INTST_UPPER_RATE
    , INTST_LOWER_RATE
    , GUARA_CALC_TYPE
    , TRANS_ACCEPT_FEE_RATE
    , SERVICE_FEE_DATA
    , DEPOSIT_PLEDGE_MK
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_seq_no
    , i_limit_seq_no
    , i_base_rate_type
    , i_spread_rate
    , i_interest_rate
    , i_fee_rate
    , i_jcic_loan_biz_code
    , i_interest_rate_type
    , i_interest_schedule_type
    , i_apprd_drawdown_unit
    , i_apprd_drawdown_period
    , i_purpose_code
    , i_loan_subcategory
    , i_credit_loan_prod_code
    , i_repaymt_source
    , i_prnp_grace_period
    , i_allow_drawdown_mk
    , i_collateral_type
    , i_appr_intst_rate
    , i_pd_value
    , i_lgd_value
    , i_first_drawdown_date
    , i_overdraft_ext_mk
    , i_credit_guara_fee_rate
    , i_paymt_type
    , i_consign_paymt_acc
    , i_intst_upper_rate
    , i_intst_lower_rate
    , i_guara_calc_type
    , i_trans_accept_fee_rate
    , i_service_fee_data
    , i_deposit_pledge_mk
    , systimestamp
    , systimestamp
    );
  END SP_INS_LIMIT_PROFILE;

--**************************************************************************
-- SP_UPD_LIMIT_PROFILE_FDD
-- Purpose: 更新分項批示條件檔首次動撥日
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************  
  PROCEDURE SP_UPD_LIMIT_PROFILE_FDD
  ( i_limit_seq_no IN NUMBER   -- 分項額度主檔序號
  , i_date         IN VARCHAR2 -- 第一次動用截止日
  ) AS
  BEGIN
    UPDATE EDLS.TB_LIMIT_PROFILE SET 
    FIRST_DRAWDOWN_DATE = i_date,
    AMEND_DATE = SYSTIMESTAMP
    WHERE LIMIT_SEQ_NO = i_limit_seq_no AND FIRST_DRAWDOWN_DATE is null;
  END SP_UPD_LIMIT_PROFILE_FDD;

--**************************************************************************
-- SP_INS_PREPAID_STOCK_TXN
-- Purpose: 新增墊付股款交易紀錄
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************  
 PROCEDURE SP_INS_PREPAID_STOCK_TXN
  ( i_limit_seq_no                     IN NUMBER    -- 分項額度主檔序號
  , i_txn_date                         IN VARCHAR2  -- 交易日期
  , i_txn_sno                          IN NUMBER    -- 交易日期序號
  , i_txn_time                         IN VARCHAR2  -- 交易時間
  , i_branch                           IN VARCHAR2  -- 分行代號
  , i_host_sno                         IN VARCHAR2  -- 主機交易序號
  , i_sup_card_code                    IN VARCHAR2  -- 主管授權卡號
  , i_txn_id                           IN VARCHAR2  -- 交易代號
  , i_txn_memo                         IN VARCHAR2  -- 交易摘要
  , i_acc_branch                       IN VARCHAR2  -- 設帳分行
  , i_dc_code                          IN VARCHAR2  -- 借貸別
  , i_action_code                      IN VARCHAR2  -- 執行類別
  , i_txn_amt                          IN NUMBER    -- 交易金額
  , i_prepaid_balance                  IN NUMBER    -- 墊款餘額
  , i_saving_acc_no                    IN VARCHAR2  -- 存款帳號
  , i_saving_acc_cust_id               IN VARCHAR2  -- 存款帳號統編
  , i_prepaid_acc_category             IN VARCHAR2  -- 墊款科目
  , i_debit_acc_no                     IN VARCHAR2  -- 轉出帳號
  , i_to_saving_acc_no                 IN VARCHAR2  -- 轉入帳號
  , i_appr_doc_seq_no                  IN NUMBER    -- 批覆書主檔序號
  , i_limit_type                       IN VARCHAR2  -- 額度種類
  , i_is_ec                            IN VARCHAR2  -- 是否為沖正交易註記
  , o_seq_no                           OUT NUMBER   -- PREPAID_STOCK_TXN_SEQ_NO
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_PREPAID_STOCK_TXN', o_seq_no);
    INSERT INTO EDLS.TB_PREPAID_STOCK_TXN
    ( PREPAID_STOCK_TXN_SEQ_NO
    , LIMIT_SEQ_NO
    , TXN_DATE
    , TXN_SNO
    , TXN_TIME
    , BRANCH
    , HOST_SNO
    , SUP_CARD_CODE
    , TXN_ID
    , TXN_MEMO
    , ACC_BRANCH
    , DC_CODE
    , ACTION_CODE
    , TXN_AMT
    , PREPAID_BALANCE
    , SAVING_ACC_NO
    , SAVING_ACC_CUST_ID
    , PREPAID_ACC_CATEGORY
    , DEBIT_ACC_NO
    , TO_SAVING_ACC_NO
    , APPR_DOC_SEQ_NO
    , LIMIT_TYPE
    , IS_EC
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_seq_no
    , i_limit_seq_no
    , i_txn_date
    , i_txn_sno
    , i_txn_time
    , i_branch
    , i_host_sno
    , i_sup_card_code
    , i_txn_id
    , i_txn_memo
    , i_acc_branch
    , i_dc_code
    , i_action_code
    , i_txn_amt
    , i_prepaid_balance
    , i_saving_acc_no
    , i_saving_acc_cust_id
    , i_prepaid_acc_category
    , i_debit_acc_no
    , i_to_saving_acc_no
    , i_appr_doc_seq_no
    , i_limit_type
    , i_is_ec
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
  END SP_INS_PREPAID_STOCK_TXN;

--**************************************************************************
-- SP_GET_PREPAID_STOCK_TXN_LIST
-- Purpose: 查詢在起訖日間符合查詢條件的交易紀錄
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************  
  PROCEDURE SP_GET_PREPAID_STOCK_TXN_LIST
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , i_limit_type      IN VARCHAR2       -- 額度種類
  , i_start_date      IN VARCHAR2       -- 交易日期起日
  , i_end_date        IN VARCHAR2       -- 交易日期迄日
  , i_action_code     IN VARCHAR2       -- 執行類別
  , i_saving_acc_no   IN VARCHAR2       -- 存款帳號
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
    ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT PREPAID_STOCK_TXN_SEQ_NO
       , LIMIT_SEQ_NO
       , TXN_DATE
       , TXN_SNO
       , TXN_TIME
       , BRANCH
       , HOST_SNO
       , SUP_CARD_CODE
       , TXN_ID
       , TXN_MEMO
       , ACC_BRANCH
       , DC_CODE
       , ACTION_CODE
       , TXN_AMT
       , PREPAID_BALANCE
       , SAVING_ACC_NO
       , SAVING_ACC_CUST_ID
       , PREPAID_ACC_CATEGORY
       , DEBIT_ACC_NO
       , TO_SAVING_ACC_NO
       , APPR_DOC_SEQ_NO
       , LIMIT_TYPE
       , IS_EC
       , CREATE_DATE
       , AMEND_DATE
    FROM EDLS.TB_PREPAID_STOCK_TXN
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no 
    AND LIMIT_TYPE = i_limit_type
    AND TXN_DATE BETWEEN i_start_date AND i_end_date 
    AND SAVING_ACC_NO = NVL(i_saving_acc_no, SAVING_ACC_NO)
	AND (i_action_code IS NULL OR ACTION_CODE = i_action_code);  --此條件查過文件沒在使用可與程式一同移除
  END SP_GET_PREPAID_STOCK_TXN_LIST;

--**************************************************************************
-- SP_GET_PREPAID_STOCK_NEXT_SNO
-- Purpose: 取得此墊付股款交易紀錄的下一交易日期序號
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************  
  PROCEDURE SP_GET_PREPAID_STOCK_NEXT_SNO
  ( i_appr_doc_seq_no IN NUMBER   -- 批覆書主檔序號
  , i_limit_type      IN VARCHAR2 -- 額度種類
  , i_txn_date        IN VARCHAR2 -- 交易日期
  , o_seq_no          OUT NUMBER  -- 墊付股款交易記錄序號
  ) AS
  BEGIN
    SELECT NVL((MAX(TXN_SNO) + 1),1) INTO o_seq_no FROM EDLS.TB_PREPAID_STOCK_TXN
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no 
    AND LIMIT_TYPE = i_limit_type 
    AND TXN_DATE = i_txn_date;
  END SP_GET_PREPAID_STOCK_NEXT_SNO;

--**************************************************************************
-- SP_INS_PREPAY_STOCK
-- Purpose: 新增墊付股款額度設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************  
  PROCEDURE SP_INS_PREPAY_STOCK
  ( i_limit_seq_no       IN NUMBER   -- 分項額度主檔序號
  , i_sub_company_id     IN VARCHAR2 -- 子公司統編
  , i_appr_limit_amt     IN NUMBER   -- 核准額度
  , i_total_drawdown_amt IN NUMBER   -- 預佔累積動用金額
  , o_seq_no             OUT NUMBER  -- 墊付股款額度設定檔序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LIMIT_PREPAY_STOCK', o_seq_no);

    INSERT INTO EDLS.TB_LIMIT_PREPAY_STOCK
    ( PREPAID_STOCK_SEQ_NO
    , LIMIT_SEQ_NO
    , SUB_COMPANY_ID
    , APPR_LIMIT_AMT
    , TOTAL_DRAWDOWN_AMT
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_seq_no
    , i_limit_seq_no
    , i_sub_company_id
    , i_appr_limit_amt
    , i_total_drawdown_amt
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
  END SP_INS_PREPAY_STOCK;

--**************************************************************************
-- SP_GET_PREPAY_STOCK
-- Purpose: 查詢墊付股款額度設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************  
  PROCEDURE SP_GET_PREPAY_STOCK
  ( i_limit_seq_no   IN NUMBER         -- 分項額度主檔序號
  , i_sub_company_id IN VARCHAR2       -- 子公司統編
  , o_cur            OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT PREPAID_STOCK_SEQ_NO
    , LIMIT_SEQ_NO
    , SUB_COMPANY_ID
    , APPR_LIMIT_AMT
    , TOTAL_DRAWDOWN_AMT
    , CREATE_DATE
    , AMEND_DATE
    FROM EDLS.TB_LIMIT_PREPAY_STOCK
    WHERE LIMIT_SEQ_NO = NVL(i_limit_seq_no, LIMIT_SEQ_NO) 
    AND SUB_COMPANY_ID = i_sub_company_id;
  END SP_GET_PREPAY_STOCK;

--**************************************************************************
-- SP_GET_PREPAY_STOCK_U
-- Purpose: 查詢墊付股款額度設定檔FOR UPDATE
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--************************************************************************** 
  PROCEDURE SP_GET_PREPAY_STOCK_U
  ( i_limit_seq_no   IN NUMBER         -- 分項額度主檔序號
  , i_sub_company_id IN VARCHAR2       -- 子公司統編 
  , o_cur            OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT PREPAID_STOCK_SEQ_NO
    , LIMIT_SEQ_NO
    , SUB_COMPANY_ID
    , APPR_LIMIT_AMT
    , TOTAL_DRAWDOWN_AMT
    , CREATE_DATE
    , AMEND_DATE
    FROM EDLS.TB_LIMIT_PREPAY_STOCK
    WHERE LIMIT_SEQ_NO = NVL(i_limit_seq_no, LIMIT_SEQ_NO) AND
    SUB_COMPANY_ID = i_sub_company_id
    FOR UPDATE;
  END SP_GET_PREPAY_STOCK_U;

--**************************************************************************
-- SP_GET_PREPAY_STOCK_LIST
-- Purpose: 查詢墊付股款額度設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_GET_PREPAY_STOCK_LIST
  ( i_limit_seq_no IN NUMBER         -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT PREPAID_STOCK_SEQ_NO
    , LIMIT_SEQ_NO
    , SUB_COMPANY_ID
    , APPR_LIMIT_AMT
    , TOTAL_DRAWDOWN_AMT
    , CREATE_DATE
    , AMEND_DATE
    FROM EDLS.TB_LIMIT_PREPAY_STOCK
    WHERE LIMIT_SEQ_NO = i_limit_seq_no;
  END SP_GET_PREPAY_STOCK_LIST;

--**************************************************************************
-- SP_UPD_PREPAY_STOCK
-- Purpose: 更新墊付股款額度設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************  
  PROCEDURE SP_UPD_PREPAY_STOCK
  ( i_prepaid_stock_seq_no IN NUMBER   -- 墊付股款額度設定檔序號
  , i_limit_seq_no         IN NUMBER   -- 分項額度主檔序號
  , i_sub_company_id       IN VARCHAR2 -- 子公司統編
  , i_appr_limit_amt       IN NUMBER   -- 核准額度
  , i_total_drawdown_amt   IN NUMBER   -- 預佔累積動用金額
  , o_row_count            OUT NUMBER  -- 異動筆數
  ) AS
  BEGIN
    UPDATE EDLS.TB_LIMIT_PREPAY_STOCK 
    SET LIMIT_SEQ_NO = i_limit_seq_no
    , SUB_COMPANY_ID = i_sub_company_id
    , APPR_LIMIT_AMT = i_appr_limit_amt
    , TOTAL_DRAWDOWN_AMT = i_total_drawdown_amt
    , AMEND_DATE = SYSTIMESTAMP
    WHERE PREPAID_STOCK_SEQ_NO = i_prepaid_stock_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_PREPAY_STOCK;

--**************************************************************************
-- SP_DEL_PREPAY_STOCK_PK
-- Purpose: 以序號刪除對應墊付股款額度設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_PREPAY_STOCK_PK
  ( i_prepaid_stock_seq_no IN NUMBER  -- 墊付股款額度設定檔序號
  , o_row_count            OUT NUMBER -- 刪除筆數
  ) AS
  BEGIN
    DELETE EDLS.TB_LIMIT_PREPAY_STOCK
    WHERE PREPAID_STOCK_SEQ_NO = i_prepaid_stock_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_PREPAY_STOCK_PK;

--**************************************************************************
-- SP_DEL_PREPAY_STOCK
-- Purpose: 刪除墊付股款額度設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_PREPAY_STOCK
  ( i_limit_seq_no IN NUMBER  -- 分項額度主檔序號
  , o_row_count    OUT NUMBER -- 刪除筆數
  ) AS
  BEGIN
    DELETE EDLS.TB_LIMIT_PREPAY_STOCK
    WHERE LIMIT_SEQ_NO = i_limit_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_PREPAY_STOCK;

 --**************************************************************************
-- SP_INS_APPR_DOC
-- Purpose: 新增批覆書主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_APPR_DOC 
  ( i_customer_loan_seq_no             IN NUMBER    -- 授信戶主檔序號
  , i_appr_doc_no                      IN VARCHAR2  -- 批覆書編號
  , i_phase                            IN VARCHAR2  -- 批覆書狀態
  , i_apprd_date                       IN VARCHAR2  -- 批覆書核準日
  , i_matu_date                        IN VARCHAR2  -- 批覆書到期日
  , i_first_drawdown_edate             IN VARCHAR2  -- 第一次動用截止日
  , i_total_appr_amt                   IN NUMBER    -- 總額度
  , i_total_appr_ccy                   IN VARCHAR2  -- 總額度幣別
  , i_channel_code                     IN VARCHAR2  -- 通路
  , i_appr_drawdown_type               IN VARCHAR2  -- 本批覆書動用方式
  , i_loan_purpose                     IN VARCHAR2  -- 借款用途
  , i_loan_attributes                  IN VARCHAR2  -- 授信性質
  , i_ccl_mk                           IN VARCHAR2  -- 綜合額度註記
  , i_source_code                      IN VARCHAR2  -- 案件來源
  , i_data_convert_source              IN VARCHAR2  -- 資料轉換來源
  , i_acc_branch                       IN VARCHAR2  -- 記帳單位
  , i_oper_branch                      IN VARCHAR2  -- 作業單位
  , i_under_center                     IN VARCHAR2  -- 批覆書所屬中心
  , i_approver_id                      IN VARCHAR2  -- 核貸者統編
  , i_apprd_type                       IN VARCHAR2  -- 核貸權限別
  , i_effec_period                     IN NUMBER    -- 批覆書有效期間
  , i_effec_unit                       IN VARCHAR2  -- 批覆書有效期間單位
  , i_contract_sdate                   IN VARCHAR2  -- 契約起始日
  , i_contract_period                  IN NUMBER    -- 契約有效期間
  , i_contract_unit                    IN VARCHAR2  -- 契約有效期間單位
  , i_from_appr_doc_no                 IN VARCHAR2  -- 來源批覆書
  , i_to_appr_doc_no                   IN VARCHAR2  -- 目的批覆書
  , i_last_txn_date                    IN VARCHAR2  -- 上次交易日
  , i_inter_media_branch               IN VARCHAR2  -- 轉介單位
  , i_report_branch                    IN VARCHAR2  -- 報表單位
  , i_profit_branch                    IN VARCHAR2  -- 利潤單位
  , i_first_drawdown_date              IN VARCHAR2  -- 首次動撥日
  , i_auth_date                        IN VARCHAR2  -- 批覆書放行日
  , i_appr_doc_edate                   IN VARCHAR2  -- 批覆書結束日
  , i_mpl_mort_overdue_cancel_mk       IN VARCHAR2  -- 月繳月省房貸因逾期取消功能註記
  , i_appr_doc_source                  IN VARCHAR2  -- 批覆書來源
  , i_system_id                        IN VARCHAR2  -- 鍵檔平台
  , i_modifiable                       IN VARCHAR2  -- 可執行變更交易
  , i_cross_border_shared_limit_mk     IN VARCHAR2  -- 跨境共用額度註記
  , o_seq_no                           OUT NUMBER   -- 批覆書主檔序號
  ) as
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_APPR_DOC', o_seq_no);
    INSERT INTO EDLS.TB_APPR_DOC 
    ( APPR_DOC_SEQ_NO
    , CUSTOMER_LOAN_SEQ_NO
    , APPR_DOC_NO
    , PHASE
    , APPRD_DATE
    , MATU_DATE
    , FIRST_DRAWDOWN_EDATE
    , TOTAL_APPR_AMT
    , TOTAL_APPR_CCY
    , CHANNEL_CODE
    , APPR_DRAWDOWN_TYPE
    , LOAN_PURPOSE
    , LOAN_ATTRIBUTES
    , CCL_MK
    , SOURCE_CODE
    , DATA_CONVERT_SOURCE
    , ACC_BRANCH
    , OPER_BRANCH
    , UNDER_CENTER
    , APPROVER_ID
    , APPRD_TYPE
    , EFFEC_PERIOD
    , EFFEC_UNIT
    , CONTRACT_SDATE
    , CONTRACT_PERIOD
    , CONTRACT_UNIT
    , FROM_APPR_DOC_NO
    , TO_APPR_DOC_NO
    , LAST_TXN_DATE
    , INTER_MEDIA_BRANCH
    , REPORT_BRANCH
    , PROFIT_BRANCH
    , FIRST_DRAWDOWN_DATE
    , AUTH_DATE
    , APPR_DOC_EDATE
    , MPL_MORT_OVERDUE_CANCEL_MK
    , APPR_DOC_SOURCE
    , SYSTEM_ID
    , MODIFIABLE
    , CROSS_BORDER_SHARED_LIMIT_MK
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_seq_no
    , i_customer_loan_seq_no
    , i_appr_doc_no
    , i_phase
    , i_apprd_date
    , i_matu_date
    , i_first_drawdown_edate
    , i_total_appr_amt
    , i_total_appr_ccy
    , i_channel_code
    , i_appr_drawdown_type
    , i_loan_purpose
    , i_loan_attributes
    , i_ccl_mk
    , i_source_code
    , i_data_convert_source
    , i_acc_branch
    , i_oper_branch
    , i_under_center
    , i_approver_id
    , i_apprd_type
    , i_effec_period
    , i_effec_unit
    , i_contract_sdate
    , i_contract_period
    , i_contract_unit
    , i_from_appr_doc_no
    , i_to_appr_doc_no
    , i_last_txn_date
    , i_inter_media_branch
    , i_report_branch
    , i_profit_branch
    , i_first_drawdown_date
    , i_auth_date
    , i_appr_doc_edate
    , i_mpl_mort_overdue_cancel_mk
    , i_appr_doc_source
    , i_system_id
    , i_modifiable
    , i_cross_border_shared_limit_mk
    , systimestamp
    , systimestamp
    );
  END SP_INS_APPR_DOC;

--**************************************************************************
-- SP_INS_APPR_DOC_ACTIVITY_PROF
-- Purpose: 新增批覆書活動設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_APPR_DOC_ACTIVITY_PROF
  ( i_appr_doc_seq_no IN NUMBER   -- 批覆書主檔序號
  , i_activity_code   IN VARCHAR2 -- 活動代號
  , o_seq_no          OUT NUMBER  -- 批覆書活動設定檔序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_APPR_DOC_ACTIVITY_PROFILE', o_seq_no);
    INSERT INTO EDLS.TB_APPR_DOC_ACTIVITY_PROFILE 
    ( APPR_DOC_ACTIVITY_PRO_SEQ_NO
    , APPR_DOC_SEQ_NO
    , ACTIVITY_CODE
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_seq_no
    , i_appr_doc_seq_no
    , i_activity_code
    , systimestamp
    , systimestamp
    );
  END SP_INS_APPR_DOC_ACTIVITY_PROF;

--**************************************************************************
-- SP_DEL_APPR_DOC
-- Purpose: 刪除批覆書主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_APPR_DOC
  ( i_appr_doc_seq_no IN NUMBER  -- 批覆書主檔序號
  , o_row_count       OUT NUMBER -- 刪除筆數
  ) AS
  BEGIN
    DELETE EDLS.TB_APPR_DOC 
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_APPR_DOC;

--**************************************************************************
-- SP_DEL_APPR_DOC_ACTIVITY_PROF
-- Purpose: 刪除批覆書活動設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_APPR_DOC_ACTIVITY_PROF
  ( i_appr_doc_seq_no IN NUMBER  -- 批覆書主檔序號
  , o_row_count       OUT NUMBER -- 刪除筆數
  ) AS
  BEGIN
    DELETE EDLS.TB_APPR_DOC_ACTIVITY_PROFILE
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_APPR_DOC_ACTIVITY_PROF;

--**************************************************************************
-- SP_DEL_LIMIT
-- Purpose: 刪除分項額度主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT
  ( i_limit_seq_no IN NUMBER  -- 分項額度主檔序號
  , o_row_count    OUT NUMBER -- 刪除筆數
  ) AS
  BEGIN
    DELETE EDLS.TB_LIMIT
    WHERE LIMIT_SEQ_NO = i_limit_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_LIMIT;

--**************************************************************************
-- SP_DEL_LIMIT_PROFILE
-- Purpose: 刪除分項批示條件設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_PROFILE
  ( i_limit_seq_no IN NUMBER  -- 分項額度主檔序號
  , o_row_count    OUT NUMBER -- 刪除筆數
  ) AS
  BEGIN
    DELETE EDLS.TB_LIMIT_PROFILE
    WHERE LIMIT_SEQ_NO = i_limit_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_LIMIT_PROFILE;

--**************************************************************************
-- SP_DEL_LIMIT_PROJ_COND_PROF
-- Purpose: 刪除專案屬性批示條件檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_PROJ_COND_PROF
  ( i_limit_profile_seq_no IN NUMBER  -- 分項批示條件檔序號
  , o_row_count            OUT NUMBER -- 回傳筆數
  ) AS
  BEGIN
    DELETE EDLS.TB_LIMIT_PROJ_COND_PROF
    WHERE LIMIT_PROFILE_SEQ_NO = i_limit_profile_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_LIMIT_PROJ_COND_PROF;

--**************************************************************************
-- SP_INS_PROD_MORTGAGE_PROF
-- Purpose: 新增房屋產品種類批示條件檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************  
  PROCEDURE SP_INS_PROD_MORTGAGE_PROF
  ( i_limit_profile_seq_no IN NUMBER   -- 分項批示條件檔序號
  , i_mortgage_product     IN VARCHAR2 -- 房貸產品種類
  , o_seq_no               OUT NUMBER  -- 房貸產品種類批示條件檔序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_PROD_MORTGAGE_PROFILE', o_seq_no);
    INSERT INTO EDLS.TB_PROD_MORTGAGE_PROFILE 
    ( PROD_MORTGAG_PROFILE_SEQ_NO
    , LIMIT_PROFILE_SEQ_NO
    , MORTGAGE_PRODUCT
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_seq_no
    , i_limit_profile_seq_no
    , i_mortgage_product
    , systimestamp
    , systimestamp
    );
  END SP_INS_PROD_MORTGAGE_PROF;

--**************************************************************************
-- SP_DEL_PROD_MORTGAGE_PROF
-- Purpose: 刪除房屋產品種類批示條件檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     ??????????  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************  
  PROCEDURE SP_DEL_PROD_MORTGAGE_PROF
  ( i_limit_profile_seq_no IN NUMBER
  , o_row_count OUT NUMBER
  ) AS
  BEGIN
    DELETE EDLS.TB_PROD_MORTGAGE_PROFILE
    WHERE LIMIT_PROFILE_SEQ_NO = i_limit_profile_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_PROD_MORTGAGE_PROF;

 --**************************************************************************
-- SP_GET_PRE_CLOSURE_FEE_PROF
-- Purpose: 取得提前清償違約金設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_PRE_CLOSURE_FEE_PROF
  ( i_limit_profile_seq_no IN NUMBER         -- 分項批示條件設定檔序號
  , o_cur                  OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN 
    OPEN o_cur FOR
    SELECT PRE_CLOSURE_FEE_PROFILE_SEQ_NO
    ,LIMIT_PROFILE_SEQ_NO
    ,TERMS
    ,PENALTY_CLAUSE_START_MONTH
    ,PENALTY_CLAUSE_END_MONTH
    ,PERCENTAGE
    ,CREATE_DATE
    ,AMEND_DATE
    FROM EDLS.TB_PRE_CLOSURE_FEE_PROFILE
    WHERE LIMIT_PROFILE_SEQ_NO = i_limit_profile_seq_no;
  END SP_GET_PRE_CLOSURE_FEE_PROF;

--**************************************************************************
-- SP_INS_PRE_CLOSURE_FEE_PROF
-- Purpose: 新增提前清償違約金設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_PRE_CLOSURE_FEE_PROF
  ( i_limit_profile_seq_no       IN NUMBER  -- 分項批示條件設定檔序號
  , i_terms                      IN NUMBER  -- 段數
  , i_penalty_clause_start_month IN NUMBER  -- 違約條款起月
  , i_penalty_clause_end_month   IN NUMBER  -- 違約條款迄月
  , i_percentage                 IN NUMBER  -- 百分比
  , o_seq_no                     OUT NUMBER -- 提前清償違約金設定檔序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_PRE_CLOSURE_FEE_PROFILE', o_seq_no);
    INSERT INTO EDLS.TB_PRE_CLOSURE_FEE_PROFILE 
    ( PRE_CLOSURE_FEE_PROFILE_SEQ_NO
    , LIMIT_PROFILE_SEQ_NO
    , TERMS
    , PENALTY_CLAUSE_START_MONTH
    , PENALTY_CLAUSE_END_MONTH
    , PERCENTAGE
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_seq_no
    , i_limit_profile_seq_no
    , i_terms
    , i_penalty_clause_start_month
    , i_penalty_clause_end_month
    , i_percentage
    , systimestamp
    , systimestamp
    );
  END SP_INS_PRE_CLOSURE_FEE_PROF;

--**************************************************************************
-- SP_UPD_PRE_CLOSURE_FEE_PROF
-- Purpose: 修改提前清償違約金設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_UPD_PRE_CLOSURE_FEE_PROF
  ( i_pre_closure_fee_prof_seq_no IN NUMBER  -- 提前清償違約金設定檔序號
  , i_limit_profile_seq_no        IN NUMBER  -- 分項批示條件設定檔序號
  , i_terms                       IN NUMBER  -- 段數
  , i_penalty_clause_start_month  IN NUMBER  -- 違約條款起月
  , i_penalty_clause_end_month    IN NUMBER  -- 違約條款迄月
  , i_percentage                  IN NUMBER  -- 百分比
  , o_row_count                   OUT NUMBER -- 異動筆數
  ) AS
  BEGIN
    UPDATE EDLS.TB_PRE_CLOSURE_FEE_PROFILE 
    SET LIMIT_PROFILE_SEQ_NO = i_limit_profile_seq_no
    , TERMS = i_terms
    , PENALTY_CLAUSE_START_MONTH = i_penalty_clause_start_month
    , PENALTY_CLAUSE_END_MONTH = i_penalty_clause_end_month
    , PERCENTAGE = i_percentage, AMEND_DATE = SYSTIMESTAMP
    WHERE PRE_CLOSURE_FEE_PROFILE_SEQ_NO = i_pre_closure_fee_prof_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_PRE_CLOSURE_FEE_PROF;

--**************************************************************************
-- SP_DEL_PRE_CLOSURE_FEE_PROF
-- Purpose: 刪除提前清償違約金設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_PRE_CLOSURE_FEE_PROF
  ( i_limit_profile_seq_no IN NUMBER  -- 分項批示條件設定檔序號
  , o_row_count            OUT NUMBER -- 刪除筆數
  ) AS
  BEGIN
    DELETE EDLS.TB_PRE_CLOSURE_FEE_PROFILE
    WHERE LIMIT_PROFILE_SEQ_NO = i_limit_profile_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_PRE_CLOSURE_FEE_PROF;

--**************************************************************************
-- SP_GET_APPR_DOC_INLOAN_PROF
-- Purpose: 取得間接授信批示條件檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_APPR_DOC_INLOAN_PROF
  ( i_limit_seq_no IN NUMBER         -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN 
    OPEN o_cur FOR
    SELECT INLOAN_PROFILE_SEQ_NO,
    LIMIT_SEQ_NO,
    CCY_MK,
    BASE_RATE_TYPE,
    INTST_RATE_TYPE,
    INTST_SPREAD_RATE,
    PAYMT_TYPE,
    CONSIGN_PAYMT_ACC,CREATE_DATE, AMEND_DATE
    FROM EDLS.TB_APPR_DOC_INLOAN_PROFILE
    WHERE LIMIT_SEQ_NO = i_limit_seq_no;
  END SP_GET_APPR_DOC_INLOAN_PROF;

--**************************************************************************
-- SP_INS_APPR_DOC_INLOAN_PROF
-- Purpose: 新增間接授信批示條件檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_APPR_DOC_INLOAN_PROF
  ( i_limit_seq_no      IN NUMBER   -- 分項額度主檔序號
  , i_ccy_mk            IN VARCHAR2 -- 幣別註記
  , i_basic_rate_type   IN VARCHAR2 -- 基放類別
  , i_intst_rate_type   IN VARCHAR2 -- 利率類別
  , i_intst_spread_rate IN NUMBER   -- 利率加減碼
  , i_paymt_type        IN VARCHAR2 -- 償還方法
  , i_consign_paymt_acc IN VARCHAR2 -- 委託繳息帳號
  , o_seq_no            OUT NUMBER  -- 間接授信批示條件檔序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_APPR_DOC_INLOAN_PROFILE', o_seq_no);
    INSERT INTO EDLS.TB_APPR_DOC_INLOAN_PROFILE 
    ( INLOAN_PROFILE_SEQ_NO
    , LIMIT_SEQ_NO
    , CCY_MK
    , BASE_RATE_TYPE
    , INTST_RATE_TYPE
    , INTST_SPREAD_RATE
    , PAYMT_TYPE
    , CONSIGN_PAYMT_ACC
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( o_seq_no
    , i_limit_seq_no
    , i_ccy_mk
    , i_basic_rate_type
    , i_intst_rate_type
    , i_intst_spread_rate
    , i_paymt_type
    , i_consign_paymt_acc
    , systimestamp
    , systimestamp
    );
  END SP_INS_APPR_DOC_INLOAN_PROF;

--**************************************************************************
-- SP_UPD_APPR_DOC_INLOAN_PROF
-- Purpose: 修改間接授信批示條件檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--************************************************************************** 
  PROCEDURE SP_UPD_APPR_DOC_INLOAN_PROF
  ( i_inloan_profile_seq_no            IN NUMBER   -- 間接授信批示條件檔序號
  , i_limit_seq_no                     IN NUMBER   -- 分項額度主檔序號
  , i_ccy_mk                           IN VARCHAR2 -- 幣別註記
  , i_base_rate_type                   IN VARCHAR2 -- 基放類別
  , i_intst_rate_type                  IN VARCHAR2 -- 利率類別
  , i_intst_spread_rate                IN NUMBER   -- 利率加減碼
  , i_paymt_type                       IN VARCHAR2 -- 償還方法
  , i_consign_paymt_acc                IN VARCHAR2 -- 委託繳息帳號
  , o_row_count                        OUT NUMBER  -- 回傳更新筆數
  ) AS
  BEGIN
    UPDATE EDLS.TB_APPR_DOC_INLOAN_PROFILE SET 
    LIMIT_SEQ_NO = i_limit_seq_no, 
    CCY_MK = i_ccy_mk, 
    BASE_RATE_TYPE = i_base_rate_type, 
    INTST_RATE_TYPE = i_intst_rate_type, 
    INTST_SPREAD_RATE = i_intst_spread_rate, 
    PAYMT_TYPE = i_paymt_type, 
    CONSIGN_PAYMT_ACC = i_consign_paymt_acc, 
    AMEND_DATE = SYSTIMESTAMP
    WHERE INLOAN_PROFILE_SEQ_NO = i_inloan_profile_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_APPR_DOC_INLOAN_PROF;   

--**************************************************************************
-- SP_DEL_APPR_DOC_INLOAN_PROF
-- Purpose: 刪除間接授信批示條件檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.22  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_APPR_DOC_INLOAN_PROF
  ( i_inloan_profile_seq_no IN NUMBER  -- 間接授信批示條件檔序號
  , o_row_count             OUT NUMBER -- 回傳筆數
  ) AS
  BEGIN
    DELETE EDLS.TB_APPR_DOC_INLOAN_PROFILE
    WHERE INLOAN_PROFILE_SEQ_NO=i_inloan_profile_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_APPR_DOC_INLOAN_PROF;

--**************************************************************************
-- SP_GET_LIMIT_AR
-- Purpose: 取得應收帳款預支價金額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_AR
  ( i_limit_seq_no IN NUMBER         -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN 
    OPEN o_cur FOR
    SELECT LIMIT_AR_SEQ_NO
    ,LIMIT_SEQ_NO
    ,TXN_BRANCH
    ,HOST_SNO
    ,TXN_DATE
    ,REGISTRY_MK
    ,PRE_PAID_BALANCE
    ,PRE_PAID_PERCENTAGE
    ,INVOICE_BALANCE_AMT
    ,PAYMT_TYPE
    ,CREATE_DATE
    ,AMEND_DATE
    FROM EDLS.TB_LIMIT_AR
    WHERE LIMIT_SEQ_NO = i_limit_seq_no;
  END SP_GET_LIMIT_AR;

--**************************************************************************
-- SP_INS_LIMIT_AR
-- Purpose: 新增應收帳款預支價金額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_LIMIT_AR
  ( i_limit_seq_no                     IN NUMBER   -- 分項額度主檔序號
  , i_txn_branch                       IN VARCHAR2 -- 交易分行
  , i_host_sno                         IN VARCHAR2 -- 主機交易序號
  , i_txn_date                         IN VARCHAR2 -- 登錄日期
  , i_registry_mk                      IN VARCHAR2 -- 登錄解除註記
  , i_pre_paid_balance                 IN NUMBER   -- 預支現欠
  , i_pre_paid_percentage              IN NUMBER   -- 預支成數
  , i_invoice_balance_amt              IN NUMBER   -- 發票轉讓餘額
  , i_paymt_type                       IN VARCHAR2 -- 償還方法
  , o_seq_no                           OUT NUMBER  -- 應收帳款預支價金額度資訊序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LIMIT_AR', o_seq_no);
    INSERT INTO EDLS.TB_LIMIT_AR 
    ( LIMIT_AR_SEQ_NO
    , LIMIT_SEQ_NO
    , TXN_BRANCH,HOST_SNO
    , TXN_DATE,REGISTRY_MK
    , PRE_PAID_BALANCE
    , PRE_PAID_PERCENTAGE
    , INVOICE_BALANCE_AMT
    , PAYMT_TYPE
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    (o_seq_no
    , i_limit_seq_no
    , i_txn_branch
    , i_host_sno
    , i_txn_date
    , i_registry_mk
    , i_pre_paid_balance
    , i_pre_paid_percentage
    , i_invoice_balance_amt
    , i_paymt_type
    , systimestamp
    , systimestamp
    );
  END SP_INS_LIMIT_AR;  

--**************************************************************************
-- SP_UPD_LIMIT_AR
-- Purpose: 修改應收帳款預支價金額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_UPD_LIMIT_AR
  ( i_limit_ar_seq_no                  IN NUMBER   -- 應收帳款預支價金額度資訊序號
  , i_limit_seq_no                     IN NUMBER   -- 分項額度主檔序號
  , i_txn_branch                       IN VARCHAR2 -- 交易分行
  , i_host_sno                         IN VARCHAR2 -- 主機交易序號
  , i_txn_date                         IN VARCHAR2 -- 登錄日期
  , i_registry_mk                      IN VARCHAR2 -- 登錄解除註記
  , i_pre_paid_balance                 IN NUMBER   -- 預支現欠
  , i_pre_paid_percentage              IN NUMBER   -- 預支成數
  , i_invoice_balance_amt              IN NUMBER   -- 發票轉讓餘額
  , i_paymt_type                       IN VARCHAR2 -- 償還方法
  , o_row_count                        OUT NUMBER  -- 異動筆數
  ) as
  BEGIN
    UPDATE EDLS.TB_LIMIT_AR 
    SET LIMIT_AR_SEQ_NO = i_limit_ar_seq_no, 
    LIMIT_SEQ_NO = i_limit_seq_no, 
    TXN_BRANCH = i_txn_branch, 
    HOST_SNO = i_host_sno, 
    TXN_DATE = i_txn_date, 
    REGISTRY_MK = i_registry_mk, 
    PRE_PAID_BALANCE = i_pre_paid_balance, 
    PRE_PAID_PERCENTAGE = i_pre_paid_percentage, 
    INVOICE_BALANCE_AMT = i_invoice_balance_amt, 
    PAYMT_TYPE = i_paymt_type, 
    AMEND_DATE = SYSTIMESTAMP
    WHERE LIMIT_AR_SEQ_NO = i_limit_ar_seq_no;
    o_row_count := SQL%ROWCOUNT;
 END SP_UPD_LIMIT_AR;

--**************************************************************************
-- SP_DEL_LIMIT_AR
-- Purpose: 刪除應收帳款預支價金額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_AR
  ( i_limit_ar_seq_no IN NUMBER  -- 應收帳款預支價金額度資訊序號
  , o_row_count       OUT NUMBER -- 刪除筆數
  ) AS
  BEGIN
    DELETE EDLS.TB_LIMIT_AR
    WHERE LIMIT_AR_SEQ_NO = i_limit_ar_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_LIMIT_AR;

--**************************************************************************
-- SP_INS_LIMIT
-- Purpose: 新增分項額度主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  --TOTAL_NEGO_AMT,TOTAL_APPR_DOC_DRAWDOWN_AMT, TOTAL_REPAYMT_AMT,TOTAL_DRAWDOWN_AMT --DB已刪除 沒記錄 Modified 2019.03.05
  PROCEDURE SP_INS_LIMIT
  ( i_appr_doc_seq_no     IN NUMBER   -- 批覆書主檔序號
  , i_limit_type          IN VARCHAR2 -- 額度種類
  , i_serial_no           IN NUMBER   -- 序號
  , i_business_type       IN VARCHAR2 -- 業務類別
  , i_business_code       IN VARCHAR2 -- 業務代碼
  , i_period_type         IN VARCHAR2 -- 融資期間種類
  , i_is_guaranteed       IN VARCHAR2 -- 有無擔保註記
  , i_ccy_type            IN VARCHAR2 -- 幣別種類
  , i_right_mk            IN VARCHAR2 -- 追索權註記
  , i_is_forward          IN VARCHAR2 -- 即遠期註記
  , i_currency            IN VARCHAR2 -- 分項額度幣別
  , i_apprd_sub_limit_amt IN NUMBER   -- 分項核准額度
  , i_limit_drawdown_type IN VARCHAR2 -- 動用方式
  , i_phase               IN VARCHAR2 -- 分項額度狀態
  , o_seq_no              OUT NUMBER  -- 分項額度主檔序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LIMIT', o_seq_no);
    INSERT INTO EDLS.TB_LIMIT 
    ( LIMIT_SEQ_NO
    , APPR_DOC_SEQ_NO
    , LIMIT_TYPE
    , SERIAL_NO
    , BUSINESS_TYPE
    , BUSINESS_CODE
    , PERIOD_TYPE
    , IS_GUARANTEED
    , CCY_TYPE
    , RIGHT_MK
    , IS_FORWARD
    , CURRENCY
    , APPRD_SUB_LIMIT_AMT
    , LIMIT_DRAWDOWN_TYPE
    , PHASE 
    , CREATE_DATE
    ,AMEND_DATE
    )
    VALUES
    ( o_seq_no
    , i_appr_doc_seq_no
    , i_limit_type
    , i_serial_no
    , i_business_type
    , i_business_code
    , i_period_type
    , i_is_guaranteed
    , i_ccy_type
    , i_right_mk
    , i_is_forward
    , i_currency
    , i_apprd_sub_limit_amt
    , i_limit_drawdown_type
    , i_phase
    , systimestamp
    , systimestamp
    );
  END SP_INS_LIMIT;

--**************************************************************************
-- SP_GET_APPR_DOC_AUTHORIZER
-- Purpose: 查詢批覆書核轉人員
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_APPR_DOC_AUTHORIZER
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN 
    OPEN o_cur FOR
    SELECT APPR_DOC_AUTHORIZER_SEQ_NO
    , APPR_DOC_SEQ_NO
    , AUTH_LEVEL_CODE
    , RIGHT_ORDER
    , CUST_ID
    , REALTOR_NAME
    , REALTOR_ID
    , ALLOGRAPH_NAME
    , IS_FIX_CONTRACT
    , CREATE_DATE
    , AMEND_DATE
    FROM EDLS.TB_APPR_DOC_AUTHORIZER
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no;
  END SP_GET_APPR_DOC_AUTHORIZER;

  --**************************************************************************
-- SP_INS_APPR_DOC_AUTHORIZER
-- Purpose: 新增批覆書核轉人員
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     ??????????  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_APPR_DOC_AUTHORIZER
  ( i_appr_doc_seq_no                  IN NUMBER   -- 批覆書主檔序號
  , i_auth_level_code                  IN VARCHAR2 -- 權限代號
  , i_right_order                      IN NUMBER   -- 權限順位
  , i_cust_id                          IN VARCHAR2 -- 核轉人員統編
  , i_realtor_name                     IN VARCHAR2 -- 房屋仲介姓名
  , i_realtor_id                       IN VARCHAR2 -- 房屋仲介統編
  , i_allograph_name                   IN VARCHAR2 -- 代書人員姓名
  , i_is_fix_contract                  IN VARCHAR2 -- 是否為制式合約
  , o_seq_no                           OUT NUMBER  -- 批覆書核轉人員序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_APPR_DOC_AUTHORIZER', o_seq_no);
    INSERT INTO EDLS.TB_APPR_DOC_AUTHORIZER 
    ( APPR_DOC_AUTHORIZER_SEQ_NO
    , APPR_DOC_SEQ_NO
    , AUTH_LEVEL_CODE
    , CUST_ID,ALLOGRAPH_NAME
    , IS_FIX_CONTRACT
    , RIGHT_ORDER
    , REALTOR_NAME
    , REALTOR_ID
    , CREATE_DATE
    , AMEND_DATE)
    VALUES
    ( o_seq_no
    , i_appr_doc_seq_no
    , i_auth_level_code
    , i_cust_id
    , i_allograph_name
    , i_is_fix_contract
    , i_right_order
    , i_realtor_name
    , i_realtor_id
    , systimestamp
    ,systimestamp
    );
  END SP_INS_APPR_DOC_AUTHORIZER;

  --**************************************************************************
-- SP_UPD_APPR_DOC_AUTHORIZER
-- Purpose: 修改批覆書核轉人員
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_UPD_APPR_DOC_AUTHORIZER
  ( i_appr_doc_authorizer_seq_no IN NUMBER   -- 批覆書核轉人員序號
  , i_appr_doc_seq_no            IN NUMBER   -- 批覆書主檔序號
  , i_auth_level_code            IN VARCHAR2 -- 權限代號
  , i_cust_id                    IN VARCHAR2 -- 銀行歸戶統編
  , i_allograph_name             IN VARCHAR2 -- 代書人員姓名
  , i_is_fix_contract            IN VARCHAR2 -- 是否為制式合約
  , i_right_order                IN NUMBER   -- 權限順位
  , i_realtor_name               IN VARCHAR2 -- 房屋仲介姓名
  , i_realtor_id                 IN VARCHAR2 -- 房屋仲介統編
  , o_row_count                  OUT NUMBER  -- 異動筆數
  ) AS
  BEGIN 
    UPDATE EDLS.TB_APPR_DOC_AUTHORIZER 
    SET APPR_DOC_SEQ_NO = i_appr_doc_seq_no, 
     AUTH_LEVEL_CODE = i_auth_level_code, 
     CUST_ID = i_cust_id, 
     ALLOGRAPH_NAME = i_allograph_name, 
     IS_FIX_CONTRACT = i_is_fix_contract, 
     RIGHT_ORDER = i_right_order, 
     REALTOR_NAME = i_realtor_name, 
     REALTOR_ID = i_realtor_id,
     AMEND_DATE = systimestamp
    WHERE APPR_DOC_AUTHORIZER_SEQ_NO = i_appr_doc_authorizer_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_APPR_DOC_AUTHORIZER;

--**************************************************************************
-- SP_DEL_APPR_DOC_AUTHORIZER
-- Purpose: 刪除批覆書核轉人員
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************  
  PROCEDURE SP_DEL_APPR_DOC_AUTHORIZER
  ( i_appr_doc_authorizer_seq_no IN NUMBER  -- 批覆書核轉人員序號
  , o_row_count                  OUT NUMBER -- 刪除筆數
  ) AS
  BEGIN
    DELETE EDLS.TB_APPR_DOC_AUTHORIZER
    WHERE APPR_DOC_AUTHORIZER_SEQ_NO = i_appr_doc_authorizer_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_APPR_DOC_AUTHORIZER;

--**************************************************************************
-- SP_INS_CLONE_APPR_DOC
-- Purpose: 複製批覆書主檔其下所有table
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.23  performance adjust
-- 1.1 詹宏茂                  2019.11.29  移除信保查覆書新增邏輯
-- 1.2 吳筠宜                  2020.11.23  新增複製擔保品設定金額資訊檔
-- 1.3 Chester   2021.04.09  新增線上動撥、線上還款
--**************************************************************************
  PROCEDURE SP_INS_CLONE_APPR_DOC
  ( i_appr_doc_seq_no      IN NUMBER   -- 批覆書主檔序號
  , i_customer_loan_seq_no IN NUMBER   -- 授信戶主檔序號 
  , i_appr_doc_no          IN VARCHAR2 -- 批覆書編號
  , i_date                 IN VARCHAR2 -- 現在交易日
  , i_branch               IN VARCHAR2 -- 交易分行
  , new_appr_doc_seq_no    OUT NUMBER  -- 新批覆書主檔序號
  ) AS
  --宣告舊有批覆書
  appr_cur SYS_REFCURSOR;
  --宣告批覆書活動設定檔
  appr_doc_activity_cur SYS_REFCURSOR;
  --宣告批覆書核轉人員
  appr_doc_authorizer_cur SYS_REFCURSOR;
  --宣告批覆書下保證人資訊
  guarantor_cur SYS_REFCURSOR;
  --宣告以批覆書主檔序號記錄的批覆書延伸資訊檔
  appr_doc_ext_cur SYS_REFCURSOR;
  --宣告批覆書的反向承諾資訊  
  coll_reverse_cur SYS_REFCURSOR;
  --宣告批覆書下擔保品登錄檔
  collateral_cur SYS_REFCURSOR;
  --宣告擔保品設定金額資訊檔
  coll_setting_amt_cur SYS_REFCURSOR;
  --宣告信保查覆書資訊
  credit_guarantee_cur SYS_REFCURSOR;
  --宣告批覆書下股票擔保品登錄檔
  stocks_cur SYS_REFCURSOR;
  --宣告分項額度資訊
  limit_cur SYS_REFCURSOR;
  --宣告應收帳款預支價金額度資訊
  limit_ar_cur SYS_REFCURSOR;
  --宣告間接授信批示條件檔
  inloan_prof_cur SYS_REFCURSOR;
  --宣告墊付股款額度設定檔
  prepay_stock_cur SYS_REFCURSOR;
  --宣告分項額度批示條件檔
  limit_prof_cur SYS_REFCURSOR;
  --宣告專案屬性註記批示條件檔資訊
  proj_cond_prof_cur SYS_REFCURSOR;
  --宣告批覆書暫存資料檔
  appr_temp_cur SYS_REFCURSOR;

  APPR_DOC_DATA TB_APPR_DOC%ROWTYPE;
  APPR_DOC_ACTIVITY_DATA TB_APPR_DOC_ACTIVITY_PROFILE%ROWTYPE;
  APPR_DOC_AUTHORIZER_DATA TB_APPR_DOC_AUTHORIZER%ROWTYPE;
  GUARANTOR_DATA TB_GUARANTOR%ROWTYPE;
  APPR_DOC_EXT_DATA TB_APPR_DOC_EXTENSION%ROWTYPE;
  COLL_REVERSE_DATA TB_COLL_REVERSE_COMMIT%ROWTYPE;
  COLLATEAL_DATA TB_COLL%ROWTYPE;
  CREDIT_GUARANTEE_DATA TB_CG_APPR_DOC%ROWTYPE;
  COLL_SETTING_AMT_DATA TB_COLL_SETTING_AMT%ROWTYPE;
  STOCKS_DATA TB_COLL_STOCK%ROWTYPE;
  LIMIT_DATA TB_LIMIT%ROWTYPE;
  LIMIT_AR_DATA TB_LIMIT_AR%ROWTYPE;
  INLOAN_PROF_DATA TB_APPR_DOC_INLOAN_PROFILE%ROWTYPE;
  PREPAY_STOCK_DATA TB_LIMIT_PREPAY_STOCK%ROWTYPE;
  LIMIT_PROF_DATA TB_LIMIT_PROFILE%ROWTYPE;
  PROJ_COND_PROF_DATA TB_LIMIT_PROJ_COND_PROF%ROWTYPE;
  APPR_TEMP_DATA TB_APPR_DOC_TEMP%ROWTYPE;

  new_activity_pro_seq_no TB_APPR_DOC_ACTIVITY_PROFILE.APPR_DOC_ACTIVITY_PRO_SEQ_NO%type;
  new_appr_doc_authorizer_seq_no TB_APPR_DOC_AUTHORIZER.APPR_DOC_AUTHORIZER_SEQ_NO%type;
  new_guarantor_seq_no TB_GUARANTOR.GUARANTOR_SEQ_NO%type;
  new_appr_doc_extension_seq_no TB_APPR_DOC_EXTENSION.APPR_DOC_EXTENSION_SEQ_NO%type;
  new_coll_reverse_commit_seq_no TB_COLL_REVERSE_COMMIT.COLL_REVERSE_COMMIT_SEQ_NO%type;
  new_cg_appr_doc_seq_no TB_CG_APPR_DOC.CG_APPR_DOC_SEQ_NO%type;
  new_collateral_seq_no TB_COLL.COLL_SEQ_NO%type;
  new_limit_seq_no TB_LIMIT.LIMIT_SEQ_NO%type;
  new_limit_ar_seq_no TB_LIMIT_AR.LIMIT_AR_SEQ_NO%type;
  new_inloan_prof_seq_no TB_APPR_DOC_INLOAN_PROFILE.INLOAN_PROFILE_SEQ_NO%type;
  new_prepay_stock_seq_no TB_LIMIT_PREPAY_STOCK.PREPAID_STOCK_SEQ_NO%type;
  new_limit_prof_seq_no TB_LIMIT_PROFILE.LIMIT_PROFILE_SEQ_NO%type;
  new_proj_cond_prof_seq_no TB_LIMIT_PROJ_COND_PROF.PROJ_CONDI_PROF_SEQ_NO%type;
  new_appr_temp_seq_no TB_APPR_DOC_TEMP.APPR_DOC_TEMP_SEQ_NO%type;

  o_row_count number;
  v_branch EDLS.TB_BRANCH_CONVERT_CONFIG.UNDER_BRANCH%type;

  stock_array COLL_STOCK_ARRAY := COLL_STOCK_ARRAY();

  BEGIN
    --取得舊有批覆書
    PG_APPR_DOC_LIMIT.SP_GET_APPR_DOC_BY_SEQNO(i_appr_doc_seq_no, appr_cur);
    --取得批覆書活動設定檔
    PG_APPR_DOC_LIMIT.SP_GET_APPR_DOC_ACTIVITYLIST(i_appr_doc_seq_no, appr_doc_activity_cur);
    --取得批覆書核轉人員
    PG_APPR_DOC_LIMIT.SP_GET_APPR_DOC_AUTHORIZER(i_appr_doc_seq_no, appr_doc_authorizer_cur);
    --取得批覆書下保證人資訊
    PG_APPR_DOC_LIMIT.SP_GET_GUARANTOR_UNDER_AD(i_appr_doc_seq_no, null, guarantor_cur);
    --取得以批覆書主檔序號記錄的批覆書延伸資訊檔 2021/04/08
    --PG_APPR_DOC_LIMIT.SP_GET_APPR_DOC_EXTLIST(i_appr_doc_seq_no, null, appr_doc_ext_cur);
    --取得批覆書的反向承諾資訊  
    PG_COLLATERAL.SP_GET_REVERSE_BY_SEQNO(i_appr_doc_seq_no, null, coll_reverse_cur);
    --取得批覆書下擔保品登錄檔
    PG_COLLATERAL.SP_GET_COLLATERAL(i_appr_doc_seq_no, null, collateral_cur);
    --取得批覆書下股票擔保品登錄檔
    PG_COLLATERAL.SP_GET_STOCKS_BY_SEQNO(i_appr_doc_seq_no, null, 'Y', stocks_cur);
    --取得分項額度資訊
    PG_APPR_DOC_LIMIT.SP_GET_LIMIT(i_appr_doc_seq_no, limit_cur);
    --分行轉換
    SELECT UNDER_BRANCH INTO v_branch
      FROM EDLS.TB_BRANCH_CONVERT_CONFIG
     WHERE BRANCH_CODE = i_branch;

    LOOP 
      FETCH appr_cur INTO APPR_DOC_DATA;
      --新增批覆書資訊
      EXIT WHEN appr_cur%NOTFOUND;
      PG_APPR_DOC_LIMIT.SP_INS_APPR_DOC(i_customer_loan_seq_no                          -- 授信戶主檔序號
                                        , i_appr_doc_no                                 -- 批覆書編號
                                        , 'X'                                           -- 批覆書狀態
                                        , APPR_DOC_DATA.apprd_date                      -- 批覆書核準日
                                        , i_date                                        -- 批覆書到期日
                                        , APPR_DOC_DATA.first_drawdown_edate            -- 第一次動用截止日
                                        , APPR_DOC_DATA.total_appr_amt                  -- 總額度
                                        , APPR_DOC_DATA.total_appr_ccy                  -- 總額度幣別
                                        , APPR_DOC_DATA.channel_code                    -- 通路
                                        , APPR_DOC_DATA.appr_drawdown_type              -- 本批覆書動用方式
                                        , APPR_DOC_DATA.loan_purpose                    -- 借款用途
                                        , APPR_DOC_DATA.loan_attributes                 -- 授信性質
                                        , APPR_DOC_DATA.ccl_mk                          -- 綜合額度註記
                                        , APPR_DOC_DATA.source_code                     -- 案件來源
                                        , APPR_DOC_DATA.data_convert_source             -- 資料轉換來源
                                        , APPR_DOC_DATA.acc_branch                      -- 記帳單位
                                        , v_branch                                      -- 作業單位
                                        , APPR_DOC_DATA.under_center                    -- 批覆書所屬中心
                                        , APPR_DOC_DATA.approver_id                     -- 核貸者統編
                                        , APPR_DOC_DATA.apprd_type                      -- 核貸權限別
                                        , APPR_DOC_DATA.effec_period                    -- 批覆書有效期間
                                        , APPR_DOC_DATA.effec_unit                      -- 批覆書有效期間單位
                                        , i_date                                        -- 契約起始日
                                        , APPR_DOC_DATA.contract_period                 -- 契約有效期間
                                        , APPR_DOC_DATA.contract_unit                   -- 契約有效期間單位
                                        , NULL                                          -- 來源批覆書
                                        , NULL                                          -- 目的批覆書
                                        , i_date                                        -- 上次交易日
                                        , APPR_DOC_DATA.inter_media_branch              -- 轉介單位
                                        , APPR_DOC_DATA.report_branch                   -- 報表單位
                                        , APPR_DOC_DATA.profit_branch                   -- 利潤單位
                                        , NULL                                          -- 首次動撥日
                                        , NULL                                          -- 批覆書放行日
                                        , NULL                                          -- 批覆書結束日
                                        , APPR_DOC_DATA.mpl_mort_overdue_cancel_mk      -- 月繳月省房貸因逾期取消功能註記
                                        , 'N'                                           -- 批覆書來源
                                        , APPR_DOC_DATA.system_id                       -- 鍵檔平台
                                        , APPR_DOC_DATA.modifiable                      -- 可執行變更交易
                                        , APPR_DOC_DATA.cross_border_shared_limit_mk    -- 跨境共用額度註記
                                        , new_appr_doc_seq_no                           -- 批覆書主檔序號
                    );
      --
    END LOOP;

    LOOP
    FETCH appr_doc_activity_cur INTO APPR_DOC_ACTIVITY_DATA;
      --取出的活動設定檔複製一份
      EXIT WHEN appr_doc_activity_cur%NOTFOUND;
      PG_APPR_DOC_LIMIT.SP_INS_APPR_DOC_ACTIVITY_PROF(new_appr_doc_seq_no -- 批覆書主檔序號
                                        , APPR_DOC_ACTIVITY_DATA.activity_code   -- 活動代號
                                        , new_activity_pro_seq_no       -- 批覆書活動設定檔序號
                    );
    END LOOP;

    LOOP
      FETCH appr_doc_authorizer_cur INTO APPR_DOC_AUTHORIZER_DATA;
      --取出的批覆書核轉人員複製一份
      EXIT WHEN appr_doc_authorizer_cur%NOTFOUND;
      PG_APPR_DOC_LIMIT.SP_INS_APPR_DOC_AUTHORIZER(new_appr_doc_seq_no       -- 批覆書主檔序號
                                        , APPR_DOC_AUTHORIZER_DATA.auth_level_code                  -- 權限代號
                                        , APPR_DOC_AUTHORIZER_DATA.right_order                      -- 權限順位
                                        , APPR_DOC_AUTHORIZER_DATA.cust_id                          -- 核轉人員統編
                                        , APPR_DOC_AUTHORIZER_DATA.realtor_name                     -- 房屋仲介姓名
                                        , APPR_DOC_AUTHORIZER_DATA.realtor_id                       -- 房屋仲介統編
                                        , APPR_DOC_AUTHORIZER_DATA.allograph_name                   -- 代書人員姓名
                                        , APPR_DOC_AUTHORIZER_DATA.is_fix_contract                  -- 是否為制式合約
                                        , new_appr_doc_authorizer_seq_no -- 批覆書核轉人員序號
                    );
    END LOOP;

    LOOP
      FETCH guarantor_cur INTO GUARANTOR_DATA;
      --新增批覆書下保證人資訊
      EXIT WHEN guarantor_cur%NOTFOUND;
      PG_APPR_DOC_LIMIT.SP_INS_GUARANTOR(new_appr_doc_seq_no       -- 批覆書主檔序號
                                        , null        -- 分項額度主檔序號
                                        , GUARANTOR_DATA.customer_loan_seq_no         -- 授信戶主檔序號
                                        , GUARANTOR_DATA.identity_code                -- 相關身份代號
                                        , GUARANTOR_DATA.country                      -- 保證人國別
                                        , GUARANTOR_DATA.phase                        -- 保證狀態
                                        , GUARANTOR_DATA.cancel_reason_mk             -- 解除原因註記
                                        , GUARANTOR_DATA.percentage                   -- 保證比率
                                        , GUARANTOR_DATA.relationship_code            -- 與主債務人關係
                                        , GUARANTOR_DATA.relation_with_min_debtor     -- 與主債務人次要關係
                                        , GUARANTOR_DATA.is_finan_instit              -- 金融機構註記
                                        , i_date                                      -- 異動日期
                                        , GUARANTOR_DATA.bind_all_mark                -- 綁定整張註記
                                        , new_guarantor_seq_no           -- 回傳保證人序號
                    );
    END LOOP;

    LOOP
      FETCH coll_reverse_cur INTO COLL_REVERSE_DATA;
      --新增反向承諾資訊
      EXIT WHEN coll_reverse_cur%NOTFOUND;
      PG_COLLATERAL.SP_INS_REVERSE_COMMIT(new_appr_doc_seq_no     -- 批覆書主檔序號
                                        , null                      -- 分項額度主檔序號
                                        , COLL_REVERSE_DATA.txn_branch                  -- 交易分行
                                        , COLL_REVERSE_DATA.host_sno                    -- 主機交易序號
                                        , i_date                                        -- 登錄日期
                                        , COLL_REVERSE_DATA.reason_code                 -- 反面承諾原因
                                        , COLL_REVERSE_DATA.reason_memo                 -- 反面承諾原因說明
                                        , i_date                                        -- 承諾期間起日
                                        , COLL_REVERSE_DATA.commit_edate                -- 承諾期間迄日
                                        , COLL_REVERSE_DATA.coll_type                   -- 承諾標的
                                        , COLL_REVERSE_DATA.content_memo                -- 標的物內容說明
                                        , COLL_REVERSE_DATA.cancel_date                 -- 註銷日期
                                        , COLL_REVERSE_DATA.cancel_reason               -- 註銷原因
                                        , COLL_REVERSE_DATA.other_cancel_reason_memo    -- 其他註銷原因說明
                                        , new_coll_reverse_commit_seq_no  -- 反面承諾序號
                    );
    END LOOP;

    LOOP
      FETCH collateral_cur INTO COLLATEAL_DATA;
        EXIT WHEN collateral_cur%NOTFOUND;
       /* 
        --取得信保查覆書資訊(20191129 因信保查覆書序號會重複，因此SA確認移除新增信保查覆書邏輯 )
        PG_COLLATERAL.SP_GET_CG_APPR_DOC_BY_SEQNO(COLLATEAL_DATA.cg_appr_doc_seq_no, credit_guarantee_cur);

        LOOP
          FETCH credit_guarantee_cur INTO CREDIT_GUARANTEE_DATA;
          --新增信保查覆書資訊
          EXIT WHEN credit_guarantee_cur%NOTFOUND;
          PG_COLLATERAL.SP_INS_CG_APPR_DOC( CREDIT_GUARANTEE_DATA.CG_APPR_DOC_NO                -- 信保查覆書編號
                                        , CREDIT_GUARANTEE_DATA.is_obtain_cg_appr_doc         -- 信保查覆書是否取得
                                        , CREDIT_GUARANTEE_DATA.FIRST_DRAWDOWN_MDATE  -- 信保查覆書首動截止日
                                        , CREDIT_GUARANTEE_DATA.LIMIT_DRAWDOWN_MDATE  -- 信保查覆書額度動用截止日
                                        , NULL                                        -- 信保查覆書首動日
                                        , new_cg_appr_doc_seq_no            -- 信保查覆書主檔序號
                    );
        END LOOP;
     */
      --新增擔保品登錄檔     
      PG_COLLATERAL.SP_INS_GENERAL(COLLATEAL_DATA.coll_no                           --擔保品編號
                                        , new_appr_doc_seq_no                       --批覆書主檔序號
                                        , null                                      --分項額度主檔序號
                                        , null                                      --信保查覆書主檔序號(20191129移除信保查覆書)
                                        , COLLATEAL_DATA.coll_type                  --擔保品種類
                                        , COLLATEAL_DATA.setting_amt                --設定金額
                                        , COLLATEAL_DATA.maturity_date              --設定到期日
                                        , COLLATEAL_DATA.new_flag                   --新格式上傳註記
                                        , COLLATEAL_DATA.coll_area_code             --擔保品所在縣市別
                                        , COLLATEAL_DATA.fire_insur_acc_no          --火險扣款帳號
                                        , COLLATEAL_DATA.fire_insur_amt             --火險保險金額
                                        , COLLATEAL_DATA.fire_insur_matu_date       --火險保險到期日
                                        , COLLATEAL_DATA.remark                     --備註
                                        , i_date                                    --異動日期
                                        , COLLATEAL_DATA.coll_status_code           --擔保品狀態
                                        , COLLATEAL_DATA.total_coll_amt             --擔保總值
                                        , COLLATEAL_DATA.eval_total_value           --評估總值
                                        , COLLATEAL_DATA.appr_doc_eval_amt          --本張批覆書之評估總值
                                        , COLLATEAL_DATA.reserved_saving_acc_no     --應收票據之備償帳號
                                        , COLLATEAL_DATA.insur_company_code         --保險公司
                                        , COLLATEAL_DATA.earthq_insur_amt           --地震險金額
                                        , COLLATEAL_DATA.earthq_insur_matu_date     --地震險到期日
                                        , COLLATEAL_DATA.house_owner_name           --房屋所有人姓名
                                        , COLLATEAL_DATA.house_owner_cust_id        --房屋所有人統編
                                        , COLLATEAL_DATA.house_tax_no               --房屋稅籍編號
                                        , COLLATEAL_DATA.house_ownership_date       --房屋所有權取得日
                                        , COLLATEAL_DATA.house_addr                 --房屋座落地址
                                        , COLLATEAL_DATA.other_insur_amt            --其他保險金額
                                        , COLLATEAL_DATA.other_insur_matu_date      --其他保險到期日
                                        , COLLATEAL_DATA.guara_type                 --擔保性質
                                        , COLLATEAL_DATA.credit_guara_type          --信保案件之送保方式
                                        , COLLATEAL_DATA.coll_percent               --擔保品徵提成數
                                        , COLLATEAL_DATA.building_type              --建物型態
                                        , COLLATEAL_DATA.fire_insur_mk              --商業火險註記
                                        , COLLATEAL_DATA.quotation_no               --報價單編號
                                        , COLLATEAL_DATA.disposal_mk                --處分理賠註記
                                        , COLLATEAL_DATA.disposal_date              --處分理賠日期
                                        , COLLATEAL_DATA.disposal_amt               --處分理賠金額
                                        , COLLATEAL_DATA.is_oversea_coll            --是否為海外擔保品
                                        , COLLATEAL_DATA.country                    --國別
                                        , COLLATEAL_DATA.eval_net_value             --評估淨值
                                        , COLLATEAL_DATA.eval_company_code          --鑑估機構
                                        , COLLATEAL_DATA.eval_no                    --鑑估編號
                                        , COLLATEAL_DATA.receive_cancel_agree_date  --塗銷同意書領取日
                                        , COLLATEAL_DATA.receive_building_permit_mk --已取得建照或興建計畫註記
                                        , COLLATEAL_DATA.cross_border_collateral_mk --跨境擔保品註記
                                        , COLLATEAL_DATA.BIND_APPR_DOC_MARK         --綁定整張註記
                                        , COLLATEAL_DATA.APPRAISAL_REPORT_FINISH_DATE--鑑價報告完成日期
                                        , COLLATEAL_DATA.LAST_APPLY_EVAL_NET_VALUE  -- 最近一次申貸時之鑑價評估淨值
                                        , COLLATEAL_DATA.LAST_APPLY_APPRAISAL_DATE  -- 最近一次申貸時之鑑價日期
                                        , COLLATEAL_DATA.FACTORY_REGIST_NO          -- 工廠證號
                                        , COLLATEAL_DATA.FACTORY_REGIST_CUST_ID     -- 工廠登記人統編
                                        , new_collateral_seq_no        --擔保品登錄檔序號
                    );

      --新增綁整張批覆書的擔保品下的擔保品設定金額資訊檔 
        PG_COLLATERAL.SP_GET_COLL_SETTING_AMT(COLLATEAL_DATA.COLL_SEQ_NO, coll_setting_amt_cur);
        LOOP
          FETCH coll_setting_amt_cur INTO COLL_SETTING_AMT_DATA;
          --新增擔保品設定金額資訊檔 
          EXIT WHEN coll_setting_amt_cur%NOTFOUND;
             INSERT INTO EDLS.TB_COLL_SETTING_AMT 
              ( COLL_SEQ_NO
              , SETTING_ORDER
              , BANK_CODE
              , SETTING_AMT
              , IS_COPERATE
              , CREATE_DATE
              , AMEND_DATE
              )
              VALUES 
              ( new_collateral_seq_no               -- 擔保品登錄檔序號
               , COLL_SETTING_AMT_DATA.SETTING_ORDER -- 設定順位
               , COLL_SETTING_AMT_DATA.BANK_CODE     -- 銀行代碼
               , COLL_SETTING_AMT_DATA.SETTING_AMT   -- 設定金額
               , COLL_SETTING_AMT_DATA.IS_COPERATE   -- 是否設定於法金 
               , SYSTIMESTAMP
               , SYSTIMESTAMP
              );
        END LOOP;
    END LOOP;

    LOOP
      FETCH stocks_cur INTO STOCKS_DATA;
        EXIT WHEN stocks_cur%NOTFOUND;
        --將 STOCKS_DATA 轉 COLL_STOCK_ARRAY
        stock_array.EXTEND;
        stock_array(stock_array.LAST) := COLL_STOCK(new_appr_doc_seq_no
                              ,null
                              ,STOCKS_DATA.coll_no
                              ,STOCKS_DATA.coll_provider_id
                              ,STOCKS_DATA.publish_company_id
                              ,STOCKS_DATA.publish_country_code
                              ,STOCKS_DATA.bind_appr_doc_mark);
    END LOOP;
    --新增股票擔保品登錄檔
    IF (stock_array.count > 0) THEN
        PG_COLLATERAL.SP_INS_STOCK(stock_array, o_row_count);
    END IF;

    LOOP
      FETCH limit_cur INTO LIMIT_DATA;
        EXIT WHEN limit_cur%NOTFOUND;

        PG_APPR_DOC_LIMIT.SP_INS_LIMIT(new_appr_doc_seq_no      -- 批覆書主檔序號
                                        , LIMIT_DATA.limit_type          -- 額度種類
                                        , LIMIT_DATA.serial_no           -- 序號
                                        , LIMIT_DATA.business_type       -- 業務類別
                                        , LIMIT_DATA.business_code       -- 業務代碼
                                        , LIMIT_DATA.period_type         -- 融資期間種類
                                        , LIMIT_DATA.is_guaranteed       -- 有無擔保註記
                                        , LIMIT_DATA.ccy_type            -- 幣別種類
                                        , LIMIT_DATA.right_mk            -- 追索權註記
                                        , LIMIT_DATA.is_forward          -- 即遠期註記
                                        , LIMIT_DATA.currency            -- 分項額度幣別
                                        , LIMIT_DATA.apprd_sub_limit_amt -- 分項核准額度
                                        , LIMIT_DATA.limit_drawdown_type -- 動用方式
                                        , 'X'                            -- 分項額度狀態
                                        , new_limit_seq_no               -- 分項額度主檔序號
                                        );

        --取得應收帳款預支價金額度資訊    
        PG_APPR_DOC_LIMIT.SP_GET_LIMIT_AR(LIMIT_DATA.limit_seq_no, limit_ar_cur);

        LOOP
          FETCH limit_ar_cur INTO LIMIT_AR_DATA;
          EXIT WHEN limit_ar_cur%NOTFOUND;
          --新增應收帳款預支價金額度資訊
          PG_APPR_DOC_LIMIT.SP_INS_LIMIT_AR(new_limit_seq_no      -- 分項額度主檔序號
                                        , LIMIT_AR_DATA.txn_branch            -- 交易分行
                                        , LIMIT_AR_DATA.host_sno              -- 主機交易序號
                                        , LIMIT_AR_DATA.txn_date              -- 登錄日期
                                        , LIMIT_AR_DATA.registry_mk           -- 登錄解除註記
                                        , LIMIT_AR_DATA.pre_paid_balance      -- 預支現欠
                                        , LIMIT_AR_DATA.pre_paid_percentage   -- 預支成數
                                        , LIMIT_AR_DATA.invoice_balance_amt   -- 發票轉讓餘額
                                        , LIMIT_AR_DATA.paymt_type            -- 償還方法
                                        , new_limit_ar_seq_no     -- 應收帳款預支價金額度資訊序號
                                        );
        END LOOP;

        --取得間接授信批示條件檔
        PG_APPR_DOC_LIMIT.SP_GET_APPR_DOC_INLOAN_PROF(LIMIT_DATA.limit_seq_no, inloan_prof_cur);

        LOOP
          FETCH inloan_prof_cur INTO INLOAN_PROF_DATA;
          EXIT WHEN inloan_prof_cur%NOTFOUND;
          --新增間接授信批示條件檔
          PG_APPR_DOC_LIMIT.SP_INS_APPR_DOC_INLOAN_PROF(new_limit_seq_no   -- 分項額度主檔序號
                                        , INLOAN_PROF_DATA.ccy_mk            -- 幣別註記
                                        , INLOAN_PROF_DATA.BASE_RATE_TYPE   -- 基放類別
                                        , INLOAN_PROF_DATA.intst_rate_type   -- 利率類別
                                        , INLOAN_PROF_DATA.intst_spread_rate -- 利率加減碼
                                        , INLOAN_PROF_DATA.paymt_type        -- 償還方法
                                        , INLOAN_PROF_DATA.consign_paymt_acc -- 委託繳息帳號
                                        , new_inloan_prof_seq_no   -- 間接授信批示條件檔序號
                                        );
        END LOOP;

        --取得墊付股款額度設定檔
        PG_APPR_DOC_LIMIT.SP_GET_PREPAY_STOCK(LIMIT_DATA.limit_seq_no, null, prepay_stock_cur);

        LOOP
          FETCH prepay_stock_cur INTO PREPAY_STOCK_DATA;
          EXIT WHEN prepay_stock_cur%NOTFOUND;
          --新增墊付股款額度設定檔
          PG_APPR_DOC_LIMIT.SP_INS_PREPAY_STOCK(new_limit_seq_no       -- 分項額度主檔序號
                                        , PREPAY_STOCK_DATA.sub_company_id     -- 子公司統編
                                        , PREPAY_STOCK_DATA.appr_limit_amt     -- 核准額度
                                        , PREPAY_STOCK_DATA.total_drawdown_amt -- 預佔累積動用金額
                                        , new_prepay_stock_seq_no    -- 墊付股款額度設定檔序號
                                        );
        END LOOP;

        --取得分項額度下保證人資訊
        PG_APPR_DOC_LIMIT.SP_GET_GUARANTOR_UNDER_AD(null, LIMIT_DATA.limit_seq_no, guarantor_cur);

        LOOP
          FETCH guarantor_cur INTO GUARANTOR_DATA;
          EXIT WHEN guarantor_cur%NOTFOUND;
          --新增分項額度下保證人資訊
          PG_APPR_DOC_LIMIT.SP_INS_GUARANTOR(new_appr_doc_seq_no       -- 批覆書主檔序號
                                        , new_limit_seq_no        -- 分項額度主檔序號
                                        , GUARANTOR_DATA.customer_loan_seq_no         -- 授信戶主檔序號
                                        , GUARANTOR_DATA.identity_code                -- 相關身份代號
                                        , GUARANTOR_DATA.country                      -- 保證人國別
                                        , GUARANTOR_DATA.phase                        -- 保證狀態
                                        , GUARANTOR_DATA.cancel_reason_mk             -- 解除原因註記
                                        , GUARANTOR_DATA.percentage                   -- 保證比率
                                        , GUARANTOR_DATA.relationship_code            -- 與主債務人關係
                                        , GUARANTOR_DATA.relation_with_min_debtor     -- 與主債務人次要關係
                                        , GUARANTOR_DATA.is_finan_instit              -- 金融機構註記
                                        , i_date                                      -- 異動日期
                                        , GUARANTOR_DATA.bind_all_mark                -- 綁定整張註記
                                        , new_guarantor_seq_no           -- 回傳保證人序號
                    );
        END LOOP;

        --取得批覆書主檔序號記錄的批覆書延伸資訊檔-聯貸案
        PG_APPR_DOC_PERSON.SP_GET_APPR_DOC_EXT(LIMIT_DATA.APPR_DOC_SEQ_NO, LIMIT_DATA.limit_seq_no, '10', null, appr_doc_ext_cur);

        LOOP
          FETCH appr_doc_ext_cur INTO APPR_DOC_EXT_DATA;
          EXIT WHEN appr_doc_ext_cur%NOTFOUND;
          --新增批覆書主檔序號記錄的批覆書延伸資訊檔-聯貸案
          PG_APPR_DOC_PERSON.SP_INS_APPR_DOC_EXT(new_appr_doc_seq_no       -- 批覆書主檔序號
                                        , new_limit_seq_no                 -- 分項額度主檔序號
                                        , APPR_DOC_EXT_DATA.data_type      -- 資料類型
                                        , APPR_DOC_EXT_DATA.REGISTRY_MK    -- 登錄解除註記
                                        , APPR_DOC_EXT_DATA.TXN_BRANCH     -- 交易分行
                                        , i_date                           -- 交易日期
                                        , APPR_DOC_EXT_DATA.txn_time       -- 交易時間
                                        , APPR_DOC_EXT_DATA.host_sno       -- 主機交易序號
                                        , APPR_DOC_EXT_DATA.teller_emp_id  -- 櫃員員編
                                        , APPR_DOC_EXT_DATA.SUP_EMP_ID     -- 主管員編
                                        , APPR_DOC_EXT_DATA.SUP_CARD       -- 主管授權代號
                                        , APPR_DOC_EXT_DATA.template_data  -- 資料內容
                                        , new_appr_doc_extension_seq_no    -- 批覆書延伸資訊檔序號
                    );
        END LOOP;
		
		--取得批覆書主檔序號記錄的批覆書延伸資訊檔-線上動撥與線上還款
        PG_APPR_DOC_PERSON.SP_GET_APPR_DOC_EXT(LIMIT_DATA.APPR_DOC_SEQ_NO, LIMIT_DATA.limit_seq_no, '25', null, appr_doc_ext_cur);
        LOOP
          FETCH appr_doc_ext_cur INTO APPR_DOC_EXT_DATA;
          EXIT WHEN appr_doc_ext_cur%NOTFOUND;
          --新增批覆書主檔序號記錄的批覆書延伸資訊檔-聯貸案
          PG_APPR_DOC_PERSON.SP_INS_APPR_DOC_EXT(new_appr_doc_seq_no       -- 批覆書主檔序號
                                        , new_limit_seq_no                 -- 分項額度主檔序號
                                        , APPR_DOC_EXT_DATA.data_type      -- 資料類型
                                        , APPR_DOC_EXT_DATA.REGISTRY_MK    -- 登錄解除註記
                                        , APPR_DOC_EXT_DATA.TXN_BRANCH     -- 交易分行
                                        , i_date                           -- 交易日期
                                        , APPR_DOC_EXT_DATA.txn_time       -- 交易時間
                                        , APPR_DOC_EXT_DATA.host_sno       -- 主機交易序號
                                        , APPR_DOC_EXT_DATA.teller_emp_id  -- 櫃員員編
                                        , APPR_DOC_EXT_DATA.SUP_EMP_ID     -- 主管員編
                                        , APPR_DOC_EXT_DATA.SUP_CARD       -- 主管授權代號
                                        , APPR_DOC_EXT_DATA.template_data  -- 資料內容
                                        , new_appr_doc_extension_seq_no    -- 批覆書延伸資訊檔序號
                    );
        END LOOP;

        --取得分項額度批示條件檔
        PG_APPR_DOC_LIMIT.SP_GET_LIMIT_PROFILE(LIMIT_DATA.limit_seq_no, limit_prof_cur);

        LOOP
          FETCH limit_prof_cur INTO LIMIT_PROF_DATA;
          EXIT WHEN limit_prof_cur%NOTFOUND;
          --新增分項額度批示條件檔
          PG_APPR_DOC_LIMIT.SP_INS_LIMIT_PROFILE(new_limit_seq_no                     -- 分項額度主檔序號
                                        , LIMIT_PROF_DATA.base_rate_type              -- 基放類別
                                        , LIMIT_PROF_DATA.spread_rate                 -- 放款利率加減碼值
                                        , LIMIT_PROF_DATA.interest_rate               -- 放款利率
                                        , LIMIT_PROF_DATA.fee_rate                    -- 手續費率
                                        , LIMIT_PROF_DATA.jcic_loan_biz_code          -- 融資業務分類
                                        , LIMIT_PROF_DATA.interest_rate_type          -- 利率類別
                                        , LIMIT_PROF_DATA.interest_schedule_type      -- 利率計劃類別
                                        , LIMIT_PROF_DATA.apprd_drawdown_unit         -- 核准動用期間單位
                                        , LIMIT_PROF_DATA.apprd_drawdown_period       -- 核准動用期間
                                        , LIMIT_PROF_DATA.purpose_code                -- 用途別
                                        , LIMIT_PROF_DATA.loan_subcategory            -- 貸放細目
                                        , LIMIT_PROF_DATA.credit_loan_prod_code       -- 信貸產品編號
                                        , LIMIT_PROF_DATA.repaymt_source              -- 償還來源
                                        , LIMIT_PROF_DATA.prnp_grace_period           -- 還本寬限期
                                        , '1'                                         -- 是否可動用註記
                                        , LIMIT_PROF_DATA.collateral_type             -- 擔保品種類
                                        , LIMIT_PROF_DATA.appr_intst_rate             -- 批覆時核貸利率
                                        , LIMIT_PROF_DATA.pd_value                    -- PD值
                                        , LIMIT_PROF_DATA.lgd_value                   -- LGD值
                                        , NULL                                        -- 分項首次動撥日
                                        , 'N'                                         -- 自動展期註記
                                        , LIMIT_PROF_DATA.credit_guara_fee_rate       -- 信保手續費率 
                                        , LIMIT_PROF_DATA.paymt_type                  -- 償還方法
                                        , LIMIT_PROF_DATA.consign_paymt_acc           -- 委託繳息帳號
                                        , LIMIT_PROF_DATA.intst_upper_rate            -- 上限利率
                                        , LIMIT_PROF_DATA.intst_lower_rate            -- 下限利率
                                        , LIMIT_PROF_DATA.guara_calc_type             -- 保證計費方式
                                        , LIMIT_PROF_DATA.trans_accept_fee_rate       -- 信用狀轉承兌費率
                                        , LIMIT_PROF_DATA.service_fee_data            -- 手續費設定條款
                                        , LIMIT_PROF_DATA.deposit_pledge_mk           -- 存單質借註記
                                        , new_limit_prof_seq_no              -- 分項批示條件檔序號
                                        );
        END LOOP;

        --取得專案屬性註記批示條件檔資訊
        PG_APPR_DOC_LIMIT.SP_GET_LIMIT_PROJ_COND_PROF(LIMIT_DATA.limit_seq_no, proj_cond_prof_cur);

        LOOP
          FETCH proj_cond_prof_cur INTO PROJ_COND_PROF_DATA;
          EXIT WHEN proj_cond_prof_cur%NOTFOUND;
          --新增專案屬性註記批示條件檔資訊
          PG_APPR_DOC_LIMIT.SP_INS_LIMIT_PROJ_COND_PROF(new_limit_prof_seq_no, PROJ_COND_PROF_DATA.project_code, new_proj_cond_prof_seq_no);
        END LOOP;

        --取得分項額度下的擔保品登錄檔
        PG_COLLATERAL.SP_GET_COLLATERAL(i_appr_doc_seq_no, LIMIT_DATA.limit_seq_no, collateral_cur);

        LOOP
        FETCH collateral_cur INTO COLLATEAL_DATA;
        EXIT WHEN collateral_cur%NOTFOUND;
          /* 
          --取得分項額度下的信保查覆書資訊(20191129 因信保查覆書序號會重複，因此SA確認移除新增信保查覆書邏輯 )
          PG_COLLATERAL.SP_GET_CG_APPR_DOC_BY_SEQNO(COLLATEAL_DATA.cg_appr_doc_seq_no, credit_guarantee_cur);

          LOOP
            FETCH credit_guarantee_cur INTO CREDIT_GUARANTEE_DATA;
            EXIT WHEN credit_guarantee_cur%NOTFOUND;
            --新增分項額度下的信保查覆書資訊
            PG_COLLATERAL.SP_INS_CG_APPR_DOC( CREDIT_GUARANTEE_DATA.cg_appr_doc_no    -- 信保查覆書編號
                                        , CREDIT_GUARANTEE_DATA.is_obtain_cg_appr_doc -- 信保查覆書是否取得
                                        , CREDIT_GUARANTEE_DATA.FIRST_DRAWDOWN_MDATE  -- 信保查覆書首動截止日
                                        , CREDIT_GUARANTEE_DATA.LIMIT_DRAWDOWN_MDATE  -- 信保查覆書額度動用截止日
                                        , NULL                                        -- 信保查覆書首動日
                                        , new_cg_appr_doc_seq_no                      -- 信保查覆書主檔序號
                    );
          END LOOP;
          */
          --新增分項額度下的擔保品登錄檔   
          PG_COLLATERAL.SP_INS_GENERAL(COLLATEAL_DATA.coll_no                       --擔保品編號
                                        , new_appr_doc_seq_no                       --批覆書主檔序號
                                        , new_limit_seq_no                          --分項額度主檔序號
                                        , null                                      --信保查覆書主檔序號(20191129移除信保查覆書邏輯)
                                        , COLLATEAL_DATA.coll_type                  --擔保品種類
                                        , COLLATEAL_DATA.setting_amt                --設定金額
                                        , COLLATEAL_DATA.maturity_date              --設定到期日
                                        , COLLATEAL_DATA.new_flag                   --新格式上傳註記
                                        , COLLATEAL_DATA.coll_area_code             --擔保品所在縣市別
                                        , COLLATEAL_DATA.fire_insur_acc_no          --火險扣款帳號
                                        , COLLATEAL_DATA.fire_insur_amt             --火險保險金額
                                        , COLLATEAL_DATA.fire_insur_matu_date       --火險保險到期日
                                        , COLLATEAL_DATA.remark                     --備註
                                        , i_date                                    --異動日期
                                        , COLLATEAL_DATA.coll_status_code           --擔保品狀態
                                        , COLLATEAL_DATA.total_coll_amt             --擔保總值
                                        , COLLATEAL_DATA.eval_total_value           --評估總值
                                        , COLLATEAL_DATA.appr_doc_eval_amt          --本張批覆書之評估總值
                                        , COLLATEAL_DATA.reserved_saving_acc_no     --應收票據之備償帳號
                                        , COLLATEAL_DATA.insur_company_code         --保險公司
                                        , COLLATEAL_DATA.earthq_insur_amt           --地震險金額
                                        , COLLATEAL_DATA.earthq_insur_matu_date     --地震險到期日
                                        , COLLATEAL_DATA.house_owner_name           --房屋所有人姓名
                                        , COLLATEAL_DATA.house_owner_cust_id        --房屋所有人統編
                                        , COLLATEAL_DATA.house_tax_no               --房屋稅籍編號
                                        , COLLATEAL_DATA.house_ownership_date       --房屋所有權取得日
                                        , COLLATEAL_DATA.house_addr                 --房屋座落地址
                                        , COLLATEAL_DATA.other_insur_amt            --其他保險金額
                                        , COLLATEAL_DATA.other_insur_matu_date      --其他保險到期日
                                        , COLLATEAL_DATA.guara_type                 --擔保性質
                                        , COLLATEAL_DATA.credit_guara_type          --信保案件之送保方式
                                        , COLLATEAL_DATA.coll_percent               --擔保品徵提成數
                                        , COLLATEAL_DATA.building_type              --建物型態
                                        , COLLATEAL_DATA.fire_insur_mk              --商業火險註記
                                        , COLLATEAL_DATA.quotation_no               --報價單編號
                                        , COLLATEAL_DATA.disposal_mk                --處分理賠註記
                                        , COLLATEAL_DATA.disposal_date              --處分理賠日期
                                        , COLLATEAL_DATA.disposal_amt               --處分理賠金額
                                        , COLLATEAL_DATA.is_oversea_coll            --是否為海外擔保品
                                        , COLLATEAL_DATA.country                    --國別
                                        , COLLATEAL_DATA.eval_net_value             --評估淨值
                                        , COLLATEAL_DATA.eval_company_code          --鑑估機構
                                        , COLLATEAL_DATA.eval_no                    --鑑估編號
                                        , COLLATEAL_DATA.receive_cancel_agree_date  --塗銷同意書領取日
                                        , COLLATEAL_DATA.receive_building_permit_mk --已取得建照或興建計畫註記
                                        , COLLATEAL_DATA.cross_border_collateral_mk --跨境擔保品註記
                                        , COLLATEAL_DATA.BIND_APPR_DOC_MARK         --綁定整張註記
                                        , COLLATEAL_DATA.APPRAISAL_REPORT_FINISH_DATE--鑑價報告完成日期
                                        , COLLATEAL_DATA.LAST_APPLY_EVAL_NET_VALUE  -- 最近一次申貸時之鑑價評估淨值
                                        , COLLATEAL_DATA.LAST_APPLY_APPRAISAL_DATE  -- 最近一次申貸時之鑑價日期
                                        , COLLATEAL_DATA.FACTORY_REGIST_NO          -- 工廠證號
                                        , COLLATEAL_DATA.FACTORY_REGIST_CUST_ID     -- 工廠登記人統編
                                        , new_collateral_seq_no                     --擔保品登錄檔序號
                    );

          --新增綁分項的擔保品下的擔保品設定金額資訊檔 
          PG_COLLATERAL.SP_GET_COLL_SETTING_AMT(COLLATEAL_DATA.COLL_SEQ_NO, coll_setting_amt_cur);
          LOOP
            FETCH coll_setting_amt_cur INTO COLL_SETTING_AMT_DATA;
            --新增擔保品設定金額資訊檔 
            EXIT WHEN coll_setting_amt_cur%NOTFOUND;
               INSERT INTO EDLS.TB_COLL_SETTING_AMT 
                ( COLL_SEQ_NO
                , SETTING_ORDER
                , BANK_CODE
                , SETTING_AMT
                , IS_COPERATE
                , CREATE_DATE
                , AMEND_DATE
                )
                VALUES 
                (  new_collateral_seq_no               -- 擔保品登錄檔序號
                 , COLL_SETTING_AMT_DATA.SETTING_ORDER -- 設定順位
                 , COLL_SETTING_AMT_DATA.BANK_CODE     -- 銀行代碼
                 , COLL_SETTING_AMT_DATA.SETTING_AMT   -- 設定金額
                 , COLL_SETTING_AMT_DATA.IS_COPERATE   -- 是否設定於法金 
                 , SYSTIMESTAMP
                 , SYSTIMESTAMP
                );
          END LOOP;
        
        END LOOP;

        --取得批覆書/額度下股票擔保品登錄檔
        PG_COLLATERAL.SP_GET_STOCKS_BY_SEQNO(i_appr_doc_seq_no, LIMIT_DATA.limit_seq_no, 'N', stocks_cur);

        LOOP
          FETCH stocks_cur INTO STOCKS_DATA;
          EXIT WHEN stocks_cur%NOTFOUND;
            --將 STOCKS_DATA 轉 COLL_STOCK_ARRAY
            stock_array.EXTEND;
            stock_array(stock_array.LAST) := COLL_STOCK(new_appr_doc_seq_no
                              ,new_limit_seq_no
                              ,STOCKS_DATA.coll_no
                              ,STOCKS_DATA.coll_provider_id
                              ,STOCKS_DATA.publish_company_id
                              ,STOCKS_DATA.publish_country_code
                              ,STOCKS_DATA.bind_appr_doc_mark);
        END LOOP;
        --新增股票擔保品登錄檔
        IF (stock_array.count > 0) THEN
            PG_COLLATERAL.SP_INS_STOCK(stock_array, o_row_count);
        END IF;
        --取得批覆書暫存資料檔-台幣透支
        PG_APPR_DOC_LIMIT.SP_GET_APPR_DOC_TEMP('1', null, LIMIT_DATA.limit_seq_no, appr_temp_cur);

        LOOP
          FETCH appr_temp_cur INTO APPR_TEMP_DATA;
          EXIT WHEN appr_temp_cur%NOTFOUND;
          --新增批覆書暫存資料檔-台幣透支
          PG_APPR_DOC_LIMIT.SP_INS_APPR_DOC_TEMP('1'      -- 資料類型
                                        , new_appr_doc_seq_no -- 批覆書主檔序號
                                        , new_limit_seq_no    -- 分項額度主檔序號
                                        , APPR_TEMP_DATA.temp_data  -- 資料內容
                                        , new_appr_temp_seq_no      -- 批覆書暫存資料檔序號
                                        );
        END LOOP;

        --取得批覆書暫存資料檔-外幣
        PG_APPR_DOC_LIMIT.SP_GET_APPR_DOC_TEMP('2', null, LIMIT_DATA.limit_seq_no, appr_temp_cur);

        LOOP
          FETCH appr_temp_cur INTO APPR_TEMP_DATA;
          EXIT WHEN appr_temp_cur%NOTFOUND;
          --新增批覆書暫存資料檔-外幣透支
          PG_APPR_DOC_LIMIT.SP_INS_APPR_DOC_TEMP('2'      -- 資料類型
                                        , new_appr_doc_seq_no -- 批覆書主檔序號
                                        , new_limit_seq_no    -- 分項額度主檔序號
                                        , APPR_TEMP_DATA.temp_data  -- 資料內容
                                        , new_appr_temp_seq_no      -- 批覆書暫存資料檔序號
                                        );
        END LOOP;

        --用批覆書主檔序號與分項額度主檔序號取得反面承諾  
        PG_COLLATERAL.SP_GET_REVERSE_BY_SEQNO(i_appr_doc_seq_no, LIMIT_DATA.limit_seq_no, coll_reverse_cur);

        LOOP
          FETCH coll_reverse_cur INTO COLL_REVERSE_DATA;
          EXIT WHEN coll_reverse_cur%NOTFOUND;
          --新增反向承諾資訊
          PG_COLLATERAL.SP_INS_REVERSE_COMMIT(new_appr_doc_seq_no     -- 批覆書主檔序號
                                        , new_limit_seq_no            -- 分項額度主檔序號
                                        , COLL_REVERSE_DATA.txn_branch                  -- 交易分行
                                        , COLL_REVERSE_DATA.host_sno                    -- 主機交易序號
                                        , i_date                                        -- 登錄日期
                                        , COLL_REVERSE_DATA.reason_code                 -- 反面承諾原因
                                        , COLL_REVERSE_DATA.reason_memo                 -- 反面承諾原因說明
                                        , i_date                                        -- 承諾期間起日
                                        , COLL_REVERSE_DATA.commit_edate                -- 承諾期間迄日
                                        , COLL_REVERSE_DATA.coll_type                   -- 承諾標的
                                        , COLL_REVERSE_DATA.content_memo                -- 標的物內容說明
                                        , COLL_REVERSE_DATA.cancel_date                 -- 註銷日期
                                        , COLL_REVERSE_DATA.cancel_reason               -- 註銷原因
                                        , COLL_REVERSE_DATA.other_cancel_reason_memo    -- 其他註銷原因說明
                                        , new_coll_reverse_commit_seq_no  -- 反面承諾序號
                    );
        END LOOP;
    END LOOP;
  END SP_INS_CLONE_APPR_DOC;

--**************************************************************************
-- SP_GET_APPR_DOC_TEMPLIST
-- Purpose: 取得批覆書暫存資料檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_APPR_DOC_TEMPLIST
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN 
    OPEN o_cur FOR
    SELECT APPR_DOC_TEMP_SEQ_NO
    ,APPR_DOC_SEQ_NO
    ,LIMIT_SEQ_NO
    ,DATA_TYPE
    ,TEMP_DATA
    FROM EDLS.TB_APPR_DOC_TEMP
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no
    FOR UPDATE;
  END SP_GET_APPR_DOC_TEMPLIST;

--**************************************************************************
-- SP_UPD_APPR_DOC_TEMP
-- Purpose: 更新批覆書暫存資料檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 許宸禎     2019.11.18  created
--
--**************************************************************************
  PROCEDURE SP_UPD_APPR_DOC_TEMP
  ( i_appr_doc_temp_seq_no      IN NUMBER   -- 批覆書暫存資料檔序號
  , i_data_type                 IN VARCHAR2 -- 資料類型
  , i_appr_doc_seq_no           IN NUMBER   -- 批覆書主檔序號
  , i_limit_seq_no              IN NUMBER   -- 分項額度主檔序號
  , i_temp_data                 IN VARCHAR2 -- 資料內容
  , o_result                   OUT NUMBER   -- 更新筆數
  ) AS
  BEGIN
    UPDATE EDLS.TB_APPR_DOC_TEMP
       SET APPR_DOC_TEMP_SEQ_NO = i_appr_doc_seq_no
         , DATA_TYPE = i_data_type
         , APPR_DOC_SEQ_NO = i_appr_doc_seq_no
         , LIMIT_SEQ_NO = i_limit_seq_no
         , TEMP_DATA = i_temp_data
         , AMEND_DATE = SYSTIMESTAMP
     WHERE APPR_DOC_TEMP_SEQ_NO = i_appr_doc_temp_seq_no;
    o_result := SQL%ROWCOUNT;
  END SP_UPD_APPR_DOC_TEMP;

--**************************************************************************
-- SP_GET_APPR_DOC_EXTLIST
-- Purpose: 取得批覆書延伸資訊檔資訊列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.23  performance adjust
-- 1.2 Chester   2021.04.09  調整分項seq為空值時，僅取的綁整張批覆書的Extend
--**************************************************************************
  PROCEDURE SP_GET_APPR_DOC_EXTLIST
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , i_limit_seq_no    IN NUMBER         -- 分項額度主檔序號
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN 
    OPEN o_cur FOR
    SELECT APPR_DOC_EXTENSION_SEQ_NO
    , APPR_DOC_SEQ_NO
    , LIMIT_SEQ_NO
    , DATA_TYPE
    , REGISTRY_MK
    , TXN_BRANCH
    , TXN_DATE
    , TXN_TIME
    , HOST_SNO
    , TELLER_EMP_ID
    , SUP_EMP_ID
    , SUP_CARD
    , TEMPLATE_DATA
    , CREATE_DATE
    , AMEND_DATE
    FROM EDLS.TB_APPR_DOC_EXTENSION
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no AND ( LIMIT_SEQ_NO = i_limit_seq_no or (i_limit_seq_no is null and LIMIT_SEQ_NO is null ));
  END SP_GET_APPR_DOC_EXTLIST;

--**************************************************************************
-- SP_GET_REMAND_LIMIT_BOOKING
-- Purpose: 查詢仍有預佔額度的預佔額度檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李建邦    2019.06.06  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_REMAND_LIMIT_BOOKING
  ( i_limit_seq_no_list IN ITEM_NUM_ARRAY -- 分項額度主檔序號
  , o_amount            OUT NUMBER        -- 筆數
  ) AS
  BEGIN 
    SELECT COUNT(1) INTO o_amount
    FROM EDLS.TB_limit_booking
    WHERE limit_seq_no IN (SELECT * FROM TABLE (i_limit_seq_no_list))
     AND total_drawdown_amt - total_today_repaymt_amt > 0;
  END SP_GET_REMAND_LIMIT_BOOKING;

--**************************************************************************
-- SP_GET_FILTER_LIMIT_BY_MORT
-- Purpose: 查詢含有特定房貸種類的分項額度個數
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李建邦    2019.06.06  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_FILTER_LIMIT_BY_MORT
  ( i_limit_seq_no_list IN ITEM_NUM_ARRAY -- 分項額度主檔序號
  , i_mortgage_product  IN VARCHAR2       -- 房貸產品種類
  , o_amount            OUT NUMBER        -- 筆數
  ) AS
  BEGIN 
    SELECT COUNT(1) INTO o_amount
    FROM EDLS.TB_LIMIT lt
      INNER JOIN EDLS.TB_LIMIT_PROFILE ltp
        ON lt.LIMIT_SEQ_NO = ltp.LIMIT_SEQ_NO
      INNER JOIN EDLS.TB_prod_mortgage_profile pmp
        ON ltp.LIMIT_PROFILE_SEQ_NO = pmp.LIMIT_PROFILE_SEQ_NO  
    WHERE lt.limit_seq_no IN (SELECT * FROM TABLE (i_limit_seq_no_list))
    AND pmp.mortgage_product = i_mortgage_product;
  END SP_GET_FILTER_LIMIT_BY_MORT;

 --***************************************************
 -- SP_GET_COUNT_UNMODIFIABLE_ACC
 -- Purpose: 取得不可執行變更交易的對應帳號的分項額度個數
 --
 -- Modification History
 -- Person       Date     Comments
 -- --------------   ----------  -----------------
 -- 1.0 ESB19417 李建邦 2018.12.21  created
 -- 1.1 ESB18627 2019.10.23  performance adjust + 邏輯錯誤修改
 --****************************************************
  PROCEDURE SP_GET_COUNT_UNMODIFIABLE_ACC
  ( i_limit_seq_no_list IN ITEM_NUM_ARRAY -- 分項額度主檔序號
  , o_amount            OUT NUMBER        -- 筆數
  ) AS
  BEGIN 
    SELECT SUM(NUM) INTO o_amount 
    FROM (
		SELECT COUNT(1) AS NUM
		FROM EDLS.TB_LIMIT lt
		INNER JOIN EDLS.TB_LOAN ln ON lt.limit_seq_no = ln.limit_seq_no
		WHERE lt.limit_seq_no IN (SELECT * FROM TABLE (i_limit_seq_no_list)) AND
		ln.IS_MODIFY = 'N'
	UNION ALL
		SELECT COUNT(1) AS NUM 
		FROM EDLS.TB_LIMIT lt
		INNER JOIN EDLS.TB_INDR_CREDIT ic ON lt.limit_seq_no = ic.limit_seq_no
		WHERE lt.limit_seq_no IN (SELECT * FROM TABLE (i_limit_seq_no_list)) AND
		ic.MODIFIABLE = 'N'
    );
 END SP_GET_COUNT_UNMODIFIABLE_ACC;

--**************************************************************************
-- SP_GET_LIMIT_LIST_BY_TYPELIST
-- Purpose: 利用分項額度主檔序號列表查詢分項額度彙計檔資料列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李建邦    2019.06.06  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_LIST_BY_TYPELIST
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , i_limit_type_list IN ITEM_ARRAY     -- 額度種類
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN 
    OPEN o_cur FOR
    SELECT lt.LIMIT_SEQ_NO        -- 分項額度主檔序號
      , lt.APPR_DOC_SEQ_NO        -- 批覆書主檔序號
      , lt.LIMIT_TYPE             -- 額度種類
      , lt.SERIAL_NO              -- 序號
      , lt.BUSINESS_TYPE          -- 業務類別
      , lt.BUSINESS_CODE          -- 業務代碼
      , lt.PERIOD_TYPE            -- 融資期間種類
      , lt.IS_GUARANTEED          -- 有無擔保註記
      , lt.CCY_TYPE               -- 幣別種類
      , lt.RIGHT_MK               -- 追索權註記
      , lt.IS_FORWARD             -- 即遠期註記
      , lt.CURRENCY               -- 分項額度幣別
      , lt.APPRD_SUB_LIMIT_AMT    -- 分項核准額度
      , lt.LIMIT_DRAWDOWN_TYPE    -- 動用方式
      , lt.PHASE                  -- 分項額度狀態
      , lp.LIMIT_PROFILE_SEQ_NO   -- 分項批示條件檔序號
      , lp.BASE_RATE_TYPE         -- 基放類別
      , lp.SPREAD_RATE            -- 放款利率加減碼值
      , lp.INTEREST_RATE          -- 放款利率
      , lp.FEE_RATE               -- 手續費率
      , lp.JCIC_LOAN_BIZ_CODE     -- 融資業務分類
      , lp.INTEREST_RATE_TYPE     -- 利率類別
      , lp.INTEREST_SCHEDULE_TYPE -- 利率計劃類別
      , lp.APPRD_DRAWDOWN_UNIT    -- 核准動用期間單位
      , lp.APPRD_DRAWDOWN_PERIOD  -- 核准動用期間
      , lp.PURPOSE_CODE           -- 用途別
      , lp.LOAN_SUBCATEGORY       -- 貸放細目
      , lp.CREDIT_LOAN_PROD_CODE  -- 信貸產品編號
      , lp.REPAYMT_SOURCE         -- 償還來源
      , lp.PRNP_GRACE_PERIOD      -- 還本寬限期
      , lp.ALLOW_DRAWDOWN_MK      -- 是否可動用註記
      , lp.COLLATERAL_TYPE        -- 擔保品別
      , lp.APPR_INTST_RATE        -- 批覆時核貸利率
      ,lp.DEPOSIT_PLEDGE_MK       -- 存單質借註記
      ,lp.PD_VALUE                -- PD值
      ,lp.LGD_VALUE               -- LGD值
      ,lp.FIRST_DRAWDOWN_DATE     -- 分項首次動撥日
      ,lp.OVERDRAFT_EXT_MK        -- 自動展期註記
      ,lp.SERVICE_FEE_DATA        -- 分項批示條件設定檔
      ,lp.CREDIT_GUARA_FEE_RATE   -- 信保手續費率 
      ,lp.PAYMT_TYPE              -- 償還方法
      ,lp.CONSIGN_PAYMT_ACC       -- 委託繳息帳號
      ,lp.INTST_UPPER_RATE        -- 上限利率
      ,lp.INTST_LOWER_RATE        -- 下限利率
      ,lp.GUARA_CALC_TYPE         -- 保證計費方式
      ,lp.TRANS_ACCEPT_FEE_RATE   -- 信用狀轉承兌費率
   FROM EDLS.TB_limit lt INNER JOIN EDLS.TB_limit_profile lp ON lt.limit_seq_no = lp.limit_seq_no
   WHERE lt.appr_doc_seq_no = i_appr_doc_seq_no
    AND lt.limit_type IN (SELECT * FROM TABLE (i_limit_type_list));
 END SP_GET_LIMIT_LIST_BY_TYPELIST;

--***************************************************
-- SP_GET_LIMIT_DTL
-- Purpose: 查詢分項額度彙計檔資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李建邦    2019.06.06  created
-- 1.1 ESB18627  2019.10.23  performance adjust
-- 1.2 ESB18757  2020.04.15  新增查詢欄位-外匯業務類別
--****************************************************
 PROCEDURE SP_GET_LIMIT_DTL
  ( i_limit_seq_no         IN VARCHAR2       -- 分項額度主檔序號
  , i_currency             IN VARCHAR2       -- 分項額度幣別
  , i_forign_business_type IN VARCHAR2       -- 外匯業務類別
  , o_cur                 OUT SYS_REFCURSOR  -- 回傳資料
  ) AS
  BEGIN 
    OPEN o_cur FOR
    SELECT LIMIT_DTL_SEQ_NO        -- 分項額度彙計檔序號
      ,LIMIT_SEQ_NO                -- 分項額度主檔序號
      ,CCY                         -- 幣別
      ,LAST_TXN_DATE               -- 最後交易日
      ,TOTAL_DRAWDOWN_AMT          -- 累積動用金額
      ,TOTAL_REPAYMT_AMT           -- 累積還款金額
      ,TOTAL_APPR_DOC_DRAWDOWN_AMT -- 佔用批覆書累積額度
      ,TOTAL_NEGO_AMT              -- 累積和解總額
      ,FORIGN_BUSINESS_TYPE        -- 外匯業務別
    FROM EDLS.TB_limit_dtl
    WHERE LIMIT_SEQ_NO = i_limit_seq_no
    AND CCY = i_currency
    AND (
           (i_forign_business_type IS NULL AND FORIGN_BUSINESS_TYPE IS NULL)
        OR FORIGN_BUSINESS_TYPE = i_forign_business_type
    );
  END SP_GET_LIMIT_DTL;

 --***************************************************
 -- SP_GET_LT_DTL_LIST_BY_S_LIST
 -- Purpose: 利用分項額度主檔序號列表查詢分項額度彙計檔資料列表
 --
 -- Modification History
 -- Person       Date     Comments
 -- --------------   ----------  -----------------
 -- 1.0 ESB19417 李建邦 2018.12.21  created
 -- 1.1 ESB18627  2019.10.23  performance adjust
 --****************************************************
  PROCEDURE SP_GET_LT_DTL_LIST_BY_S_LIST
  ( i_limit_seq_no_list IN ITEM_NUM_ARRAY -- 分項額度主檔序號
  , o_cur               OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN 
    OPEN o_cur FOR
    SELECT limit_dtl_seq_no        -- 分項額度彙計檔序號
      ,limit_seq_no                -- 分項額度主檔序號
      ,ccy                         -- 幣別
      ,last_txn_date               -- 最後交易日
      ,total_drawdown_amt          -- 累積動用金額
      ,total_repaymt_amt           -- 累積還款金額
      ,total_appr_doc_drawdown_amt -- 佔用批覆書累積額度
      ,total_nego_amt              -- 累積和解總額 
      ,forign_business_type        -- 外匯業務別
    FROM EDLS.TB_limit_dtl
    WHERE limit_seq_no IN (SELECT * FROM TABLE (i_limit_seq_no_list));
  END SP_GET_LT_DTL_LIST_BY_S_LIST;

--***************************************************
-- SP_GET_LT_AR_LIST_BY_S_LIST
-- Purpose: 利用分項額度主檔序號列表查詢應收帳款預支價金資訊
--
-- Modification History
-- Person       Date     Comments
-- --------------   ----------  -----------------
-- 1.0 ESB19417 李建邦 2018.12.21  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--****************************************************
  PROCEDURE SP_GET_LT_AR_LIST_BY_S_LIST
  ( i_limit_seq_no_list IN ITEM_NUM_ARRAY -- 分項額度主檔序號
  , o_cur               OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN 
    OPEN o_cur FOR
    SELECT limit_ar_seq_no -- 應收帳款預支價金額度資訊序號
      ,limit_seq_no        -- 分項額度主檔序號
      ,txn_branch          -- 交易分行
      ,host_sno            -- 主機交易序號
      ,txn_date            -- 登錄日期
      ,registry_mk         -- 登錄解除註記
      ,pre_paid_balance    -- 預支現欠
      ,pre_paid_percentage -- 預支成數
      ,invoice_balance_amt -- 發票轉讓餘額
      ,paymt_type          -- 償還方法
     FROM EDLS.TB_limit_ar
     WHERE limit_seq_no IN (SELECT * FROM TABLE (i_limit_seq_no_list));
  END SP_GET_LT_AR_LIST_BY_S_LIST;

--**************************************************************************
-- SP_DEL_LIMIT_AR_BY_LIMIT
-- Purpose: 利用分項額度主檔序號刪除應收帳款預支價金額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_AR_BY_LIMIT
  ( i_limit_seq_no IN NUMBER  -- 分項額度主檔序號
  , o_row_count    OUT NUMBER -- 回傳筆數
  ) as 
  BEGIN
    DELETE EDLS.TB_LIMIT_AR
    WHERE LIMIT_SEQ_NO = i_limit_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_LIMIT_AR_BY_LIMIT;  

  --**************************************************************************
-- SP_DEL_ALL_AD_AUTHORIZER
-- Purpose: 
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_ALL_AD_AUTHORIZER
  ( i_appr_doc_seq_no IN NUMBER  -- 批覆書主檔序號
  , o_row_count       OUT NUMBER -- 回傳筆數 
  ) as
  BEGIN
    DELETE EDLS.TB_APPR_DOC_AUTHORIZER
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_ALL_AD_AUTHORIZER;

--**************************************************************************
-- SP_INS_SYND_LOAN_ADV_FEE
-- Purpose: 新增聯貸案預收手續費
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 吳筠宜   2019.01.03 created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_SYND_LOAN_ADV_FEE
  ( i_appr_doc_seq_no          IN NUMBER    -- 批覆書主檔序號
  , i_txn_branch               IN VARCHAR2  -- 交易分行
  , i_host_sno                 IN VARCHAR2  -- 主機交易序號
  , i_txn_date                 IN VARCHAR2  -- 登錄日期
  , i_registry_mk              IN VARCHAR2  -- 登錄解除註記
  , i_first_amort_date         IN VARCHAR2  -- 手續費首次入帳日
  , i_drawdown_expired_date    IN VARCHAR2  -- 可動用最後期限
  , i_fee_category             IN VARCHAR2  -- 預收手續費科目
  , i_fee_code                 IN VARCHAR2  -- 手續費代碼
  , i_fee_ccy                  IN VARCHAR2  -- 手續費幣別
  , i_total_fee_amt            IN NUMBER    -- 手續費累計總收取原幣金額
  , i_amort_amt_to_loan_acc_no IN NUMBER    -- 手續費已攤銷掛到帳號的原幣金額
  , i_amort_amt_to_ad_no       IN NUMBER    -- 手續費已攤銷但無掛到帳號之原幣金額
  , i_unamorit_fee_amt         IN NUMBER    -- 手續費尚未攤銷原幣金額
  , i_acc_branch               IN VARCHAR2  -- 預收手續費作帳單位
  , i_new_case_flag            IN VARCHAR2  -- 新舊案註記
  , i_old_case_total_amort_amt IN NUMBER    -- 舊案累計已攤銷金額
  , i_old_case_unamort_amt     IN NUMBER    -- 舊案尚未攤銷金額
  , o_seq_no                   OUT NUMBER   -- 回傳序號
  ) AS 
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_SYND_LOAN_ADVANCE_FEE', o_seq_no); 
    INSERT INTO EDLS.TB_SYND_LOAN_ADVANCE_FEE
    ( SYND_LOAN_ADVANCE_FEE_SEQ_NO
    , APPR_DOC_SEQ_NO 
    , TXN_BRANCH
    , HOST_SNO
    , TXN_DATE
    , REGISTRY_MK 
    , FIRST_AMORT_DATE
    , DRAWDOWN_EXPIRED_DATE 
    , FEE_Category
    , FEE_CODE , FEE_CCY 
    , TOTAL_FEE_AMT
    , AMORT_AMT_TO_LOAN_ACC_NO
    , AMORT_AMT_TO_AD_NO
    , UNAMORIT_FEE_AMT
    , ACC_BRANCH
    , NEW_CASE_FLAG
    , OLD_CASE_TOTAL_AMORT_AMT
    , OLD_CASE_UNAMORT_AMT
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES 
    ( o_seq_no
    , i_appr_doc_seq_no
    , i_txn_branch
    , i_host_sno
    , i_txn_date
    , i_registry_mk
    , i_first_amort_date
    , i_drawdown_expired_date
    , i_fee_category
    , i_fee_code
    , i_fee_ccy
    , i_total_fee_amt
    , i_amort_amt_to_loan_acc_no 
    , i_amort_amt_to_ad_no
    , i_unamorit_fee_amt
    , i_acc_branch
    , i_new_case_flag
    , i_old_case_total_amort_amt
    , i_old_case_unamort_amt 
    , systimestamp
    , systimestamp
    );
  END SP_INS_SYND_LOAN_ADV_FEE;

--**************************************************************************
-- SP_GET_SYND_LOAN_ADV_FEE
-- Purpose: 查詢聯貸案預收手續費
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 吳筠宜   2019.01.03 created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_SYND_LOAN_ADV_FEE
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT SYND_LOAN_ADVANCE_FEE_SEQ_NO-- 聯貸案預收手續費序號
      , APPR_DOC_SEQ_NO                -- 批覆書主檔序號
      , TXN_BRANCH                     -- 交易分行
      , HOST_SNO                       -- 主機交易序號
      , TXN_DATE                       -- 登錄日期
      , REGISTRY_MK                    -- 登錄解除註記
      , FIRST_AMORT_DATE               -- 手續費首次入帳日
      , DRAWDOWN_EXPIRED_DATE          -- 可動用最後期限
      , FEE_Category                   -- 預收手續費科目
      , FEE_CODE                       -- 手續費代碼
      , FEE_CCY                        -- 手續費幣別
      , TOTAL_FEE_AMT                  -- 手續費累計總收取原幣金額
      , AMORT_AMT_TO_LOAN_ACC_NO       -- 手續費已攤銷掛到帳號的原幣金額
      , AMORT_AMT_TO_AD_NO             -- 手續費已攤銷但無掛到帳號之原幣金額
      , UNAMORIT_FEE_AMT               -- 手續費尚未攤銷原幣金額
      , ACC_BRANCH                     -- 預收手續費作帳單位
      , NEW_CASE_FLAG                  -- 新舊案註記
      , OLD_CASE_TOTAL_AMORT_AMT       -- 舊案累計已攤銷金額
      , OLD_CASE_UNAMORT_AMT           -- 舊案尚未攤銷金額
    FROM EDLS.TB_SYND_LOAN_ADVANCE_FEE
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no;
 END SP_GET_SYND_LOAN_ADV_FEE;   

--**************************************************************************
-- SP_GET_SYND_LOAN_ADV_FEE_ONE
-- Purpose: 查詢聯貸案預收手續費
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.01.03  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
 PROCEDURE SP_GET_SYND_LOAN_ADV_FEE_ONE
 ( i_appr_doc_seq_no           IN NUMBER         -- 批覆書主檔序號
 , i_fee_code                  IN VARCHAR2       -- 手續費代碼
 , o_cur                       OUT SYS_REFCURSOR -- 回傳資料
 ) AS
 BEGIN
  OPEN o_cur FOR
   SELECT SYND_LOAN_ADVANCE_FEE_SEQ_NO -- 聯貸案預收手續費序號
      , APPR_DOC_SEQ_NO                -- 批覆書主檔序號
      , TXN_BRANCH                     -- 交易分行
      , HOST_SNO                       -- 主機交易序號
      , TXN_DATE                       -- 登錄日期
      , REGISTRY_MK                    -- 登錄解除註記
      , FIRST_AMORT_DATE               -- 手續費首次入帳日
      , DRAWDOWN_EXPIRED_DATE          -- 可動用最後期限
      , FEE_Category                   -- 預收手續費科目
      , FEE_CODE                       -- 手續費代碼
      , FEE_CCY                        -- 手續費幣別
      , TOTAL_FEE_AMT                  -- 手續費累計總收取原幣金額
      , AMORT_AMT_TO_LOAN_ACC_NO       -- 手續費已攤銷掛到帳號的原幣金額
      , AMORT_AMT_TO_AD_NO             -- 手續費已攤銷但無掛到帳號之原幣金額
      , UNAMORIT_FEE_AMT               -- 手續費尚未攤銷原幣金額
      , ACC_BRANCH                     -- 預收手續費作帳單位
      , NEW_CASE_FLAG                  -- 新舊案註記
      , OLD_CASE_TOTAL_AMORT_AMT       -- 舊案累計已攤銷金額
      , OLD_CASE_UNAMORT_AMT           -- 舊案尚未攤銷金額
  FROM EDLS.TB_SYND_LOAN_ADVANCE_FEE
  WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no
   AND FEE_CODE = i_fee_code;
 END SP_GET_SYND_LOAN_ADV_FEE_ONE;   

--**************************************************************************
-- SP_UPD_SYND_LOAN_ADV_FEE
-- Purpose: 更新聯貸案預收手續費
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 吳筠宜   2019.01.03 created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_UPD_SYND_LOAN_ADV_FEE
  ( i_synd_loan_advance_fee_seq_no IN NUMBER   -- 聯貸案預收手續費序號
  , i_appr_doc_seq_no              IN NUMBER   -- 批覆書主檔序號
  , i_txn_branch                   IN VARCHAR2 -- 交易分行
  , i_host_sno                     IN VARCHAR2 -- 主機交易序號
  , i_txn_date                     IN VARCHAR2 -- 登錄日期
  , i_registry_mk                  IN VARCHAR2 -- 登錄解除註記
  , i_first_amort_date             IN VARCHAR2 -- 手續費首次入帳日
  , i_drawdown_expired_date        IN VARCHAR2 -- 可動用最後期限
  , i_fee_category                 IN VARCHAR2 -- 預收手續費科目
  , i_fee_code                     IN VARCHAR2 -- 手續費代碼
  , i_fee_ccy                      IN VARCHAR2 -- 手續費幣別
  , i_total_fee_amt                IN NUMBER   -- 手續費累計總收取原幣金額
  , i_amort_amt_to_loan_acc_no     IN NUMBER   -- 手續費已攤銷掛到帳號的原幣金額
  , i_amort_amt_to_ad_no           IN NUMBER   -- 手續費已攤銷但無掛到帳號之原幣金額
  , i_unamorit_fee_amt             IN NUMBER   -- 手續費尚未攤銷原幣金額
  , i_acc_branch                   IN VARCHAR2 -- 預收手續費作帳單位
  , i_new_case_flag                IN VARCHAR2 -- 新舊案註記
  , i_old_case_total_amort_amt     IN NUMBER   -- 舊案累計已攤銷金額
  , i_old_case_unamort_amt         IN NUMBER   -- 舊案尚未攤銷金額
  , o_row_count                    OUT NUMBER  -- 回傳更新筆數
 ) AS
 BEGIN
  UPDATE EDLS.TB_SYND_LOAN_ADVANCE_FEE
   SET
    APPR_DOC_SEQ_NO = i_appr_doc_seq_no
    , TXN_BRANCH = i_txn_branch
    , HOST_SNO = i_host_sno
    , TXN_DATE = i_txn_date
    , REGISTRY_MK = i_registry_mk
    , FIRST_AMORT_DATE = i_first_amort_date
    , DRAWDOWN_EXPIRED_DATE = i_drawdown_expired_date
    , FEE_CATEGORY = i_fee_category
    , FEE_CODE = i_fee_code
    , FEE_CCY = i_fee_ccy
    , TOTAL_FEE_AMT = i_total_fee_amt
    , AMORT_AMT_TO_LOAN_ACC_NO = i_amort_amt_to_loan_acc_no
    , AMORT_AMT_TO_AD_NO = i_amort_amt_to_ad_no
    , UNAMORIT_FEE_AMT = i_unamorit_fee_amt
    , ACC_BRANCH = i_acc_branch
    , NEW_CASE_FLAG = i_new_case_flag
    , OLD_CASE_TOTAL_AMORT_AMT = i_old_case_total_amort_amt
    , OLD_CASE_UNAMORT_AMT = i_old_case_unamort_amt
    , AMEND_DATE = SYSTIMESTAMP
  WHERE SYND_LOAN_ADVANCE_FEE_SEQ_NO = i_synd_loan_advance_fee_seq_no;
  o_row_count:=SQL%ROWCOUNT;
 END SP_UPD_SYND_LOAN_ADV_FEE;   

--**************************************************************************
-- SP_DEL_SYND_LOAN_ADV_FEE_PK
-- Purpose: 刪除聯貸案預收手續費
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 吳筠宜   2019.01.03 created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_SYND_LOAN_ADV_FEE_PK
  ( i_synd_loan_advance_fee_seq_no IN NUMBER  -- 聯貸案預收手續費序號
  , o_row_count                    OUT NUMBER -- 回傳更新筆數
  ) AS 
  BEGIN
    DELETE EDLS.TB_SYND_LOAN_ADVANCE_FEE
    WHERE SYND_LOAN_ADVANCE_FEE_SEQ_NO = i_synd_loan_advance_fee_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_SYND_LOAN_ADV_FEE_PK;   

--**************************************************************************
-- SP_GET_LOAN_ADV_HANDLING_FEE
-- Purpose: 查詢預收手續費資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 吳筠宜   2019.01.04 created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
 PROCEDURE SP_GET_LOAN_ADV_HANDLING_FEE 
 ( i_loan_seq_no         IN NUMBER          -- 放款主檔序號
 , i_last_amort_date     IN VARCHAR2        -- 最近一次的攤銷日期
 , i_total_amort_fee     IN NUMBER          -- 本帳號累積攤銷的手續費
 , i_monthly_amort_amt   IN NUMBER          -- 當月內累積攤銷的手續費
 , i_ccy                 IN VARCHAR2        -- 幣別
 , i_reg_doc_no          IN VARCHAR2        -- 登錄文件號碼
 , i_reg_date            IN VARCHAR2        -- 登錄日期
 , i_reg_host_sno        IN VARCHAR2        -- 登錄主機交易序號
 , i_reg_txn_branch      IN VARCHAR2        -- 登錄交易分行
 , i_reg_sup_emp_id      IN VARCHAR2        -- 登錄交易主管員編
 , i_reg_teller_emp_id   IN VARCHAR2        -- 登錄交易櫃員員編
 , i_reg_time            IN VARCHAR2        -- 登錄時間
 , i_reg_sup_card        IN VARCHAR2        -- 登錄授權主管卡號
 , i_adv_category        IN VARCHAR2        -- 預收手續費科目
 , i_adv_amrtiz_category IN VARCHAR2        -- 預收攤提收入科目
 , i_recov_type          IN VARCHAR2        -- 聯貸收回方式 
 , i_fee_code            IN VARCHAR2        -- 手續費科目
 , o_cur                 out  SYS_REFCURSOR -- 回傳資料
 ) AS
 BEGIN
  OPEN o_cur FOR
   SELECT LOAN_ADV_HANDLING_FEE_SEQ_NO -- 預收手續費資訊序號
      , LOAN_SEQ_NO                    -- 放款主檔序號
      , LAST_AMORT_DATE                -- 最近一次的攤銷日期
      , TOTAL_AMORT_FEE                -- 本帳號累積攤銷的手續費
      , MONTHLY_AMORT_AMT              -- 當月內累積攤銷的手續費
      , CCY                            -- 幣別
      , REG_DOC_NO                     -- 登錄文件號碼
      , REG_DATE                       -- 登錄日期
      , REG_HOST_SNO                   -- 登錄主機交易序號
      , REG_TXN_BRANCH                 -- 登錄交易分行
      , REG_SUP_EMP_ID                 -- 登錄交易主管員編
      , REG_TELLER_EMP_ID              -- 登錄交易櫃員員編
      , REG_TIME                       -- 登錄時間
      , REG_SUP_CARD                   -- 登錄授權主管卡號
      , ADV_CATEGORY                   -- 預收手續費科目
      , ADV_AMRTIZ_CATEGORY            -- 預收攤提收入科目
      , RECOV_TYPE                     -- 聯貸收回方式
      , FEE_CODE
  FROM EDLS.TB_LOAN_ADV_HANDLING_FEE
      WHERE LOAN_SEQ_NO = nvl(i_loan_seq_no, LOAN_SEQ_NO)
      AND (i_last_amort_date is null or LAST_AMORT_DATE = i_last_amort_date)
      AND (i_total_amort_fee is null or TOTAL_AMORT_FEE = i_total_amort_fee)
      AND (i_monthly_amort_amt is null or MONTHLY_AMORT_AMT = i_monthly_amort_amt)
      AND (i_ccy is null or CCY = i_ccy)
      AND (i_reg_doc_no is null or REG_DOC_NO = i_reg_doc_no)
      AND (i_reg_date is null or REG_DATE = i_reg_date)
      AND (i_reg_host_sno is null or REG_HOST_SNO = i_reg_host_sno)
      AND (i_reg_txn_branch is null or REG_TXN_BRANCH = i_reg_txn_branch)
      AND (i_reg_sup_emp_id is null or REG_SUP_EMP_ID = i_reg_sup_emp_id)
      AND (i_reg_teller_emp_id is null or REG_TELLER_EMP_ID = i_reg_teller_emp_id)
      AND (i_reg_time is null or REG_TIME = i_reg_time)
      AND (i_reg_sup_card is null or REG_SUP_CARD = i_reg_sup_card)
      AND (i_adv_category is null or ADV_CATEGORY = i_adv_category)
      AND (i_adv_amrtiz_category is null or ADV_AMRTIZ_CATEGORY = i_adv_amrtiz_category)
      AND (i_recov_type is null or RECOV_TYPE = i_recov_type)
      AND (i_fee_code is null or FEE_CODE = i_fee_code)
  ORDER BY AMEND_DATE DESC ;
 END SP_GET_LOAN_ADV_HANDLING_FEE;   

--**************************************************************************
-- SP_GET_ADV_HANDLING_FEE_BY_CAT
-- Purpose: 查詢預收手續費資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 吳筠宜   2019.01.04 created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_ADV_HANDLING_FEE_BY_CAT 
  ( i_loan_seq_no  IN NUMBER         -- 放款主檔序號
  , i_adv_category IN VARCHAR2       -- 預收手續費科目
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LOAN_ADV_HANDLING_FEE_SEQ_NO -- 預收手續費資訊序號
      , LOAN_SEQ_NO                     -- 放款主檔序號
      , LAST_AMORT_DATE                 -- 最近一次的攤銷日期
      , TOTAL_AMORT_FEE                 -- 本帳號累積攤銷的手續費
      , MONTHLY_AMORT_AMT               -- 當月內累積攤銷的手續費
      , CCY                             -- 幣別
      , REG_DOC_NO                      -- 登錄文件號碼
      , REG_DATE                        -- 登錄日期
      , REG_HOST_SNO                    -- 登錄主機交易序號
      , REG_TXN_BRANCH                  -- 登錄交易分行
      , REG_SUP_EMP_ID                  -- 登錄交易主管員編
      , REG_TELLER_EMP_ID               -- 登錄交易櫃員員編
      , REG_TIME                        -- 登錄時間
      , REG_SUP_CARD                    -- 登錄授權主管卡號
      , ADV_CATEGORY                    -- 預收手續費科目
      , ADV_AMRTIZ_CATEGORY             -- 預收攤提收入科目
      , RECOV_TYPE                      -- 聯貸收回方式
      , FEE_CODE
    FROM EDLS.TB_LOAN_ADV_HANDLING_FEE
    WHERE LOAN_SEQ_NO = nvl(i_loan_seq_no, LOAN_SEQ_NO)
    AND (i_adv_category IS NULL OR ADV_CATEGORY = i_adv_category)
    ORDER BY AMEND_DATE DESC ;
  END SP_GET_ADV_HANDLING_FEE_BY_CAT;  

--*************************************************************************
-- SP_DEL_LOAN_ADV_HANDLING_FEE_PK
-- Purpose: 刪除預收手續費資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 吳筠宜   2018.01.04 created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_LOAN_ADV_HANDLING_FEE_PK
  ( i_loan_adv_handling_fee_seq_no in NUMBER  -- 預收手續費資訊序號
  , o_row_count                    out NUMBER -- 回傳更新筆數
  ) AS
  BEGIN
    DELETE EDLS.TB_LOAN_ADV_HANDLING_FEE
    WHERE LOAN_ADV_HANDLING_FEE_SEQ_NO = i_loan_adv_handling_fee_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_LOAN_ADV_HANDLING_FEE_PK;

--*************************************************************************
-- SP_INS_LIMIT_PROJ_COND_PROF
-- Purpose: 專案屬性註記批示條件檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈     2019.01.08 created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************  
  PROCEDURE SP_INS_LIMIT_PROJ_COND_PROF
  ( i_limit_profile_seq_no IN NUMBER   -- 分項批示條件檔序號
  , i_project_code         IN VARCHAR2 -- 專案屬性註記
  , o_seq_no               OUT NUMBER  -- 屬性註記批示條件檔序號
  ) AS
 BEGIN
  EDLS.PG_SYS.SP_GET_SEQ_NO('TB_LIMIT_PROJ_COND_PROF', o_seq_no);
  INSERT
    INTO EDLS.TB_LIMIT_PROJ_COND_PROF
    ( PROJ_CONDI_PROF_SEQ_NO
    , LIMIT_PROFILE_SEQ_NO
    , PROJECT_CODE
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    (o_seq_no
    , i_limit_profile_seq_no
    , i_project_code
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
 END SP_INS_LIMIT_PROJ_COND_PROF;   

--*************************************************************************
-- SP_DEL_APPR_DOC_ALL_BY_PK
-- Purpose: 放款存單質借動用沖正需刪除「批覆書、批覆書核轉人員、擔保品、分項額度、分項額度批示設定檔」
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 謝宇倫  2019.01.08  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************    
  PROCEDURE SP_DEL_APPR_DOC_ALL_BY_PK
  ( i_appr_doc_seq_no IN NUMBER -- 批覆書主檔序號
  , i_limit_seq_no    IN NUMBER -- 分項額度主檔序號
  , o_row_count OUT NUMBER
  ) IS
  v_coll_seq_no NUMBER;
  v_limit_dtl_seq_no NUMBER;
  v_seq_no NUMBER;
  BEGIN 
    SELECT  
      TB_COLL.COLL_SEQ_NO 
    INTO  
      v_coll_seq_no
    FROM EDLS.TB_COLL
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no 
      AND LIMIT_SEQ_NO IS NULL;

    --刪除額度更新軌跡檔
    DELETE FROM TB_LIMIT_DTL_HISTORY
    WHERE TB_LIMIT_DTL_HISTORY.LIMIT_DTL_SEQ_NO IN
    (
      SELECT LIMIT_DTL_SEQ_NO
      FROM TB_LIMIT_DTL
      WHERE TB_LIMIT_DTL.LIMIT_SEQ_NO = i_limit_seq_no
    );
    --刪除分項額度彙計檔
    DELETE FROM TB_LIMIT_DTL
    WHERE TB_LIMIT_DTL.LIMIT_SEQ_NO = i_limit_seq_no;
    --刪除擔保品
    PG_COLLATERAL.SP_DEL_GENERAL(v_coll_seq_no, v_seq_no);
    PG_APPR_DOC_LIMIT.SP_DEL_LIMIT(i_limit_seq_no,v_seq_no);
    PG_APPR_DOC_LIMIT.SP_DEL_LIMIT_PROFILE(i_limit_seq_no,v_seq_no);
    PG_APPR_DOC_LIMIT.SP_DEL_APPR_DOC_AUTH_BY_APDSNO(i_appr_doc_seq_no);
    PG_APPR_DOC_LIMIT.SP_DEL_APPR_DOC(i_appr_doc_seq_no,v_seq_no);
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_APPR_DOC_ALL_BY_PK;

--*************************************************************************
-- SP_CNT_PROJECT_CODE
-- Purpose: 專案屬性註記筆數，專案屬性註記條件為字串轉陣列A,B,C,D -> ('A','B','C','D')
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 Cooper     2019.01.24  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_CNT_PROJECT_CODE 
  ( i_limit_seq_no IN NUMBER   -- 分項額度主檔序號
  , i_project_code IN VARCHAR2 -- 專案屬性註記
  , o_cnt          OUT NUMBER  -- 回傳資料
  ) IS
  BEGIN
    SELECT COUNT(1) INTO o_cnt FROM EDLS.TB_LIMIT_PROJ_COND_PROF 
    WHERE LIMIT_PROFILE_SEQ_NO IN ( SELECT LIMIT_PROFILE_SEQ_NO FROM EDLS.TB_LIMIT_PROFILE WHERE LIMIT_SEQ_NO = i_limit_seq_no) 
    AND PROJECT_CODE IN ( SELECT TRIM(REGEXP_SUBSTR(i_project_code, '[^,]+', 1, LEVEL)) code FROM dual 
                          CONNECT BY LEVEL <= REGEXP_COUNT(i_project_code, ',') + 1 ) ;
 END SP_CNT_PROJECT_CODE;

--*************************************************************************
-- SP_CNT_PROD_MORTGAGE_PROFILE
-- Purpose: 房貸產品種類數量，房貸產品種類條件為字串轉陣列A,B,C,D -> ('A','B','C','D')
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 Cooper     2019.01.24  created
-- 1.1 ESB18627  2019.10.23  performance adjust
--**************************************************************************
  PROCEDURE SP_CNT_PROD_MORTGAGE_PROFILE 
  ( i_limit_seq_no     IN NUMBER   -- 分項額度主檔序號
  , i_mortgage_product IN VARCHAR2 -- 房貸產品種類
  , o_cnt              OUT NUMBER  -- 回傳資料
  ) IS
  BEGIN
    SELECT COUNT(1) INTO o_cnt FROM EDLS.TB_PROD_MORTGAGE_PROFILE 
    WHERE LIMIT_PROFILE_SEQ_NO IN ( SELECT LIMIT_PROFILE_SEQ_NO FROM EDLS.TB_LIMIT_PROFILE WHERE LIMIT_SEQ_NO = i_limit_seq_no) 
    AND MORTGAGE_PRODUCT IN ( SELECT TRIM(REGEXP_SUBSTR(i_mortgage_product, '[^,]+', 1, LEVEL)) code FROM dual 
                            CONNECT BY LEVEL <= REGEXP_COUNT(i_mortgage_product, ',') + 1 ) ;
 END SP_CNT_PROD_MORTGAGE_PROFILE;   

--*************************************************************************
-- SP_GET_CHECK_INTST_SPREAD_MK
-- Purpose: 利率減碼專案分段優惠利率未生效檢核
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 ESB19400  2020.04.29  created
--
--**************************************************************************
  PROCEDURE SP_GET_CHECK_INTST_SPREAD_MK 
  ( i_limit_seq_no IN NUMBER
  , o_value        OUT NUMBER
  ) AS
  BEGIN
    SELECT count(1) INTO o_value FROM EDLS.TB_PROD_MORTGAGE_PROFILE 
        WHERE LIMIT_PROFILE_SEQ_NO IN ( SELECT LIMIT_PROFILE_SEQ_NO FROM EDLS.TB_LIMIT_PROFILE WHERE LIMIT_SEQ_NO = i_limit_seq_no) 
          AND MORTGAGE_PRODUCT = '5'
        FETCH FIRST 1 ROWS ONLY;
    IF (o_value IS NULL OR o_value <= 0) THEN
        SELECT count(1) INTO o_value FROM EDLS.TB_LIMIT_PROJ_COND_PROF 
          WHERE LIMIT_PROFILE_SEQ_NO IN ( SELECT LIMIT_PROFILE_SEQ_NO FROM EDLS.TB_LIMIT_PROFILE WHERE LIMIT_SEQ_NO = i_limit_seq_no) 
            AND PROJECT_CODE IN ('78', '87')
          FETCH FIRST 1 ROWS ONLY;
    END IF;
  END SP_GET_CHECK_INTST_SPREAD_MK;

--**************************************************************************
-- 719 SP_GET_GUAR_BY_DOCSQN
-- Purpose: 以批覆書主檔序號取得保證人資料
-- 
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 康晉維   2019.03.22 modified
-- 1.1 ESB18627  2019.10.23  performance adjust  待確認是否移除
--************************************************************************** 
  PROCEDURE SP_GET_GUAR_BY_DOCSQN
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , o_cur             OUT SYS_REFCURSOR -- 回傳保證人資料   
  ) AS
  BEGIN 
    OPEN o_cur FOR
    SELECT cust.CUST_ID
         ,cust.CUST_NAME
         ,cust.TEL_NO
         ,cust.BIRTH_DATE
         ,cust.CREATE_BRANCH
         ,cust.FIRST_DRAWDOWN_DATE
         ,cust.FIRST_DRAWDOWN_MATU_DATE
         ,cust.LOAN_REJECT_REASON
         ,cust.MAJ_CUST_LOAN_MK
         ,cust.INTST_PARTY_FLAG 
         ,cust.LAST_TXN_DATE
         ,cust.CONTINUE_LOAN_MK
         ,cust.TRANS_OVERDUE_CENTER_STAT
         ,cust.CUST_TYPE
         ,cust.FIRST_APPRD_DATE
         ,cust.NEW_CUST_REG_DATE
         ,cust.REPAYMT_NOTIFY_MK
         ,cust.DELAY_PAYMT_NOTI_MSG_MK
         ,cust.OVERDUE_SPECIAL_MK
         ,cust.ESUN_STOCK_PROJ_MK
         ,cust.MEMO
         ,cust.REL_GROUP_REG_DATE
         ,gu.GUARANTOR_SEQ_NO
         ,gu.APPR_DOC_SEQ_NO
         ,gu.LIMIT_SEQ_NO     
         ,gu.CUSTOMER_LOAN_SEQ_NO              -- 授信戶主檔序號
         ,gu.IDENTITY_CODE
         ,gu.COUNTRY
         ,gu.PHASE
         ,gu.CANCEL_REASON_MK
         ,gu.PERCENTAGE
         ,gu.RELATIONSHIP_CODE
         ,gu.RELATION_WITH_MIN_DEBTOR
         ,gu.IS_FINAN_INSTIT
         ,gu.CHANGE_DATE
         ,gu.BIND_ALL_MARK
    FROM EDLS.TB_GUARANTOR gu
    JOIN EDLS.TB_CUSTOMER_LOAN cust 
      On gu.CUSTOMER_LOAN_SEQ_NO = cust.CUSTOMER_LOAN_SEQ_NO
    WHERE gu.APPR_DOC_SEQ_NO = i_appr_doc_seq_no;    
  END SP_GET_GUAR_BY_DOCSQN;  

--**************************************************************************
-- 722 SP_GET_GUAR_BY_GCID_PHR_PAGE
-- Purpose: 以保證人銀行歸戶統編及保證狀態取得保證人資料
-- 
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.1 康晉維   2019.03.22 modified
-- 1.2 葉庭宇   2019.05.28 modified
-- 1.3 ESB18627  2019.10.24  performance adjust 
--************************************************************************** 
  PROCEDURE SP_GET_GUAR_BY_GCID_PHR_PAGE
  ( i_customer_id   IN VARCHAR2      -- 銀行歸戶統編
  , i_phase        IN VARCHAR2       -- 保證狀態
  , o_cur          OUT SYS_REFCURSOR -- 回傳保證人資料   
  ) AS
  BEGIN 
    OPEN o_cur FOR
    SELECT cust.CUST_ID
     ,cust.CUST_NAME
     ,cust.TEL_NO
     ,gu.GUARANTOR_SEQ_NO
     ,gu.APPR_DOC_SEQ_NO
     ,gu.LIMIT_SEQ_NO
     ,gu.CUSTOMER_LOAN_SEQ_NO   
     ,gu.IDENTITY_CODE
     ,gu.COUNTRY
     ,gu.PHASE
     ,gu.CANCEL_REASON_MK
     ,gu.PERCENTAGE
     ,gu.RELATIONSHIP_CODE
     ,gu.RELATION_WITH_MIN_DEBTOR
     ,gu.IS_FINAN_INSTIT
     ,gu.CHANGE_DATE
     FROM EDLS.TB_GUARANTOR gu
     JOIN EDLS.TB_CUSTOMER_LOAN cust 
       On gu.CUSTOMER_LOAN_SEQ_NO = cust.CUSTOMER_LOAN_SEQ_NO
     WHERE cust.CUST_ID = i_customer_id   
     AND gu.PHASE = i_phase
     ORDER BY gu.GUARANTOR_SEQ_NO;
  END SP_GET_GUAR_BY_GCID_PHR_PAGE;  

--**************************************************************************
-- 860 SP_GET_BWR_GUAR_ALL
-- Purpose: 借保戶查詢全部（借戶及保戶）
-- 
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 康晉維   2019.01.21 created
-- 1.1 ESB18627  2019.10.24  performance adjust 
--************************************************************************** 
  PROCEDURE SP_GET_BWR_GUAR_ALL
  ( i_customer_id   IN VARCHAR2       -- 銀行歸戶統編
  , i_phase         IN VARCHAR2       -- 保證狀態
  , i_start_row     IN NUMBER         -- 起始筆數
  , i_record_number IN NUMBER         -- 每頁筆數
  , o_cur           OUT SYS_REFCURSOR -- 回傳保證人資料   
  ) AS
    BEGIN 
    OPEN o_cur FOR 
     SELECT * FROM (
       SELECT g.GUARANTOR_SEQ_NO
          , g.APPR_DOC_SEQ_NO
          , g.LIMIT_SEQ_NO
          , g.IDENTITY_CODE
          , g.COUNTRY
          , g.PHASE
          , g.CANCEL_REASON_MK
          , g.PERCENTAGE
          , g.RELATIONSHIP_CODE
          , g.RELATION_WITH_MIN_DEBTOR
          , g.IS_FINAN_INSTIT
          , g.CHANGE_DATE
          , g.BIND_ALL_MARK 
        FROM EDLS.TB_APPR_DOC ad
           JOIN (SELECT CUSTOMER_LOAN_SEQ_NO
               FROM EDLS.TB_CUSTOMER_LOAN
               WHERE CUST_ID = i_customer_id) TCL ON TCL.CUSTOMER_LOAN_SEQ_NO = ad.CUSTOMER_LOAN_SEQ_NO
			LEFT JOIN EDLS.TB_GUARANTOR g ON ad.APPR_DOC_SEQ_NO = g.APPR_DOC_SEQ_NO
        UNION ALL
       SELECT GUARANTOR_SEQ_NO
          , APPR_DOC_SEQ_NO
          , LIMIT_SEQ_NO
          , IDENTITY_CODE
          , COUNTRY
          , PHASE
          , CANCEL_REASON_MK
          , PERCENTAGE
          , RELATIONSHIP_CODE
          , RELATION_WITH_MIN_DEBTOR
          , IS_FINAN_INSTIT
          , CHANGE_DATE
          , BIND_ALL_MARK
        FROM EDLS.TB_GUARANTOR
        WHERE PHASE = i_phase
     )
    ORDER BY GUARANTOR_SEQ_NO
    OFFSET i_start_row ROWS FETCH NEXT i_record_number ROWS ONLY;    
  END SP_GET_BWR_GUAR_ALL;  

--*************************************************************************
-- SP_DEL_APPR_DOC_AUTH_BY_APDSNO
-- Purpose: 刪除批覆書核轉人員資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 謝宇倫   2019.01.18 created
-- 1.1 ESB18627  2019.10.24  performance adjust 
--************************************************************************** 
  PROCEDURE SP_DEL_APPR_DOC_AUTH_BY_APDSNO
  ( i_appr_doc_seq_no IN NUMBER -- 批覆書主檔序號
  ) AS
  BEGIN
     DELETE EDLS.TB_APPR_DOC_AUTHORIZER
     WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no;
  END SP_DEL_APPR_DOC_AUTH_BY_APDSNO;  

--***************************************************
-- SP_GET_LIMIT_DTL_LIST
-- Purpose: 查詢分項額度彙計檔資料
--
-- Modification History
-- Person              Date          Comments
-- --------------      ----------    -----------------
-- 1.0 劉佑慈           2019.01.28    created
-- 1.1 ESB18627  2019.10.24  performance adjust 
--****************************************************
  PROCEDURE SP_GET_LIMIT_DTL_LIST
  ( i_limit_seq_no IN NUMBER         -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LIMIT_DTL_SEQ_NO
     ,LIMIT_SEQ_NO
     ,CCY
     ,LAST_TXN_DATE
     ,TOTAL_DRAWDOWN_AMT
     ,TOTAL_REPAYMT_AMT
     ,TOTAL_APPR_DOC_DRAWDOWN_AMT
     ,TOTAL_NEGO_AMT
     ,FORIGN_BUSINESS_TYPE
    FROM EDLS.TB_LIMIT_DTL
    WHERE LIMIT_SEQ_NO = i_limit_seq_no
    For Update;
  END SP_GET_LIMIT_DTL_LIST;  

--*************************************************************************
-- SP_GET_COUNT_LOAN
-- Purpose: 查詢放款主檔總數
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈     2019.02.01 created
-- 1.1 ESB18627  2019.10.24  performance adjust 
--**************************************************************************
  PROCEDURE SP_GET_COUNT_LOAN
  ( i_appr_doc_seq_no IN NUMBER  -- 批覆書主檔序號
  , o_count           OUT NUMBER -- 查詢筆數
  ) AS
  BEGIN
    SELECT COUNT(1) INTO o_count
    FROM EDLS.TB_LOAN
    WHERE APPR_DOC_SEQ_NO= i_appr_doc_seq_no;
  END SP_GET_COUNT_LOAN;  

--*************************************************************************
-- SP_GET_COUNT_FOREIGN
-- Purpose: 查詢外匯交易主檔總數
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈     2019.02.01 created
-- 1.1 ESB18627  2019.10.24  performance adjust 
--**************************************************************************
  PROCEDURE SP_GET_COUNT_FOREIGN
  ( i_appr_doc_seq_no IN NUMBER  -- 批覆書主檔序號
  , o_count           OUT NUMBER -- 查詢筆數
  ) AS
  BEGIN
    SELECT COUNT(1) INTO o_count
    FROM EDLS.TB_FOREIGN
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no;
  END SP_GET_COUNT_FOREIGN;  


--*************************************************************************
-- SP_GET_COUNT_INDIR_CREDIT
-- Purpose:
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈     2019.02.11 created
-- 1.1 ESB18627  2019.10.24  performance adjust 
--**************************************************************************
  PROCEDURE SP_GET_COUNT_INDIR_CREDIT
  ( i_appr_doc_seq_no IN NUMBER  -- 批覆書主檔序號
  , o_count           OUT NUMBER -- 查詢筆數
  ) AS
  BEGIN
    SELECT COUNT(1) INTO o_count
    FROM EDLS.TB_INDR_CREDIT
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no;
  END SP_GET_COUNT_INDIR_CREDIT;

--*************************************************************************
-- SP_GET_COUNT_OVERDRAFT
-- Purpose: 查詢分項額度透支資訊檔總數
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈     2019.02.01 created
-- 1.1 ESB18627  2019.10.24  performance adjust 
--**************************************************************************
  PROCEDURE SP_GET_COUNT_OVERDRAFT
  ( i_appr_doc_seq_no IN NUMBER  -- 批覆書主檔序號
  , o_count           OUT NUMBER -- 查詢筆數
  ) AS
  BEGIN
    SELECT COUNT(1) INTO o_count
    FROM EDLS.TB_LIMIT  lt 
	INNER JOIN EDLS.TB_OVERDRAFT od ON lt.LIMIT_SEQ_NO=od.LIMIT_SEQ_NO
    AND lt.APPR_DOC_SEQ_NO= i_appr_doc_seq_no;
  END SP_GET_COUNT_OVERDRAFT;

--*************************************************************************
-- SP_UPD_LIMIT_USED
-- Purpose: 將分項額度狀態未使用改為使用中
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈    2019.02.18  created
-- 1.1 ESB18627  2019.10.24  performance adjust 
--**************************************************************************
  PROCEDURE SP_UPD_LIMIT_USED
  ( i_limit_seq_no IN NUMBER  -- 分項額度主檔序號
  , o_row_count    OUT NUMBER -- 回傳異動筆數 
  ) AS
  BEGIN 
    UPDATE EDLS.TB_LIMIT SET PHASE = '0', AMEND_DATE = SYSTIMESTAMP
    WHERE LIMIT_SEQ_NO = i_limit_seq_no AND PHASE = 'N';
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_LIMIT_USED;

--*************************************************************************
-- SP_UPD_LIMIT_PROFILE_FDD
-- Purpose: 更新分項批示條件檔首次動撥日
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈    2019.02.18  created
-- 1.1 ESB18627  2019.10.24  performance adjust 
--**************************************************************************
  PROCEDURE SP_UPD_LIMIT_PROFILE_FDD
  ( i_limit_seq_no IN NUMBER   -- 分項額度主檔序號
  , i_date         IN VARCHAR2 -- 分項首次動撥日
  , o_row_count    OUT NUMBER  -- 異動筆數
  ) AS
  BEGIN 
    UPDATE EDLS.TB_LIMIT_PROFILE 
    SET FIRST_DRAWDOWN_DATE = i_date
    , AMEND_DATE = SYSTIMESTAMP
    WHERE LIMIT_SEQ_NO = i_limit_seq_no AND FIRST_DRAWDOWN_DATE is null;
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_LIMIT_PROFILE_FDD;

--*************************************************************************
-- SP_DEL_OVERDRAFT
-- Purpose: 刪除分項額度透支資訊檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈    2019.02.18  created
-- 1.1 ESB18627  2019.10.24  performance adjust 
--**************************************************************************
  PROCEDURE SP_DEL_OVERDRAFT
  ( i_overdraft_seq_no IN NUMBER -- 分項額度透支資訊檔序號
  , o_row_count OUT NUMBER       -- 刪除筆數
  ) AS
  BEGIN 
    DELETE EDLS.TB_OVERDRAFT
    WHERE OVERDRAFT_SEQ_NO = i_overdraft_seq_no;
    o_row_count := SQL%ROWCOUNT;
   END SP_DEL_OVERDRAFT;

--*************************************************************************
-- SP_DEL_OVERDRAFT_BY_SELECT
-- Purpose: 搜尋刪除分項額度透支資訊檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈    2019.02.18  created
-- 1.1 ESB18627  2019.10.24  performance adjust 
--**************************************************************************
  PROCEDURE SP_DEL_OVERDRAFT_BY_SELECT
  ( i_limit_seq_no IN NUMBER   -- 分項額度主檔序號
  , i_account_no IN NUMBER     -- 帳號序號
  , i_account_type IN VARCHAR2 -- 帳號類別
  , i_currency IN VARCHAR2     -- 幣別
  , o_row_count OUT NUMBER     -- 刪除筆數
  ) AS
  BEGIN 
    DELETE EDLS.TB_OVERDRAFT
    WHERE LIMIT_SEQ_NO = i_limit_seq_no 
    AND ACC_TYPE = I_ACCOUNT_TYPE 
	AND ACC_NO = i_account_no 
    AND CCY = NVL(i_currency, CCY);
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_OVERDRAFT_BY_SELECT;  

--*************************************************************************
-- SP_GET_FILTER_OVERDRAFT
-- Purpose: 過濾查詢透支明細
--
-- Modification HistORy
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈    2019.02.18  created
-- 1.1 ESB18627 2019.10.24  perfORmance adjust /存款部分沒有INDEX，如有效能問題請存款新增INDEX
-- 1.2 許宸禎    2019.12.27  新增幣別種類
--**************************************************************************
  PROCEDURE SP_GET_FILTER_OVERDRAFT
  ( i_cust_id         IN VARCHAR2       -- 銀行歸戶統編
  , i_appr_doc_no     IN VARCHAR2       -- 批覆書編號
  , i_limit_type      IN VARCHAR2       -- 額度種類
  , i_saving_acc_no   IN VARCHAR2       -- 存款帳號
  , i_saving_acc_type IN VARCHAR2       -- 存款帳號類別
  , i_ccy_type        IN VARCHAR2       -- 幣別種類
  , i_maturity_date   IN VARCHAR2       -- 到期日
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN 
    OPEN o_cur FOR
    SELECT ad.APPR_DOC_NO AS apprDocNo,
           ad.TOTAL_APPR_AMT AS totalApprovalAmount,
           ad.OPER_BRANCH AS operationBranchId,
           lt.LIMIT_TYPE AS limitType,
           lt.APPRD_SUB_LIMIT_AMT AS approvedSubLimit,
           dc.DEMAND_DEPT_ACC AS savingAccNo,
           oc.OVER_AMT AS overdraftLimit,
           oc.OVER_USE_START_DATE AS startDate,
           oc.OVER_USE_END_DATE AS maturityDate,
           oc.CURR AS CURR
      FROM EDLS.TB_APPR_DOC ad
     INNER JOIN EDLS.TB_CUSTOMER_LOAN cl
        ON ad.CUSTOMER_LOAN_SEQ_NO = cl.CUSTOMER_LOAN_SEQ_NO
     INNER JOIN EDLS.TB_LIMIT  lt
        ON ad.APPR_DOC_SEQ_NO = lt.APPR_DOC_SEQ_NO
     INNER JOIN TB_LIMIT_PARAMETER_CONFIG lpc
        ON lt.LIMIT_TYPE = lpc.LIMIT_TYPE
     INNER JOIN EDLS.TB_OVERDRAFT  od
        ON lt.LIMIT_SEQ_NO = od.LIMIT_SEQ_NO
     INNER JOIN EDLS.TB_DEPT_ACC   dc
        ON dc.DEPT_ACC_SEQ_NO = od.ACC_NO
     INNER JOIN EDLS.TB_DEPT_PROD_ATTRIBUTE    dpa
        ON dc.PROD_CODE = dpa.PROD_CODE
     INNER JOIN EDLS.TB_OVER_CURR  oc
        ON dc.DEPT_ACC_SEQ_NO = oc.DEPT_ACC_SEQ_NO AND od.CCY = oc.CURR
     WHERE (i_saving_acc_type IS NULL OR (i_saving_acc_type = 'A' OR (i_saving_acc_type = 'B' AND (dpa.ACC_TYPE = '1' OR dpa. ACC_TYPE = '2'))))
       AND cl.CUST_ID = i_cust_id
       AND (i_appr_doc_no IS NULL OR ad.APPR_DOC_NO = i_appr_doc_no)
       AND (i_limit_type IS NULL OR lt.LIMIT_TYPE = i_limit_type)
       AND (i_saving_acc_no IS NULL OR dc.DEMAND_DEPT_ACC = i_saving_acc_no)
       AND (i_ccy_type IS NULL OR lpc.CCY_TYPE = i_ccy_type)
       AND (i_maturity_date IS NULL OR oc.OVER_USE_END_DATE > i_maturity_date)
       AND dc.STATUS = 1
       AND dpa.STATUS = 1
       AND oc.STATUS = 1
       AND oc.START_STATUS = '1';
  END SP_GET_FILTER_OVERDRAFT;

--*************************************************************************
-- SP_GET_APPR_DOC_TEMP
-- Purpose: 取得批覆書暫存資料檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈     2019.02.18  created
-- 1.1 ESB18627  2019.10.24  performance adjust
-- 1.2 詹宏茂     2019.11.27  修改查詢欄位順序
--**************************************************************************
  PROCEDURE SP_GET_APPR_DOC_TEMP
  ( i_data_type       IN VARCHAR2       -- 資料類型
  , i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , i_limit_seq_no    IN NUMBER         -- 分項額度主檔序號
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN 
    OPEN o_cur FOR
    SELECT APPR_DOC_TEMP_SEQ_NO
         , DATA_TYPE
         , APPR_DOC_SEQ_NO
         , LIMIT_SEQ_NO
         , TEMP_DATA
         , CREATE_DATE
         , AMEND_DATE
    FROM EDLS.TB_APPR_DOC_TEMP
    WHERE (i_appr_doc_seq_no IS NULL OR APPR_DOC_SEQ_NO = i_appr_doc_seq_no)
    AND (i_limit_seq_no IS NULL OR LIMIT_SEQ_NO = i_limit_seq_no)
    AND DATA_TYPE = i_data_type
    FOR UPDATE;
  END SP_GET_APPR_DOC_TEMP;

--*************************************************************************
-- SP_INS_APPR_DOC_TEMP
-- Purpose: 新增批覆書暫存資料檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈    2019.02.18  created
-- 1.1 ESB18627  2019.10.24  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_APPR_DOC_TEMP
  ( i_data_type       IN VARCHAR2 -- 資料類型
  , i_appr_doc_seq_no IN NUMBER   -- 批覆書主檔序號
  , i_limit_seq_no    IN NUMBER   -- 分項額度主檔序號
  , i_temp_data       IN VARCHAR2 -- 資料內容
  , o_seq_no          OUT NUMBER  -- 批覆書暫存資料檔序號
 ) AS
 BEGIN 
  EDLS.PG_SYS.SP_GET_SEQ_NO('TB_APPR_DOC_TEMP', o_seq_no);
  INSERT INTO EDLS.TB_APPR_DOC_TEMP
  ( APPR_DOC_TEMP_SEQ_NO
  , APPR_DOC_SEQ_NO
  , LIMIT_SEQ_NO
  , DATA_TYPE, TEMP_DATA
  , CREATE_DATE
  , AMEND_DATE
  )
  VALUES
  ( o_seq_no
  , i_appr_doc_seq_no
  , i_limit_seq_no
  , i_data_type
  , i_temp_data
  , SYSTIMESTAMP
  , SYSTIMESTAMP
  );
 END SP_INS_APPR_DOC_TEMP;

--*************************************************************************
-- SP_DEL_APPR_DOC_TEMP
-- Purpose: 刪除批覆書暫存資料檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈    2019.02.18  created
-- 1.1 ESB18627  2019.10.24  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_APPR_DOC_TEMP
  ( i_type            IN VARCHAR2 -- 資料類型
  , i_appr_doc_seq_no IN NUMBER   -- 批覆書主檔序號
  , i_limit_seq_no    IN NUMBER   -- 分項額度主檔序號
  , o_row_count       OUT NUMBER  -- 回傳筆數 
  ) AS
  BEGIN 
    DELETE EDLS.TB_APPR_DOC_TEMP
    WHERE (i_appr_doc_seq_no IS NULL OR APPR_DOC_SEQ_NO = i_appr_doc_seq_no)
    AND (i_limit_seq_no IS NULL OR LIMIT_SEQ_NO = i_limit_seq_no)
	AND (i_type IS NULL OR DATA_TYPE = i_type); 
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_APPR_DOC_TEMP;


--*************************************************************************
-- SP_INS_VOSTRO_OVERDRAFT_LIMIT
-- Purpose: 新增同存透支額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.02.19  created
-- 1.1 ESB18627  2019.10.24  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_VOSTRO_OVERDRAFT_LIMIT
  ( i_customer_loan_seq_no      IN NUMBER   -- 授信戶主檔序號
  , i_appr_date                 IN VARCHAR2 -- 透支核准日
  , i_last_chg_date             IN VARCHAR2 -- 上次變更日
  , i_overdraft_limit_ccy       IN VARCHAR2 -- 透支額度幣別
  , i_intraday_apprd_amt        IN NUMBER   -- 日間透支核准額度
  , i_end_of_dal_apprd_amt      IN NUMBER   -- 日終透支核准額度
  , i_overdraft_limit_effec_mk  IN VARCHAR2 -- 透支額度有效註記
  , i_approved_no               IN VARCHAR2 -- 核准文號
  , i_saving_acc_no             IN VARCHAR2 -- 存款帳號
  , o_seq_no                    OUT NUMBER  -- 回傳序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_VOSTRO_OVERDRAFT_LIMIT', o_seq_no);
    INSERT INTO EDLS.TB_VOSTRO_OVERDRAFT_LIMIT 
    ( VOSTRO_OVERDRAFT_LIMIT_SEQ_NO
    , CUSTOMER_LOAN_SEQ_NO
    , APPR_DATE
    , LAST_CHG_DATE
    , OVERDRAFT_LIMIT_CCY
    , INTRADAY_APPRD_AMT
    , END_OF_DAL_APPRD_AMT
    , OVERDRAFT_LIMIT_EFFEC_MK
    , APPROVED_NO
    , SAVING_ACC_NO
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES 
    ( o_seq_no
    , i_customer_loan_seq_no
    , i_appr_date
    , i_last_chg_date
    , i_overdraft_limit_ccy
    , i_intraday_apprd_amt
    , i_end_of_dal_apprd_amt
    , i_overdraft_limit_effec_mk
    , i_approved_no
    , i_saving_acc_no
    , systimestamp
    ,  systimestamp
    );
  END SP_INS_VOSTRO_OVERDRAFT_LIMIT;

--*************************************************************************
-- SP_UPD_VOSTRO_OVERDRAFT_LIMIT
-- Purpose: 修改同存透支額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.02.19  created
-- 1.1 ESB18627  2019.10.24  performance adjust
--**************************************************************************
  PROCEDURE SP_UPD_VOSTRO_OVERDRAFT_LIMIT
  ( i_vostro_overdraft_limit_seq IN NUMBER   -- 同存透支額度資訊序號
  , i_customer_loan_seq_no       IN NUMBER   -- 授信戶主檔序號
  , i_appr_date                  IN VARCHAR2 -- 透支核准日
  , i_last_chg_date              IN VARCHAR2 -- 上次變更日
  , i_overdraft_limit_ccy        IN VARCHAR2 -- 透支額度幣別
  , i_intraday_apprd_amt         IN NUMBER   -- 日間透支核准額度
  , i_end_of_dal_apprd_amt       IN NUMBER   -- 日終透支核准額度
  , i_overdraft_limit_effec_mk   IN VARCHAR2 -- 透支額度有效註記
  , i_approved_no                IN VARCHAR2 -- 核准文號
  , i_saving_acc_no              IN VARCHAR2 -- 存款帳號
  , o_row_count                  OUT NUMBER  -- 回傳更新筆數
  ) AS
  BEGIN
    UPDATE EDLS.TB_VOSTRO_OVERDRAFT_LIMIT
    SET
      CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no, 
      APPR_DATE = i_appr_date, 
      LAST_CHG_DATE = i_last_chg_date, 
      OVERDRAFT_LIMIT_CCY = i_overdraft_limit_ccy, 
      INTRADAY_APPRD_AMT = i_intraday_apprd_amt, 
      END_OF_DAL_APPRD_AMT = i_end_of_dal_apprd_amt, 
      OVERDRAFT_LIMIT_EFFEC_MK = i_overdraft_limit_effec_mk, 
      APPROVED_NO = i_approved_no, 
      SAVING_ACC_NO = i_saving_acc_no, 
      AMEND_DATE = systimestamp
    WHERE VOSTRO_OVERDRAFT_LIMIT_SEQ_NO = i_vostro_overdraft_limit_seq; 
    o_row_count:=SQL%ROWCOUNT;
  END SP_UPD_VOSTRO_OVERDRAFT_LIMIT;

--*************************************************************************
-- SP_GET_VOSTRO_OVERDRAFT_LIMIT
-- Purpose: 取得同存透支額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.02.19  created
-- 1.1 ESB18627  2019.10.24  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_VOSTRO_OVERDRAFT_LIMIT
  ( i_cust_id   IN  VARCHAR2       -- 銀行歸戶統編
  , o_cur       OUT SYS_REFCURSOR  -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT vol.VOSTRO_OVERDRAFT_LIMIT_SEQ_NO
         , vol.CUSTOMER_LOAN_SEQ_NO
         , vol.APPR_DATE
         , vol.LAST_CHG_DATE
         , vol.OVERDRAFT_LIMIT_CCY
         , vol.INTRADAY_APPRD_AMT
         , vol.END_OF_DAL_APPRD_AMT
         , vol.OVERDRAFT_LIMIT_EFFEC_MK
         , vol.APPROVED_NO
         , vol.SAVING_ACC_NO
         , vol.CREATE_DATE
         , vol.AMEND_DATE
    FROM EDLS.TB_VOSTRO_OVERDRAFT_LIMIT vol JOIN EDLS.TB_CUSTOMER_LOAN cl
      ON cl.CUSTOMER_LOAN_SEQ_NO = vol.CUSTOMER_LOAN_SEQ_NO
    WHERE (i_cust_id IS NULL OR cl.CUST_ID=i_cust_id)
    FOR UPDATE;
  END SP_GET_VOSTRO_OVERDRAFT_LIMIT;

--*************************************************************************
-- SP_INS_CUST_LIMIT_DTL
-- Purpose: 新增授信戶額度彙計檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.02.19  created
-- 1.1 ESB18627  2019.10.24  performance adjust
--**************************************************************************
  PROCEDURE SP_INS_CUST_LIMIT_DTL
  ( i_customer_loan_seq_no             IN NUMBER   -- 授信戶主檔序號
  , i_ccy                              IN VARCHAR2 -- 幣別
  , i_business_type                    IN VARCHAR2 -- 業務別
  , i_last_txn_date                    IN VARCHAR2 -- 最後交易日
  , i_total_drawdown_amt               IN NUMBER   -- 累積動用金額
  , i_total_repaymt_amt                IN NUMBER   -- 累積還款金額
  , i_total_appr_doc_drawdown_amt      IN NUMBER   -- 佔用批覆書累積額度
  , i_total_nego_amt                   IN NUMBER   -- 累積和解總額 
  , o_seq_no                           OUT NUMBER  -- 回傳序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_CUST_LIMIT_DTL', o_seq_no);
    INSERT INTO EDLS.TB_CUST_LIMIT_DTL 
    ( CUST_LIMIT_DTL_SEQ_NO
    , CUSTOMER_LOAN_SEQ_NO
    , CCY, LAST_TXN_DATE
    , TOTAL_DRAWDOWN_AMT
    , TOTAL_REPAYMT_AMT
    , TOTAL_APPR_DOC_DRAWDOWN_AMT
    , BUSINESS_TYPE
    , total_nego_amt
    , CREATE_DATE
    , AMEND_DATE)
    VALUES 
    ( o_seq_no
    , i_customer_loan_seq_no
    , i_ccy
    , i_last_txn_date
    , i_total_drawdown_amt
    , i_total_repaymt_amt
    , i_total_appr_doc_drawdown_amt
    ,  i_business_type
    , i_total_nego_amt
    , systimestamp
    ,  systimestamp
    );
  END SP_INS_CUST_LIMIT_DTL;

--*************************************************************************
-- SP_UPD_CUST_LIMIT_DTL
-- Purpose: 修改授信戶額度彙計檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.02.19  created
-- 1.1 ESB18627  2019.10.24  performance adjust
--**************************************************************************
  PROCEDURE SP_UPD_CUST_LIMIT_DTL
  ( i_cust_limit_dtl_seq_no            IN NUMBER   -- 授信戶額度彙計檔序號
  , i_customer_loan_seq_no             IN NUMBER   -- 授信戶主檔序號
  , i_ccy                              IN VARCHAR2 -- 幣別
  , i_last_txn_date                    IN VARCHAR2 -- 最後交易日
  , i_business_type                    IN VARCHAR2 -- 業務別
  , i_total_drawdown_amt               IN NUMBER   -- 累積動用金額
  , i_total_repaymt_amt                IN NUMBER   -- 累積還款金額
  , i_total_appr_doc_drawdown_amt      IN NUMBER   -- 佔用批覆書累積額度
  , i_total_nego_amt                   IN NUMBER   -- 累積和解總額
  , o_row_count                        OUT NUMBER  -- 回傳更新筆數
  ) AS
  BEGIN
    UPDATE EDLS.TB_CUST_LIMIT_DTL
    SET
      CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no, 
      CCY = i_ccy, 
      LAST_TXN_DATE = i_last_txn_date, 
      TOTAL_DRAWDOWN_AMT = i_total_drawdown_amt, 
      TOTAL_REPAYMT_AMT = i_total_repaymt_amt, 
      TOTAL_APPR_DOC_DRAWDOWN_AMT = i_total_appr_doc_drawdown_amt, 
      TOTAL_NEGO_AMT = i_total_nego_amt, 
      BUSINESS_TYPE = i_business_type, 
      AMEND_DATE = systimestamp
    WHERE CUST_LIMIT_DTL_SEQ_NO = i_cust_limit_dtl_seq_no; 
    o_row_count:=SQL%ROWCOUNT;
  END SP_UPD_CUST_LIMIT_DTL;

--*************************************************************************
-- SP_GET_CUST_LIMIT_DTL
-- Purpose: 取得授信戶額度彙計檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.02.19  created
-- 1.1 ESB18627  2019.10.24  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_CUST_LIMIT_DTL
  ( i_cust_id                    IN VARCHAR2       -- 銀行歸戶統編
  , i_currency                   IN VARCHAR2       -- 幣別
  , i_business_type              IN VARCHAR2       -- 業務別
  , o_cur                        OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT cld.CUST_LIMIT_DTL_SEQ_NO
          ,cld.CUSTOMER_LOAN_SEQ_NO
          ,cld.CCY
          ,cld.LAST_TXN_DATE
          ,cld.TOTAL_DRAWDOWN_AMT
          ,cld.TOTAL_REPAYMT_AMT
          ,cld.TOTAL_APPR_DOC_DRAWDOWN_AMT
          ,cld.TOTAL_NEGO_AMT
          ,cld.BUSINESS_TYPE
    FROM EDLS.TB_CUST_LIMIT_DTL cld JOIN EDLS.TB_CUSTOMER_LOAN cl
      ON cl.CUSTOMER_LOAN_SEQ_NO = cld.CUSTOMER_LOAN_SEQ_NO
    WHERE (i_cust_id IS NULL OR cl.CUST_ID=i_cust_id)
      AND (i_currency IS NULL OR cld.CCY = i_currency)
      AND (i_business_type IS NULL OR cld.BUSINESS_TYPE = i_business_type)
    FOR UPDATE;
  END SP_GET_CUST_LIMIT_DTL;


  --*************************************************************************
-- SP_GET_LIMIT_COMBINED_LIST
-- Purpose: 以分項額度查詢組合額度設定檔列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 ????     ???????????  created
-- 1.1 ESB18627  2019.10.24  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_COMBINED_LIST
  ( i_limit_seq_no IN NUMBER
  , o_cur OUT SYS_REFCURSOR
  ) AS
  BEGIN
    OPEN o_cur FOR
    Select LIMIT_COMBINED_PROFILE_SEQ_NO, LIMIT_COMBINED_SEQ_NO, LIMIT_SEQ_NO
    From EDLS.TB_LIMIT_COMBINED_PROFILE
    Where LIMIT_SEQ_NO = i_limit_seq_no
    FOR UPDATE;
  END SP_GET_LIMIT_COMBINED_LIST;

--*************************************************************************
-- SP_DEL_CUST_LIMIT_DTL
-- Purpose: 刪除授信戶額度彙計檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李建邦     2019.03.20  created
-- 1.1 ESB18627  2019.10.24  performance adjust
--**************************************************************************
  PROCEDURE SP_DEL_CUST_LIMIT_DTL
  ( i_loan_cust_seq_no IN NUMBER   -- 授信戶主檔序號
  , i_business_type    IN VARCHAR2 -- 業務別
  , i_currency         IN VARCHAR2 -- 幣別
  , o_row_count       OUT NUMBER   -- 刪除筆數
  ) AS 
  BEGIN
    DELETE 
      FROM EDLS.TB_CUST_LIMIT_DTL
     WHERE CUSTOMER_LOAN_SEQ_NO = i_loan_cust_seq_no
       AND BUSINESS_TYPE = i_business_type
       AND CCY = i_currency;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_CUST_LIMIT_DTL;

--*************************************************************************
-- SP_UPD_LIMIT_DTL
-- Purpose: 更新分項額度彙計檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李建邦     2019.03.22  created
-- 1.1 ESB18627  2019.10.24  performance adjust
--**************************************************************************
  PROCEDURE SP_UPD_LIMIT_DTL
  ( i_limit_dtl_seq_no            IN NUMBER   -- 分項額度彙計檔序號
  , i_limit_seq_no                IN NUMBER   -- 分項額度主檔序號
  , i_ccy                         IN VARCHAR2 -- 幣別
  , i_last_txn_date               IN VARCHAR2 -- 最後交易日
  , i_total_drawdown_amt          IN NUMBER   -- 累積動用金額
  , i_total_repaymt_amt           IN NUMBER   -- 累積還款金額
  , i_total_appr_doc_drawdown_amt IN NUMBER   -- 佔用批覆書累積額度
  , i_total_nego_amt              IN NUMBER   -- 累積和解總額
  , i_forign_business_type        IN VARCHAR2 -- 外匯業務別
  , o_row_count                   OUT NUMBER  -- 更新筆數
  ) AS --更新筆數
  BEGIN
    UPDATE EDLS.TB_LIMIT_DTL 
       SET LIMIT_SEQ_NO                = i_limit_seq_no
          ,CCY                         = i_ccy
          ,LAST_TXN_DATE               = i_last_txn_date
          ,TOTAL_DRAWDOWN_AMT          = i_total_drawdown_amt
          ,TOTAL_REPAYMT_AMT           = i_total_repaymt_amt
          ,TOTAL_APPR_DOC_DRAWDOWN_AMT = i_total_appr_doc_drawdown_amt
          ,TOTAL_NEGO_AMT              = i_total_nego_amt
          ,FORIGN_BUSINESS_TYPE        = i_forign_business_type 
          ,AMEND_DATE                  = SYSTIMESTAMP
     WHERE LIMIT_DTL_SEQ_NO = i_limit_dtl_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_LIMIT_DTL;


--*************************************************************************
-- SP_GET_PREPAID_STOCK_TXN
-- Purpose: 查詢特定墊付股款交易紀錄
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李栢陞     2019.03.25  created
-- 1.1 ESB18627  2019.10.24  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_PREPAID_STOCK_TXN
  ( i_txn_date  IN  VARCHAR2      -- 登錄日期
  , i_branch    IN  VARCHAR2      -- 分行代號
  , i_host_sno  IN  VARCHAR2      -- 主機交易序號
  , o_cur       OUT SYS_REFCURSOR -- 回傳資料
  )AS
  BEGIN
    OPEN o_cur FOR
    SELECT PREPAID_STOCK_TXN_SEQ_NO
      , LIMIT_SEQ_NO
      , TXN_DATE
      , TXN_SNO
      , TXN_TIME
      , BRANCH
      , HOST_SNO
      , SUP_CARD_CODE
      , TXN_ID
      , TXN_MEMO
      , ACC_BRANCH
      , DC_CODE
      , ACTION_CODE
      , TXN_AMT
      , PREPAID_BALANCE
      , SAVING_ACC_NO
      , SAVING_ACC_CUST_ID
      , PREPAID_ACC_CATEGORY
      , DEBIT_ACC_NO
      , TO_SAVING_ACC_NO
      , CREATE_DATE
      , AMEND_DATE
      , APPR_DOC_SEQ_NO
      , LIMIT_TYPE
      , IS_EC
    FROM
      EDLS.TB_PREPAID_STOCK_TXN
    WHERE
	  i_txn_date = TXN_DATE AND
	  i_branch   = BRANCH   AND
      i_host_sno = HOST_SNO;
  END SP_GET_PREPAID_STOCK_TXN;

--*************************************************************************
-- SP_GET_COUNT_APPR_DOC_HISTORY
-- Purpose: 取得批覆書變更紀錄查詢總數
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈     2019.03.26  created
-- 1.1 ESB18627  2019.10.24  performance adjust
--************************************************************************** 
  PROCEDURE SP_GET_COUNT_APPR_DOC_HISTORY
  ( i_appr_doc_seq_no           IN NUMBER   -- 批覆書主檔序號
  , i_modify_code_operator      IN VARCHAR2 -- 變更代號運算子
  , i_modify_code               IN VARCHAR2 -- 變更代號
  , i_transaction_type_operator IN VARCHAR2 -- 交易分類運算子
  , i_transaction_type          IN VARCHAR2 -- 交易分類
  , o_count                     OUT NUMBER  -- 回傳筆數 
  ) AS
  BEGIN
    SELECT COUNT(1) INTO o_count
    FROM EDLS.TB_APPR_DOC_HISTORY adh, 
         EDLS.TB_APPR_DOC_HISTORY_DTL adhl
    WHERE adh.APPR_DOC_HISTORY_SEQ_NO = adhl.APPR_DOC_HISTORY_SEQ_NO
    AND adh.APPR_DOC_SEQ_NO = i_appr_doc_seq_no AND
         ( i_transaction_type_operator IS NULL 
         OR ( i_transaction_type_operator = '0' AND adh.TXN_TYPE NOT IN(SELECT COLUMN_VALUE FROM TABLE(FN_SPLIT_STRING(i_transaction_type, ',')))) 
         OR ( i_transaction_type_operator = '1' AND adh.TXN_TYPE IN(SELECT COLUMN_VALUE FROM TABLE(FN_SPLIT_STRING(i_transaction_type, ','))))
         )
    And  ( i_modify_code_operator IS NULL 
         OR ( i_modify_code_operator = '0' AND adhl.MODIFY_CODE NOT IN(SELECT COLUMN_VALUE FROM TABLE(FN_SPLIT_STRING(i_modify_code, ',')))) 
         OR ( i_modify_code_operator = '1' AND adhl.MODIFY_CODE IN(SELECT COLUMN_VALUE FROM TABLE(FN_SPLIT_STRING(i_modify_code, ','))))
         );
  END SP_GET_COUNT_APPR_DOC_HISTORY;

--*************************************************************************
-- SP_GET_CUST_APPR_DOC_LIST    
-- Purpose: 查詢歸戶下批覆書列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈     2019.03.26  created
-- 1.1 ESB18627  2019.10.24  performance adjust
--**************************************************************************
  PROCEDURE SP_GET_CUST_APPR_DOC_LIST
  ( i_cust_id    IN VARCHAR2       -- 銀行歸戶統編
  , i_limit_type IN VARCHAR2       -- 額度種類
  , i_date       IN VARCHAR2       -- 批覆書到期日
  , o_cur        OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT ad.APPR_DOC_SEQ_NO
    , ad.CUSTOMER_LOAN_SEQ_NO
    , ad.APPR_DOC_NO
    , ad.PHASE
    , ad.APPRD_DATE
    , ad.MATU_DATE
    , ad.FIRST_DRAWDOWN_EDATE
    , ad.TOTAL_APPR_AMT
    , ad.TOTAL_APPR_CCY
    , ad.CHANNEL_CODE
    , ad.APPR_DRAWDOWN_TYPE
    , ad.LOAN_PURPOSE
    , ad.LOAN_ATTRIBUTES
    , ad.CCL_MK
    , ad.SOURCE_CODE
	, ad.DATA_CONVERT_SOURCE
    , ad.ACC_BRANCH
    , ad.OPER_BRANCH
    , ad.UNDER_CENTER 
    , ad.APPROVER_ID
    , ad.APPRD_TYPE
    , ad.EFFEC_PERIOD
    , ad.EFFEC_UNIT
    , ad.CONTRACT_SDATE
    , ad.CONTRACT_PERIOD
    , ad.CONTRACT_UNIT
    , ad.FROM_APPR_DOC_NO
    , ad.TO_APPR_DOC_NO
    , ad.LAST_TXN_DATE
    , ad.INTER_MEDIA_BRANCH
    , ad.REPORT_BRANCH
    , ad.PROFIT_BRANCH
    , ad.FIRST_DRAWDOWN_DATE
    , ad.AUTH_DATE
    , ad.APPR_DOC_EDATE
    , ad.MPL_MORT_OVERDUE_CANCEL_MK
    , ad.APPR_DOC_SOURCE
    , ad.SYSTEM_ID
    , ad.CROSS_BORDER_SHARED_LIMIT_MK
    , ad.MODIFIABLE
    , ad.CREATE_DATE
    , ad.AMEND_DATE
  From EDLS.TB_CUSTOMER_LOAN  cl 
  INNER JOIN EDLS.TB_APPR_DOC ad 
    ON ad.CUSTOMER_LOAN_SEQ_NO = cl.CUSTOMER_LOAN_SEQ_NO
  INNER JOIN EDLS.TB_LIMIT  lt
    ON ad.APPR_DOC_SEQ_NO= lt.APPR_DOC_SEQ_NO
  Where cl.CUST_ID=i_cust_id
  AND (i_limit_type  IS NULL OR lt.LIMIT_TYPE = i_limit_type)
  AND (ad.phase ='N' OR ad.phase ='0')
  AND (i_date IS NULL OR ad.MATU_DATE  >=  i_date);

  END SP_GET_CUST_APPR_DOC_LIST;

--*************************************************************************
-- 1834  SP_GET_APPR_DOC_BY_CUST_SEQ_NO
-- Purpose: 以授信戶主檔序號取得該授信戶所有的批覆書。
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維  2019.05.15  created
-- 1.1 ESB18627  2019.10.24  performance adjust
--**************************************************************************
  PROCEDURE  SP_GET_APPR_DOC_BY_CUST_SEQ_NO 
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , o_cur                  OUT SYS_REFCURSOR -- 批覆書資料
  ) AS
  BEGIN
        OPEN o_cur FOR
        SELECT APPR_DOC_SEQ_NO              -- 批覆書主檔序號
              ,CUSTOMER_LOAN_SEQ_NO         -- 授信戶主檔序號
              ,APPR_DOC_NO                  -- 批覆書編號
              ,PHASE                        -- 批覆書狀態
              ,APPRD_DATE                   -- 批覆書核準日
              ,MATU_DATE                    -- 批覆書到期日
              ,FIRST_DRAWDOWN_EDATE         -- 第一次動用截止日
              ,TOTAL_APPR_AMT               -- 總額度
              ,TOTAL_APPR_CCY               -- 總額度幣別
              ,CHANNEL_CODE                 -- 通路
              ,APPR_DRAWDOWN_TYPE           -- 本批覆書動用方式
              ,LOAN_PURPOSE                 -- 借款用途
              ,LOAN_ATTRIBUTES              -- 授信性質
              ,CCL_MK                       -- 綜合額度註記
              ,SOURCE_CODE                  -- 案件來源
              ,DATA_CONVERT_SOURCE          -- 資料轉換來源
              ,ACC_BRANCH                   -- 記帳單位
              ,OPER_BRANCH                  -- 作業單位
              ,UNDER_CENTER                 -- 批覆書所屬中心
              ,APPROVER_ID                  -- 核貸者統編
              ,APPRD_TYPE                   -- 核貸權限別
              ,EFFEC_PERIOD                 -- 批覆書有效期間
              ,EFFEC_UNIT                   -- 批覆書有效期間單位
              ,CONTRACT_SDATE               -- 契約起始日
              ,CONTRACT_PERIOD              -- 契約有效期間
              ,CONTRACT_UNIT                -- 契約有效期間單位
              ,FROM_APPR_DOC_NO             -- 來源批覆書
              ,TO_APPR_DOC_NO               -- 目的批覆書
              ,LAST_TXN_DATE                -- 上次交易日
              ,INTER_MEDIA_BRANCH           -- 轉介單位
              ,REPORT_BRANCH                -- 報表單位
              ,PROFIT_BRANCH                -- 利潤單位
              ,FIRST_DRAWDOWN_DATE          -- 首次動撥日
              ,AUTH_DATE                    -- 批覆書放行日
              ,APPR_DOC_EDATE               -- 批覆書結束日
              ,MPL_MORT_OVERDUE_CANCEL_MK   -- 月繳月省房貸因逾期取消功能註記
              ,APPR_DOC_SOURCE              -- 批覆書來源
              ,SYSTEM_ID                    -- 鍵檔平台
              ,MODIFIABLE                   -- 可執行變更交易
              ,CROSS_BORDER_SHARED_LIMIT_MK -- 跨境共用額度註記
          FROM EDLS.TB_APPR_DOC 
         WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
         ORDER BY APPR_DOC_SEQ_NO;
   END SP_GET_APPR_DOC_BY_CUST_SEQ_NO;  

--*************************************************************************
-- SP_GET_CORP_BUSINESS_ACC_NO
-- Purpose: 取得企金業務專戶
--
-- Modification History
-- Person       Date        Comments
-- ----------   ----------  ---------------------------------------------
-- 1.0 黃偉庭    2019.06.19  created
-- 1.1 ESB18627  2019.10.24  performance adjust 存款業務INDEX無法調整，如果慢請存款調整INDEX
--**************************************************************************
  PROCEDURE SP_GET_CORP_BUSINESS_ACC_NO
  ( i_account_branch        IN VARCHAR2         -- 記帳單位
  , o_account_no            OUT VARCHAR2        -- 活存帳號
  ) AS
  v_BH_ID_NO EDLS.TB_BRANCH.BH_ID_NO%TYPE;
  BEGIN
    SELECT bh.BH_ID_NO INTO v_BH_ID_NO
    FROM TB_BRANCH bh 
    WHERE bh.BH_CODE = i_account_branch; 

    IF v_BH_ID_NO IS NOT NULL THEN
    v_BH_ID_NO := v_BH_ID_NO || '%';
    SELECT da.DEMAND_DEPT_ACC
    INTO o_account_no
    FROM TB_DEPT_ACC da 
    WHERE CUST_ID LIKE v_BH_ID_NO
    AND da.ACC_STATUS = '0' 
    AND da.BU_SPECIAL_MARK = '5' 
    ORDER BY da.CUST_ID ASC, da.DEMAND_DEPT_ACC ASC
    FETCH FIRST 1 ROWS ONLY;
    END IF;
 
    EXCEPTION WHEN NO_DATA_FOUND
    THEN o_account_no := NULL;  
  END SP_GET_CORP_BUSINESS_ACC_NO;

--*************************************************************************
-- SP_DEL_APPR_DOC_ALL_DATA
-- Purpose: 以批覆書主檔序號刪除批覆書所有相關table
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 MARS      2019.07.03  created
-- 1.1 ESB18627  2019.10.24  performance adjust 
-- 1.2 ESB19237  2020.11.23  新增刪除【擔保品設定金額資訊檔】
--**************************************************************************
  PROCEDURE  SP_DEL_APPR_DOC_ALL_DATA 
  ( i_appr_doc_seqno IN item_num_array  -- 批覆書主檔序號(多筆)
  , o_count          OUT NUMBER         -- 筆數
  )AS 
  -- 宣告 Table 資料型態
  type l_limit is table of number index by binary_integer;
  l_limit_seqno l_limit;
  type l_limit_pf is table of number index by binary_integer;
  l_limit_profile_seqno l_limit_pf;
  type l_coll is table of number index by binary_integer;
  l_coll_seq_no l_coll;
  BEGIN
    --對其下關聯的擔保品主檔 collect and lock
      SELECT COLL.COLL_SEQ_NO BULK COLLECT INTO l_coll_seq_no
      FROM EDLS.TB_COLL COLL
      WHERE COLL.APPR_DOC_SEQ_NO IN (SELECT * FROM TABLE (i_appr_doc_seqno))
      FOR UPDATE;

    --對其下關聯的分項額度主檔 collect and lock
      SELECT l.LIMIT_SEQ_NO BULK COLLECT INTO l_limit_seqno
      FROM EDLS.TB_LIMIT l
      WHERE l.APPR_DOC_SEQ_NO IN (SELECT * FROM TABLE (i_appr_doc_seqno))
      FOR UPDATE;

      SELECT lp.LIMIT_PROFILE_SEQ_NO BULK COLLECT INTO l_limit_profile_seqno
      FROM EDLS.TB_LIMIT_PROFILE lp
      WHERE lp.LIMIT_SEQ_NO in (select LIMIT_SEQ_NO from EDLS.TB_LIMIT where APPR_DOC_SEQ_NO in (SELECT * FROM TABLE (i_appr_doc_seqno)))
      FOR UPDATE;

      --刪除擔保品設定檔底下的擔保品設定金額資訊檔
      for i in 1..l_coll_seq_no.count loop
        DELETE FROM EDLS.TB_COLL_SETTING_AMT     --使用 FORALL 刪除【擔保品設定金額資訊檔】
        WHERE COLL_SEQ_NO = l_coll_seq_no(i);
      end loop;

      --刪除分項批示條件設定檔及其下關聯資料
      for i in 1..l_limit_profile_seqno.count loop
        DELETE FROM EDLS.TB_LIMIT_PROJ_COND_PROF     --使用 FORALL 刪除【專案屬性註記批示條件檔】
        WHERE LIMIT_PROFILE_SEQ_NO = l_limit_profile_seqno(i);
        DELETE FROM EDLS.TB_PROD_MORTGAGE_PROFILE    --使用 FORALL 刪除【房貸產品種類批示條件檔】
        WHERE LIMIT_PROFILE_SEQ_NO = l_limit_profile_seqno(i);
        DELETE FROM EDLS.TB_PRE_CLOSURE_FEE_PROFILE  --使用 FORALL 刪除【提前清償違約金設定檔】
        WHERE LIMIT_PROFILE_SEQ_NO = l_limit_profile_seqno(i);
        DELETE FROM EDLS.TB_LIMIT_PROFILE            --使用 FORALL 刪除【分項批示條件設定檔】 (主檔需於最後刪除)
        WHERE LIMIT_PROFILE_SEQ_NO = l_limit_profile_seqno(i);
      end loop;
      --刪除分項額度主檔及其下關聯資料
      --for i in 1..l_limit_seqno.count loop
      DELETE FROM EDLS.TB_APPR_DOC_INLOAN_PROFILE    -- 使用 FORALL 刪除【間接授信批示條件檔】
      WHERE LIMIT_SEQ_NO in (select LIMIT_SEQ_NO from EDLS.TB_LIMIT where APPR_DOC_SEQ_NO in (SELECT * FROM TABLE (i_appr_doc_seqno)));
      DELETE FROM EDLS.TB_LIMIT_COMBINED_PROFILE     -- 使用 FORALL 刪除【組合額度設定檔】
      WHERE LIMIT_SEQ_NO in (select LIMIT_SEQ_NO from EDLS.TB_LIMIT where APPR_DOC_SEQ_NO in (SELECT * FROM TABLE (i_appr_doc_seqno)));
      DELETE FROM EDLS.TB_LIMIT_PREPAY_STOCK         -- 使用 FORALL 刪除【墊付股款額度設定檔】
      WHERE LIMIT_SEQ_NO in (select LIMIT_SEQ_NO from EDLS.TB_LIMIT where APPR_DOC_SEQ_NO in (SELECT * FROM TABLE (i_appr_doc_seqno)));
      DELETE FROM EDLS.TB_LIMIT_AR                   -- 使用 FORALL 刪除【應收帳款預支價金額度資訊】
      WHERE LIMIT_SEQ_NO in (select LIMIT_SEQ_NO from EDLS.TB_LIMIT where APPR_DOC_SEQ_NO in (SELECT * FROM TABLE (i_appr_doc_seqno)));
      DELETE FROM EDLS.TB_LIMIT                      -- 使用 FORALL 刪除【分項額度主檔】(主檔需於最後刪除)
      WHERE LIMIT_SEQ_NO in (select LIMIT_SEQ_NO from EDLS.TB_LIMIT where APPR_DOC_SEQ_NO in (SELECT * FROM TABLE (i_appr_doc_seqno)));
      --END LOOP;
    --刪除批覆書及其下關聯資料
    DELETE FROM EDLS.TB_GUARANTOR                 -- 使用 FORALL 刪除【保證人資料檔】
    WHERE APPR_DOC_SEQ_NO IN (SELECT * FROM TABLE (i_appr_doc_seqno));
    DELETE FROM EDLS.TB_COLL                      -- 使用 FORALL 刪除【擔保品登錄檔】
    WHERE APPR_DOC_SEQ_NO IN (SELECT * FROM TABLE (i_appr_doc_seqno));
    DELETE FROM EDLS.TB_COLL_STOCK                -- 使用 FORALL 刪除【股票擔保品登錄檔】
    WHERE APPR_DOC_SEQ_NO IN (SELECT * FROM TABLE (i_appr_doc_seqno));
    DELETE FROM EDLS.TB_COLL_REVERSE_COMMIT       -- 使用 FORALL 刪除【反面承諾】
    WHERE APPR_DOC_SEQ_NO IN (SELECT * FROM TABLE (i_appr_doc_seqno));
    DELETE FROM EDLS.TB_LIMIT_COMBINED            -- 使用 FORALL 刪除【組合額度主檔】
    WHERE APPR_DOC_SEQ_NO IN (SELECT * FROM TABLE (i_appr_doc_seqno));
    DELETE FROM EDLS.TB_APPR_DOC_EXTENSION        -- 使用 FORALL 刪除【分段優惠利率資訊】and【刪除消金動撥資訊】and【聯貸案資訊】
    WHERE APPR_DOC_SEQ_NO IN (SELECT * FROM TABLE (i_appr_doc_seqno));
    DELETE FROM EDLS.TB_APPR_DOC_ACTIVITY_PROFILE -- 使用 FORALL 刪除【批覆書活動設定檔】
    WHERE APPR_DOC_SEQ_NO IN (SELECT * FROM TABLE (i_appr_doc_seqno));
    DELETE FROM EDLS.TB_APPR_DOC_TEMP             -- 使用 FORALL 刪除【批覆書暫存資料檔】
    WHERE APPR_DOC_SEQ_NO IN (SELECT * FROM TABLE (i_appr_doc_seqno));
    DELETE FROM EDLS.TB_APPR_DOC                  -- 使用 FORALL 刪除【批覆書主檔】(主檔需於最後刪除)
    WHERE APPR_DOC_SEQ_NO IN (SELECT * FROM TABLE (i_appr_doc_seqno));
    o_count := SQL%ROWCOUNT;
  END SP_DEL_APPR_DOC_ALL_DATA;

--*************************************************************************
--  SP_GET_LIMIT
-- Purpose: 以批覆書主檔序號查詢分項額度檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈    2019.07.03  created
-- 1.1 ESB18627  2019.10.24  performance adjust 
--************************************************************************** 
  PROCEDURE SP_GET_LIMIT(i_appr_doc_seq_no IN NUMBER, o_cur OUT SYS_REFCURSOR) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LIMIT_SEQ_NO,
      APPR_DOC_SEQ_NO,
      LIMIT_TYPE,
      SERIAL_NO,
      BUSINESS_TYPE,
      BUSINESS_CODE,
      PERIOD_TYPE,
      IS_GUARANTEED,
      CCY_TYPE,
      RIGHT_MK,
      IS_FORWARD,
      CURRENCY,
      APPRD_SUB_LIMIT_AMT,
      LIMIT_DRAWDOWN_TYPE,
      PHASE,
      CREATE_DATE,
      AMEND_DATE
    FROM TB_LIMIT lt 
    WHERE (APPR_DOC_SEQ_NO = i_appr_doc_seq_no)
    FOR UPDATE;

  END SP_GET_LIMIT;

--*************************************************************************
--  SP_GET_GUARANTOR_UNDER_AD
-- Purpose: 取得批覆書下保證人資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈      2019.07.03  created
--
--**************************************************************************   
  PROCEDURE SP_GET_GUARANTOR_UNDER_AD( i_appr_doc_seq_no IN  NUMBER        --批覆書主檔序號
  , i_limit_seq_no    IN  NUMBER        --分項額度主檔序號
  , o_cur             OUT SYS_REFCURSOR --回傳資料
  ) AS
  BEGIN
    open o_cur FOR
    SELECT GUARANTOR_SEQ_NO,
        APPR_DOC_SEQ_NO,
        LIMIT_SEQ_NO,
        CUSTOMER_LOAN_SEQ_NO,
        IDENTITY_CODE,
        COUNTRY,
        PHASE,
        CANCEL_REASON_MK,
        PERCENTAGE,
        RELATIONSHIP_CODE,
        RELATION_WITH_MIN_DEBTOR,
        IS_FINAN_INSTIT,
        CHANGE_DATE,
        BIND_ALL_MARK,
        CREATE_DATE,
        AMEND_DATE
      FROM TB_GUARANTOR 
    WHERE (APPR_DOC_SEQ_NO = i_appr_doc_seq_no)
     AND (i_limit_seq_no IS NULL AND LIMIT_SEQ_NO IS NULL)
     AND (i_limit_seq_no IS NOT  NULL AND LIMIT_SEQ_NO= i_limit_seq_no)
    ORDER BY GUARANTOR_SEQ_NO, APPR_DOC_SEQ_NO, LIMIT_SEQ_NO;
  END SP_GET_GUARANTOR_UNDER_AD;

  PROCEDURE SP_GET_APPR_DOC_BY_SEQNO( i_appr_doc_seq_no IN NUMBER, o_cur OUT SYS_REFCURSOR) AS
  BEGIN
    OPEN o_cur FOR
    SELECT APPR_DOC_SEQ_NO,
        CUSTOMER_LOAN_SEQ_NO,
        APPR_DOC_NO,
        PHASE,
        APPRD_DATE,
        MATU_DATE,
        FIRST_DRAWDOWN_EDATE,
        TOTAL_APPR_AMT,
        TOTAL_APPR_CCY,
        CHANNEL_CODE,
        APPR_DRAWDOWN_TYPE,
        LOAN_PURPOSE,
        LOAN_ATTRIBUTES,
        CCL_MK,
        SOURCE_CODE,
        DATA_CONVERT_SOURCE,
        ACC_BRANCH,
        OPER_BRANCH,
        UNDER_CENTER,
        APPROVER_ID,
        APPRD_TYPE,
        EFFEC_PERIOD,
        EFFEC_UNIT,
        CONTRACT_SDATE,
        CONTRACT_PERIOD,
        CONTRACT_UNIT,
        FROM_APPR_DOC_NO,
        TO_APPR_DOC_NO,
        LAST_TXN_DATE,
        INTER_MEDIA_BRANCH,
        REPORT_BRANCH,
        PROFIT_BRANCH,
        FIRST_DRAWDOWN_DATE,
        AUTH_DATE,
        APPR_DOC_EDATE,
        MPL_MORT_OVERDUE_CANCEL_MK,
        APPR_DOC_SOURCE,
        SYSTEM_ID,
        MODIFIABLE,
        CROSS_BORDER_SHARED_LIMIT_MK,
        CREATE_DATE,
        AMEND_DATE
    FROM EDLS.TB_appr_doc ad 
    WHERE (ad.APPR_DOC_SEQ_NO= i_appr_doc_seq_no);
  END SP_GET_APPR_DOC_BY_SEQNO;

--**************************************************************************
-- SP_UPD_PREPAID_STOCK_TXN
-- Purpose: 更新特定墊付股款交易紀錄
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李柏陞     2019.07.05  created
-- 1.1 ESB18627   2019.10.24  performance adjust 
--**************************************************************************
  PROCEDURE SP_UPD_PREPAID_STOCK_TXN
    (  i_limit_seq_no              IN  NUMBER
    ,  i_txn_date                  IN  VARCHAR2
    ,  i_txn_sno                   IN  NUMBER
    ,  i_txn_time                  IN  VARCHAR2
    ,  i_branch                    IN  VARCHAR2
    ,  i_host_sno                  IN  VARCHAR2
    ,  i_sup_card_code             IN  VARCHAR2
    ,  i_txn_id                    IN  VARCHAR2
    ,  i_txn_memo                  IN  VARCHAR2
    ,  i_acc_branch                IN  VARCHAR2
    ,  i_dc_code                   IN  VARCHAR2
    ,  i_action_code               IN  VARCHAR2
    ,  i_txn_amt                   IN  NUMBER
    ,  i_prepaid_balance           IN  NUMBER
    ,  i_saving_acc_no             IN  VARCHAR2
    ,  i_saving_acc_cust_id        IN  VARCHAR2
    ,  i_prepaid_acc_category      IN  VARCHAR2
    ,  i_debit_acc_no              IN  VARCHAR2
    ,  i_to_saving_acc_no          IN  VARCHAR2
    ,  i_appr_doc_seq_no           IN  NUMBER
    ,  i_limit_type                IN  VARCHAR2
    ,  i_is_ec                     IN  VARCHAR2
    ,  o_row_count                 OUT NUMBER -- 回傳資料
  ) AS
  BEGIN
    UPDATE EDLS.TB_PREPAID_STOCK_TXN
     SET
         LIMIT_SEQ_NO          =   i_limit_seq_no
       , TXN_DATE              =   i_txn_date
       , TXN_SNO               =   i_txn_sno
       , TXN_TIME              =   i_txn_time
       , BRANCH                =   i_branch
       , HOST_SNO              =   i_host_sno
       , SUP_CARD_CODE         =   i_sup_card_code
       , TXN_ID                =   i_txn_id
       , TXN_MEMO              =   i_txn_memo
       , ACC_BRANCH            =   i_acc_branch
       , DC_CODE               =   i_dc_code
       , ACTION_CODE           =   i_action_code
       , TXN_AMT               =   i_txn_amt
       , PREPAID_BALANCE       =   i_prepaid_balance
       , SAVING_ACC_NO         =   i_saving_acc_no
       , SAVING_ACC_CUST_ID    =   i_saving_acc_cust_id
       , PREPAID_ACC_CATEGORY  =   i_prepaid_acc_category
       , DEBIT_ACC_NO          =   i_debit_acc_no
       , TO_SAVING_ACC_NO      =   i_to_saving_acc_no
       , APPR_DOC_SEQ_NO       =   i_appr_doc_seq_no
       , LIMIT_TYPE            =   i_limit_type
       , IS_EC                 =   i_is_ec
       , AMEND_DATE            =   SYSTIMESTAMP
    WHERE
      TXN_DATE     = i_txn_date AND
      BRANCH       = i_branch  AND
      HOST_SNO     = i_host_sno;
      o_row_count := SQL%ROWCOUNT;
  END SP_UPD_PREPAID_STOCK_TXN;

--**************************************************************************
-- SP_GET_OVERDRAFT_BY_ACC_NO
-- Purpose: 用帳號序號查詢分項額度透支資訊檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.07.18  created
-- 1.1 ESB18627  2019.10.24  performance adjust
-- 1.2 ESB18757  2020.01.07  增加查詢條件以確保查出正確資料
--**************************************************************************
  PROCEDURE SP_GET_OVERDRAFT_BY_ACCOUNT
            ( i_acc_no         IN NUMBER        -- 帳號序號
            , i_acc_type       IN VARCHAR2      -- 帳號類別
            , i_account_status IN VARCHAR2      -- 帳號狀態
            , o_cur           OUT SYS_REFCURSOR -- 回傳資料
            ) AS 
  BEGIN
    OPEN o_cur FOR
    SELECT OVERDRAFT_SEQ_NO
      , LIMIT_SEQ_NO
      , ACC_NO
      , ACC_TYPE
      , CCY
      , OVERDRAFT_BALANCE_AMT
      , ACCOUNT_STATUS
    FROM EDLS.TB_OVERDRAFT
    WHERE ACC_NO = i_acc_no
      AND ACC_TYPE = i_acc_type
      AND ACCOUNT_STATUS = i_account_status;
  END SP_GET_OVERDRAFT_BY_ACCOUNT;

--**************************************************************************
-- SP_GET_LIMIT_BY_SEQNO_TYPE
-- Purpose: 以批覆書主檔序號及額度種類查詢分項額度主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李建邦     2019.07.22  created
-- 1.1 ESB18627   2019.10.24  performance adjust 
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BY_SEQNO_TYPE
            ( i_appr_doc_seq_no IN NUMBER        --批覆書主檔序號
            , i_limit_type      IN VARCHAR2      --額度種類
            , o_cur            OUT SYS_REFCURSOR --回傳資料
            ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LIMIT_SEQ_NO
          ,APPR_DOC_SEQ_NO
          ,LIMIT_TYPE
          ,SERIAL_NO
          ,BUSINESS_TYPE
          ,BUSINESS_CODE
          ,PERIOD_TYPE
          ,IS_GUARANTEED
          ,CCY_TYPE
          ,RIGHT_MK
          ,IS_FORWARD
          ,CURRENCY
          ,APPRD_SUB_LIMIT_AMT
          ,LIMIT_DRAWDOWN_TYPE
          ,PHASE
          ,CREATE_DATE
          ,AMEND_DATE
      FROM TB_LIMIT
     WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no
       AND LIMIT_TYPE = i_limit_type;
  END SP_GET_LIMIT_BY_SEQNO_TYPE;

--*************************************************************************
--  SP_GET_CUST_LIMIT_DTL_BY_CLSEQ
-- Purpose: 以授信戶主檔序號取得授信戶額度彙計檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維      2019.08.26  created
-- 1.1 ESB18627    2019.10.24  performance adjust 
--**************************************************************************
  PROCEDURE  SP_GET_CUST_LIMIT_DTL_BY_CLSEQ
  ( i_customer_loan_seq_no  IN NUMBER        -- 授信戶主檔序號
  , o_cur                  OUT SYS_REFCURSOR -- 授信戶額度彙計檔
  )AS
  BEGIN
        OPEN o_cur FOR
        SELECT CUST_LIMIT_DTL_SEQ_NO       --授信戶額度彙計檔序號
              ,CUSTOMER_LOAN_SEQ_NO        --授信戶主檔序號
              ,CCY                         --幣別
              ,LAST_TXN_DATE               --最後交易日
              ,TOTAL_DRAWDOWN_AMT          --累積動用金額
              ,TOTAL_REPAYMT_AMT           --累積還款金額
              ,TOTAL_APPR_DOC_DRAWDOWN_AMT --佔用批覆書累積額度
              ,TOTAL_NEGO_AMT              --累積和解總額
              ,BUSINESS_TYPE               --業務別
          FROM EDLS.TB_CUST_LIMIT_DTL
         WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
   END SP_GET_CUST_LIMIT_DTL_BY_CLSEQ;

--*************************************************************************
--  SP_GET_GUARANTOR_SEQS_BY_CLSEQ
-- Purpose: 以授信戶主檔序號取得[保證人資料檔]資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維      2019.08.26  created
-- 1.1 ESB18627    2019.10.24  performance adjust 
--**************************************************************************
  PROCEDURE  SP_GET_GUARANTOR_SEQS_BY_CLSEQ
  ( i_customer_loan_seq_no  IN NUMBER        -- 授信戶主檔序號
  , o_cur                  OUT SYS_REFCURSOR -- 保證人資料檔
  )AS
  BEGIN
        OPEN o_cur FOR
        SELECT TG.GUARANTOR_SEQ_NO
              ,TG.APPR_DOC_SEQ_NO
              ,TG.LIMIT_SEQ_NO
              ,TG.CUSTOMER_LOAN_SEQ_NO
              ,TG.IDENTITY_CODE
              ,TG.COUNTRY
              ,TG.PHASE
              ,TG.CANCEL_REASON_MK
              ,TG.PERCENTAGE
              ,TG.RELATIONSHIP_CODE
              ,TG.RELATION_WITH_MIN_DEBTOR
              ,TG.IS_FINAN_INSTIT
              ,TG.CHANGE_DATE
              ,TG.BIND_ALL_MARK
              ,TG.CREATE_DATE
              ,TG.AMEND_DATE
          FROM EDLS.TB_GUARANTOR TG
         WHERE EXISTS (SELECT 1 
                         FROM TB_APPR_DOC AD 
                        WHERE AD.CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no 
                          AND AD.APPR_DOC_SEQ_NO = TG.APPR_DOC_SEQ_NO);
   END SP_GET_GUARANTOR_SEQS_BY_CLSEQ;   

--*************************************************************************
-- SP_UPD_OVERDRAFT_DATA_INFO
-- Purpose: 03對透支還款使用SP。
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 MARS      2019.09.17  created
-- 1.1 ESB18627  2019.10.24  performance adjust 
-- 1.2 Mars      2019.12.23  如輸入欄位任一為空時拋錯，代碼”0910” ，訊息為”輸入要項不全(XXXX)”(XXXX為欄位的中文名稱)
-- 1.3 ESB18757  2020.04.22  同步SP_GET_DEPT_ACC查出欄位之差異
-- 1.4 ESB18757  2020.04.27  非預期之錯誤訊息Format拋出0900及trace內容，以供使用者辨別
-- 1.5 ESB20168  2020.06.12  若交易正常執行，o_return_desc內放置「額度更新軌跡檔主檔序號」，供後續整批還原時使用
-- 1.6 ESB19521  2021.02.17  VER #25225 add DIGITAL_SAVINGS_ACC_AUTH_TYPE
--**************************************************************************  
  PROCEDURE SP_UPD_OVERDRAFT_DATA_INFO
  ( i_date              IN VARCHAR2  -- 交易日期
  , i_cust_id           IN VARCHAR2  -- 銀行歸戶统編
  , i_appr_doc_no       IN VARCHAR2  -- 批覆書編號
  , i_limit_type        IN VARCHAR2  -- 額度種類
  , i_currency          IN VARCHAR2  -- 透支幣別
  , i_overdraft_balance IN VARCHAR2  -- 透支餘額
  , i_acc_no            IN VARCHAR2  -- 透支帳號
  , o_return_code       OUT VARCHAR2 -- 錯誤代碼
  , o_return_desc       OUT VARCHAR2 -- 錯誤訊息
  )AS
  o_cur SYS_REFCURSOR;
  o_cur2 SYS_REFCURSOR;
  type DEPT_ACC IS record
  ( DEPT_ACC_SEQ_NO                  EDLS.TB_DEPT_ACC.DEPT_ACC_SEQ_NO%type
  , DEMAND_DEPT_ACC                  EDLS.TB_DEPT_ACC.DEMAND_DEPT_ACC%type
  , ACC_TYPE                         EDLS.TB_DEPT_ACC.ACC_TYPE%type
  , CURR_TYPE                        EDLS.TB_DEPT_ACC.CURR_TYPE%type
  , CUST_ID                          EDLS.TB_DEPT_ACC.CUST_ID%type
  , OPEN_ACC_DATE                    EDLS.TB_DEPT_ACC.OPEN_ACC_DATE%type
  , OPEN_ACC_BH                      EDLS.TB_DEPT_ACC.OPEN_ACC_BH%type
  , SOURCE_BH                        EDLS.TB_DEPT_ACC.SOURCE_BH%type
  , BOOKING_BH                       EDLS.TB_DEPT_ACC.BOOKING_BH%type
  , TX_CTRL_BH                       EDLS.TB_DEPT_ACC.TX_CTRL_BH%type
  , REMITTANCE_NOTIFIC_BH            EDLS.TB_DEPT_ACC.REMITTANCE_NOTIFIC_BH%type
  , PROD_CODE                        EDLS.TB_DEPT_ACC.PROD_CODE%type
  , PASSBOOK_MARKER                  EDLS.TB_DEPT_ACC.PASSBOOK_MARKER%type
  , ACC_ALIAS                        EDLS.TB_DEPT_ACC.ACC_ALIAS%type
  , ACC_STATUS                       EDLS.TB_DEPT_ACC.ACC_STATUS%type
  , MODI_DATE_OF_ACC_STATUS          EDLS.TB_DEPT_ACC.MODI_DATE_OF_ACC_STATUS%type
  , INTER_BH_AGEN_PMNT_MARK          EDLS.TB_DEPT_ACC.INTER_BH_AGEN_PMNT_MARK%type
  , AML_MARK                         EDLS.TB_DEPT_ACC.AML_MARK%type
  , FUTR_SPECIAL_ACC_MARK            EDLS.TB_DEPT_ACC.FUTR_SPECIAL_ACC_MARK%type
  , RTIME_TRANS_MARK_OF_TX_DTLS      EDLS.TB_DEPT_ACC.RTIME_TRANS_MARK_OF_TX_DTLS%type
  , VLDT_FOR_TX_DTLS                 EDLS.TB_DEPT_ACC.VLDT_FOR_TX_DTLS%type
  , STMT_FORMAT                      EDLS.TB_DEPT_ACC.STMT_FORMAT%type
  , DIGITAL_SAVINGS_ACC_TYPE         EDLS.TB_DEPT_ACC.DIGITAL_SAVINGS_ACC_TYPE%type
  , DIGITAL_SAVINGS_ACC_MARK         EDLS.TB_DEPT_ACC.DIGITAL_SAVINGS_ACC_MARK%type
  , NEW_CONTRACT_SIGN_OFF_MARK       EDLS.TB_DEPT_ACC.NEW_CONTRACT_SIGN_OFF_MARK%type
  , MAIN_DEPT_ACC                    EDLS.TB_DEPT_ACC.MAIN_DEPT_ACC%type
  , DESIGNED_CHK_MARK                EDLS.TB_DEPT_ACC.DESIGNED_CHK_MARK%type
  , REDEPT_CPHS_DEPT_MARK            EDLS.TB_DEPT_ACC.REDEPT_CPHS_DEPT_MARK%type
  , SLEEPING_ACC_MARK                EDLS.TB_DEPT_ACC.SLEEPING_ACC_MARK%type
  , SUB_BROKERAGE_ACT_MARK           EDLS.TB_DEPT_ACC.SUB_BROKERAGE_ACT_MARK%type
  , SUB_BROKERAGE_FEE                EDLS.TB_DEPT_ACC.SUB_BROKERAGE_FEE%type
  , DEPT_WITHDRAW_CTRL_MARK          EDLS.TB_DEPT_ACC.DEPT_WITHDRAW_CTRL_MARK%type
  , PFTL_INTE_CCL_MARK               EDLS.TB_DEPT_ACC.PFTL_INTE_CCL_MARK%type
  , SPECIAL_PROJ_MARK                EDLS.TB_DEPT_ACC.SPECIAL_PROJ_MARK%type
  , ESA_ACC_MARK                     EDLS.TB_DEPT_ACC.ESA_ACC_MARK%type
  , WITHDRAW_PASSWORD_MARK           EDLS.TB_DEPT_ACC.WITHDRAW_PASSWORD_MARK%type
  , DECLINED_ACC_MARK                EDLS.TB_DEPT_ACC.DECLINED_ACC_MARK%type
  , BU_SPECIAL_MARK                  EDLS.TB_DEPT_ACC.BU_SPECIAL_MARK%type
  , DIGITAL_SAVINGS_ACC_FRT_MARK     EDLS.TB_DEPT_ACC.DIGITAL_SAVINGS_ACC_FRT_MARK%type
  , WITHDRAW_PASSWORD                EDLS.TB_DEPT_ACC.WITHDRAW_PASSWORD%type
  , OVER_PROD_ID                     EDLS.TB_DEPT_ACC.OVER_PROD_ID%type
  , MERGED_ACC_MARK                  EDLS.TB_DEPT_ACC.MERGED_ACC_MARK%type
  , CPHS_DEPT_CNT                    EDLS.TB_DEPT_ACC.CPHS_DEPT_CNT%type
  , LAST_LIMIT_DEPT_DATE             EDLS.TB_DEPT_ACC.LAST_LIMIT_DEPT_DATE%type
  , TX_DTL_LIMIT_MARK                EDLS.TB_DEPT_ACC.TX_DTL_LIMIT_MARK%type
  , DIGITAL_SAVINGS_ACC_AUTH_TYPE    EDLS.TB_DEPT_ACC.DIGITAL_SAVINGS_ACC_AUTH_TYPE%type
  );
  v_data DEPT_ACC;
  n_overdraft_seq_no EDLS.TB_OVERDRAFT.OVERDRAFT_SEQ_NO%TYPE;
  n_limit_seq_no EDLS.TB_OVERDRAFT.LIMIT_SEQ_NO%TYPE;
  v_acc_type EDLS.TB_OVERDRAFT.ACC_TYPE%TYPE;
  n_acc_no EDLS.TB_OVERDRAFT.ACC_NO%TYPE;
  v_ccy EDLS.TB_OVERDRAFT.CCY%TYPE;
  n_overdraft_balance_amt EDLS.TB_OVERDRAFT.OVERDRAFT_BALANCE_AMT%TYPE;
  v_account_status EDLS.TB_OVERDRAFT.ACCOUNT_STATUS%TYPE;
  v_before_total_drawdown_amt EDLS.TB_LIMIT_DTL.TOTAL_DRAWDOWN_AMT%TYPE;
  o_row_count number;
  type LIMIT_DTL is RECORD
  ( LIMIT_DTL_SEQ_NO            EDLS.TB_LIMIT_DTL.LIMIT_DTL_SEQ_NO%type
  , LIMIT_SEQ_NO                EDLS.TB_LIMIT_DTL.LIMIT_SEQ_NO%type
  , CCY                         EDLS.TB_LIMIT_DTL.CCY%type
  , LAST_TXN_DATE               EDLS.TB_LIMIT_DTL.LAST_TXN_DATE%type
  , TOTAL_DRAWDOWN_AMT          EDLS.TB_LIMIT_DTL.TOTAL_DRAWDOWN_AMT%type
  , TOTAL_REPAYMT_AMT           EDLS.TB_LIMIT_DTL.TOTAL_REPAYMT_AMT%type
  , TOTAL_APPR_DOC_DRAWDOWN_AMT EDLS.TB_LIMIT_DTL.TOTAL_APPR_DOC_DRAWDOWN_AMT%type
  , TOTAL_NEGO_AMT              EDLS.TB_LIMIT_DTL.TOTAL_NEGO_AMT%type
  , FORIGN_BUSINESS_TYPE        EDLS.TB_LIMIT_DTL.FORIGN_BUSINESS_TYPE%type
  );
  v_data2 LIMIT_DTL;
  n_count NUMBER;
  o_limit_dtl_seq_no number;
  o_limit_dtl_history_seq_no number;-- 額度更新軌跡檔主檔序號
  BEGIN
    -- 4.1.1	輸入檢核
    -- 如輸入欄位任一為空時拋錯，代碼”0910” ，訊息為”輸入要項不全(XXXX)”(XXXX為欄位的中文名稱)
    IF i_date is null
    THEN
        o_return_code := '0910';
        o_return_desc := '輸入要項不全(交易日期)';
        RETURN;
    ELSIF i_cust_id is null
    THEN
        o_return_code := '0910';
        o_return_desc := '輸入要項不全(銀行歸戶统編)';
        RETURN;
    ELSIF i_appr_doc_no is null
    THEN
        o_return_code := '0910';
        o_return_desc := '輸入要項不全(批覆書編號)';
        RETURN;
    ELSIF i_limit_type is null
    THEN
        o_return_code := '0910';
        o_return_desc := '輸入要項不全(額度種類)';
        RETURN;
    ELSIF i_currency is null
    THEN
        o_return_code := '0910';
        o_return_desc := '輸入要項不全(透支幣別)';
        RETURN;
    ELSIF i_overdraft_balance is null
    THEN
        o_return_code := '0910';
        o_return_desc := '輸入要項不全(透支餘額)';
        RETURN;
    ELSIF i_acc_no is null
    THEN
        o_return_code := '0910';
        o_return_desc := '輸入要項不全(透支帳號)';
        RETURN;
    END IF;
    -- 4.1.2	取得【分項額度透支資訊檔】
    -- 4.1.2.1	取得活存主檔
    EDLS.PG_DEPT_ACC.SP_GET_DEPT_ACC(i_acc_no , o_cur); --取得 v_dept_acc_seq_no
    LOOP
      FETCH o_cur INTO v_data;
      EXIT WHEN o_cur%notfound;
      -- 4.1.2.2	取得分項額度透支資訊檔
      SELECT ot.OVERDRAFT_SEQ_NO
           , ot.LIMIT_SEQ_NO
           , ot.ACC_TYPE
           , ot.ACC_NO
           , ot.CCY
           , ot.OVERDRAFT_BALANCE_AMT
           , ot.ACCOUNT_STATUS
           into n_overdraft_seq_no
              , n_limit_seq_no
              , v_acc_type
              , n_acc_no
              , v_ccy
              , n_overdraft_balance_amt
              , v_account_status
        FROM EDLS.TB_OVERDRAFT ot 
        INNER JOIN EDLS.TB_LIMIT lt ON ot.LIMIT_SEQ_NO = lt.LIMIT_SEQ_NO
        INNER JOIN EDLS.TB_APPR_DOC ad ON lt.APPR_DOC_SEQ_NO = ad.APPR_DOC_SEQ_NO
        INNER JOIN EDLS.TB_CUSTOMER_LOAN cl ON ad.CUSTOMER_LOAN_SEQ_NO = cl.CUSTOMER_LOAN_SEQ_NO
        WHERE ot.ACC_NO = v_data.dept_acc_seq_no --取得 v_dept_acc_seq_no
          AND ot.ACC_TYPE = 'DP'
          AND ot.CCY = i_currency 
          AND cl.CUST_ID = i_cust_id 
          AND ad.APPR_DOC_NO = i_appr_doc_no 
          AND lt.LIMIT_TYPE = i_limit_type;
      -- 4.1.3	更新【分項額度透支資訊檔】
      EDLS.PG_APPR_DOC_LIMIT.SP_UPD_OVERDRAFT
      ( n_overdraft_seq_no
      , n_limit_seq_no
      , v_acc_type
      , n_acc_no
      , v_ccy
      , i_overdraft_balance
      , v_account_status
      , o_row_count
      );

      -- 4.1.4	抓【分項額度彙計檔】
      ---EDLS.PG_APPR_DOC_LIMIT.SP_GET_LIMIT_DTL(4.1.2.2取得的v_limit_seq_no, i_currency)    
      EDLS.PG_APPR_DOC_LIMIT.SP_GET_LIMIT_DTL(n_limit_seq_no, i_currency, null, o_cur2);
      v_before_total_drawdown_amt :=0 ;
      LOOP
        FETCH o_cur2 INTO v_data2;
        EXIT WHEN o_cur2%notfound;
        v_before_total_drawdown_amt := v_data2.TOTAL_DRAWDOWN_AMT;

        PG_APPR_DOC_LIMIT.SP_UPD_LIMIT_DTL
        ( v_data2.LIMIT_DTL_SEQ_NO
        , v_data2.LIMIT_SEQ_NO
        , v_data2.CCY
        , i_date
        , i_overdraft_balance
        , 0
        , i_overdraft_balance
        , v_data2.total_nego_amt
        , v_data2.forign_business_type
        , o_row_count
        );
        o_limit_dtl_seq_no := v_data2.LIMIT_DTL_SEQ_NO;
      END LOOP;
      IF o_cur2%rowcount = 0 THEN
        --4.1.6	如4.1.4無抓到資訊則做以下更新
        --呼叫
          EDLS.PG_APPR_DOC_LIMIT.SP_INS_LIMIT_DTL
          ( n_limit_seq_no
          , i_currency
          , i_date
          , i_overdraft_balance
          , 0
          , i_overdraft_balance
          , 0
          , null
          , o_limit_dtl_seq_no
          );
      END IF;

      --4.1.7	新增【額度更新軌跡檔】
      EDLS.PG_APPR_DOC_LIMIT.SP_INS_LIMIT_DTL_HISTORY
      ( o_limit_dtl_seq_no              -- 分項額度彙計檔序號
      , i_date                          -- 交易日期
      , null                            -- 交易日期序號
      , substr(to_char( systimestamp, 'HH24missff'),0,8)    -- 交易時間
      , 'R'                             -- 作業類別
      , 'N'                             -- 沖正註記
      , i_currency                      -- 幣別
      , null                            -- 業務代碼
      , null                            -- 業務別
      , i_overdraft_balance             -- 交易金額
      , (i_overdraft_balance-v_before_total_drawdown_amt)   -- 累積動用金額
      , 0                               -- 累積還款金額
      , (i_overdraft_balance-v_before_total_drawdown_amt)   -- 佔用批覆書額度金額
      , 0                               -- 累積和解總額
      , o_limit_dtl_history_seq_no      -- 額度更新軌跡檔主檔序號
      );

      o_return_desc := o_limit_dtl_history_seq_no;
    END LOOP;

    EXCEPTION
    WHEN OTHERS THEN
      o_return_code:= '0900';
      o_return_desc := SQLERRM || DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

  END SP_UPD_OVERDRAFT_DATA_INFO;

  --*************************************************************************
-- SP_GET_COUNT_LIMIT_UNTRANS
-- Purpose: 取得批覆書下未移轉額度數目。
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.09.17  created
-- 1.1 ESB18627    2019.10.24  performance adjust 
--**************************************************************************
  PROCEDURE SP_GET_COUNT_LIMIT_UNTRANS
  ( i_appr_doc_seq_no     IN NUMBER  -- 批覆書主檔序號
  , o_count              OUT NUMBER  -- 未移轉額度數目
  ) AS
  BEGIN
    SELECT COUNT(1) INTO o_count
    FROM EDLS.TB_LIMIT
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no
      AND PHASE != '2';
  END SP_GET_COUNT_LIMIT_UNTRANS;  

--**************************************************************************
-- SP_GET_AD_LIMIT_FOR_CALC
-- Purpose: 取得批覆書下所有分項的各項金額總和，以分項流水號、已佔預佔的幣別做群組
--          (批覆書額度計算使用)(無鎖)
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 詹宏茂     2019.10.30  created
--
--**************************************************************************
  PROCEDURE SP_GET_AD_LIMIT_FOR_CALC
  ( i_appr_doc_seq_no       IN NUMBER  -- 批覆書主檔序號
  , o_cur                   OUT SYS_REFCURSOR --分項總和資訊
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT 
      LIMIT_SEQ_NO, --分項流水號
      CCY,--幣別(已佔、預佔)
      CURRENCY AS LIMIT_CCY,--分項幣別
      APPRD_SUB_LIMIT_AMT,--分項核准額度
      LIMIT_DRAWDOWN_TYPE,--分項動用類型
      PHASE ,--分項狀態
      SUM(SUM_DRAWDOWN) AS SUM_DRAWDOWN,--分項動用總金額(已佔+預佔)
      SUM(SUM_REPAYMENT) AS SUM_REPAYMENT, --分項還總款金額(已佔+預佔)
      SUM(SUM_NEGT) AS SUM_NEGT, --分項和解總金額(已佔)
      SUM(SUM_APPR_DOC_DRAWDOWN) AS SUM_APPR_DOC_DRAWDOWN, --分項批覆書占用累積金額
      SUM(BOOKING_BALANCE) AS SUM_BOOKING_BALANCE, --預佔現欠
      SUM(SUM_BALANCE) AS SUM_BALANCE --已佔現欠
    FROM
      (SELECT 
        LT.LIMIT_SEQ_NO,--分項流水號
        LD.CCY,--已佔幣別
        LT.CURRENCY,--分項幣別
        LT.APPRD_SUB_LIMIT_AMT,--分項核准額度
        LT.LIMIT_DRAWDOWN_TYPE,--分項動用方式
        LT.PHASE,--分項狀態
        NVL(SUM(LD.TOTAL_DRAWDOWN_AMT),0)                                                  AS SUM_DRAWDOWN,--分項動用金額
        NVL(SUM(LD.TOTAL_REPAYMT_AMT),0)                                                   AS SUM_REPAYMENT,--分項還款金額
        NVL(SUM(TOTAL_NEGO_AMT),0)                                                         AS SUM_NEGT,--分項累積和解總和
        NVL(SUM(TOTAL_APPR_DOC_DRAWDOWN_AMT),0)                                            AS SUM_APPR_DOC_DRAWDOWN, --已佔累積占用批覆書額度累積金額
        0                                                                           AS BOOKING_BALANCE,--預佔現欠
        (NVL(SUM(LD.TOTAL_DRAWDOWN_AMT),0)-NVL(SUM(LD.TOTAL_REPAYMT_AMT),0)- NVL(SUM(TOTAL_NEGO_AMT),0)) AS SUM_BALANCE --已佔現欠
      FROM EDLS.TB_APPR_DOC AD
      INNER JOIN EDLS.TB_LIMIT LT
      ON AD.APPR_DOC_SEQ_NO = LT.APPR_DOC_SEQ_NO
      LEFT JOIN EDLS.TB_LIMIT_DTL LD
      ON LT.LIMIT_SEQ_NO      = LD.LIMIT_SEQ_NO
      WHERE AD.APPR_DOC_SEQ_NO = i_appr_doc_seq_no
      GROUP BY LD.CCY,LT.LIMIT_SEQ_NO,LT.CURRENCY,LT.APPRD_SUB_LIMIT_AMT,LT.LIMIT_DRAWDOWN_TYPE,LT.PHASE
      UNION ALL
      SELECT 
        LT.LIMIT_SEQ_NO, --分項流水號
        LB.CCY,--預佔額度幣別
        LT.CURRENCY,--分項幣別
        LT.APPRD_SUB_LIMIT_AMT,--分項核准額度
        LT.LIMIT_DRAWDOWN_TYPE,--分項動用方式
        LT.PHASE,--分項狀態
        SUM(LB.TOTAL_DRAWDOWN_AMT)                                   AS SUM_DRAWDOWN,--預佔累計動用金額
        SUM(LB.TOTAL_TODAY_REPAYMT_AMT)                              AS SUM_REPAYMENT,--預佔當日累計還款金額
        0                                                            AS SUM_NEGT,--分項累積和解總和
        SUM(LB.TOTAL_DRAWDOWN_APPR_DOC_AMT)                                   AS SUM_APPR_DOC_DRAWDOWN, --預佔占用批覆書額度累積金額
        (SUM(LB.TOTAL_DRAWDOWN_AMT)-SUM(LB.TOTAL_TODAY_REPAYMT_AMT)) AS BOOKING_BALANCE ,--預佔現欠
        0                                                            AS SUM_BALANCE--已佔現欠
      FROM EDLS.TB_APPR_DOC AD
      INNER JOIN EDLS.TB_LIMIT LT ON AD.APPR_DOC_SEQ_NO = LT.APPR_DOC_SEQ_NO
      INNER JOIN EDLS.TB_LIMIT_BOOKING LB ON LT.LIMIT_SEQ_NO = LB.LIMIT_SEQ_NO
      WHERE AD.APPR_DOC_SEQ_NO = i_appr_doc_seq_no
        AND LB.TOTAL_DRAWDOWN_AMT - TOTAL_TODAY_REPAYMT_AMT > 0
      GROUP BY LB.CCY,LT.LIMIT_SEQ_NO,LT.CURRENCY,LT.APPRD_SUB_LIMIT_AMT,LT.LIMIT_DRAWDOWN_TYPE,LT.PHASE
    )V1
    GROUP BY CCY,LIMIT_SEQ_NO,CURRENCY,APPRD_SUB_LIMIT_AMT,LIMIT_DRAWDOWN_TYPE,PHASE;
  END SP_GET_AD_LIMIT_FOR_CALC;

--**************************************************************************
-- SP_GET_AD_LIMIT_FOR_CALC_U
-- Purpose: 取得批覆書下所有分項的各項金額總和，以分項流水號、已佔預佔的幣別做群組
--          (批覆書額度計算使用)
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 詹宏茂     2019.10.30  created
--
--**************************************************************************
  PROCEDURE SP_GET_AD_LIMIT_FOR_CALC_U
  ( i_appr_doc_seq_no       IN NUMBER  -- 批覆書主檔序號
  , o_cur                   OUT SYS_REFCURSOR --分項總和資訊
  ) AS
    CURSOR lock_cur IS 
        SELECT 
          '1' 
        FROM EDLS.TB_APPR_DOC AD
        INNER JOIN EDLS.TB_LIMIT LT
        ON AD.APPR_DOC_SEQ_NO = LT.APPR_DOC_SEQ_NO
        LEFT JOIN EDLS.TB_LIMIT_DTL LD 
        ON LT.LIMIT_SEQ_NO      = LD.LIMIT_SEQ_NO
        LEFT JOIN EDLS.TB_LIMIT_BOOKING LB ON LT.LIMIT_SEQ_NO = LB.LIMIT_SEQ_NO
        WHERE AD.APPR_DOC_SEQ_NO = i_appr_doc_seq_no
        FOR UPDATE;  
  BEGIN
    OPEN lock_cur;
    CLOSE lock_cur;
  
    OPEN o_cur FOR
    SELECT 
      LIMIT_SEQ_NO, --分項流水號
      CCY,--幣別(已佔、預佔)
      CURRENCY AS LIMIT_CCY,--分項幣別
      APPRD_SUB_LIMIT_AMT,--分項核准額度
      LIMIT_DRAWDOWN_TYPE,--分項動用類型
      PHASE ,--分項狀態
      SUM(SUM_DRAWDOWN) AS SUM_DRAWDOWN,--分項動用總金額(已佔+預佔)
      SUM(SUM_REPAYMENT) AS SUM_REPAYMENT, --分項還總款金額(已佔+預佔)
      SUM(SUM_NEGT) AS SUM_NEGT, --分項和解總金額(已佔)
      SUM(SUM_APPR_DOC_DRAWDOWN) AS SUM_APPR_DOC_DRAWDOWN, --分項批覆書占用累積金額
      SUM(BOOKING_BALANCE) AS SUM_BOOKING_BALANCE, --預佔現欠
      SUM(SUM_BALANCE) AS SUM_BALANCE --已佔現欠
    FROM
      (SELECT 
        LT.LIMIT_SEQ_NO,--分項流水號
        LD.CCY,--已佔幣別
        LT.CURRENCY,--分項幣別
        LT.APPRD_SUB_LIMIT_AMT,--分項核准額度
        LT.LIMIT_DRAWDOWN_TYPE,--分項動用方式
        LT.PHASE,--分項狀態
        NVL(SUM(LD.TOTAL_DRAWDOWN_AMT),0)                                                  AS SUM_DRAWDOWN,--分項動用金額
        NVL(SUM(LD.TOTAL_REPAYMT_AMT),0)                                                   AS SUM_REPAYMENT,--分項還款金額
        NVL(SUM(TOTAL_NEGO_AMT),0)                                                         AS SUM_NEGT,--分項累積和解總和
        NVL(SUM(TOTAL_APPR_DOC_DRAWDOWN_AMT),0)                                            AS SUM_APPR_DOC_DRAWDOWN, --已佔累積占用批覆書額度累積金額
        0                                                                           AS BOOKING_BALANCE,--預佔現欠
        (NVL(SUM(LD.TOTAL_DRAWDOWN_AMT),0)-NVL(SUM(LD.TOTAL_REPAYMT_AMT),0)- NVL(SUM(TOTAL_NEGO_AMT),0)) AS SUM_BALANCE --已佔現欠
      FROM EDLS.TB_APPR_DOC AD
      INNER JOIN EDLS.TB_LIMIT LT
      ON AD.APPR_DOC_SEQ_NO = LT.APPR_DOC_SEQ_NO
      LEFT JOIN EDLS.TB_LIMIT_DTL LD
      ON LT.LIMIT_SEQ_NO      = LD.LIMIT_SEQ_NO
      WHERE AD.APPR_DOC_SEQ_NO = i_appr_doc_seq_no
      GROUP BY LD.CCY,LT.LIMIT_SEQ_NO,LT.CURRENCY,LT.APPRD_SUB_LIMIT_AMT,LT.LIMIT_DRAWDOWN_TYPE,LT.PHASE
      UNION ALL
      SELECT 
        LT.LIMIT_SEQ_NO, --分項流水號
        LB.CCY,--預佔額度幣別
        LT.CURRENCY,--分項幣別
        LT.APPRD_SUB_LIMIT_AMT,--分項核准額度
        LT.LIMIT_DRAWDOWN_TYPE,--分項動用方式
        LT.PHASE,--分項狀態
        SUM(LB.TOTAL_DRAWDOWN_AMT)                                   AS SUM_DRAWDOWN,--預佔累計動用金額
        SUM(LB.TOTAL_TODAY_REPAYMT_AMT)                              AS SUM_REPAYMENT,--預佔當日累計還款金額
        0                                                            AS SUM_NEGT,--分項累積和解總和
        SUM(LB.TOTAL_DRAWDOWN_APPR_DOC_AMT)                                   AS SUM_APPR_DOC_DRAWDOWN, --預佔占用批覆書額度累積金額
        (SUM(LB.TOTAL_DRAWDOWN_AMT)-SUM(LB.TOTAL_TODAY_REPAYMT_AMT)) AS BOOKING_BALANCE ,--預佔現欠
        0                                                            AS SUM_BALANCE--已佔現欠
      FROM EDLS.TB_APPR_DOC AD
      INNER JOIN EDLS.TB_LIMIT LT ON AD.APPR_DOC_SEQ_NO = LT.APPR_DOC_SEQ_NO
      INNER JOIN EDLS.TB_LIMIT_BOOKING LB ON LT.LIMIT_SEQ_NO = LB.LIMIT_SEQ_NO
      WHERE AD.APPR_DOC_SEQ_NO = i_appr_doc_seq_no
        AND LB.TOTAL_DRAWDOWN_AMT - TOTAL_TODAY_REPAYMT_AMT > 0
      GROUP BY LB.CCY,LT.LIMIT_SEQ_NO,LT.CURRENCY,LT.APPRD_SUB_LIMIT_AMT,LT.LIMIT_DRAWDOWN_TYPE,LT.PHASE
    )V1
    GROUP BY CCY,LIMIT_SEQ_NO,CURRENCY,APPRD_SUB_LIMIT_AMT,LIMIT_DRAWDOWN_TYPE,PHASE;
  END SP_GET_AD_LIMIT_FOR_CALC_U;

--**************************************************************************
-- SP_GET_LIMIT_PROJ_CODE_BY_AD
-- Purpose: 取得批覆書所有分項的專案代號(無鎖)
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 詹宏茂     2019.10.30  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_PROJ_CODE_BY_AD
  ( i_appr_doc_seq_no       IN NUMBER  -- 批覆書主檔序號
  , o_cur                   OUT SYS_REFCURSOR --分項資訊
  ) AS 
  BEGIN 
    OPEN o_cur FOR
    SELECT 
      LT.LIMIT_SEQ_NO,
      PCP.PROJECT_CODE
    FROM EDLS.TB_LIMIT LT
    INNER JOIN EDLS.TB_LIMIT_PROFILE LB 
      ON LT.LIMIT_SEQ_NO = LB.LIMIT_SEQ_NO
    INNER JOIN EDLS.TB_LIMIT_PROJ_COND_PROF PCP
      ON LB.LIMIT_PROFILE_SEQ_NO = PCP.LIMIT_PROFILE_SEQ_NO
    WHERE LT.APPR_DOC_SEQ_NO = i_appr_doc_seq_no ;
  END SP_GET_LIMIT_PROJ_CODE_BY_AD;
  
--**************************************************************************
-- SP_GET_OVERDRAFT_LIST_BY_AD
-- Purpose: 查詢分項額度透支資訊檔列表(By批覆書)(無鎖)
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 ESB20276  2019.11.05  create
--**************************************************************************
  PROCEDURE SP_GET_OVERDRAFT_LIST_BY_AD
  ( i_appr_doc_seq_no      IN NUMBER         -- 分項額度主檔序號
  , o_cur               OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT 
      LT.LIMIT_SEQ_NO
      ,OT.OVERDRAFT_SEQ_NO
      ,OT.ACC_NO
      ,OT.ACC_TYPE
      ,OT.CCY
      ,OT.OVERDRAFT_BALANCE_AMT
      ,OT.ACCOUNT_STATUS
    FROM EDLS.TB_LIMIT LT
    JOIN EDLS.TB_OVERDRAFT OT ON LT.LIMIT_SEQ_NO = OT.LIMIT_SEQ_NO
    WHERE LT.APPR_DOC_SEQ_NO = i_appr_doc_seq_no ;
  END SP_GET_OVERDRAFT_LIST_BY_AD;
  
--**************************************************************************
-- SP_GET_OVERDRAFT_LIST_BY_AD_U
-- Purpose: 查詢分項額度透支資訊檔列表(By批覆書)
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 ESB20276  2019.11.05  create
--**************************************************************************
  PROCEDURE SP_GET_OVERDRAFT_LIST_BY_AD_U
  ( i_appr_doc_seq_no      IN NUMBER         -- 分項額度主檔序號
  , o_cur               OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT 
      LT.LIMIT_SEQ_NO
      ,OT.OVERDRAFT_SEQ_NO
      ,OT.ACC_NO
      ,OT.ACC_TYPE
      ,OT.CCY
      ,OT.OVERDRAFT_BALANCE_AMT
      ,OT.ACCOUNT_STATUS
    FROM EDLS.TB_LIMIT LT
    JOIN EDLS.TB_OVERDRAFT OT ON LT.LIMIT_SEQ_NO = OT.LIMIT_SEQ_NO
    WHERE LT.APPR_DOC_SEQ_NO = i_appr_doc_seq_no 
    FOR UPDATE;
  END SP_GET_OVERDRAFT_LIST_BY_AD_U;
  
--**************************************************************************
-- SP_GET_GUAR_APPR_DOC_BY_GCID_PHR_PAGE
-- Purpose: 以保證人銀行歸戶統編及保證狀態取得保證人、批覆書、借款人等資料
-- 
-- Modification History
-- Person      Date       Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 詹宏茂   2019.11.20 Create
--************************************************************************** 
  PROCEDURE SP_GET_GUAR_APPR_DOC_BY_GCID_PHR_PAGE
  ( i_customer_id   IN VARCHAR2      -- 銀行歸戶統編
  , i_phase        IN VARCHAR2       -- 保證狀態
  , o_cur          OUT SYS_REFCURSOR -- 回傳保證人資料   
  ) AS
  BEGIN 
    OPEN o_cur FOR
    SELECT 
      GC.CUST_ID AS GC_CUST_ID,
      GC.CUST_NAME AS GC_CUST_NAME,
      GC.TEL_NO AS GC_TEL_NO,
      GU.GUARANTOR_SEQ_NO,
      GU.APPR_DOC_SEQ_NO,
      GU.LIMIT_SEQ_NO AS GU_LIMIT_SEQ_NO,
      GU.CUSTOMER_LOAN_SEQ_NO AS GU_CUST_LOAN_SEQ_NO,
      GU.PERCENTAGE,
      GU.CANCEL_REASON_MK,
      AD.CUSTOMER_LOAN_SEQ_NO AS LC_CUST_LOAN_SEQ_NO,
      AD.APPR_DOC_NO,
      AD.PHASE,
      AD.APPRD_DATE,
      AD.MATU_DATE,
      AD.FIRST_DRAWDOWN_EDATE,
      AD.TOTAL_APPR_AMT,
      AD.TOTAL_APPR_CCY,
      AD.CHANNEL_CODE,
      AD.APPR_DRAWDOWN_TYPE,
      AD.LOAN_PURPOSE,
      AD.LOAN_ATTRIBUTES,
      AD.CCL_MK,
      AD.SOURCE_CODE,
      AD.DATA_CONVERT_SOURCE,
      AD.ACC_BRANCH,
      AD.OPER_BRANCH,
      AD.UNDER_CENTER,
      AD.APPROVER_ID,
      AD.APPRD_TYPE,
      AD.EFFEC_PERIOD,
      AD.EFFEC_UNIT,
      AD.CONTRACT_SDATE,
      AD.CONTRACT_PERIOD,
      AD.CONTRACT_UNIT,
      AD.FROM_APPR_DOC_NO,
      AD.TO_APPR_DOC_NO,
      AD.LAST_TXN_DATE,
      AD.INTER_MEDIA_BRANCH,
      AD.REPORT_BRANCH,
      AD.PROFIT_BRANCH,
      AD.FIRST_DRAWDOWN_DATE,
      AD.AUTH_DATE,
      AD.APPR_DOC_EDATE,
      AD.MPL_MORT_OVERDUE_CANCEL_MK,
      AD.APPR_DOC_SOURCE,
      AD.SYSTEM_ID,
      AD.MODIFIABLE,
      AD.CROSS_BORDER_SHARED_LIMIT_MK,
      AD.create_date,
      AD.amend_date,
      LC.CUST_ID AS LC_CUST_ID,
      LC.CUST_NAME AS LC_CUST_NAME,
      LC.TEL_NO AS LC_TEL_NO,
      GL.LIMIT_TYPE AS GU_LIMIT_TYPE,
      GLPC.LIMIT_TYPE_NAME AS GU_LIMIT_TYPE_NAME
    from EDLS.TB_GUARANTOR GU 
    JOIN EDLS.TB_CUSTOMER_LOAN GC ON GU.CUSTOMER_LOAN_SEQ_NO = GC.CUSTOMER_LOAN_SEQ_NO
    JOIN EDLS.TB_APPR_DOC AD ON GU.APPR_DOC_SEQ_NO = AD.APPR_DOC_SEQ_NO
    JOIN EDLS.TB_CUSTOMER_LOAN LC ON AD.CUSTOMER_LOAN_SEQ_NO = LC.CUSTOMER_LOAN_SEQ_NO
    LEFT JOIN EDLS.TB_LIMIT GL ON GU.LIMIT_SEQ_NO = GL.LIMIT_SEQ_NO
    LEFT JOIN EDLS.TB_LIMIT_PARAMETER_CONFIG GLPC ON GL.LIMIT_TYPE = GLPC.LIMIT_TYPE
    WHERE GC.CUST_ID = i_customer_id   
         AND GU.PHASE = i_phase
    ORDER BY GU.GUARANTOR_SEQ_NO;  
  END SP_GET_GUAR_APPR_DOC_BY_GCID_PHR_PAGE;
  
--**************************************************************************
-- SP_GET_GUAR_LIMIT_TYPE_BY_DOCSQN
-- Purpose: 以批覆書主檔序號取得保證人資料
-- 
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 詹宏茂   2019.11.20 Create
--************************************************************************** 
  PROCEDURE SP_GET_GUAR_LIMIT_TYPE_BY_DOCSQN
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , o_cur             OUT SYS_REFCURSOR -- 回傳保證人資料   
  ) AS
  BEGIN 
    OPEN o_cur FOR
    SELECT 
       cust.CUST_ID,
       cust.CUST_NAME,
       gu.LIMIT_SEQ_NO,
       cust.TEL_NO,
       gu.CUSTOMER_LOAN_SEQ_NO, -- 授信戶主檔序號
       gu.CANCEL_REASON_MK,
       li.LIMIT_TYPE,
       lpc.LIMIT_TYPE_NAME
    FROM EDLS.TB_GUARANTOR gu
    JOIN EDLS.TB_CUSTOMER_LOAN cust 
      On gu.CUSTOMER_LOAN_SEQ_NO = cust.CUSTOMER_LOAN_SEQ_NO
    LEFT JOIN EDLS.TB_LIMIT li ON li.LIMIT_SEQ_NO = gu.LIMIT_SEQ_NO
    LEFT JOIN EDLS.TB_LIMIT_PARAMETER_CONFIG lpc ON lpc.limit_type =  li.limit_type
    WHERE gu.APPR_DOC_SEQ_NO = i_appr_doc_seq_no;    
  END SP_GET_GUAR_LIMIT_TYPE_BY_DOCSQN;  
  
--**************************************************************************
-- SP_DEL_LIMIT_COMBINED_INFO
-- Purpose: 以批覆書主檔序號刪除沒對應到分項的組合額度
-- 
-- Modification History
-- Person      Date       Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 詹宏茂   2019.12.5  Create
--************************************************************************** 
  PROCEDURE SP_DEL_LIMIT_COMBINED_INFO
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  ) AS
  BEGIN 
    --刪除對應不到分項的組合額度明細
    DELETE FROM EDLS.tb_limit_combined_profile 
    WHERE limit_combined_profile_seq_no IN 
            ( SELECT S2.limit_combined_profile_seq_no 
              FROM EDLS.tb_limit_combined S1
              JOIN EDLS.tb_limit_combined_profile S2 ON S1.limit_combined_seq_no = S2.limit_combined_seq_no
              WHERE s1.appr_doc_seq_no = i_appr_doc_seq_no 
              AND NOT EXISTS( 
                        SELECT 1 
                        FROM EDLS.TB_LIMIT SS1 
                        WHERE SS1.APPR_DOC_SEQ_NO = i_appr_doc_seq_no 
                        AND SS1.LIMIT_SEQ_NO = S2.LIMIT_SEQ_NO 
                      )
            );
    --刪除沒分項的組合額度明細對應的的組合額度主檔
    DELETE FROM EDLS.tb_limit_combined 
        WHERE limit_combined_seq_no IN 
             ( SELECT S1.limit_combined_seq_no 
               FROM EDLS.tb_limit_combined S1
         WHERE S1.appr_doc_seq_no = i_appr_doc_seq_no 
         AND NOT EXISTS (SELECT 1 
                         FROM EDLS.tb_limit_combined_profile SS1 
                 WHERE SS1.limit_combined_seq_no = S1.limit_combined_seq_no)
             );
    
      --刪除只剩下一筆的組合額度明細
    /* DELETE FROM EDLS.tb_limit_combined_profile 
      WHERE limit_combined_seq_no IN 
            ( SELECT S2.limit_combined_seq_no 
              FROM EDLS.tb_limit_combined S1
              JOIN EDLS.tb_limit_combined_profile S2 ON S2.limit_combined_seq_no = S1.limit_combined_seq_no
              WHERE S1.appr_doc_seq_no = i_appr_doc_seq_no 
              GROUP BY S2.limit_combined_seq_no 
              HAVING COUNT(1) < 2
            );
	*/
      --刪除沒分項的或僅剩1個組合額度明細的組合額度
     /* DELETE FROM EDLS.tb_limit_combined 
      WHERE limit_combined_seq_no IN 
           ( SELECT S1.limit_combined_seq_no 
             FROM EDLS.tb_limit_combined S1
             LEFT JOIN EDLS.tb_limit_combined_profile S2 ON S2.limit_combined_seq_no = S1.limit_combined_seq_no
             WHERE S1.appr_doc_seq_no = i_appr_doc_seq_no 
             GROUP BY S1.limit_combined_seq_no 
             HAVING COUNT(1) < 2
           );
    */
  END SP_DEL_LIMIT_COMBINED_INFO;

--*************************************************************************
-- SP_GET_GUARANTOR_APPDOC_LIMIT
-- Purpose: 取得[保證人資料檔]資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 ELITE-Ryan 2019.12.20  created
--**************************************************************************
  PROCEDURE SP_GET_GUARANTOR_APPDOC_LIMIT
  ( i_appr_doc_seq_no IN  NUMBER        --批覆書主檔序號
  , i_limit_seq_no    IN  NUMBER        --分項額度主檔序號
  , o_cur             OUT SYS_REFCURSOR --回傳資料
  ) AS
  BEGIN
    open o_cur FOR
    SELECT GUARANTOR_SEQ_NO
      , APPR_DOC_SEQ_NO
      , LIMIT_SEQ_NO
      , CUSTOMER_LOAN_SEQ_NO
      , IDENTITY_CODE
      , COUNTRY
      , PHASE
      , CANCEL_REASON_MK
      , PERCENTAGE
      , RELATIONSHIP_CODE
      , RELATION_WITH_MIN_DEBTOR
      , IS_FINAN_INSTIT
      , CHANGE_DATE
      , BIND_ALL_MARK
    FROM EDLS.TB_GUARANTOR
    WHERE APPR_DOC_SEQ_NO = i_appr_doc_seq_no
     AND (LIMIT_SEQ_NO IS NULL OR LIMIT_SEQ_NO = i_limit_seq_no)
    ORDER BY GUARANTOR_SEQ_NO, APPR_DOC_SEQ_NO, LIMIT_SEQ_NO;
  END SP_GET_GUARANTOR_APPDOC_LIMIT; 
  
--**************************************************************************
-- SP_GET_CUST_RRSAC_AUTO_TRANS
-- Purpose: 以授信戶主檔序號查詢備償專戶自動轉帳登錄資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.12.24  created
--**************************************************************************
  PROCEDURE SP_GET_CUST_RRSAC_AUTO_TRANS 
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , o_cur                  OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT RRSAC_AUTO_TRANSFER_SEQ_NO
     , CUSTOMER_LOAN_SEQ_NO
     , RRSAC_ACC_SEQ_NO
     , TO_SAVING_ACC_SEQ_NO
     , THE_LOWEST_TRANS_AMT
     , OPEN_SETTING
     , OPEN_SETTING_DATE
     , TRANS_UNIT
     , NET_NOTES
     , CREATE_DATE
     , AMEND_DATE
    FROM EDLS.TB_RRSAC_AUTO_TRANSFER
    WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
  END SP_GET_CUST_RRSAC_AUTO_TRANS;  

--*************************************************************************
-- SP_GET_LIMIT_SHARE_BY_LOANSEQ
-- Purpose: 查詢共用額度主檔資訊BY〔授信戶主檔序號〕無FOR UPDATE
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 康晉維   2019.01.03  created
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_SHARE_BY_LOANSEQ 
  ( i_customer_loan_seq_no  IN NUMBER         -- 授信戶主檔序號
  , o_cur                  OUT SYS_REFCURSOR  -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT LIMIT_SHARE_SEQ_NO
       , CUSTOMER_LOAN_SEQ_NO
       , SERIAL_NO
       , CCY
       , APPRD_AMT
    FROM EDLS.TB_LIMIT_SHARE
    WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
  END SP_GET_LIMIT_SHARE_BY_LOANSEQ;

--*************************************************************************
-- SP_GET_VOSTRO_OVERDRAFT_LIMIT_LOANSEQ
-- Purpose: 取得同存透支額度資訊BY〔授信戶主檔序號〕無FOR update
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維   2019.01.03  created
--**************************************************************************
  PROCEDURE SP_GET_VOSTRO_OVERDRAFT_LIMIT_LOANSEQ
  ( i_customer_loan_seq_no   IN  NUMBER       -- 銀行歸戶統編
  , o_cur                    OUT SYS_REFCURSOR  -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT VOSTRO_OVERDRAFT_LIMIT_SEQ_NO
         , CUSTOMER_LOAN_SEQ_NO
         , APPR_DATE
         , LAST_CHG_DATE
         , OVERDRAFT_LIMIT_CCY
         , INTRADAY_APPRD_AMT
         , END_OF_DAL_APPRD_AMT
         , OVERDRAFT_LIMIT_EFFEC_MK
         , APPROVED_NO
         , SAVING_ACC_NO
         , CREATE_DATE
         , AMEND_DATE
    FROM EDLS.TB_VOSTRO_OVERDRAFT_LIMIT 
    WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
  END SP_GET_VOSTRO_OVERDRAFT_LIMIT_LOANSEQ; 

--*************************************************************************
-- SP_GET_MONTH_PAID_MONTH_SAVE
-- Purpose: 符合月繳月省條件筆數
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- ELITE-RYAN   2020.03.16  created
--**************************************************************************
  PROCEDURE SP_GET_MONTH_PAID_MONTH_SAVE
  ( I_LOAN_NO    IN  VARCHAR2 -- 放款主檔序號
  , O_ROW_COUNT  OUT  NUMBER  -- 符合筆數
  ) AS
  BEGIN
    SELECT COUNT(1) INTO O_ROW_COUNT
    FROM EDLS.TB_LOAN LN
    INNER JOIN EDLS.TB_APPR_DOC AD
      ON LN.APPR_DOC_SEQ_NO = AD.APPR_DOC_SEQ_NO
    INNER JOIN EDLS.TB_APPR_DOC_EXTENSION ADE
      ON AD.APPR_DOC_SEQ_NO = ADE.APPR_DOC_SEQ_NO
    WHERE
          LN.LOAN_NO = I_LOAN_NO
      AND AD.MPL_MORT_OVERDUE_CANCEL_MK = 'N'
      AND ADE.LIMIT_SEQ_NO IS NULL
      AND ADE.DATA_TYPE = 14
      AND ADE.REGISTRY_MK = '0';
  END SP_GET_MONTH_PAID_MONTH_SAVE;

--**************************************************************************
-- SP_GET_APPR_DOC_HISTORY
-- Purpose: 查詢批覆書變更紀錄
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 19237     2020.04.27  created
--**************************************************************************
  PROCEDURE SP_GET_APPR_DOC_HISTORY
  ( i_appr_doc_seq_no IN NUMBER             -- 批覆書主檔序號
  , i_transaction_type_operator IN VARCHAR2 -- 交易分類處理註記
  , i_offset IN NUMBER                      -- 偏移設定
  , i_page_size IN NUMBER                   -- 分頁大小
  , o_cur OUT SYS_REFCURSOR                 -- 回傳資料
  ) AS
  BEGIN
   OPEN o_cur FOR
   SELECT adh.APPR_DOC_HISTORY_SEQ_NO
    ,adh.APPR_DOC_SEQ_NO
    ,adh.TXN_DATE
    ,adh.TXN_BRANCH
    ,adh.HOST_SNO
    ,adh.TXN_TIME
    ,adh.SUP_CARD
    ,adh.TELLER_EMP_ID
    ,adh.SUP_EMP_ID
    ,adh.TXN_ID
    ,ADH.TXN_TYPE
    ,adhl.APPR_DOC_HISTORY_DTL_SEQ_NO
    ,adhl.MODIFY_MEMO
    ,adhl.MODIFY_OLD_DATA
    ,adhl.MODIFY_NEW_DATA
    ,adhl.MODIFY_CODE
    ,adhl.MODIFY_TABLE
    ,adhl.MODIFY_FIELD
    ,adhl.BEFORE_MODIFY_VALUE
    ,adhl.AFTER_MODIFY_VALUE
    ,adh.INFO_ASSET_NO
   FROM TB_APPR_DOC_HISTORY adh INNER JOIN TB_APPR_DOC_HISTORY_DTL adhl ON adh.APPR_DOC_HISTORY_SEQ_NO = adhl.APPR_DOC_HISTORY_SEQ_NO
   WHERE adh.APPR_DOC_SEQ_NO = i_appr_doc_seq_no 
   AND (i_transaction_type_operator IS NULL 
    OR (i_transaction_type_operator = '0')
    OR (i_transaction_type_operator = '1' AND (adh.TXN_TYPE IS NULL OR adh.TXN_TYPE NOT IN('T537', 'T538', 'T5C6', 'T5H702', 'LN1157C')))) 
   ORDER BY adh.TXN_DATE, adh.TXN_TIME, adhl.MODIFY_CODE, adhl.APPR_DOC_HISTORY_DTL_SEQ_NO
   OFFSET i_offset ROWS FETCH NEXT i_page_size ROWS ONLY;
  END SP_GET_APPR_DOC_HISTORY;

--*************************************************************************
-- SP_GET_COUNT_APPR_DOC_HISTORY
-- Purpose: 取得批覆書變更紀錄查詢總數
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 19237     2020.04.27  created
--
--**************************************************************************
  PROCEDURE SP_GET_COUNT_APPR_DOC_HISTORY
  ( i_appr_doc_seq_no           IN NUMBER   -- 批覆書主檔序號
  , i_transaction_type_operator IN VARCHAR2 -- 交易分類處理註記
  , o_count                     OUT NUMBER  -- 回傳筆數 
  ) AS
  BEGIN
    SELECT COUNT(1) INTO o_count
    FROM EDLS.TB_APPR_DOC_HISTORY adh, 
         EDLS.TB_APPR_DOC_HISTORY_DTL adhl
    WHERE adh.APPR_DOC_HISTORY_SEQ_NO = adhl.APPR_DOC_HISTORY_SEQ_NO
      AND adh.APPR_DOC_SEQ_NO = i_appr_doc_seq_no
      AND (i_transaction_type_operator IS NULL 
        OR (i_transaction_type_operator = '0')
        OR (i_transaction_type_operator = '1' AND (adh.TXN_TYPE IS NULL OR adh.TXN_TYPE NOT IN('T537', 'T538', 'T5C6', 'T5H702', 'LN1157C')))) 
   ORDER BY adh.TXN_DATE, adh.TXN_TIME, adhl.MODIFY_CODE, adhl.APPR_DOC_HISTORY_DTL_SEQ_NO;
  END SP_GET_COUNT_APPR_DOC_HISTORY;

--*************************************************************************
-- SP_GET_PROJECT_CODE
-- Purpose: 取得屬性註記批示條件檔-專案屬性註記
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 RYAN      2020.05.08  created
--
--**************************************************************************
  PROCEDURE SP_GET_PROJECT_CODE
  ( i_loan_no           IN VARCHAR2   -- 放款帳號
  , o_cur               OUT  SYS_REFCURSOR  -- 回傳資料
  ) AS
  BEGIN
    OPEN O_CUR FOR
    SELECT LCP.PROJECT_CODE
    FROM EDLS.TB_LOAN LN
    , EDLS.TB_LIMIT_PROFILE LP
    , EDLS.TB_LIMIT_PROJ_COND_PROF LCP
    WHERE LN.LOAN_NO = i_loan_no
    AND LN.LIMIT_SEQ_NO = LP.LIMIT_SEQ_NO
    AND LP.LIMIT_PROFILE_SEQ_NO = LCP.LIMIT_PROFILE_SEQ_NO;
  END SP_GET_PROJECT_CODE;

END PG_APPR_DOC_LIMIT;