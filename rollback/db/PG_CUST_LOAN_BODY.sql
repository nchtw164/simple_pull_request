CREATE OR REPLACE PACKAGE BODY "EDLS"."PG_CUST_LOAN" AS

-- **************************************************
-- SP_INS_CUSTLOANRELDTL
-- Purpose: 00701 新增同一關係企業資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXX           2019.05.30  Create
-- **************************************************
  PROCEDURE SP_INS_CUSTLOANRELDTL 
  ( i_customer_loan_seq_no IN NUMBER       -- 授信戶主檔序號
  , i_related_company_id IN VARCHAR2       -- 關係企業統編
  , i_data_type IN VARCHAR2                -- 資料種類
  , i_setup_branch IN VARCHAR2             -- 建檔單位
  , i_setup_date IN VARCHAR2               -- 建檔日期
  , i_sub_oardination_code IN VARCHAR2     -- 從屬關係代號
  , i_mutual_investment_code IN VARCHAR2   -- 相互投資關係代號
  , i_shareholder_related_code IN VARCHAR2 -- 董事關係代號
  , i_spouse_related_code IN VARCHAR2      -- 配偶關係代號
  , i_blood_relatives_code IN VARCHAR2     -- 血親關係代號
  , i_obu_name IN VARCHAR                  -- 境外法人的戶名
  , i_obu_country IN VARCHAR2              -- 境外法人的國別
  , i_obu_addr IN VARCHAR2                 -- 境外法人的地址
  , o_customer_loan_seq_no OUT NUMBER      -- 授信戶主檔序號
  ) AS
  BEGIN
    INSERT INTO EDLS.TB_CUST_LOAN_REL_DTL 
    ( CUSTOMER_LOAN_SEQ_NO
    , RELATED_COMPANY_ID
    , DATA_TYPE
    , SETUP_BRANCH
    , SETUP_DATE
    , SUB_OARDINATION_CODE
    , MUTUAL_INVESTMENT_CODE
    , SHAREHOLDER_RELATED_CODE
    , SPOUSE_RELATED_CODE
    , BLOOD_RELATIVES_CODE
    , OBU_NAME
    , OBU_COUNTRY
    , OBU_ADDR
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES 
    ( i_customer_loan_seq_no
    , i_related_company_id
    , i_data_type
    , i_setup_branch
    , i_setup_date
    , i_sub_oardination_code
    , i_mutual_investment_code
    , i_shareholder_related_code
    , i_spouse_related_code
    , i_blood_relatives_code
    , i_obu_name
    , i_obu_country
    , i_obu_addr
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
    o_customer_loan_seq_no := i_customer_loan_seq_no;
  END SP_INS_CUSTLOANRELDTL;
  
-- **************************************************
-- SP_UPD_CUSTLOANRELDTL
-- Purpose: 00702 更新同一關係企業資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXX           2019.05.30  Create
-- **************************************************
  PROCEDURE SP_UPD_CUSTLOANRELDTL 
  ( i_customer_loan_seq_no IN NUMBER       -- 授信戶主檔序號
  , i_related_company_id IN VARCHAR2       -- 關係企業統編
  , i_data_type IN VARCHAR2                -- 資料種類
  , i_setup_branch IN VARCHAR2             -- 建檔單位
  , i_setup_date IN VARCHAR2               -- 建檔日期
  , i_sub_oardination_code IN VARCHAR2     -- 從屬關係代號
  , i_mutual_investment_code IN VARCHAR2   -- 相互投資關係代號
  , i_shareholder_related_code IN VARCHAR2 -- 董事關係代號
  , i_spouse_related_code IN VARCHAR2      -- 配偶關係代號
  , i_blood_relatives_code IN VARCHAR2     -- 血親關係代號
  , i_obu_name IN VARCHAR2                 -- 境外法人的戶名
  , i_obu_country IN VARCHAR2              -- 境外法人的國別
  , i_obu_addr IN VARCHAR2                 -- 境外法人的地址
  , o_customer_loan_seq_no OUT NUMBER      -- 授信戶主檔序號
  ) AS
  BEGIN
    UPDATE EDLS.TB_CUST_LOAN_REL_DTL
    SET
      DATA_TYPE = i_data_type,
      SETUP_BRANCH = i_setup_branch,
      SETUP_DATE = i_setup_date,
      SUB_OARDINATION_CODE = i_sub_oardination_code,
      MUTUAL_INVESTMENT_CODE = i_mutual_investment_code,
      SHAREHOLDER_RELATED_CODE = i_shareholder_related_code,
      SPOUSE_RELATED_CODE = i_spouse_related_code,
      BLOOD_RELATIVES_CODE = i_blood_relatives_code,
      OBU_NAME = i_obu_name,
      OBU_COUNTRY = i_obu_country,
      OBU_ADDR = i_obu_addr,
      AMEND_DATE = SYSTIMESTAMP
    WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
      AND RELATED_COMPANY_ID = i_related_company_id;
    o_customer_loan_seq_no := i_customer_loan_seq_no;
  END SP_UPD_CUSTLOANRELDTL;
  
-- **************************************************
-- SP_DEL_CUSTLOANRELDTL
-- Purpose: 00703 刪除同一關係企業資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXX           2019.05.30  Create
-- **************************************************
  PROCEDURE SP_DEL_CUSTLOANRELDTL 
  ( i_customer_loan_seq_no IN NUMBER -- 授信戶主檔序號
  , i_related_company_id IN VARCHAR2 -- 關係企業統編
  ) AS
  BEGIN
    DELETE EDLS.TB_CUST_LOAN_REL_DTL
    WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
      AND RELATED_COMPANY_ID = i_related_company_id;
  END SP_DEL_CUSTLOANRELDTL;
  
-- **************************************************
-- SP_GET_RELDTL_BY_SEQNO_TYPE
-- Purpose: 00704 以授信戶主檔序號及資料種類取得同一關係企業資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXX           2019.05.30  Create
-- **************************************************
  PROCEDURE SP_GET_RELDTL_BY_SEQNO_TYPE
  ( i_customer_loan_seq_no IN NUMBER -- 授信戶主檔序號
  , i_data_type IN VARCHAR2          -- 資料種類
  , i_page_number IN NUMBER          -- 頁數
  , i_row_count IN NUMBER            -- 列數
  , o_cur OUT SYS_REFCURSOR          -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT CUSTOMER_LOAN_SEQ_NO
          , RELATED_COMPANY_ID
          , DATA_TYPE
          , SETUP_BRANCH
          , SETUP_DATE
          , SUB_OARDINATION_CODE
          , MUTUAL_INVESTMENT_CODE
          , SHAREHOLDER_RELATED_CODE
          , SPOUSE_RELATED_CODE
          , BLOOD_RELATIVES_CODE
          , OBU_NAME
          , OBU_COUNTRY
          , OBU_ADDR
    FROM EDLS.TB_CUST_LOAN_REL_DTL
    WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
      AND DATA_TYPE = i_data_type
      ORDER BY CUSTOMER_LOAN_SEQ_NO
      OFFSET ((i_page_number-1)*i_row_count) ROWS 
      FETCH NEXT i_row_count ROWS ONLY;
  END SP_GET_RELDTL_BY_SEQNO_TYPE;
   
-- **************************************************
-- SP_GET_RELDTL_BY_SEQNO_COMID
-- Purpose: 00705 以授信戶主檔序號及關係企業統編取得同一關係企業資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXX           2019.05.30  Create
-- **************************************************
  PROCEDURE SP_GET_RELDTL_BY_SEQNO_COMID
  ( i_customer_loan_seq_no IN NUMBER -- 授信戶主檔序號
  , i_related_company_id IN VARCHAR2 -- 關係企業統編
  , o_cur OUT SYS_REFCURSOR          -- 回傳資料                                                                                           
  ) AS
  BEGIN
    OPEN o_cur FOR
     SELECT CUSTOMER_LOAN_SEQ_NO
          , RELATED_COMPANY_ID
          , DATA_TYPE
          , SETUP_BRANCH
          , SETUP_DATE
          , SUB_OARDINATION_CODE
          , MUTUAL_INVESTMENT_CODE
          , SHAREHOLDER_RELATED_CODE
          , SPOUSE_RELATED_CODE
          , BLOOD_RELATIVES_CODE
          , OBU_NAME
          , OBU_COUNTRY
          , OBU_ADDR
    FROM EDLS.TB_CUST_LOAN_REL_DTL
    WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
      AND RELATED_COMPANY_ID = i_related_company_id;
  END SP_GET_RELDTL_BY_SEQNO_COMID;
  
-- **************************************************
-- SP_GET_RELDTL_BY_SEQNO_COMID_U
-- Purpose: 00706 以授信戶主檔序號及關係企業統編取得同一關係企業資料 for update
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXX           2019.05.30  Create
-- **************************************************
  PROCEDURE SP_GET_RELDTL_BY_SEQNO_COMID_U
  ( i_customer_loan_seq_no IN NUMBER -- 授信戶主檔序號
  , i_related_company_id IN VARCHAR2 -- 關係企業統編
  , o_cur OUT SYS_REFCURSOR          -- 回傳資料  
  )AS
  BEGIN
    OPEN o_cur FOR
      SELECT CUSTOMER_LOAN_SEQ_NO
           , RELATED_COMPANY_ID
           , DATA_TYPE
           , SETUP_BRANCH
           , SETUP_DATE
           , SUB_OARDINATION_CODE
           , MUTUAL_INVESTMENT_CODE
           , SHAREHOLDER_RELATED_CODE
           , SPOUSE_RELATED_CODE
           , BLOOD_RELATIVES_CODE
           , OBU_NAME
           , OBU_COUNTRY
           , OBU_ADDR
      FROM EDLS.TB_CUST_LOAN_REL_DTL
      WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
        AND RELATED_COMPANY_ID = i_related_company_id
        FOR UPDATE;
  END SP_GET_RELDTL_BY_SEQNO_COMID_U;

-- **************************************************
-- SP_GET_RELDTL_BY_RELCOMID
-- Purpose: 00707 以關係企業統編取得同一關係企業資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXX           2019.05.30  Create
-- **************************************************  
  PROCEDURE SP_GET_RELDTL_BY_RELCOMID
  ( i_related_company_id IN VARCHAR2 -- 關係企業統編
  , o_cur OUT SYS_REFCURSOR          -- 回傳資料
  )AS
  BEGIN
    OPEN o_cur FOR
      SELECT CUSTOMER_LOAN_SEQ_NO
           , RELATED_COMPANY_ID
           , DATA_TYPE
           , SETUP_BRANCH
           , SETUP_DATE
           , SUB_OARDINATION_CODE
           , MUTUAL_INVESTMENT_CODE
           , SHAREHOLDER_RELATED_CODE
           , SPOUSE_RELATED_CODE
           , BLOOD_RELATIVES_CODE
           , OBU_NAME
           , OBU_COUNTRY
           , OBU_ADDR
      FROM EDLS.TB_CUST_LOAN_REL_DTL 
      WHERE RELATED_COMPANY_ID = i_related_company_id;
  END SP_GET_RELDTL_BY_RELCOMID;
  
-- **************************************************
-- SP_INS_CUST_LOAN_HISTORY
-- Purpose: 00696 新增授信戶主檔變更紀錄
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ELITE-GCHong                 Create
-- ESB19411         2019.04.22  Fix problems with table schema change
-- **************************************************
  PROCEDURE SP_INS_CUST_LOAN_HISTORY 
  ( i_customer_loan_seq_no IN NUMBER   -- 授信戶主檔序號
  , i_txn_date             IN VARCHAR2 -- 交易日期
  , i_txn_branch           IN VARCHAR2 -- 交易分行
  , i_host_sno             IN VARCHAR2 -- 主機交易序號
  , i_txn_time             IN VARCHAR2 -- 交易時間
  , i_sup_card_id          IN VARCHAR2 -- 主管授權卡號
  , i_teller_emp_id        IN VARCHAR2 -- 櫃員員編
  , i_sup_emp_id           IN VARCHAR2 -- 主管員編
  , i_txn_id               IN VARCHAR2 -- 交易代號
  , i_txn_type             IN VARCHAR2 -- 交易分類
  , o_cust_history_seq_sno OUT NUMBER  -- 授信戶變更記錄序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_CUSTOMER_LOAN_HISTORY', o_cust_history_seq_sno);
    INSERT INTO EDLS.TB_CUSTOMER_LOAN_HISTORY 
    ( CUSTOMER_HISTORY_SEQ_NO  -- 授信戶變更記錄序號
    , CUSTOMER_LOAN_SEQ_NO     -- 授信戶主檔序號
    , TXN_DATE                 -- 交易日期
    , HOST_SNO                 -- 主機交易序號
    , TXN_BRANCH               -- 交易分行
    , TXN_TIME                 -- 交易時間
    , SUP_CARD                 -- 主管授權卡號
    , TELLER_EMP_ID            -- 櫃員員編
    , SUP_EMP_ID               -- 主管員編
    , TXN_ID                   -- 交易代號
    , TXN_TYPE                 -- 交易分類
    , CREATE_DATE              -- 建立時間
    , AMEND_DATE               -- 更新時間
    )
    VALUES 
    ( o_cust_history_seq_sno
    , i_customer_loan_seq_no
    , i_txn_date
    , i_host_sno
    , i_txn_branch
    , i_txn_time
    , i_sup_card_id
    , i_teller_emp_id
    , i_sup_emp_id
    , i_txn_id
    , i_txn_type
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
  END SP_INS_CUST_LOAN_HISTORY;

-- **************************************************
-- SP_UPD_CUST_LOAN_HISTORY
-- Purpose: 00697 更新授信戶主檔變更紀錄
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXX           2019.05.30  Create
-- **************************************************
  PROCEDURE SP_UPD_CUST_LOAN_HISTORY 
  ( i_cust_history_seq_no IN NUMBER    -- 授信戶變更記錄序號
  , i_customer_loan_seq_no IN VARCHAR2 -- 授信戶主檔序號
  , i_txn_date IN VARCHAR2             -- 交易日期
  , i_txn_branch IN VARCHAR2           -- 交易分行
  , i_host_sno IN VARCHAR2             -- 主機交易序號
  , i_txn_time IN VARCHAR2             -- 交易時間
  , i_sup_card_id IN VARCHAR2          -- 主管授權卡號
  , i_teller_emp_id IN VARCHAR2        -- 櫃員員編
  , i_sup_emp_id IN VARCHAR2           -- 主管員編
  , i_txn_id IN VARCHAR2               -- 交易代號
  , i_txn_type IN VARCHAR2             -- 交易分類
  --, i_channel_code IN VARCHAR2        
  , o_row_count OUT NUMBER             -- 異動筆數
  )AS
  BEGIN
    UPDATE EDLS.TB_CUSTOMER_LOAN_HISTORY
    SET
      TXN_DATE = i_txn_date,
      TXN_BRANCH = i_txn_branch,
      HOST_SNO = i_host_sno,
      TXN_TIME = i_txn_time,
      SUP_CARD = i_sup_card_id,
      TELLER_EMP_ID = i_teller_emp_id,
      SUP_EMP_ID = i_sup_emp_id,
      TXN_ID = i_txn_id,
      TXN_TYPE = i_txn_type,
      --CHANNEL_CODE = i_channel_code,
      AMEND_DATE = SYSTIMESTAMP
    WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
      AND CUSTOMER_HISTORY_SEQ_NO = i_cust_history_seq_no;
    o_row_count := SQL%ROWCOUNT;
  END SP_UPD_CUST_LOAN_HISTORY;


-- **************************************************
-- SP_GET_CUSTLNHIS_BY_CLNSQN
-- Purpose: 00698 以授信戶主檔序號取得授信戶主檔變更紀錄
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ELITE-GCHong                 Create
-- ESB19411         2019.04.23  Fix problems with table schema change
-- **************************************************
  PROCEDURE SP_GET_CUSTLNHIS_BY_CLNSQN 
  ( i_customer_loan_seq_no IN NUMBER -- 授信戶主檔序號
  , o_cur OUT SYS_REFCURSOR          -- 回傳資料
  ) AS
  BEGIN
  	OPEN o_cur FOR
    SELECT CUSTOMER_HISTORY_SEQ_NO  -- 授信戶變更記錄序號
       , CUSTOMER_LOAN_SEQ_NO     -- 授信戶主檔序號
       , TXN_DATE                 -- 交易日期
       , TXN_BRANCH               -- 交易分行
       , HOST_SNO                 -- HOST_SNO
       , TXN_TIME                 -- 交易時間
       , SUP_CARD                 -- 主管授權卡號
       , TELLER_EMP_ID            -- 櫃員員編
       , SUP_EMP_ID               -- 主管員編
       , TXN_ID                   -- 交易代號
       , TXN_TYPE                 -- 交易分類
      FROM EDLS.TB_CUSTOMER_LOAN_HISTORY
       WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
  END SP_GET_CUSTLNHIS_BY_CLNSQN;

-- **************************************************
-- [For test] SP_GET_CUSTLNHIS_BY_PK
-- Purpose: 以授信戶主檔變更紀錄序號取得授信戶主檔變更紀錄
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ELITE-GCHong                 Create
-- ESB19411         2019.04.23  Fix problems with table schema change
-- **************************************************
  PROCEDURE SP_GET_CUSTLNHIS_BY_PK 
  ( i_customer_history_seq_no IN NUMBER         -- 授信戶變更記錄序號
  , o_cur                     OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
      SELECT CUSTOMER_HISTORY_SEQ_NO  -- 授信戶變更記錄序號
           , CUSTOMER_LOAN_SEQ_NO     -- 授信戶主檔序號
           , TXN_DATE                 -- 交易日期
           , TXN_BRANCH               -- 交易分行
           , HOST_SNO                 -- 主機交易序號
           , TXN_TIME                 -- 交易時間
           , SUP_CARD                 -- 主管授權卡號
           , TELLER_EMP_ID            -- 櫃員員編
           , SUP_EMP_ID               -- 主管員編
           , TXN_ID                   -- 交易代號
           , TXN_TYPE                 -- 交易分類
        FROM EDLS.TB_CUSTOMER_LOAN_HISTORY
       WHERE CUSTOMER_HISTORY_SEQ_NO = i_customer_history_seq_no;
    END SP_GET_CUSTLNHIS_BY_PK;
  
-- **************************************************
-- SP_INS_CUST_LOAN_HISTORY_DTL
-- Purpose: 00709 新增授信戶變更紀錄明細檔
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXX           2019.05.30  Create
-- **************************************************
  PROCEDURE SP_INS_CUST_LOAN_HISTORY_DTL 
  ( txnLogDtlArray IN TXN_LOG_DTL_ARRAY -- 授信戶變更紀錄明細檔
  , o_row_count    OUT NUMBER           -- 新增筆數
  ) AS
    v_customer_history_dtl_seq_no NUMBER;
    n_seq_no NUMBER;
  BEGIN
    o_row_count := 0;
    IF txnLogDtlArray is not null and txnLogDtlArray.count > 0 THEN
      EDLS.PG_SYS.SP_BH_GET_SEQ_NO_RTN_NUM ('TB_CUSTOMER_LOAN_HISTORY_DTL', txnLogDtlArray.count, n_seq_no);
      FOR i in txnLogDtlArray.first..txnLogDtlArray.last 
      LOOP
        INSERT INTO EDLS.TB_CUSTOMER_LOAN_HISTORY_DTL 
        ( CUSTOMER_HISTORY_DTL_SEQ_NO
        , CUSTOMER_HISTORY_SEQ_NO
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
        ( n_seq_no
        , txnLogDtlArray(i).TXN_LOG_SEQ_NO
        , txnLogDtlArray(i).BEF_CHG_DATA
        , txnLogDtlArray(i).AFT_CHG_DATA
        , txnLogDtlArray(i).CHG_TB_NAME
        , txnLogDtlArray(i).CHG_COLUMN_NAME
        , txnLogDtlArray(i).BEF_CHG_CONTENT
        , txnLogDtlArray(i).AFT_CHG_CONTENT
        , txnLogDtlArray(i).CHG_CODE
        , systimestamp
        , systimestamp
        );
        n_seq_no := n_seq_no + 1;
        o_row_count := o_row_count + 1;
      END LOOP;
    END IF;
  END SP_INS_CUST_LOAN_HISTORY_DTL;
  
-- **************************************************
-- SP_INS_CUST_LOAN
-- Purpose: 00257 新增授信戶主檔資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXX           2019.05.30  Create
-- **************************************************
  PROCEDURE SP_INS_CUST_LOAN 
  ( i_customer_id IN VARCHAR2                  -- 銀行歸戶統編
  , i_customer_name IN VARCHAR2                -- 授信戶戶名
  , i_birth_date IN VARCHAR2                   -- 授信戶生日
  , i_telephone_no IN VARCHAR2                 -- 授信戶電話
  , i_create_branch_id IN VARCHAR2             -- 建檔單位
  , i_first_drawdown_date IN VARCHAR2          -- 初放日
  , i_first_drawdown_maturity_date IN VARCHAR2 -- 初放到期日
  , i_loan_reject_reason IN VARCHAR2           -- 拒絕貸放理由
  , i_major_loan_customer_mark IN VARCHAR2     -- 主要授信戶註記
  , i_interest_party_flag IN VARCHAR2          -- 利害關係人註記
  , i_last_txn_date IN VARCHAR2                -- 上次交易日
  , i_continue_loan_mark IN VARCHAR2           -- 授信戶續貸註記
  , i_trans2overdue_branch_mk IN VARCHAR2      -- 移送催理中心狀態
  , i_customer_loan_type IN VARCHAR2           -- 顧客分類
  , i_1stApprDoc_apprvedDate IN VARCHAR2       -- 首次批覆書核准日
  , i_new_customer_registry_date IN VARCHAR2   -- 新戶登錄日
  , i_repay_notifyMsg_mk IN VARCHAR2           -- 預告繳款簡訊通知註記
  , i_delayPaymt_notifyMsg_mk IN VARCHAR2      -- 延滯繳款簡訊通知註記
  , i_overdue_special_mark IN VARCHAR2         -- 逾期特殊註記
  , i_esun_stock_project_mark IN VARCHAR2      -- 玉證專案
  , i_loan_notify_memo IN VARCHAR2             -- 授信注意事項
  , i_related_group_register_date IN VARCHAR2  -- 關係集團戶登錄日
  , o_customer_loan_seq_no OUT NUMBER          -- 授信戶主檔序號
  ) AS
  BEGIN
    EDLS.PG_SYS.SP_GET_SEQ_NO('TB_CUSTOMER_LOAN', o_customer_loan_seq_no);
    INSERT INTO EDLS.TB_CUSTOMER_LOAN 
    ( CUSTOMER_LOAN_SEQ_NO      -- 授信戶主檔序號
    , CUST_ID                   -- 銀行歸戶統編
    , CUST_NAME                 -- 授信戶戶名
    , BIRTH_DATE                -- 授信戶生日
    , TEL_NO                    -- 授信戶電話
    , CREATE_BRANCH             -- 建檔單位
    , FIRST_DRAWDOWN_DATE       -- 初放日
    , FIRST_DRAWDOWN_MATU_DATE  -- 初放到期日
    , LOAN_REJECT_REASON        -- 拒絕貸放理由
    , MAJ_CUST_LOAN_MK          -- 主要授信戶註記
    , INTST_PARTY_FLAG          -- 利害關係人註記
    , LAST_TXN_DATE             -- 上次交易日
    , CONTINUE_LOAN_MK          -- 授信戶續貸註記
    , TRANS_OVERDUE_CENTER_STAT -- 移送催理中心狀態
    , CUST_TYPE                 -- 顧客分類
    , FIRST_APPRD_DATE          -- 首次批覆書核准日
    , NEW_CUST_REG_DATE         -- 新戶登錄日
    , REPAYMT_NOTIFY_MK         -- 預告繳款簡訊通知註記
    , DELAY_PAYMT_NOTI_MSG_MK   -- 延滯繳款簡訊通知註記
    , OVERDUE_SPECIAL_MK        -- 逾期特殊註記
    , ESUN_STOCK_PROJ_MK        -- 玉證專案
    , MEMO                      -- 授信注意事項
    , REL_GROUP_REG_DATE        -- 關係集團戶登錄日
    , CREATE_DATE
    , AMEND_DATE 
    )
    VALUES
    ( o_customer_loan_seq_no
    , i_customer_id
    , i_customer_name
    , i_birth_date
    , i_telephone_no
    , i_create_branch_id
    , i_first_drawdown_date
    , i_first_drawdown_maturity_date
    , i_loan_reject_reason
    , i_major_loan_customer_mark
    , i_interest_party_flag
    , i_last_txn_date
    , i_continue_loan_mark
    , i_trans2overdue_branch_mk
    , i_customer_loan_type
    , i_1stApprDoc_apprvedDate
    , i_new_customer_registry_date
    , i_repay_notifyMsg_mk
    , i_delayPaymt_notifyMsg_mk
    , i_overdue_special_mark
    , i_esun_stock_project_mark
    , i_loan_notify_memo
    , i_related_group_register_date
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
  END SP_INS_CUST_LOAN;

-- **************************************************
-- SP_UPD_CUST_LOAN
-- Purpose: 00264 更新授信戶主檔資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXX           2019.05.30  Create
-- **************************************************
  PROCEDURE SP_UPD_CUST_LOAN 
  ( i_customer_loan_seq_no IN INTEGER          -- 授信戶主檔序號
  , i_customer_id IN VARCHAR2                  -- 銀行歸戶統編
  , i_customer_name IN VARCHAR2                -- 授信戶戶名
  , i_birth_date IN VARCHAR2                   -- 授信戶生日
  , i_telephone_no IN VARCHAR2                 -- 授信戶電話
  , i_create_branch_id IN VARCHAR2             -- 建檔單位
  , i_first_drawdown_date IN VARCHAR2          -- 初放日
  , i_first_drawdown_maturity_date IN VARCHAR2 -- 初放到期日
  , i_loan_reject_reason IN VARCHAR2           -- 拒絕貸放理由
  , i_major_loan_customer_mark IN VARCHAR2     -- 主要授信戶註記
  , i_interest_party_flag IN VARCHAR2          -- 利害關係人註記
  , i_last_txn_date IN VARCHAR2                -- 上次交易日
  , i_continue_loan_mark IN VARCHAR2           -- 授信戶續貸註記
  , i_trans2overdue_branch_mk IN VARCHAR2      -- 移送催理中心狀態
  , i_customer_loan_type IN VARCHAR2           -- 顧客分類
  , i_1stApprDoc_apprvedDate IN VARCHAR2       -- 首次批覆書核准日
  , i_new_customer_registry_date IN VARCHAR2   -- 新戶登錄日
  , i_repay_notifyMsg_mk IN VARCHAR2           -- 預告繳款簡訊通知註記
  , i_delayPaymt_notifyMsg_mk IN VARCHAR2      -- 延滯繳款簡訊通知註記
  , i_overdue_special_mark IN VARCHAR2         -- 逾期特殊註記
  , i_esun_stock_project_mark IN VARCHAR2      -- 玉證專案
  , i_loan_notify_memo IN VARCHAR2             -- 授信注意事項
  , i_related_group_register_date IN VARCHAR2  -- 關係集團戶登錄日
  , o_customer_loan_seq_no OUT NUMBER          -- 授信戶主檔序號
  ) AS
  BEGIN
    UPDATE EDLS.TB_CUSTOMER_LOAN
    SET
      CUST_ID = i_customer_id,
      CUST_NAME = i_customer_name,
      BIRTH_DATE = i_birth_date,
      TEL_NO = i_telephone_no,
      CREATE_BRANCH = i_create_branch_id,
      FIRST_DRAWDOWN_DATE = i_first_drawdown_date,
      FIRST_DRAWDOWN_MATU_DATE = i_first_drawdown_maturity_date,
      LOAN_REJECT_REASON = i_loan_reject_reason,
      MAJ_CUST_LOAN_MK = i_major_loan_customer_mark,
      INTST_PARTY_FLAG = i_interest_party_flag,
      LAST_TXN_DATE = i_last_txn_date,
      CONTINUE_LOAN_MK = i_continue_loan_mark,
      TRANS_OVERDUE_CENTER_STAT = i_trans2overdue_branch_mk,
      CUST_TYPE = i_customer_loan_type,
      FIRST_APPRD_DATE = i_1stApprDoc_apprvedDate,
      NEW_CUST_REG_DATE = i_new_customer_registry_date,
      REPAYMT_NOTIFY_MK = i_repay_notifyMsg_mk,
      DELAY_PAYMT_NOTI_MSG_MK = i_delayPaymt_notifyMsg_mk,
      OVERDUE_SPECIAL_MK = i_overdue_special_mark,
      ESUN_STOCK_PROJ_MK = i_esun_stock_project_mark,
      MEMO = i_loan_notify_memo,
      REL_GROUP_REG_DATE = i_related_group_register_date,
      AMEND_DATE = SYSTIMESTAMP
      WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
      o_customer_loan_seq_no := i_customer_loan_seq_no;
  END SP_UPD_CUST_LOAN;

-- **************************************************
-- SP_DEL_CUST_LOAN_BY_CUSTID
-- Purpose: 刪除授信戶主檔
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXX           2019.05.30  Create
-- **************************************************
  PROCEDURE SP_DEL_CUST_LOAN_BY_CUSTID 
  ( i_cust_id IN VARCHAR2  -- 銀行歸戶統編
  , o_row_count OUT NUMBER -- 刪除筆數
  ) AS
  BEGIN 
    DELETE EDLS.TB_CUSTOMER_LOAN
    WHERE CUST_ID = i_cust_id ;
    o_row_count := SQL%ROWCOUNT;
  END SP_DEL_CUST_LOAN_BY_CUSTID;

-- **************************************************
-- SP_DEL_CUST_LOAN
-- Purpose: 00657 刪除授信戶主檔
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXX           2019.05.30  Create
-- **************************************************
  PROCEDURE SP_DEL_CUST_LOAN (
    i_customer_loan_seq_no IN NUMBER -- 授信戶主檔序號
  ) AS
  BEGIN
    DELETE EDLS.TB_CUSTOMER_LOAN
    WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
  END SP_DEL_CUST_LOAN;
  
-- **************************************************
-- SP_GET_CUST_LOAN_BY_CUST_ID
-- Purpose: 00258 以銀行歸戶統編取得授信戶主檔
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXX           2019.05.30  Create
-- **************************************************
  PROCEDURE SP_GET_CUST_LOAN_BY_CUST_ID 
  ( i_customer_id IN VARCHAR2 -- 銀行歸戶統編
  , o_cur OUT SYS_REFCURSOR   -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
      SELECT CUSTOMER_LOAN_SEQ_NO
           , CUST_ID
           , CUST_NAME
           , BIRTH_DATE
           , TEL_NO
           , CREATE_BRANCH
           , FIRST_DRAWDOWN_DATE
           , FIRST_DRAWDOWN_MATU_DATE
           , LOAN_REJECT_REASON
           , MAJ_CUST_LOAN_MK
           , INTST_PARTY_FLAG
           , LAST_TXN_DATE
           , CONTINUE_LOAN_MK
           , TRANS_OVERDUE_CENTER_STAT
           , CUST_TYPE
           , FIRST_APPRD_DATE
           , NEW_CUST_REG_DATE
           , REPAYMT_NOTIFY_MK
           , DELAY_PAYMT_NOTI_MSG_MK
           , OVERDUE_SPECIAL_MK
           , ESUN_STOCK_PROJ_MK
           , MEMO
           , REL_GROUP_REG_DATE
      FROM EDLS.TB_CUSTOMER_LOAN 
      WHERE CUST_ID = i_customer_id;
  END SP_GET_CUST_LOAN_BY_CUST_ID;

-- **************************************************
-- SP_GET_CUST_LOAN_BY_CUST_ID_U
-- Purpose: 00654 以銀行歸戶統編取得授信戶主檔 for update
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXX           2019.05.30  Create
-- **************************************************
  PROCEDURE SP_GET_CUST_LOAN_BY_CUST_ID_U 
  ( i_customer_id IN VARCHAR2 -- 銀行歸戶統編
  , o_cur OUT SYS_REFCURSOR   -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
      SELECT CUSTOMER_LOAN_SEQ_NO
          , CUST_ID
          , CUST_NAME
          , BIRTH_DATE
          , TEL_NO
          , CREATE_BRANCH
          , FIRST_DRAWDOWN_DATE
          , FIRST_DRAWDOWN_MATU_DATE
          , LOAN_REJECT_REASON
          , MAJ_CUST_LOAN_MK
          , INTST_PARTY_FLAG
          , LAST_TXN_DATE
          , CONTINUE_LOAN_MK
          , TRANS_OVERDUE_CENTER_STAT
          , CUST_TYPE
          , FIRST_APPRD_DATE
          , NEW_CUST_REG_DATE
          , REPAYMT_NOTIFY_MK
          , DELAY_PAYMT_NOTI_MSG_MK
          , OVERDUE_SPECIAL_MK
          , ESUN_STOCK_PROJ_MK
          , MEMO
          , REL_GROUP_REG_DATE
      FROM EDLS.TB_CUSTOMER_LOAN
      WHERE CUST_ID = i_customer_id
      FOR UPDATE;
  END SP_GET_CUST_LOAN_BY_CUST_ID_U;

-- **************************************************
-- SP_GET_CUSTLN_BY_CUSTLNSEQNO
-- Purpose: 00655 以授信戶主檔序號取得授信戶主檔
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXX           2019.05.30  Create
-- **************************************************
  PROCEDURE SP_GET_CUSTLN_BY_CUSTLNSEQNO 
  ( i_customer_loan_seq_no IN NUMBER -- 授信戶主檔序號
  , o_cur OUT SYS_REFCURSOR          -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
      SELECT CUSTOMER_LOAN_SEQ_NO
           , CUST_ID
           , CUST_NAME
           , BIRTH_DATE
           , TEL_NO
           , CREATE_BRANCH
           , FIRST_DRAWDOWN_DATE
           , FIRST_DRAWDOWN_MATU_DATE
           , LOAN_REJECT_REASON
           , MAJ_CUST_LOAN_MK
           , INTST_PARTY_FLAG
           , LAST_TXN_DATE
           , CONTINUE_LOAN_MK
           , TRANS_OVERDUE_CENTER_STAT
           , CUST_TYPE
           , FIRST_APPRD_DATE
           , NEW_CUST_REG_DATE
           , REPAYMT_NOTIFY_MK
           , DELAY_PAYMT_NOTI_MSG_MK
           , OVERDUE_SPECIAL_MK
           ,  ESUN_STOCK_PROJ_MK
           , MEMO
           , REL_GROUP_REG_DATE
      FROM EDLS.TB_CUSTOMER_LOAN
      WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
  END SP_GET_CUSTLN_BY_CUSTLNSEQNO;
  
-- **************************************************
-- SP_GET_CUSTLN_BY_CUSTLNSEQNO_U
-- Purpose: 00656 以授信戶主檔序號取得授信戶主檔 for update
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXX           2019.05.30  Create
-- **************************************************
  PROCEDURE SP_GET_CUSTLN_BY_CUSTLNSEQNO_U 
  ( i_customer_loan_seq_no IN NUMBER -- 授信戶主檔序號
  , o_cur OUT SYS_REFCURSOR			 -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
      SELECT CUSTOMER_LOAN_SEQ_NO
           , CUST_ID
           , CUST_NAME
           , BIRTH_DATE
           , TEL_NO
           , CREATE_BRANCH
           , FIRST_DRAWDOWN_DATE
           , FIRST_DRAWDOWN_MATU_DATE
           , LOAN_REJECT_REASON
           , MAJ_CUST_LOAN_MK
           , INTST_PARTY_FLAG
           , LAST_TXN_DATE
           , CONTINUE_LOAN_MK
           , TRANS_OVERDUE_CENTER_STAT
           , CUST_TYPE
            , FIRST_APPRD_DATE
            , NEW_CUST_REG_DATE
            , REPAYMT_NOTIFY_MK
            , DELAY_PAYMT_NOTI_MSG_MK
            , OVERDUE_SPECIAL_MK
            , ESUN_STOCK_PROJ_MK
            , MEMO
            , REL_GROUP_REG_DATE
        FROM EDLS.TB_CUSTOMER_LOAN
        WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
        FOR UPDATE;
  END SP_GET_CUSTLN_BY_CUSTLNSEQNO_U;

  -- getCustomerLoanByCustName對應的SP
-- **************************************************
-- SP_GET_CUSTLN_BY_CUSTNAME
-- Purpose: 00716 以戶名取得授信戶主檔(分頁查詢
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXX           2019.05.30  Create
-- **************************************************
  PROCEDURE SP_GET_CUSTLN_BY_CUSTNAME
  ( i_cust_name IN VARCHAR2     -- 授信戶戶名
  , i_create_branch IN VARCHAR2 -- 建檔單位
  , i_start_row IN NUMBER       -- 起始筆數
  , i_row_count IN NUMBER       -- 每頁筆數
  , o_cur OUT SYS_REFCURSOR     -- 回傳資料
  )AS
  BEGIN
    OPEN o_cur FOR
      SELECT CUSTOMER_LOAN_SEQ_NO
           , CUST_ID
           , CUST_NAME
           , BIRTH_DATE
           , TEL_NO
            , CREATE_BRANCH
            , FIRST_DRAWDOWN_DATE
            , FIRST_DRAWDOWN_MATU_DATE
            , LOAN_REJECT_REASON
            , MAJ_CUST_LOAN_MK
            , INTST_PARTY_FLAG
            , LAST_TXN_DATE
            , CONTINUE_LOAN_MK
            , TRANS_OVERDUE_CENTER_STAT
            , CUST_TYPE
            , FIRST_APPRD_DATE
            , NEW_CUST_REG_DATE
            , REPAYMT_NOTIFY_MK
            , DELAY_PAYMT_NOTI_MSG_MK
            , OVERDUE_SPECIAL_MK
            , ESUN_STOCK_PROJ_MK
            , MEMO
            , REL_GROUP_REG_DATE
            FROM EDLS.TB_CUSTOMER_LOAN 
        WHERE CUST_NAME LIKE '%' || i_cust_name || '%'
        AND CREATE_BRANCH = nvl(i_create_branch, CREATE_BRANCH)
        ORDER BY CUSTOMER_LOAN_SEQ_NO
        OFFSET (i_start_row) ROWS 
        FETCH NEXT i_row_count ROWS ONLY;
  END SP_GET_CUSTLN_BY_CUSTNAME;
  
-- **************************************************
-- SP_INS_CUST_LOAN_NUM
-- Purpose: 00259 新增授信戶號資訊
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXX           2019.05.30  Create
-- **************************************************  
  PROCEDURE SP_INS_CUST_LOAN_NUM 
  ( i_customer_loan_seq_no IN NUMBER  -- 授信戶主檔序號
  , i_branch_id IN VARCHAR2           -- 分行代號
  , i_customer_type IN VARCHAR2       -- 客戶性質別
  , i_customer_loan_no IN VARCHAR2    -- 授信戶號
  , i_kbb_cutomer_loan_no IN VARCHAR2 -- KBB授信戶號
  ) AS
  BEGIN
    INSERT INTO EDLS.TB_CUST_LOAN_NUMBER 
    ( CUSTOMER_LOAN_SEQ_NO
    , BRANCH
    , CUST_TYPE
    , CUST_LOAN_NUMBER
    , KBB_CUST_LOAN_NUMBER
    , CREATE_DATE
    , AMEND_DATE 
    )
      VALUES 
    ( i_customer_loan_seq_no
    , i_branch_id
    , i_customer_type
    , i_customer_loan_no
    , i_kbb_cutomer_loan_no
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
  END SP_INS_CUST_LOAN_NUM;

-- **************************************************
-- SP_DEL_CUST_LOAN_NUM
-- Purpose: 00260 刪除授信戶號資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB19377         2019.05.30  Create
-- **************************************************
  PROCEDURE SP_DEL_CUST_LOAN_NUM 
  ( i_customer_loan_seq_no IN NUMBER -- 授信戶主檔序號
  , i_branch_id IN VARCHAR2          -- 分行代號
  , i_customer_loan_no IN VARCHAR2   -- 授信戶號
  ) AS
  BEGIN
    DELETE EDLS.TB_CUST_LOAN_NUMBER
    WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
    AND BRANCH = i_branch_id
    AND CUST_LOAN_NUMBER = i_customer_loan_no;
  END SP_DEL_CUST_LOAN_NUM;
  
-- **************************************************
-- SP_GET_CUST_LOAN_NUM
-- Purpose: 00261 以授信戶主檔序號與授信戶號取得授信戶號資訊
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXXXX         2019.05.30  Create
-- **************************************************
  PROCEDURE SP_GET_CUST_LOAN_NUM 
  ( i_customer_loan_seq_no IN NUMBER -- 授信戶主檔序號
  , i_branch_id IN VARCHAR2          -- 分行代號
  , i_customer_loan_no IN VARCHAR2   -- 授信戶號
  , o_cur OUT SYS_REFCURSOR          -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT CUSTOMER_LOAN_SEQ_NO
          , BRANCH
          , CUST_LOAN_NUMBER
          , CUST_TYPE
          , KBB_CUST_LOAN_NUMBER
    FROM EDLS.TB_CUST_LOAN_NUMBER
    WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
    AND BRANCH = i_branch_id
    AND CUST_LOAN_NUMBER = i_customer_loan_no;
  END SP_GET_CUST_LOAN_NUM;
  
-- **************************************************
-- SP_GET_CUSTLNNUM_BY_CUSTLNNO
-- Purpose: 00263 以授信戶號及分行代號取得多筆授信戶號資訊
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXXXX         2019.05.30  Create
-- **************************************************
  PROCEDURE SP_GET_CUSTLNNUM_BY_CUSTLNNO 
  ( i_customer_loan_no IN VARCHAR2 -- 授信戶號
  , i_branch_id IN VARCHAR2      -- 分行代號
  , o_cur OUT SYS_REFCURSOR      -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR 
      SELECT CUSTOMER_LOAN_SEQ_NO
           , BRANCH
           , CUST_LOAN_NUMBER
           , CUST_TYPE
           , KBB_CUST_LOAN_NUMBER
        FROM EDLS.TB_CUST_LOAN_NUMBER
      WHERE BRANCH = i_branch_id
      AND CUST_LOAN_NUMBER = i_customer_loan_no;
  END SP_GET_CUSTLNNUM_BY_CUSTLNNO;

-- **************************************************
-- SP_GET_CUSTLNNUM_BY_CUSTLNSNO
-- Purpose: 00262 以授信戶主檔序號取得多筆授信戶號資訊
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXXXX         2019.05.30  Create
-- Mars             2019.11.22  移除forupdate
-- **************************************************
  PROCEDURE SP_GET_CUSTLNNUM_BY_CUSTLNSNO 
  ( i_customer_loan_seq_no IN NUMBER -- 授信戶主檔序號
  , i_branch_id IN VARCHAR2          -- 分行代號
  , o_cur OUT SYS_REFCURSOR          -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
      SELECT CUSTOMER_LOAN_SEQ_NO
           , BRANCH
           , CUST_LOAN_NUMBER
           , CUST_TYPE
           , KBB_CUST_LOAN_NUMBER
        FROM EDLS.TB_CUST_LOAN_NUMBER
        WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
          AND BRANCH = i_branch_id;
  END SP_GET_CUSTLNNUM_BY_CUSTLNSNO;


-- **************************************************
-- SP_INS_LOAN_CORPORATE
-- Purpose: 00668 新增企金戶資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ELITE-GCHong                 Create
-- ESB19411         2019.04.23  Fix problems with table schema change
-- **************************************************
    PROCEDURE SP_INS_LOAN_CORPORATE 
    ( i_customer_loan_seq_no IN NUMBER    -- 授信戶主檔序號
    , i_center_branch        IN VARCHAR2  -- 企金中心代號
    , i_enterprise_size_mk   IN VARCHAR2  -- 企業規模
    , i_team_id              IN VARCHAR2  -- 企金中心組別
    , i_rm_id                IN VARCHAR2  -- RM 人員統編
    , i_arm_id               IN VARCHAR2  -- ARM 人員統編
    , i_inter_media_branch   IN VARCHAR2  -- 轉介分行
    , i_fi_mk                IN VARCHAR2  -- 金融同業註記
    , i_cust_prop_mk         IN VARCHAR2  -- 授信戶屬性註記
    , i_pd_value             IN NUMBER    -- PD 值
    , i_cm_sup_no            IN VARCHAR2  -- CM 覆核統編
    , i_cm_id                IN VARCHAR2  -- CM 統編
    , i_cbc_industry_code    IN VARCHAR2  -- 行業別代碼（央行）
    , i_revenue_code         IN VARCHAR2  -- 營收代碼
    , i_industry_prop_type   IN VARCHAR2  -- 行業屬性類別
    , i_capital_amt          IN NUMBER    -- 資本額
    , i_cm_team_no           IN VARCHAR2  -- CM 組別
    , i_cm_mk                IN VARCHAR2  -- CM 經管註記
    , i_notify_branch        IN VARCHAR2  -- 通知單位
    , i_invalid_date         IN VARCHAR2  -- 授信失效日
    , i_prm_id               IN VARCHAR2  -- PRM 統編
    , i_eval_mk              IN VARCHAR2  -- 評核註記
    , i_cust_trade_mk        IN VARCHAR2  -- 顧客往來屬性
    , i_rm_team        		 IN VARCHAR2  -- RM 組代號
    , i_cm_team       	 	 IN VARCHAR2  -- CM 組代號
    , o_customer_loan_seq_no OUT NUMBER   -- 授信戶主檔序號
    ) AS
    BEGIN  
      INSERT INTO EDLS.TB_LOAN_CORPORATE 
      ( CUSTOMER_LOAN_SEQ_NO  -- 授信戶主檔序號
      , CENTER_BRANCH         -- 企金中心代號
      , ENTERPRISE_SIZE_MK    -- 企業規模
      , TEAM_ID               -- 企金中心組別
      , RM_ID                 -- RM 人員統編
      , ARM_ID                -- ARM 人員統編
      , INTER_MEDIA_BRANCH    -- 轉介分行
      , FI_MK                 -- 金融同業註記
      , CUST_PROP_MK          -- 授信戶屬性註記
      , PD_VALUE              -- PD 值
      , CM_AUTH_ID            -- CM 覆核統編
      , CM_ID                 -- CM 統編
      , CBC_INDUSTRY_CODE     -- 行業別代碼（央行）
      , REVENUE_CODE          -- 營收代碼
      , INDUSTRY_PROP_TYPE    -- 行業屬性類別
      , CAPITAL_AMT           -- 資本額
      , CM_GROUP              -- CM 組別
      , CM_MK                 -- CM 經管註記
      , NOTIFY_BRANCH         -- 通知單位
      , INVALID_DATE          -- 授信失效日
      , PRM_ID                -- PRM 統編
      , EVAL_MK               -- 評核註記
      , CUST_TRADE_MK         -- 顧客往來屬性
      , RM_TEAM				  -- RM 組代號
      , CM_TEAM				  -- CM 組代號
      , CREATE_DATE           -- 建立時間
      , AMEND_DATE            -- 更新時間
      )
      VALUES 
      ( i_customer_loan_seq_no
      , i_center_branch
      , i_enterprise_size_mk
      , i_team_id
      , i_rm_id
      , i_arm_id
      , i_inter_media_branch
      , i_fi_mk
      , i_cust_prop_mk
      , i_pd_value
      , i_cm_sup_no
      , i_cm_id
      , i_cbc_industry_code
      , i_revenue_code
      , i_industry_prop_type
      , i_capital_amt
      , i_cm_team_no
      , i_cm_mk
      , i_notify_branch
      , i_invalid_date
      , i_prm_id
      , i_eval_mk
      , i_cust_trade_mk
      , i_rm_team
      , i_cm_team 
      , SYSTIMESTAMP
      , SYSTIMESTAMP
      );
      o_customer_loan_seq_no := i_customer_loan_seq_no;
  END SP_INS_LOAN_CORPORATE;


-- **************************************************
-- SP_UPD_LOAN_CORPORATE
-- Purpose: 00669 更新企金戶資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ELITE-GCHong                 Create
-- ESB19411         2019.04.23  Fix problems with table schema change
-- **************************************************
    PROCEDURE SP_UPD_LOAN_CORPORATE 
    ( i_customer_loan_seq_no IN NUMBER    -- 授信戶主檔序號
    , i_center_branch        IN VARCHAR2  -- 企金中心代號
    , i_enterprise_size_mk   IN VARCHAR2  -- 企業規模
    , i_team_id              IN VARCHAR2  -- 企金中心組別
    , i_rm_id                IN VARCHAR2  -- RM 人員統編
    , i_arm_id               IN VARCHAR2  -- ARM 人員統編
    , i_inter_media_branch   IN VARCHAR2  -- 轉介分行
    , i_fi_mk                IN VARCHAR2  -- 金融同業註記
    , i_cust_prop_mk         IN VARCHAR2  -- 授信戶屬性註記
    , i_pd_value             IN NUMBER    -- PD 值
    , i_cm_sup_no            IN VARCHAR2  -- CM 覆核統編
    , i_cm_id                IN VARCHAR2  -- CM 統編
    , i_cbc_industry_code    IN VARCHAR2  -- 行業別代碼（央行）
    , i_revenue_code         IN VARCHAR2  -- 營收代碼
    , i_industry_prop_type   IN VARCHAR2  -- 行業屬性類別
    , i_capital_amt          IN NUMBER    -- 資本額
    , i_cm_team_no           IN VARCHAR2  -- CM 組別
    , i_cm_mk                IN VARCHAR2  -- CM 經管註記
    , i_notify_branch        IN VARCHAR2  -- 通知單位
    , i_invalid_date         IN VARCHAR2  -- 授信失效日
    , i_prm_id               IN VARCHAR2  -- PRM 統編
    , i_eval_mk              IN VARCHAR2  -- 評核註記
    , i_cust_trade_mk        IN VARCHAR2  -- 顧客往來屬性
    , i_rm_team        		 IN VARCHAR2  -- RM 組代號
	, i_cm_team       	 	 IN VARCHAR2  -- CM 組代號
    , o_customer_loan_seq_no OUT NUMBER   -- 授信戶主檔序號
    ) AS
    BEGIN
        o_customer_loan_seq_no := i_customer_loan_seq_no;

        UPDATE EDLS.TB_LOAN_CORPORATE
           SET CENTER_BRANCH        = i_center_branch
             , ENTERPRISE_SIZE_MK   = i_enterprise_size_mk
             , TEAM_ID              = i_team_id
             , RM_ID                = i_rm_id
             , ARM_ID               = i_arm_id
             , INTER_MEDIA_BRANCH   = i_inter_media_branch
             , FI_MK                = i_fi_mk
             , CUST_PROP_MK         = i_cust_prop_mk
             , PD_VALUE             = i_pd_value
             , CM_AUTH_ID            = i_cm_sup_no
             , CM_ID                = i_cm_id
             , CBC_INDUSTRY_CODE    = i_cbc_industry_code
             , REVENUE_CODE         = i_revenue_code
             , INDUSTRY_PROP_TYPE   = i_industry_prop_type
             , CAPITAL_AMT          = i_capital_amt
             , CM_GROUP           = i_cm_team_no
             , CM_MK                = i_cm_mk
             , NOTIFY_BRANCH        = i_notify_branch
             , INVALID_DATE         = i_invalid_date
             , PRM_ID               = i_prm_id
             , EVAL_MK              = i_eval_mk
             , CUST_TRADE_MK        = i_cust_trade_mk
             , AMEND_DATE           = SYSTIMESTAMP
             , RM_TEAM				= i_rm_team
             , CM_TEAM				= i_cm_team
         WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
    END SP_UPD_LOAN_CORPORATE;
  
-- **************************************************
-- SP_DEL_LOAN_CORPORATE
-- Purpose: 00670 刪除企金戶資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXXXX         2019.05.30  Create
-- **************************************************
  PROCEDURE SP_DEL_LOAN_CORPORATE 
  ( i_customer_loan_seq_no IN NUMBER -- 授信戶主檔序號
  ) AS
  BEGIN
    DELETE EDLS.TB_LOAN_CORPORATE
    WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
  END SP_DEL_LOAN_CORPORATE;

-- **************************************************
-- SP_GET_LOANCORP_BY_SEQNO
-- Purpose: 00664 以授信戶主檔序號查詢企金戶資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ELITE-GCHong                 Create
-- ESB19411         2019.04.23  Fix problems with table schema change
-- **************************************************
  PROCEDURE SP_GET_LOANCORP_BY_SEQNO 
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , o_cur                  OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT CUSTOMER_LOAN_SEQ_NO -- 授信戶主檔序號
       , CENTER_BRANCH        -- 企金中心代號
       , ENTERPRISE_SIZE_MK   -- 企業規模
       , TEAM_ID              -- 企金中心組別
       , RM_ID                -- RM 人員統編
       , ARM_ID               -- ARM 人員統編
       , INTER_MEDIA_BRANCH   -- 轉介分行
       , FI_MK                -- 金融同業註記
       , CUST_PROP_MK         -- 授信戶屬性註記
       , PD_VALUE             -- PD 值
       , CM_AUTH_ID           -- CM 覆核統編
       , CM_ID                -- CM 統編
       , CBC_INDUSTRY_CODE    -- 行業別代碼（央行）
       , REVENUE_CODE         -- 營收代碼
       , INDUSTRY_PROP_TYPE   -- 行業屬性類別
       , CAPITAL_AMT          -- 資本額
       , CM_GROUP             -- CM 組別
       , CM_MK                -- CM 經管註記
       , NOTIFY_BRANCH        -- 通知單位
       , INVALID_DATE         -- 授信失效日
       , PRM_ID               -- PRM 統編
       , EVAL_MK              -- 評核註記
       , CUST_TRADE_MK        -- 顧客往來屬性
       , RM_TEAM              -- RM組代號
       , CM_TEAM              -- CM組代號
	  FROM EDLS.TB_LOAN_CORPORATE
	 WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
  END SP_GET_LOANCORP_BY_SEQNO;

-- **************************************************
-- SP_GET_LOANCORP_BY_SEQNO_U
-- Purpose: 00665 以授信戶主檔序號查詢企金戶資料 for update
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ELITE-GCHong                 Create
-- ESB19411         2019.04.23  Fix problems with table schema change
-- **************************************************
  PROCEDURE SP_GET_LOANCORP_BY_SEQNO_U 
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , o_cur                  OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
  OPEN o_cur FOR
    SELECT CUSTOMER_LOAN_SEQ_NO -- 授信戶主檔序號
         , CENTER_BRANCH        -- 企金中心代號
         , ENTERPRISE_SIZE_MK   -- 企業規模
         , TEAM_ID              -- 企金中心組別
         , RM_ID                -- RM 人員統編
         , ARM_ID               -- ARM 人員統編
         , INTER_MEDIA_BRANCH   -- 轉介分行
         , FI_MK                -- 金融同業註記
         , CUST_PROP_MK         -- 授信戶屬性註記
         , PD_VALUE             -- PD 值
         , CM_AUTH_ID           -- CM 覆核統編
         , CM_ID                -- CM 統編
         , CBC_INDUSTRY_CODE    -- 行業別代碼（央行）
         , REVENUE_CODE         -- 營收代碼
         , INDUSTRY_PROP_TYPE   -- 行業屬性類別
         , CAPITAL_AMT          -- 資本額
         , CM_GROUP             -- CM 組別
         , CM_MK                -- CM 經管註記
         , NOTIFY_BRANCH        -- 通知單位
         , INVALID_DATE         -- 授信失效日
         , PRM_ID               -- PRM 統編
         , EVAL_MK              -- 評核註記
         , CUST_TRADE_MK        -- 顧客往來屬性
       	 , RM_TEAM              -- RM組代號
       	 , CM_TEAM              -- CM組代號                 
      FROM EDLS.TB_LOAN_CORPORATE
       WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
       FOR UPDATE;
  END SP_GET_LOANCORP_BY_SEQNO_U;


-- **************************************************
-- SP_GET_LOANCORP_BY_CUSTID
-- Purpose: 00666 以銀行歸戶統編查詢企金戶資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ELITE-GCHong                 Create
-- ESB19411         2019.04.24  Fix problems with table schema change
-- **************************************************
  PROCEDURE SP_GET_LOANCORP_BY_CUSTID
  ( i_customer_id IN VARCHAR        -- 銀行歸戶統編
  , o_cur         OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  v_customer_loan_seq_no EDLS.TB_CUSTOMER_LOAN.CUSTOMER_LOAN_SEQ_NO%TYPE;
  BEGIN
    BEGIN
      SELECT customer_loan_seq_no
      INTO v_customer_loan_seq_no
      FROM EDLS.TB_CUSTOMER_LOAN
       WHERE CUST_ID = i_customer_id;
         EXCEPTION 
      WHEN NO_DATA_FOUND THEN
        v_customer_loan_seq_no := NULL;
    END;
    OPEN o_cur FOR
      SELECT CUSTOMER_LOAN_SEQ_NO  -- 授信戶主檔序號
           , CENTER_BRANCH         -- 企金中心代號
           , ENTERPRISE_SIZE_MK    -- 企業規模
           , TEAM_ID               -- 企金中心組別
           , RM_ID                 -- RM 人員統編
           , ARM_ID                -- ARM 人員統編
           , INTER_MEDIA_BRANCH    -- 轉介分行
           , FI_MK                 -- 金融同業註記
           , CUST_PROP_MK          -- 授信戶屬性註記
           , PD_VALUE              -- PD 值
           , CM_AUTH_ID            -- CM 覆核統編
           , CM_ID                 -- CM 統編
           , CBC_INDUSTRY_CODE     -- 行業別代碼（央行）
           , REVENUE_CODE          -- 營收代碼
           , INDUSTRY_PROP_TYPE    -- 行業屬性類別
           , CAPITAL_AMT           -- 資本額
           , CM_GROUP              -- CM 組別
           , CM_MK                 -- CM 經管註記
           , NOTIFY_BRANCH         -- 通知單位
           , INVALID_DATE          -- 授信失效日
           , PRM_ID                -- PRM 統編
           , EVAL_MK               -- 評核註記
           , CUST_TRADE_MK         -- 顧客往來屬性
           , RM_TEAM               -- RM組代號
       	   , CM_TEAM               -- CM組代號    
        FROM EDLS.TB_LOAN_CORPORATE
       WHERE CUSTOMER_LOAN_SEQ_NO = v_customer_loan_seq_no;
  END SP_GET_LOANCORP_BY_CUSTID;


-- **************************************************
-- SP_GET_LOANCORP_BY_CUSTID_U
-- Purpose: 00667 以銀行歸戶統編查詢企金戶資料 for update
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ELITE-GCHong                 Create
-- ESB19411         2019.04.24  Fix problems with table schema change
-- **************************************************
  PROCEDURE SP_GET_LOANCORP_BY_CUSTID_U
  ( i_customer_id IN VARCHAR        -- 銀行歸戶統編
  , o_cur         OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  v_customer_loan_seq_no EDLS.TB_CUSTOMER_LOAN.CUSTOMER_LOAN_SEQ_NO%TYPE;
  BEGIN
    BEGIN
        SELECT customer_loan_seq_no
          INTO v_customer_loan_seq_no
          FROM EDLS.TB_CUSTOMER_LOAN
         WHERE CUST_ID = i_customer_id;
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            v_customer_loan_seq_no := NULL;
    END;
    OPEN o_cur FOR
        SELECT CUSTOMER_LOAN_SEQ_NO  -- 授信戶主檔序號
             , CENTER_BRANCH         -- 企金中心代號
             , ENTERPRISE_SIZE_MK    -- 企業規模
             , TEAM_ID               -- 企金中心組別
             , RM_ID                 -- RM 人員統編
             , ARM_ID                -- ARM 人員統編
             , INTER_MEDIA_BRANCH    -- 轉介分行
             , FI_MK                 -- 金融同業註記
             , CUST_PROP_MK          -- 授信戶屬性註記
             , PD_VALUE              -- PD 值
             , CM_AUTH_ID            -- CM 覆核統編
             , CM_ID                 -- CM 統編
             , CBC_INDUSTRY_CODE     -- 行業別代碼（央行）
             , REVENUE_CODE          -- 營收代碼
             , INDUSTRY_PROP_TYPE    -- 行業屬性類別
             , CAPITAL_AMT           -- 資本額
             , CM_GROUP              -- CM 組別
             , CM_MK                 -- CM 經管註記
             , NOTIFY_BRANCH         -- 通知單位
             , INVALID_DATE          -- 授信失效日
             , PRM_ID                -- PRM 統編
             , EVAL_MK               -- 評核註記
             , CUST_TRADE_MK         -- 顧客往來屬性
			 , RM_TEAM               -- RM組代號
       	     , CM_TEAM               -- CM組代號    
    FROM EDLS.TB_LOAN_CORPORATE
    WHERE CUSTOMER_LOAN_SEQ_NO = v_customer_loan_seq_no
    FOR UPDATE;    
  END SP_GET_LOANCORP_BY_CUSTID_U;
  
-- **************************************************
-- SP_INS_SB_CORPORATE
-- Purpose: 00658 新增微型企業
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXXXX         2019.05.30  Create
-- **************************************************
  PROCEDURE SP_INS_SB_CORPORATE 
  ( i_customer_loan_seq_no IN NUMBER  -- 授信戶主檔序號
  , i_profit_branch IN VARCHAR2       -- 維繫(利潤)分行
  , i_bmo_id IN VARCHAR2              -- 維繫(轉介)人員統編
  , o_customer_loan_seq_no OUT NUMBER -- 授信戶主檔序號
  ) AS
  BEGIN
    INSERT INTO EDLS.TB_SB_CORPORATE 
    ( CUSTOMER_LOAN_SEQ_NO
    , PROFIT_BRANCH
    , BMO_ID
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( i_customer_loan_seq_no
    , i_profit_branch
    , i_bmo_id
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
    o_customer_loan_seq_no := i_customer_loan_seq_no;
  END SP_INS_SB_CORPORATE;
  
-- **************************************************
-- SP_UPD_SB_CORPORATE
-- Purpose: 00659  更新微型企業
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXXXX         2019.05.30  Create
-- **************************************************
  PROCEDURE SP_UPD_SB_CORPORATE 
  ( i_customer_loan_seq_no IN NUMBER  -- 授信戶主檔序號
  , i_profit_branch IN VARCHAR2       -- 維繫(利潤)分行
  , i_bmo_id IN VARCHAR2              -- 維繫(轉介)人員統編
  , o_customer_loan_seq_no OUT NUMBER -- 授信戶主檔序號
  ) AS
  BEGIN
    o_customer_loan_seq_no := i_customer_loan_seq_no;
    UPDATE EDLS.TB_SB_CORPORATE
    SET
      PROFIT_BRANCH = i_profit_branch,
      BMO_ID = i_bmo_id,
      AMEND_DATE = SYSTIMESTAMP
    WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
  END SP_UPD_SB_CORPORATE;
  
-- **************************************************
-- SP_DEL_SB_CORPORATE
-- Purpose: 00660 刪除微型企業
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXXXX         2019.05.30  Create
-- **************************************************
  PROCEDURE SP_DEL_SB_CORPORATE
  ( i_customer_loan_seq_no IN NUMBER -- 授信戶主檔序號
  ) AS
  BEGIN
    DELETE EDLS.TB_SB_CORPORATE
    WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
  END SP_DEL_SB_CORPORATE;
  
-- **************************************************
-- SP_GET_SBCORP_BY_CUSTLNSEQNO
-- Purpose: 00661 以授信戶主檔序號查詢微型企業資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXXXX         2019.05.30  Create
-- **************************************************
  PROCEDURE SP_GET_SBCORP_BY_CUSTLNSEQNO
  ( i_customer_loan_seq_no IN NUMBER -- 授信戶主檔序號
  , o_cur OUT SYS_REFCURSOR          -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT CUSTOMER_LOAN_SEQ_NO
         , PROFIT_BRANCH
         , BMO_ID
    FROM EDLS.TB_SB_CORPORATE
    WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
  END SP_GET_SBCORP_BY_CUSTLNSEQNO;
  
-- **************************************************
-- SP_GET_SBCORP_BY_CUSTLNSEQNO_U
-- Purpose: 00662 以授信戶主檔序號查詢微型企業資料 for update
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- XXXXXXXX         2019.05.30  Create
-- **************************************************
  PROCEDURE SP_GET_SBCORP_BY_CUSTLNSEQNO_U 
  ( i_customer_loan_seq_no IN NUMBER -- 授信戶主檔序號 
  , o_cur OUT SYS_REFCURSOR          -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT CUSTOMER_LOAN_SEQ_NO
         , PROFIT_BRANCH
         , BMO_ID
    FROM EDLS.TB_SB_CORPORATE
    WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
    FOR UPDATE;
  END SP_GET_SBCORP_BY_CUSTLNSEQNO_U;

-- **************************************************
-- SP_INS_TRSODCTR
-- Purpose: 00765 新增移送催理中心資訊
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ELITE-GCHong                 Create
-- ESB19411         2019.04.24  Fix problems with table schema change
-- **************************************************
  PROCEDURE SP_INS_TRSODCTR 
  ( i_customer_loan_seq_no  IN NUMBER   -- 授信戶主檔序號
  , i_trans_overdue_date    IN VARCHAR2 -- 移送催理中心日期
  , i_delay_trans_date      IN VARCHAR2 -- 暫緩移送催理中心日期
  , i_move_back_date        IN VARCHAR2 -- 移回企消金日期
  , i_delay_trans_doc_no    IN VARCHAR2 -- 核准暫緩移送催理中心編號
  , i_overdue_center_branch IN VARCHAR2 -- 應移送的催理中心代號
  , i_center_branch         IN VARCHAR2 -- 企消金中心代號
  , i_is_gen_accounting     IN VARCHAR2 -- 訴訟代墊款出帳註記
  , o_seq_no OUT NUMBER                 -- 授信戶主檔序號
  ) AS
  BEGIN
    -- EDLS.PG_SYS.SP_GET_SEQ_NO('TB_TRANS_OVERDUE_CENTER', o_seq_no);
    INSERT INTO EDLS.TB_TRANS_OVERDUE_CENTER 
    ( customer_loan_seq_no   -- 授信戶主檔序號
    , trans_overdue_date     -- 移送催理中心日期
    , delay_trans_date       -- 暫緩移送催理中心日期
    , move_back_date         -- 移回企消金日期
    , delay_trans_doc_no     -- 核准暫緩移送催理中心編號
    , overdue_center_branch  -- 應移送的催理中心代號
    , center_branch          -- 企消金中心代號
    , is_gen_accounting      -- 訴訟代墊款出帳註記
    , create_date
    , amend_date
    )
    VALUES 
    ( i_customer_loan_seq_no
    , i_trans_overdue_date
    , i_delay_trans_date
    , i_move_back_date
    , i_delay_trans_doc_no
    , i_overdue_center_branch
    , i_center_branch
    , i_is_gen_accounting
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
    o_seq_no := i_customer_loan_seq_no;
  END SP_INS_TRSODCTR;

-- **************************************************
-- SP_GET_TRSODCTR_BY_SQN
-- Purpose: 00762 以授信戶主檔序號查詢移送催理中心資訊
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- 英倫             2018.10.23  Create
-- ESB19411         2019.04.24  Fix problems with table schema change
-- **************************************************
  PROCEDURE SP_GET_TRSODCTR_BY_SQN
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , o_cur                  OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT customer_loan_seq_no
         , trans_overdue_date
         , delay_trans_date
         , move_back_date
         , delay_trans_doc_no
         , overdue_center_branch
         , center_branch
         , is_gen_accounting
      FROM EDLS.TB_TRANS_OVERDUE_CENTER
   	 WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
  END SP_GET_TRSODCTR_BY_SQN;

-- **************************************************
-- SP_GET_TRSODCTR_BY_SQN_U
-- Purpose: 00763 以授信戶主檔序號查詢移送催理中心資訊 for update
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- 英倫             2018.10.23  Create
-- ESB19411         2019.04.24  Fix problems with table schema change
-- **************************************************
  PROCEDURE SP_GET_TRSODCTR_BY_SQN_U
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , o_cur                  OUT SYS_REFCURSOR -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
      SELECT customer_loan_seq_no
           , trans_overdue_date
           , delay_trans_date
           , move_back_date
           , delay_trans_doc_no
           , overdue_center_branch
           , center_branch
           , is_gen_accounting
        FROM EDLS.TB_TRANS_OVERDUE_CENTER
       WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
         FOR UPDATE;
  END SP_GET_TRSODCTR_BY_SQN_U;

  -- **************************************************
-- SP_UPD_TRSODCTR
-- Purpose: 00766 更新移送催理中心資訊
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- 英倫             2018.10.23  Create
-- **************************************************
  PROCEDURE SP_UPD_TRSODCTR
  ( i_customer_loan_seq_no  IN NUMBER   -- 授信戶主檔序號
  , i_trans_overdue_date    IN VARCHAR2 -- 移送催理中心日期
  , i_delay_trans_date      IN VARCHAR2 -- 暫緩移送催理中心日期
  , i_move_back_date        IN VARCHAR2 -- 移回企消金日期
  , i_delay_trans_doc_no    IN VARCHAR2 -- 核准暫緩移送催理中心編號
  , i_overdue_center_branch IN VARCHAR2 -- 應移送的催理中心代號
  , i_center_branch         IN VARCHAR2 -- 企消金中心代號
  , i_is_gen_accounting     IN VARCHAR2 -- 訴訟代墊款出帳註記
  , o_row_count OUT NUMBER              -- 更新筆數
  ) AS
  BEGIN
    UPDATE EDLS.TB_TRANS_OVERDUE_CENTER
      SET
         TRANS_OVERDUE_DATE    = i_trans_overdue_date,
         DELAY_TRANS_DATE      = i_delay_trans_date,
         MOVE_BACK_DATE        = i_move_back_date,
         DELAY_TRANS_DOC_NO    = i_delay_trans_doc_no,
         OVERDUE_CENTER_BRANCH = i_overdue_center_branch,
         CENTER_BRANCH         = i_center_branch,
         IS_GEN_ACCOUNTING     = i_is_gen_accounting,
         AMEND_DATE            = SYSTIMESTAMP
     WHERE CUSTOMER_LOAN_SEQ_NO  = i_customer_loan_seq_no;
     o_row_count := SQL%ROWCOUNT;
  END SP_UPD_TRSODCTR; 
  
-- **************************************************
-- SP_INS_LNODRSN
-- Purpose: 00767 新增逾期原因
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- 英倫             2018-10-23  Create
-- **************************************************
  PROCEDURE SP_INS_LNODRSN
  ( i_customer_loan_seq_no    IN NUMBER   -- 授信戶主檔序號
  , i_overdue_increase_reason IN VARCHAR2 -- 逾期新增原因
  , i_overdue_reduce_reason   IN VARCHAR2 -- 逾期減少原因
  )AS
  BEGIN
    INSERT INTO EDLS.TB_LOAN_OVERDUE_REASON
    ( CUSTOMER_LOAN_SEQ_NO
    , OVERDUE_INCREASE_REASON
    , OVERDUE_DECREASE_REASON
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( i_customer_loan_seq_no
    , i_overdue_increase_reason
    , i_overdue_reduce_reason
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
  END SP_INS_LNODRSN;
   
-- **************************************************
-- SP_UPD_LNODRSN
-- Purpose: 00768 更新逾期原因 
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- 英倫             2018-10-24  Create
-- **************************************************
  PROCEDURE SP_UPD_LNODRSN
  ( i_customer_loan_seq_no    IN NUMBER   -- 授信戶主檔序號
  , i_overdue_increase_reason IN VARCHAR2 -- 逾期新增原因
  , i_overdue_reduce_reason   IN VARCHAR2 -- 逾期減少原因
  ) AS
  BEGIN 
    UPDATE EDLS.TB_LOAN_OVERDUE_REASON
    SET 
    OVERDUE_INCREASE_REASON = i_overdue_increase_reason,
    OVERDUE_DECREASE_REASON = i_overdue_reduce_reason,
    AMEND_DATE = SYSTIMESTAMP
    WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
  END SP_UPD_LNODRSN;
  
-- **************************************************
-- SP_GET_LNODRSN_BY_CLNSQN
-- Purpose:以授信戶主檔序號取得逾期原因 
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- 英倫             2018-10-24  Create
-- **************************************************
  PROCEDURE SP_GET_LNODRSN_BY_CLNSQN
  ( i_customer_loan_seq_no IN NUMBER -- 授信戶主檔序號
  , o_cur OUT SYS_REFCURSOR          -- 回傳資料
  ) AS
  BEGIN 
     OPEN o_cur FOR
     SELECT CUSTOMER_LOAN_SEQ_NO,
            OVERDUE_INCREASE_REASON,
            OVERDUE_DECREASE_REASON
      FROM EDLS.TB_LOAN_OVERDUE_REASON
     WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
  END SP_GET_LNODRSN_BY_CLNSQN;
  
-- **************************************************
-- SP_GET_LNODRSN_BY_CLNSQN_U
-- Purpose: 00770 以授信戶主檔序號取得逾期原因
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- 英倫             2018-10-24  Create
-- **************************************************
  PROCEDURE SP_GET_LNODRSN_BY_CLNSQN_U
  ( i_customer_loan_seq_no IN NUMBER -- 授信戶主檔序號
  , o_cur OUT SYS_REFCURSOR          -- 回傳資料
	) AS
    BEGIN
     OPEN o_cur FOR
     SELECT CUSTOMER_LOAN_SEQ_NO,
            OVERDUE_INCREASE_REASON,
            OVERDUE_DECREASE_REASON
       FROM EDLS.TB_LOAN_OVERDUE_REASON
      WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no
     FOR UPDATE;
   END SP_GET_LNODRSN_BY_CLNSQN_U;
   
-- **************************************************
-- SP_GET_ANLINC_BY_CUST_ID
-- Purpose: 00756 以授信戶主檔序號查詢授信戶年所得資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- 英倫             2018-11-19  Create
-- **************************************************
  PROCEDURE SP_GET_ANLINC_BY_CUST_ID
  ( i_customer_id IN VARCHAR2 -- 銀行歸戶統編
  , o_cur OUT SYS_REFCURSOR   -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
    SELECT CA.CUSTOMER_LOAN_SEQ_NO
         , CA.TXN_BRANCH
         , CA.HOST_SNO
         , CA.FIRST_REG_DATE
         , CA.LAST_TXN_DATE
         , CA.ANNUAL_INCOME
         , CA.YEAR_MONTH
    FROM EDLS.TB_CUST_ANNUAL_INCOME CA
    INNER JOIN EDLS.TB_CUSTOMER_LOAN CL 
	  ON CA.CUSTOMER_LOAN_SEQ_NO = CL.CUSTOMER_LOAN_SEQ_NO
    WHERE CL.CUST_ID = i_customer_id;
  END SP_GET_ANLINC_BY_CUST_ID;
     
-- **************************************************
-- SP_GET_ANLINC_BY_CLNSQN
-- Purpose: 00757 以授信戶主檔序號查詢授信戶年所得資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- 英倫             2018.11.19  Create
-- **************************************************
  PROCEDURE SP_GET_ANLINC_BY_CLNSQN
  ( i_cust_loan_seq_no IN NUMBER  -- 授信戶主檔序號
  , o_cur OUT SYS_REFCURSOR       -- 回傳資料
  )AS
  BEGIN
    OPEN o_cur FOR 
    SELECT CUSTOMER_LOAN_SEQ_NO
         , TXN_BRANCH
         , HOST_SNO
         , FIRST_REG_DATE
         , LAST_TXN_DATE
         , ANNUAL_INCOME
         , YEAR_MONTH
      FROM EDLS.TB_CUST_ANNUAL_INCOME
     WHERE CUSTOMER_LOAN_SEQ_NO = i_cust_loan_seq_no;
  END SP_GET_ANLINC_BY_CLNSQN;
     
-- **************************************************
-- SP_GET_ANLINC_BY_CLNSQN_U
-- Purpose: 00758 以授信戶主檔序號查詢授信戶年所得資料 for update
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- 英倫             2018.11.20  Create
-- **************************************************
  PROCEDURE SP_GET_ANLINC_BY_CLNSQN_U
  ( i_cust_loan_seq_no IN NUMBER -- 授信戶主檔序號
  , o_cur OUT SYS_REFCURSOR      -- 回傳資料
  )AS
  BEGIN
     OPEN o_cur FOR
     SELECT CUSTOMER_LOAN_SEQ_NO
          , TXN_BRANCH
          , HOST_SNO
          , FIRST_REG_DATE
          , LAST_TXN_DATE
          , ANNUAL_INCOME
          , YEAR_MONTH
       FROM EDLS.TB_CUST_ANNUAL_INCOME
     WHERE CUSTOMER_LOAN_SEQ_NO = i_cust_loan_seq_no
     FOR UPDATE;
  END SP_GET_ANLINC_BY_CLNSQN_U;
     
-- **************************************************
-- SP_INS_ANLINC
-- Purpose: 00760 新增授信戶年所得資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- 英倫             2018.11.21  Create
-- **************************************************
  PROCEDURE SP_INS_ANLINC
  ( i_cust_loan_seq_no IN VARCHAR2 --授信戶主檔序號
  , i_txn_branch IN VARCHAR2       -- 交易分行 
  , i_host_sno IN VARCHAR2         -- 主機交易序號
  , i_first_reg_date IN VARCHAR2   -- 首次登錄日期
  , i_last_txn_date IN VARCHAR2    -- 上次交易日
  , i_annual_income IN NUMBER      -- 年所得金額
  , i_year_month IN VARCHAR2       -- 年所得的年度月份
  , o_row_count OUT NUMBER         -- 新增筆數
  )AS                              
  BEGIN
    INSERT INTO EDLS.TB_CUST_ANNUAL_INCOME
    ( CUSTOMER_LOAN_SEQ_NO
    , TXN_BRANCH
    , HOST_SNO
    , FIRST_REG_DATE
    , LAST_TXN_DATE
    , ANNUAL_INCOME
    , YEAR_MONTH
    , CREATE_DATE
    , AMEND_DATE
    )
    VALUES
    ( i_cust_loan_seq_no
    , i_txn_branch
    , i_host_sno
    , i_first_reg_date
    , i_last_txn_date
    , i_annual_income
    , i_year_month
    , SYSTIMESTAMP
    , SYSTIMESTAMP
    );
    o_row_count := SQL%ROWCOUNT;
  END SP_INS_ANLINC;
  
-- **************************************************
-- SP_UPD_ANLINC
-- Purpose: 00761 更新授信戶年所得資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- 英倫             2018.11.21  Create
-- **************************************************
  PROCEDURE SP_UPD_ANLINC
  ( i_cust_loan_seq_no IN VARCHAR2 -- 授信戶主檔序號
  , i_txn_branch IN VARCHAR2       -- 交易分行 
  , i_host_sno IN VARCHAR2         -- 主機交易序號
  , i_first_reg_date IN VARCHAR2   -- 首次登錄日期
  , i_last_txn_date IN VARCHAR2    -- 上次交易日
  , i_annual_income IN NUMBER      -- 年所得金額
  , i_year_month IN VARCHAR2       -- 年所得的年度月份
  )AS
  BEGIN 
    UPDATE EDLS.TB_CUST_ANNUAL_INCOME 
    SET
       TXN_BRANCH = i_txn_branch,
       HOST_SNO   = i_host_sno,
       FIRST_REG_DATE = i_first_reg_date,
       LAST_TXN_DATE = i_last_txn_date,
       ANNUAL_INCOME = i_annual_income,
       YEAR_MONTH = i_year_month,
       AMEND_DATE = SYSTIMESTAMP
       WHERE CUSTOMER_LOAN_SEQ_NO = i_cust_loan_seq_no;
  END SP_UPD_ANLINC;  

-- **************************************************
-- SP_GET_LAW_BEFALF_BALANCE
-- Purpose: 00869 取得全行訴訟代墊款餘額
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- 晉維             2019.01.18  Create
-- **************************************************  
  PROCEDURE SP_GET_LAW_BEFALF_BALANCE
  ( i_customer_loan_seq_no IN NUMBER   -- 授信戶主檔序號
  , o_sum_amt              OUT NUMBER  -- 全行訴訟代墊款餘額
  ) AS
  BEGIN 
    SELECT SUM(acc.AMT)
     INTO o_sum_amt  
     FROM EDLS.TB_LOAN_CIF_ACCOUNTING acc
    INNER JOIN EDLS.TB_CUSTOMER_LOAN cust_loan 
       ON acc.CUSTOMER_LOAN_SEQ_NO = cust_loan.CUSTOMER_LOAN_SEQ_NO 
    WHERE acc.CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no  
      AND acc.ACC_CATEGORY = '078';
  END SP_GET_LAW_BEFALF_BALANCE;
  
-- **************************************************
-- SP_CNT_LOAN_EACH_ACC_UNRECO
-- Purpose: 01350 查詢設帳科目未回收列帳主檔筆數
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- Cooper           2019.01.25  Create
-- **************************************************  
  PROCEDURE SP_CNT_LOAN_EACH_ACC_UNRECO
  ( i_customer_loan_seq_no IN NUMBER -- 授信戶主檔序號
  , i_acc_category IN VARCHAR2       -- 設帳科目
  , o_cnt OUT NUMBER                 -- 未回收筆數              
  ) IS 
  BEGIN 
    SELECT COUNT (1)  INTO o_cnt 
      FROM EDLS.TB_LOAN_EACH_ACCOUNTING
     WHERE CUSTOMER_LOAN_SEQ_NO = nvl (i_customer_loan_seq_no, CUSTOMER_LOAN_SEQ_NO)
       AND ACC_CATEGORY = nvl (i_acc_category, ACC_CATEGORY)
       AND (nvl(ACCOUNTING_AMT, 0) - nvl(SETTLEMENT_AMT, 0)) > 0;
  END SP_CNT_LOAN_EACH_ACC_UNRECO;

-- **************************************************
-- SP_GET_CUST_LOAN_BY_LOAN_NO
-- Purpose: 用放款帳號（直接、間接、MailLoan）取得授信戶主檔
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB19411         2018.10.23  Create
-- **************************************************
  PROCEDURE SP_GET_CUST_LOAN_BY_LOAN_NO
  ( i_loan_no IN VARCHAR2       -- 放款帳號
  , o_curs    OUT SYS_REFCURSOR -- 回傳資料
  ) IS
  BEGIN
    OPEN o_curs FOR
      SELECT CUSTOMER_LOAN_SEQ_NO
           , CUST_ID                   -- 銀行歸戶統編
           , CUST_NAME                 -- 授信戶戶名
           , BIRTH_DATE                 -- 授信戶生日
           , TEL_NO                    -- 授信戶電話
           , CREATE_BRANCH             -- 建檔單位
           , FIRST_DRAWDOWN_DATE       -- 初放日
           , FIRST_DRAWDOWN_MATU_DATE  -- 初放到期日
           , LOAN_REJECT_REASON        -- 拒絕貸放理由
           , MAJ_CUST_LOAN_MK          -- 主要授信戶註記
           , INTST_PARTY_FLAG          -- 利害關係人註記
           , LAST_TXN_DATE             -- 上次交易日
           , CONTINUE_LOAN_MK          -- 授信戶續貸註記
           , TRANS_OVERDUE_CENTER_STAT -- 移送催理中心狀態
           , CUST_TYPE                 -- 顧客分類
           , FIRST_APPRD_DATE          -- 首次批覆書核准日
           , NEW_CUST_REG_DATE         -- 新戶登錄日
           , REPAYMT_NOTIFY_MK         -- 預告繳款簡訊通知註記
           , DELAY_PAYMT_NOTI_MSG_MK   -- 延滯繳款簡訊通知註記
           , OVERDUE_SPECIAL_MK        -- 逾期特殊註記
           , ESUN_STOCK_PROJ_MK        -- 玉證專案
           , MEMO                      -- 授信注意事項
           , REL_GROUP_REG_DATE        -- 關係集團戶登錄日
           , CREATE_DATE               -- 建立時間
           , AMEND_DATE                -- 更新時間
      from (
        SELECT CL.CUSTOMER_LOAN_SEQ_NO      -- 授信戶主檔序號
             , CL.CUST_ID                   -- 銀行歸戶統編
             , CL.CUST_NAME                 -- 授信戶戶名
             , CL.BIRTH_DATE                 -- 授信戶生日
             , CL.TEL_NO                    -- 授信戶電話
             , CL.CREATE_BRANCH             -- 建檔單位
             , CL.FIRST_DRAWDOWN_DATE       -- 初放日
             , CL.FIRST_DRAWDOWN_MATU_DATE  -- 初放到期日
             , CL.LOAN_REJECT_REASON        -- 拒絕貸放理由
             , CL.MAJ_CUST_LOAN_MK          -- 主要授信戶註記
             , CL.INTST_PARTY_FLAG          -- 利害關係人註記
             , CL.LAST_TXN_DATE             -- 上次交易日
             , CL.CONTINUE_LOAN_MK          -- 授信戶續貸註記
             , CL.TRANS_OVERDUE_CENTER_STAT -- 移送催理中心狀態
             , CL.CUST_TYPE                 -- 顧客分類
             , CL.FIRST_APPRD_DATE          -- 首次批覆書核准日
             , CL.NEW_CUST_REG_DATE         -- 新戶登錄日
             , CL.REPAYMT_NOTIFY_MK         -- 預告繳款簡訊通知註記
             , CL.DELAY_PAYMT_NOTI_MSG_MK   -- 延滯繳款簡訊通知註記
             , CL.OVERDUE_SPECIAL_MK        -- 逾期特殊註記
             , CL.ESUN_STOCK_PROJ_MK        -- 玉證專案
             , CL.MEMO                      -- 授信注意事項
             , CL.REL_GROUP_REG_DATE        -- 關係集團戶登錄日
             , CL.CREATE_DATE               -- 建立時間
             , CL.AMEND_DATE                -- 更新時間
            FROM EDLS.TB_LOAN L
            JOIN EDLS.TB_CUSTOMER_LOAN CL
            ON L.CUSTOMER_LOAN_SEQ_NO = CL.CUSTOMER_LOAN_SEQ_NO
           WHERE L.LOAN_NO = i_loan_no
        UNION ALL
          SELECT CL.CUSTOMER_LOAN_SEQ_NO      -- 授信戶主檔序號
               , CL.CUST_ID                   -- 銀行歸戶統編
               , CL.CUST_NAME                 -- 授信戶戶名
               , CL.BIRTH_DATE                -- 授信戶生日
               , CL.TEL_NO                    -- 授信戶電話
               , CL.CREATE_BRANCH             -- 建檔單位
               , CL.FIRST_DRAWDOWN_DATE       -- 初放日
               , CL.FIRST_DRAWDOWN_MATU_DATE  -- 初放到期日
               , CL.LOAN_REJECT_REASON        -- 拒絕貸放理由
               , CL.MAJ_CUST_LOAN_MK          -- 主要授信戶註記
               , CL.INTST_PARTY_FLAG          -- 利害關係人註記
               , CL.LAST_TXN_DATE             -- 上次交易日
               , CL.CONTINUE_LOAN_MK          -- 授信戶續貸註記
               , CL.TRANS_OVERDUE_CENTER_STAT -- 移送催理中心狀態
               , CL.CUST_TYPE                 -- 顧客分類
               , CL.FIRST_APPRD_DATE          -- 首次批覆書核准日
               , CL.NEW_CUST_REG_DATE         -- 新戶登錄日
               , CL.REPAYMT_NOTIFY_MK         -- 預告繳款簡訊通知註記
               , CL.DELAY_PAYMT_NOTI_MSG_MK   -- 延滯繳款簡訊通知註記
               , CL.OVERDUE_SPECIAL_MK        -- 逾期特殊註記
               , CL.ESUN_STOCK_PROJ_MK        -- 玉證專案
               , CL.MEMO                      -- 授信注意事項
               , CL.REL_GROUP_REG_DATE        -- 關係集團戶登錄日
               , CL.CREATE_DATE               -- 建立時間
               , CL.AMEND_DATE                -- 更新時間
              FROM EDLS.TB_INDR_CREDIT IC
              JOIN EDLS.TB_CUSTOMER_LOAN CL
              ON IC.CUSTOMER_LOAN_SEQ_NO = CL.CUSTOMER_LOAN_SEQ_NO
             WHERE IC.ACC_NO = i_loan_no
         UNION ALL
           SELECT CL.CUSTOMER_LOAN_SEQ_NO      -- 授信戶主檔序號
             , CL.CUST_ID                   -- 銀行歸戶統編
             , CL.CUST_NAME                 -- 授信戶戶名
             , CL.BIRTH_DATE                -- 授信戶生日
             , CL.TEL_NO                    -- 授信戶電話
             , CL.CREATE_BRANCH             -- 建檔單位
             , CL.FIRST_DRAWDOWN_DATE       -- 初放日
             , CL.FIRST_DRAWDOWN_MATU_DATE  -- 初放到期日
             , CL.LOAN_REJECT_REASON        -- 拒絕貸放理由
             , CL.MAJ_CUST_LOAN_MK          -- 主要授信戶註記
             , CL.INTST_PARTY_FLAG          -- 利害關係人註記
             , CL.LAST_TXN_DATE             -- 上次交易日
             , CL.CONTINUE_LOAN_MK          -- 授信戶續貸註記
             , CL.TRANS_OVERDUE_CENTER_STAT -- 移送催理中心狀態
             , CL.CUST_TYPE                 -- 顧客分類
             , CL.FIRST_APPRD_DATE          -- 首次批覆書核准日
             , CL.NEW_CUST_REG_DATE         -- 新戶登錄日
             , CL.REPAYMT_NOTIFY_MK         -- 預告繳款簡訊通知註記
             , CL.DELAY_PAYMT_NOTI_MSG_MK   -- 延滯繳款簡訊通知註記
             , CL.OVERDUE_SPECIAL_MK        -- 逾期特殊註記
             , CL.ESUN_STOCK_PROJ_MK        -- 玉證專案
             , CL.MEMO                      -- 授信注意事項
             , CL.REL_GROUP_REG_DATE        -- 關係集團戶登錄日
             , CL.CREATE_DATE               -- 建立時間
             , CL.AMEND_DATE                -- 更新時間
            FROM EDLS.TB_MAIL_LOAN ML
            JOIN EDLS.TB_CUSTOMER_LOAN CL
            ON ML.CUSTOMER_LOAN_SEQ_NO = CL.CUSTOMER_LOAN_SEQ_NO
           WHERE ML.LOAN_NO = i_loan_no
           ) group by CUSTOMER_LOAN_SEQ_NO
                    , CUST_ID
                   , CUST_NAME
                    , BIRTH_DATE
                    , TEL_NO
                    , CREATE_BRANCH
                    , FIRST_DRAWDOWN_DATE
                    , FIRST_DRAWDOWN_MATU_DATE
                    , LOAN_REJECT_REASON
                    , MAJ_CUST_LOAN_MK
                    , INTST_PARTY_FLAG
                    , LAST_TXN_DATE
                    , CONTINUE_LOAN_MK
                    , TRANS_OVERDUE_CENTER_STAT
                    , CUST_TYPE
                    , FIRST_APPRD_DATE
                    , NEW_CUST_REG_DATE
                    , REPAYMT_NOTIFY_MK
                    , DELAY_PAYMT_NOTI_MSG_MK
                    , OVERDUE_SPECIAL_MK
                    , ESUN_STOCK_PROJ_MK
                    , MEMO
                    , REL_GROUP_REG_DATE
                    , CREATE_DATE
                    , AMEND_DATE;
  END SP_GET_CUST_LOAN_BY_LOAN_NO;

-- **************************************************
-- 814 SP_GET_TRSODCTRINFO_BY_CID
-- Purpose: 以銀行歸戶統編查詢授信戶主檔，移送催理中心資訊，逾期原因
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB19377         2019.05.28  Create
-- **************************************************
  PROCEDURE SP_GET_TRSODCTRINFO_BY_CID
  ( i_customer_id IN VARCHAR2   -- 銀行歸戶統編
  , o_curs    OUT SYS_REFCURSOR --授信戶主檔 + 移送催理中心資訊 + 逾期原因
  ) AS
  BEGIN
    OPEN o_curs FOR 
    SELECT cl.CUSTOMER_LOAN_SEQ_NO      -- 授信戶主檔序號
         , cl.CUST_ID                   -- 銀行歸戶統編
         , cl.CUST_NAME                 -- 授信戶戶名
         , cl.BIRTH_DATE                -- 授信戶生日
         , cl.TEL_NO                    -- 授信戶電話
         , cl.CREATE_BRANCH             -- 建檔單位
         , cl.FIRST_DRAWDOWN_DATE       -- 初放日
         , cl.FIRST_DRAWDOWN_MATU_DATE  -- 初放到期日
         , cl.LOAN_REJECT_REASON        -- 拒絕貸放理由
         , cl.MAJ_CUST_LOAN_MK          -- 主要授信戶註記
         , cl.INTST_PARTY_FLAG          -- 利害關係人註記
         , cl.LAST_TXN_DATE             -- 上次交易日
         , cl.CONTINUE_LOAN_MK          -- 授信戶續貸註記
         , cl.TRANS_OVERDUE_CENTER_STAT -- 移送催理中心狀態
         , cl.CUST_TYPE                 -- 顧客分類
         , cl.FIRST_APPRD_DATE          -- 首次批覆書核准日
         , cl.NEW_CUST_REG_DATE         -- 新戶登錄日
         , cl.REPAYMT_NOTIFY_MK         -- 預告繳款簡訊通知註記
         , cl.DELAY_PAYMT_NOTI_MSG_MK   -- 延滯繳款簡訊通知註記
         , cl.OVERDUE_SPECIAL_MK        -- 逾期特殊註記
         , cl.ESUN_STOCK_PROJ_MK        -- 玉證專案
         , cl.MEMO                      -- 授信注意事項
         , cl.REL_GROUP_REG_DATE        -- 關係集團戶登錄日
         , toc.TRANS_OVERDUE_DATE       -- 移送催理中心日期
         , toc.DELAY_TRANS_DATE         -- 暫緩移送催理中心日期
         , toc.MOVE_BACK_DATE           -- 移回企消金日期
         , toc.DELAY_TRANS_DOC_NO       -- 核准暫緩移送催理中心編號
         , toc.OVERDUE_CENTER_BRANCH    -- 應移送的催理中心代號
         , toc.CENTER_BRANCH            -- 企消金中心代號
         , toc.IS_GEN_ACCOUNTING        -- 訴訟代墊款出帳註記
         , rs.OVERDUE_INCREASE_REASON   -- 逾期新增原因
         , rs.OVERDUE_DECREASE_REASON   -- 逾期減少原因
      FROM EDLS.TB_CUSTOMER_LOAN cl
     inner JOIN EDLS.TB_TRANS_OVERDUE_CENTER toc
        ON cl.CUSTOMER_LOAN_SEQ_NO = toc.CUSTOMER_LOAN_SEQ_NO
     LEFT JOIN EDLS.TB_LOAN_OVERDUE_REASON rs
        ON toc.CUSTOMER_LOAN_SEQ_NO = rs.CUSTOMER_LOAN_SEQ_NO
     WHERE cl.CUST_ID =  i_customer_id ;
  END SP_GET_TRSODCTRINFO_BY_CID;

-- **************************************************
-- SP_GET_TRSODCTR_BY_CID
-- Purpose: 以銀行歸戶統編查詢授信主檔項下的【移送催理中心資訊】
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB19377         2019.05.30  Create
-- **************************************************
  PROCEDURE SP_GET_TRSODCTR_BY_CID
  ( i_customer_id  IN VARCHAR2     -- 銀行歸戶統編
  , o_cur        OUT SYS_REFCURSOR -- 移送催理中心資訊
  ) AS
  BEGIN
    OPEN o_cur FOR 
    SELECT toc.CUSTOMER_LOAN_SEQ_NO     -- 授信戶主檔序號
         , toc.TRANS_OVERDUE_DATE       -- 移送催理中心日期
         , toc.DELAY_TRANS_DATE         -- 暫緩移送催理中心日期
         , toc.MOVE_BACK_DATE           -- 移回企消金日期
         , toc.DELAY_TRANS_DOC_NO       -- 核准暫緩移送催理中心編號
         , toc.OVERDUE_CENTER_BRANCH    -- 應移送的催理中心代號
         , toc.CENTER_BRANCH            -- 企消金中心代號
         , toc.IS_GEN_ACCOUNTING        -- 訴訟代墊款出帳註記          
      FROM EDLS.TB_CUSTOMER_LOAN cl
      JOIN EDLS.TB_TRANS_OVERDUE_CENTER toc
        ON cl.CUSTOMER_LOAN_SEQ_NO = toc.CUSTOMER_LOAN_SEQ_NO
     WHERE cl.CUST_ID =  i_customer_id ;   
    END SP_GET_TRSODCTR_BY_CID;

-- **************************************************
-- 1919 SP_GET_CUST_LOAN_NUM_BY_KBB
-- Purpose: 查詢授信戶號資訊
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB19377         2019.07.01  Create
-- **************************************************
  PROCEDURE  SP_GET_CUST_LOAN_NUM_BY_KBB
  ( i_customer_loan_seq_no  IN NUMBER        -- 授信戶主檔序號
  , i_branch                IN VARCHAR2      -- 分行代號
  , i_cust_loan_number      IN VARCHAR2      -- 授信戶號
  , i_cust_type             IN VARCHAR2      -- 客戶性質別
  , i_kbb_cust_loan_number  IN VARCHAR2      -- KBB授信戶號
  , o_cur                  OUT SYS_REFCURSOR -- 移送催理中心資訊
  )AS
  BEGIN
    OPEN o_cur FOR 
    SELECT CUSTOMER_LOAN_SEQ_NO     -- 授信戶主檔序號
         , BRANCH                   -- 分行代號
         , CUST_LOAN_NUMBER         -- 授信戶號
         , CUST_TYPE                -- 客戶性質別
         , KBB_CUST_LOAN_NUMBER     -- KBB授信戶號     
      FROM EDLS.TB_CUST_LOAN_NUMBER -- 授信戶號資訊     
     WHERE (i_customer_loan_seq_no  IS NULL OR CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no)
       AND (i_branch                IS NULL OR BRANCH = i_branch)
       AND (i_cust_loan_number      IS NULL OR CUST_LOAN_NUMBER = i_cust_loan_number)
       AND (i_cust_type             IS NULL OR CUST_TYPE = i_cust_type)
       AND (i_kbb_cust_loan_number  IS NULL OR KBB_CUST_LOAN_NUMBER = i_kbb_cust_loan_number);
    END SP_GET_CUST_LOAN_NUM_BY_KBB; 

--*************************************************************************
-- SP_GET_CUST_HISTORY_DTL_PAGE
-- Purpose: 1. 以授信戶主檔序號查詢授信戶變更紀錄明細檔
--          2. 總筆數
--          3. 分頁
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜    2019.07.15  created
--
--**************************************************************************
  PROCEDURE SP_GET_CUST_HISTORY_DTL_PAGE
  ( i_cust_seq_no IN NUMBER          -- 授信戶主檔序號
  , i_index       IN NUMBER          -- 分頁
  , i_page_size   IN VARCHAR2        -- 每頁筆數
  , i_txn_type    IN VARCHAR2        -- 交易類別
  , o_cur         OUT SYS_REFCURSOR  -- 回傳資料
  ) AS
  v_totalCount NUMBER;
  BEGIN
    SELECT COUNT (*) into v_totalCount 
    FROM EDLS.TB_CUSTOMER_LOAN_HISTORY_DTL tclhd
    inner join (
      SELECT CUSTOMER_HISTORY_SEQ_NO
      FROM EDLS.TB_CUSTOMER_LOAN_HISTORY
      WHERE CUSTOMER_LOAN_SEQ_NO = i_cust_seq_no 
      group by CUSTOMER_HISTORY_SEQ_NO
    ) tclh
    on tclhd.CUSTOMER_HISTORY_SEQ_NO = tclh.CUSTOMER_HISTORY_SEQ_NO;
    
    OPEN o_cur FOR
    SELECT v_totalCount as TOTAL_COUNT
         , tclh.TXN_DATE
         , tclh.TXN_BRANCH
         , tclh.SUP_CARD
         , tclh.TELLER_EMP_ID
         , tclh.SUP_EMP_ID
         , tclh.TXN_ID
         , tclh.TXN_TYPE
         , tclhd.MODIFY_OLD_DATA
         , tclhd.MODIFY_NEW_DATA
         , tclhd.MODIFY_CODE
         , tclhd.MODIFY_TABLE
         , tclhd.MODIFY_FIELD
         , tclhd.BEFORE_MODIFY_VALUE
         , tclhd.AFTER_MODIFY_VALUE
    FROM EDLS.TB_CUSTOMER_LOAN_HISTORY_DTL tclhd 
    JOIN EDLS.TB_CUSTOMER_LOAN_HISTORY tclh 
      ON tclh.CUSTOMER_HISTORY_SEQ_NO = tclhd.CUSTOMER_HISTORY_SEQ_NO
    WHERE tclh.CUSTOMER_LOAN_SEQ_NO = i_cust_seq_no 
      AND (i_txn_type IS NULL OR tclh.TXN_TYPE = i_txn_type)
    ORDER BY tclh.TXN_DATE, tclh.TXN_TIME
    OFFSET (i_index - 1) ROWS 
    FETCH NEXT i_page_size ROWS ONLY;  
    
  END SP_GET_CUST_HISTORY_DTL_PAGE;

--*************************************************************************
-- SP_GET_CUST_HISTORY_DTL_BY_DATE
-- Purpose: 1. 以授信戶主檔序號查詢授信戶變更紀錄明細檔
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 許宸禎    2020.02.20  created
--
--**************************************************************************
  PROCEDURE SP_GET_CUST_HISTORY_DTL_BY_DATE
  ( i_cust_seq_no IN NUMBER          -- 授信戶主檔序號
  , i_date        IN VARCHAR2        -- 交易日期
  , i_txn_type    IN VARCHAR2        -- 交易類別
  , o_cur         OUT SYS_REFCURSOR  -- 回傳資料
  ) AS
  v_totalCount NUMBER;
  BEGIN
    SELECT COUNT (*) into v_totalCount 
    FROM EDLS.TB_CUSTOMER_LOAN_HISTORY_DTL tclhd
    inner join (
      SELECT CUSTOMER_HISTORY_SEQ_NO
      FROM EDLS.TB_CUSTOMER_LOAN_HISTORY
      WHERE CUSTOMER_LOAN_SEQ_NO = i_cust_seq_no 
      group by CUSTOMER_HISTORY_SEQ_NO
    ) tclh
    on tclhd.CUSTOMER_HISTORY_SEQ_NO = tclh.CUSTOMER_HISTORY_SEQ_NO;
    
    OPEN o_cur FOR
    SELECT v_totalCount as TOTAL_COUNT
         , tclh.TXN_DATE
         , tclh.TXN_BRANCH
         , tclh.SUP_CARD
         , tclh.TELLER_EMP_ID
         , tclh.SUP_EMP_ID
         , tclh.TXN_ID
         , tclh.TXN_TYPE
         , tclhd.MODIFY_OLD_DATA
         , tclhd.MODIFY_NEW_DATA
         , tclhd.MODIFY_CODE
         , tclhd.MODIFY_TABLE
         , tclhd.MODIFY_FIELD
         , tclhd.BEFORE_MODIFY_VALUE
         , tclhd.AFTER_MODIFY_VALUE
    FROM EDLS.TB_CUSTOMER_LOAN_HISTORY_DTL tclhd 
    JOIN EDLS.TB_CUSTOMER_LOAN_HISTORY tclh 
      ON tclh.CUSTOMER_HISTORY_SEQ_NO = tclhd.CUSTOMER_HISTORY_SEQ_NO
    WHERE tclh.CUSTOMER_LOAN_SEQ_NO = i_cust_seq_no 
      AND (i_txn_type IS NULL OR tclh.TXN_TYPE = i_txn_type)
      AND (i_date IS NULL OR tclh.TXN_DATE = i_date)
    ORDER BY tclh.TXN_DATE, tclh.TXN_TIME;
  END SP_GET_CUST_HISTORY_DTL_BY_DATE;

-- **************************************************
-- SP_GET_RELDTL_SEQS_BY_CLSEQ
-- Purpose: 以授信戶主檔序號取得同一關係企業資料所有序號
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB19377         2019.08.26  Create
-- **************************************************
  PROCEDURE  SP_GET_RELDTL_SEQS_BY_CLSEQ
  ( i_customer_loan_seq_no  IN NUMBER        -- 授信戶主檔序號
  , o_cur                  OUT SYS_REFCURSOR -- 授信戶同一關係企業資料分頁資料查詢結果
  )AS
  BEGIN
    OPEN o_cur FOR 
    SELECT CUSTOMER_LOAN_SEQ_NO      --授信戶主檔序號
          ,RELATED_COMPANY_ID        --關係企業統編
          ,DATA_TYPE                 --資料種類
          ,SETUP_BRANCH              --建檔單位
          ,SETUP_DATE                --建檔日期
          ,SUB_OARDINATION_CODE      --從屬關係代號
          ,MUTUAL_INVESTMENT_CODE    --相互投資關係代號
          ,SHAREHOLDER_RELATED_CODE  --董事關係代號
          ,SPOUSE_RELATED_CODE       --配偶關係代號
          ,BLOOD_RELATIVES_CODE      --血親關係代號
          ,OBU_NAME                  --境外法人的戶名
          ,OBU_COUNTRY               --境外法人的國別
          ,OBU_ADDR                  --境外法人的地址
      FROM EDLS.TB_CUST_LOAN_REL_DTL 
     WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
    END SP_GET_RELDTL_SEQS_BY_CLSEQ;    
    
-- **************************************************
-- SP_GET_CUSTLNNUMS_BY_CLSEQ
-- Purpose: 以授信戶主檔序號取得多筆授信戶號資訊
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB19377         2019.08.26  Create
-- **************************************************
  PROCEDURE  SP_GET_CUSTLNNUMS_BY_CLSEQ
  ( i_customer_loan_seq_no  IN NUMBER        -- 授信戶主檔序號
  , o_cur                  OUT SYS_REFCURSOR -- 授信戶號資訊
  )AS
  BEGIN
    OPEN o_cur FOR 
    SELECT CUSTOMER_LOAN_SEQ_NO  --授信戶主檔序號
          ,BRANCH                --分行代號
          ,CUST_LOAN_NUMBER      --授信戶號
          ,CUST_TYPE             --客戶性質別
          ,KBB_CUST_LOAN_NUMBER  --KBB授信戶號
      FROM EDLS.TB_CUST_LOAN_NUMBER 
     WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
    END SP_GET_CUSTLNNUMS_BY_CLSEQ;       

-- **************************************************
-- SP_UPD_CLSEQ_FOR_CUST_MODIFY
-- Purpose: 更新授信戶主檔序號 for 授信歸戶變更批次處理 (包含所有相關聯資料)
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB19377         2019.08.26  Create
-- **************************************************
  PROCEDURE  SP_UPD_CLSEQ_FOR_CUST_MODIFY
  ( i_before_customer_loan_seq_no  IN NUMBER         -- 變更前授信戶主檔序號
   ,i_after_customer_loan_seq_no   IN NUMBER         -- 變更後授信戶主檔序號
   )AS
  BEGIN
    -- 授信戶變更記錄主檔
    UPDATE EDLS.TB_CUSTOMER_LOAN_HISTORY
       SET CUSTOMER_LOAN_SEQ_NO   = i_after_customer_loan_seq_no 
         , AMEND_DATE             = SYSTIMESTAMP
     WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no ;

    -- 授信戶同一關係企業資料
    UPDATE EDLS.TB_CUST_LOAN_REL_DTL
       SET CUSTOMER_LOAN_SEQ_NO = i_after_customer_loan_seq_no
         , AMEND_DATE = SYSTIMESTAMP
     WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no ;

    -- 放款手續費交易紀錄
    UPDATE TB_LOAN_FEE
       SET CUSTOMER_LOAN_SEQ_NO = i_after_customer_loan_seq_no
          ,AMEND_DATE = SYSTIMESTAMP
     WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no ;

    -- 批覆書主檔
    UPDATE TB_APPR_DOC
       SET CUSTOMER_LOAN_SEQ_NO = i_after_customer_loan_seq_no
          ,AMEND_DATE = SYSTIMESTAMP
     WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no ;

    -- 保證人資料檔
    UPDATE TB_GUARANTOR
       SET CUSTOMER_LOAN_SEQ_NO = i_after_customer_loan_seq_no
          ,AMEND_DATE = SYSTIMESTAMP
     WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no ;

    -- 共用額度主檔
    UPDATE TB_LIMIT_SHARE
       SET CUSTOMER_LOAN_SEQ_NO = i_after_customer_loan_seq_no
          ,AMEND_DATE = SYSTIMESTAMP
     WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no ;

    -- 同存透支額度資訊
    UPDATE TB_VOSTRO_OVERDRAFT_LIMIT
       SET CUSTOMER_LOAN_SEQ_NO = i_after_customer_loan_seq_no
          ,AMEND_DATE = SYSTIMESTAMP
     WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no ;

    -- 備償專戶自動轉帳登錄
    UPDATE TB_RRSAC_AUTO_TRANSFER
       SET CUSTOMER_LOAN_SEQ_NO = i_after_customer_loan_seq_no
          ,AMEND_DATE = SYSTIMESTAMP
     WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no ;

    -- 放款主檔
    UPDATE TB_LOAN
       SET CUSTOMER_LOAN_SEQ_NO = i_after_customer_loan_seq_no
          ,AMEND_DATE = SYSTIMESTAMP
     WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no ;

    -- 外匯交易主檔
    UPDATE TB_FOREIGN
       SET CUSTOMER_LOAN_SEQ_NO = i_after_customer_loan_seq_no
          ,AMEND_DATE = SYSTIMESTAMP
     WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no ;

    -- 間接授信主檔
    UPDATE TB_INDR_CREDIT
       SET CUSTOMER_LOAN_SEQ_NO = i_after_customer_loan_seq_no
          ,AMEND_DATE = SYSTIMESTAMP
     WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no ;

    -- 列帳主檔
    UPDATE TB_LOAN_EACH_ACCOUNTING
       SET CUSTOMER_LOAN_SEQ_NO = i_after_customer_loan_seq_no
          ,AMEND_DATE = SYSTIMESTAMP
     WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no ;

    -- 授信戶列銷帳交易明細
    UPDATE TB_LOAN_CIF_SETTLEMENT
       SET CUSTOMER_LOAN_SEQ_NO = i_after_customer_loan_seq_no
          ,AMEND_DATE = SYSTIMESTAMP
     WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no ;

    -- Mail Loan放款主檔
    UPDATE TB_MAIL_LOAN
       SET CUSTOMER_LOAN_SEQ_NO = i_after_customer_loan_seq_no
          ,AMEND_DATE = SYSTIMESTAMP
    WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no;
    
    -- 移送催理中心資訊
    UPDATE TB_TRANS_OVERDUE_CENTER
       SET CUSTOMER_LOAN_SEQ_NO = i_after_customer_loan_seq_no
          ,AMEND_DATE = SYSTIMESTAMP
    WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no;
    
    -- 微型企業資料
    UPDATE TB_SB_CORPORATE
       SET CUSTOMER_LOAN_SEQ_NO = i_after_customer_loan_seq_no
          ,AMEND_DATE = SYSTIMESTAMP
    WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no;
    
    -- 逾期原因
    UPDATE TB_LOAN_OVERDUE_REASON
       SET CUSTOMER_LOAN_SEQ_NO = i_after_customer_loan_seq_no
          ,AMEND_DATE = SYSTIMESTAMP
    WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no;
    
  END SP_UPD_CLSEQ_FOR_CUST_MODIFY;    

-- **************************************************
-- SP_CHK_CLSEQ_FOR_CUST_MODIFY
-- Purpose: 確認變更後授信戶主檔序號是否存在，存在即刪除變更前授信戶資料
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB20285         2020.03.05  Create
-- **************************************************
  PROCEDURE  SP_CHK_CLSEQ_FOR_CUST_MODIFY
  ( i_before_customer_loan_seq_no  IN NUMBER         -- 變更前授信戶主檔序號
   ,i_after_customer_loan_seq_no   IN NUMBER         -- 變更後授信戶主檔序號
   )AS
  BEGIN
    -- 移送催理中心資訊
    DELETE FROM TB_TRANS_OVERDUE_CENTER
     WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no 
       AND EXISTS (SELECT 1 
                     FROM TB_TRANS_OVERDUE_CENTER
                    WHERE CUSTOMER_LOAN_SEQ_NO = i_after_customer_loan_seq_no ) ;
    -- 微型企業資料
    DELETE FROM TB_SB_CORPORATE
     WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no 
       AND EXISTS (SELECT 1 
                     FROM TB_SB_CORPORATE
                    WHERE CUSTOMER_LOAN_SEQ_NO = i_after_customer_loan_seq_no ) ;
    -- 逾期原因
    DELETE FROM TB_LOAN_OVERDUE_REASON
     WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no 
       AND EXISTS (SELECT 1 
                     FROM TB_LOAN_OVERDUE_REASON
                    WHERE CUSTOMER_LOAN_SEQ_NO = i_after_customer_loan_seq_no ) ;

  END SP_CHK_CLSEQ_FOR_CUST_MODIFY;

-- **************************************************
-- SP_DEL_CLDATA_FOR_CUST_MODIFY
-- Purpose: 實體刪除授信戶主檔序號相關資料 for 授信歸戶變更批次處理only (包含所有相關聯資料)。
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB19377         2019.08.26  Create
-- **************************************************
  PROCEDURE  SP_DEL_CLDATA_FOR_CUST_MODIFY
  ( i_before_customer_loan_seq_no  IN NUMBER         -- 變更前授信戶主檔序號
   )AS
  BEGIN   
  -- 授信戶主檔
       DELETE FROM TB_CUSTOMER_LOAN
        WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no ;
  -- 企金戶資料
       DELETE FROM TB_LOAN_CORPORATE
        WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no ;
  -- 授信戶列銷帳主檔
       DELETE FROM TB_LOAN_CIF_ACCOUNTING
        WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no ;
  -- 授信戶額度彙計檔
       DELETE FROM TB_CUST_LIMIT_DTL
        WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no ;
  -- 授信戶年所得資料
       DELETE FROM TB_CUST_ANNUAL_INCOME
        WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no ;
  -- 授信戶號資訊
       DELETE FROM TB_CUST_LOAN_NUMBER
        WHERE CUSTOMER_LOAN_SEQ_NO = i_before_customer_loan_seq_no ;          
  END SP_DEL_CLDATA_FOR_CUST_MODIFY;    

--**************************************************************************
-- SP_INS_LOAN_CUST_MODIFY
-- Purpose: 授信歸戶變更結果檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 Mars      2019.06.05  created
--
--**************************************************************************
  PROCEDURE SP_INS_LOAN_CUST_MODIFY
  ( i_data_date IN VARCHAR2           -- 資料日期
  , i_bef_cust_id IN VARCHAR2         -- 變更前銀行歸戶統編
  , i_aft_cust_id IN VARCHAR2         -- 變更後銀行歸戶統編
  , i_process_status_code IN VARCHAR2 -- 處理狀態
  , i_err_code IN VARCHAR2            -- 錯誤代碼
  , i_err_msg_code IN VARCHAR2        -- 錯誤訊息(代碼)
  , i_backup_raw_data IN CLOB         -- 備份資訊
  ) AS
  O_SEQ_NO NUMBER;
  BEGIN
    PG_SYS.SP_GET_SEQ_NO('TT_LOAN_CUST_MODIFY', O_SEQ_NO);
    INSERT INTO EDLS.TT_LOAN_CUST_MODIFY
    ( data_date
    , bef_cust_id
    , aft_cust_id
    , process_status_code
    , err_code
    , err_msg_code
    , backup_raw_data
    , create_date
    , amend_date
    , LOAN_CUST_MODIFY_SEQ_NO
    )
    VALUES 
    ( i_data_date
    , i_bef_cust_id
    , i_aft_cust_id
    , i_process_status_code
    , i_err_code
    , i_err_msg_code
    , i_backup_raw_data
    , systimestamp
    , systimestamp
    , O_SEQ_NO
    );
  END SP_INS_LOAN_CUST_MODIFY;
  
-- **************************************************
-- SP_GET_DUPL_LIMIT_SERIAL_NO
-- Purpose: 取得新舊授信戶主檔_共用額度序號 重複個數
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB19377         2019.12.27  Create
-- **************************************************
  PROCEDURE  SP_GET_DUPL_LIMIT_SERIAL_NO
  ( i_before_customer_loan_seq_no  IN NUMBER         -- 變更前授信戶主檔序號
   ,i_after_customer_loan_seq_no   IN NUMBER         -- 變更後授信戶主檔序號
   ,o_cur                         OUT NUMBER         -- 重複個數
   ) AS
  BEGIN 
    SELECT COUNT(TLS.SERIAL_NO) INTO o_cur
      FROM (SELECT SERIAL_NO           -- 共用額度序號
              FROM EDLS.TB_LIMIT_SHARE 
             WHERE CUSTOMER_LOAN_SEQ_NO IN (i_before_customer_loan_seq_no, i_after_customer_loan_seq_no)
            HAVING COUNT(1) > 1
             GROUP BY SERIAL_NO) TLS;  
  END SP_GET_DUPL_LIMIT_SERIAL_NO;
  
-- **************************************************
-- SP_GET_CUSTLNNUMS_BY_CLSEQ_U
-- Purpose: 以授信戶主檔序號取得多筆授信戶號資訊 無鎖FOR UPDATE
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB19377         2020.01.03  Create
-- **************************************************
  PROCEDURE  SP_GET_CUSTLNNUMS_BY_CLSEQ_U
  ( i_customer_loan_seq_no  IN NUMBER        -- 授信戶主檔序號
  , o_cur                  OUT SYS_REFCURSOR -- 授信戶號資訊
  )AS
  BEGIN
    OPEN o_cur FOR 
    SELECT CUSTOMER_LOAN_SEQ_NO  --授信戶主檔序號
          ,BRANCH                --分行代號
          ,CUST_LOAN_NUMBER      --授信戶號
          ,CUST_TYPE             --客戶性質別
          ,KBB_CUST_LOAN_NUMBER  --KBB授信戶號
      FROM EDLS.TB_CUST_LOAN_NUMBER 
     WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
    END SP_GET_CUSTLNNUMS_BY_CLSEQ_U;

-- **************************************************
-- SP_GET_LOAN_CONSOLIDATED
-- Purpose: 查詢直接授信相關帳號資訊
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB18757         2020.04.07  Create
-- **************************************************
  PROCEDURE SP_GET_LOAN_CONSOLIDATED
  ( i_customer_id IN VARCHAR2                  -- 銀行歸戶統編
  , i_account_no IN VARCHAR2                   -- 帳號
  , i_account_status_list IN ITEM_ARRAY        -- 帳號狀態
  , i_exclude_closed IN VARCHAR2               -- 未結清
  , i_exclude_chg_category IN VARCHAR2         -- 排除科目變更
  , i_loan_status_update_date IN VARCHAR2      -- 帳號狀態更新日
  , i_ccy_type IN VARCHAR2                     -- 幣別種類
  , i_paid_fire_insurance_query_mk IN VARCHAR2 -- 墊付火險保費查詢註記
  , i_credit_effective_mk IN VARCHAR2          -- 信保有效註記
  , i_is_guaranteed IN VARCHAR2                -- 有無擔保註記
  , i_hide_expired_info IN VARCHAR2            -- 不顯示過期資訊
  , i_exclude_cg_mark IN VARCHAR2              -- 排除信保有擔註記
  , i_exclude_n_cg_mark IN VARCHAR2            -- 排除信保無擔註記
  , i_sell_debit_mark IN VARCHAR2              -- 出售債權註記
  , i_loan_credit_mark_list IN ITEM_ARRAY      -- 授信債權註記
  , i_under_branch IN VARCHAR2                 -- 交易分行
  , i_appr_doc_no IN VARCHAR2                  -- 批覆書編號
  , i_data_convert_source_list IN ITEM_ARRAY   -- 批覆書資料轉換來源
  , i_limit_type_list IN ITEM_ARRAY            -- 額度種類
  , i_business_type_list IN ITEM_ARRAY         -- 業務類別
  , i_operation_branch IN VARCHAR2             -- 作業分行
  , i_project_code_list IN ITEM_ARRAY          -- 專案屬性註記
  , i_cur_biz_day IN VARCHAR2                  -- 現在交易日
  , i_start IN NUMBER                          -- 起始筆數
  , i_end IN NUMBER                            -- 結束筆數
  , o_cur OUT SYS_REFCURSOR                    -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
      WITH HOUSING_SUBCATEGORY AS (SELECT LOAN_SUBCATEGORY FROM EDLS.TB_LOAN_SUBCATEGORY_CONFIG WHERE HOUSING_LOAN_MK = 'Y'),
           POLICY_PROJ_CODE AS (SELECT PROJECT_CODE FROM EDLS.TB_PROJ_CONDITION_CONFIG WHERE POLICY_MORTGAGE_PROJ_MK = 'Y'),
           POLICY_SUBCATEGORY AS (SELECT LOAN_SUBCATEGORY FROM EDLS.TB_LOAN_SUBCATEGORY_CONFIG WHERE GOV_LOAN_MK = 'Y'),
           TOTAL_RESULT AS (SELECT cl.CUSTOMER_LOAN_SEQ_NO
                                 , cl.CUST_TYPE
                                 , ad.APPR_DOC_SEQ_NO
                                 , ad.APPR_DOC_NO
                                 , ad.PHASE APPR_PHASE
                                 , ad.MATU_DATE APPR_MATU_DATE
                                 , ad.OPER_BRANCH
                                 , ad.PROFIT_BRANCH
                                 , lt.LIMIT_SEQ_NO
                                 , lt.LIMIT_TYPE
                                 , lt.BUSINESS_TYPE
                                 , lt.CURRENCY
                                 , lt.APPRD_SUB_LIMIT_AMT
                                 , lt.LIMIT_DRAWDOWN_TYPE
                                 , ltp.LIMIT_PROFILE_SEQ_NO
                                 , ltp.LOAN_SUBCATEGORY
                                 , ltp.CREDIT_LOAN_PROD_CODE
                                 , ltp.COLLATERAL_TYPE
                                 , ln.LOAN_SEQ_NO
                                 , ln.LOAN_NO
                                 , ln.ACC_BRANCH
                                 , ln.PROD_CODE
                                 , ln.PROD_SUB_CODE
                                 , ln.STATUS_CHG_DATE
                                 , ln.PHASE
                                 , ln.LOAN_SERIAL_CNT
                                 , ln.BASE_RATE_TYPE
                                 , ln.FIRST_DRAWDOWN_AMT
                                 , ln.LOAN_SDATE
                                 , ln.LOAN_MATU_DATE
                                 , ln.LOAN_CCY
                                 , ln.LOAN_BALANCE
                                 , ln.INTST_RECEIV
                                 , ln.INTST_PAYMT_CYCLE
                                 , ln.INTST_GRACE_PERIOD
                                 , ln.IS_FULL_MONTH
                                 , ln.BONUS_OFFSET_AMT
                                 , ln.CONSIGN_PAYMT_MK
                                 , ln.CONSIGN_PAYMT_ACC
                                 , ln.SPECIAL_OVERDUE_MK
                                 , ln.SPECIAL_LOAN_MK
                                 , ln.DATA_SOURCE
                                 , ln.DELAY_PAYMT_CNT
                                 , ln.LOAN_CLAIM_MK
                                 , ln.LOAN_CLAIM_EFFEC_DATE
                                 , ln.OUTTER_OFFSET_INTST
                                 , ln.OUTTER_OFFSET_PENALTY
                                 , ln.OUTTER_FX801_AMT
                                 , ln.OUTTER_LAW_AMT
                                 , ln.INNER_LAW_AMT
                                 , ln.INNER_IR
                                 , ln.INNER_PRNP
                                 , ln.TOTAL_RECOV_BD_AMT
                                 , ln.INNER_FX801_AMT
                                 , ln.TRANS_OVERDUE_CENTER_MK
                                 , ln.SELL_CLAIM_MK
                                 , ln.CCY_TYPE
                                 , ld.START_DATE
                                 , ld.MATU_DATE
                                 , ld.PAYMT_TYPE
                                 , ld.LAST_INTST_EDATE
                                 , ld.NEXT_INTST_EDATE
                                 , ld.INTST_CUT_DATE
                                 , ld.REF_DATE
                                 , lc.CG_PERCT
                                 , lc.CG_EFFEC_MK
                                 , (SELECT LISTAGG(PROJECT_CODE, ',') FROM EDLS.TB_LIMIT_PROJ_COND_PROF WHERE LIMIT_PROFILE_SEQ_NO = ltp.LIMIT_PROFILE_SEQ_NO) PROJECT_CODE_LIST
                                 , ade25.APPR_DOC_EXTENSION_SEQ_NO AS APPR_DOC_EXTENSION_25_SEQ_NO
                                 , NULL AS ONLINE_REPAYMENT_MK -- 2021/06/24 先兼容舊版本，之後可刪除 by ESB18757
                              FROM EDLS.TB_CUSTOMER_LOAN cl
                             INNER JOIN EDLS.TB_APPR_DOC ad
                                ON cl.CUSTOMER_LOAN_SEQ_NO = ad.CUSTOMER_LOAN_SEQ_NO
                             INNER JOIN EDLS.TB_LIMIT lt
                                ON ad.APPR_DOC_SEQ_NO = lt.APPR_DOC_SEQ_NO
                             INNER JOIN EDLS.TB_LIMIT_PARAMETER_CONFIG lpc
                                ON lt.LIMIT_TYPE = lpc.LIMIT_TYPE
                             INNER JOIN EDLS.TB_LIMIT_PROFILE ltp
                                ON lt.LIMIT_SEQ_NO = ltp.LIMIT_SEQ_NO
                             INNER JOIN EDLS.TB_LOAN ln
                                ON cl.CUSTOMER_LOAN_SEQ_NO = ln.CUSTOMER_LOAN_SEQ_NO AND lt.LIMIT_SEQ_NO = ln.LIMIT_SEQ_NO
                             INNER JOIN EDLS.TB_ACC_USED au
                                ON ln.LOAN_NO = au.ACC
                             INNER JOIN EDLS.TB_LOAN_CATEGORY_CONFIG lcc
                                ON ln.PROD_CODE = lcc.PRODUCT_NO AND ln.PROD_SUB_CODE = lcc.PRODUCT_SUB_NO
                             INNER JOIN EDLS.TB_LOAN_DRAWDOWN ld
                                ON ln.LOAN_SEQ_NO = ld.LOAN_SEQ_NO AND ld.SNO = 1
                              LEFT JOIN EDLS.TB_LOAN_CG lc
                                ON ln.LOAN_SEQ_NO = lc.LOAN_SEQ_NO
                              LEFT JOIN EDLS.TB_LIMIT_PROJ_COND_PROF lpcp
                                ON ltp.LIMIT_PROFILE_SEQ_NO = lpcp.LIMIT_PROFILE_SEQ_NO
                              LEFT JOIN EDLS.TB_APPR_DOC_EXTENSION ade25
                                ON ln.LIMIT_SEQ_NO = ade25.LIMIT_SEQ_NO AND ade25.DATA_TYPE = '25' -- 【批覆書延伸資訊檔】.【資料類型】=「25:線上動撥還款資訊」
                             WHERE cl.CUST_ID = i_customer_id
                               AND (i_account_no IS NULL OR ln.LOAN_NO = i_account_no)
                               AND (NOT EXISTS(SELECT * FROM TABLE (i_account_status_list)) OR ln.PHASE IN (SELECT * FROM TABLE (i_account_status_list)))
                               AND (i_exclude_closed IS NULL OR (ln.PHASE IN ('3', '4', '7') OR (ln.PHASE = '8' AND ln.LOAN_CLAIM_MK IS NULL)))
                               AND (i_exclude_chg_category IS NULL OR (ln.TRANS_ACC_MK != '1'))
                               AND (i_loan_status_update_date IS NULL OR ln.STATUS_CHG_DATE >= i_loan_status_update_date)
                               AND (i_sell_debit_mark IS NULL OR ln.SELL_CLAIM_MK = i_sell_debit_mark)
                               AND (NOT EXISTS(SELECT * FROM TABLE (i_loan_credit_mark_list)) OR ln.LOAN_CLAIM_MK IN (SELECT * FROM TABLE (i_loan_credit_mark_list)))
                               AND (i_under_branch IS NULL OR ln.ACC_BRANCH != i_under_branch)
                               AND (i_appr_doc_no IS NULL OR ad.APPR_DOC_NO = i_appr_doc_no)
                               AND (i_operation_branch IS NULL OR ad.OPER_BRANCH = i_operation_branch)
                               AND (NOT EXISTS(SELECT * FROM TABLE (i_project_code_list)) OR lpcp.PROJECT_CODE IN (SELECT * FROM TABLE (i_project_code_list)))
                               AND (NOT EXISTS(SELECT * FROM TABLE (i_limit_type_list)) OR lt.LIMIT_TYPE IN (SELECT * FROM TABLE (i_limit_type_list)))
                               AND (i_ccy_type IS NULL OR ln.CCY_TYPE = i_ccy_type)
                               AND (i_paid_fire_insurance_query_mk != 'Y' OR i_paid_fire_insurance_query_mk IS NULL OR (
                                      ((ln.PROD_CODE LIKE 'LM%' OR ln.PROD_CODE LIKE 'LL%') AND ln.PHASE != '6')
                                  AND (lpc.BUSINESS_TYPE = 'LN' AND lpc.IS_GUARANTEED = 'Y' AND lpc.CCY_TYPE = 'T')
                                  AND (ltp.LOAN_SUBCATEGORY IN ('160008' , '120005') OR ltp.LOAN_SUBCATEGORY IN (SELECT LOAN_SUBCATEGORY FROM HOUSING_SUBCATEGORY))
                                  AND (
                                        (NOT EXISTS(SELECT lpcp_sub.PROJECT_CODE FROM EDLS.TB_LIMIT_PROJ_COND_PROF lpcp_sub INNER JOIN POLICY_PROJ_CODE ppc ON lpcp_sub.PROJECT_CODE = ppc.PROJECT_CODE WHERE lpcp_sub.LIMIT_PROFILE_SEQ_NO = ltp.LIMIT_PROFILE_SEQ_NO))
                                     OR (NOT EXISTS(SELECT ltp_sub.LOAN_SUBCATEGORY FROM EDLS.TB_LIMIT_PROFILE ltp_sub INNER JOIN POLICY_SUBCATEGORY ps ON ltp_sub.LOAN_SUBCATEGORY = ps.LOAN_SUBCATEGORY WHERE ltp_sub.LIMIT_PROFILE_SEQ_NO = ltp.LIMIT_PROFILE_SEQ_NO))
                                  )
                               ))
                               AND (i_credit_effective_mk IS NULL OR (lc.CG_EFFEC_MK = i_credit_effective_mk OR (i_credit_effective_mk = 'N'  AND lc.CG_SEQ_NO IS NULL)))
                               AND (i_is_guaranteed IS NULL OR lcc.IS_GUARANTEED = i_is_guaranteed)
                               AND (i_hide_expired_info != 'Y' OR i_hide_expired_info IS NULL OR ln.LOAN_MATU_DATE >= i_cur_biz_day)
                               AND (NOT EXISTS(SELECT * FROM TABLE (i_data_convert_source_list)) OR ad.DATA_CONVERT_SOURCE IN (SELECT * FROM TABLE (i_data_convert_source_list)))
                               AND (i_exclude_cg_mark != 'Y' OR i_exclude_cg_mark IS NULL OR(
                                     (lc.CG_EFFEC_MK = 'Y' AND lcc.IS_GUARANTEED = 'N')
                                  OR (lc.CG_EFFEC_MK != 'Y' OR lc.CG_SEQ_NO IS NULL)
                               ))
                               AND (i_exclude_n_cg_mark != 'Y' OR i_exclude_n_cg_mark IS NULL OR(
                                     (lc.CG_EFFEC_MK = 'Y' AND lcc.IS_GUARANTEED = 'Y')
                                  OR (lc.CG_EFFEC_MK != 'Y' OR lc.CG_SEQ_NO IS NULL)
                               ))
                             GROUP BY cl.CUSTOMER_LOAN_SEQ_NO, cl.CUST_TYPE, ad.APPR_DOC_SEQ_NO, ad.APPR_DOC_NO, ad.PHASE, ad.MATU_DATE, ad.OPER_BRANCH, ad.PROFIT_BRANCH, lt.LIMIT_SEQ_NO, lt.LIMIT_TYPE, lt.BUSINESS_TYPE, lt.CURRENCY, lt.APPRD_SUB_LIMIT_AMT, lt.LIMIT_DRAWDOWN_TYPE, ltp.LIMIT_PROFILE_SEQ_NO, ltp.LOAN_SUBCATEGORY, ltp.CREDIT_LOAN_PROD_CODE, ltp.COLLATERAL_TYPE, ln.LOAN_SEQ_NO, ln.LOAN_NO, ln.ACC_BRANCH, ln.PROD_CODE, ln.PROD_SUB_CODE, ln.STATUS_CHG_DATE, ln.PHASE, ln.LOAN_SERIAL_CNT, ln.BASE_RATE_TYPE, ln.FIRST_DRAWDOWN_AMT, ln.LOAN_SDATE, ln.LOAN_MATU_DATE, ln.LOAN_CCY, ln.LOAN_BALANCE, ln.INTST_RECEIV, ln.INTST_PAYMT_CYCLE, ln.INTST_GRACE_PERIOD, ln.IS_FULL_MONTH, ln.BONUS_OFFSET_AMT, ln.CONSIGN_PAYMT_MK, ln.CONSIGN_PAYMT_ACC, ln.SPECIAL_OVERDUE_MK, ln.SPECIAL_LOAN_MK, ln.DATA_SOURCE, ln.DELAY_PAYMT_CNT, ln.LOAN_CLAIM_MK, ln.LOAN_CLAIM_EFFEC_DATE, ln.OUTTER_OFFSET_INTST, ln.OUTTER_OFFSET_PENALTY, ln.OUTTER_FX801_AMT, ln.OUTTER_LAW_AMT, ln.INNER_LAW_AMT, ln.INNER_IR, ln.INNER_PRNP, ln.TOTAL_RECOV_BD_AMT, ln.INNER_FX801_AMT, ln.TRANS_OVERDUE_CENTER_MK, ln.SELL_CLAIM_MK, ln.CCY_TYPE, ld.START_DATE, ld.MATU_DATE, ld.PAYMT_TYPE, ld.LAST_INTST_EDATE, ld.NEXT_INTST_EDATE, ld.INTST_CUT_DATE, ld.REF_DATE, lc.CG_PERCT, lc.CG_EFFEC_MK, ade25.APPR_DOC_EXTENSION_SEQ_NO
                             ORDER BY ln.LOAN_NO),
           TOTAL_COUNT AS (SELECT COUNT(1) TOTAL_COUNT FROM TOTAL_RESULT),
           TARGET AS (SELECT * FROM TOTAL_RESULT ORDER BY LOAN_NO OFFSET i_start ROWS FETCH NEXT i_end - i_start ROWS ONLY)
      SELECT TARGET.*, TOTAL_COUNT.TOTAL_COUNT FROM TOTAL_COUNT LEFT JOIN TARGET ON TOTAL_COUNT.TOTAL_COUNT = TOTAL_COUNT.TOTAL_COUNT;
  END SP_GET_LOAN_CONSOLIDATED;

-- **************************************************
-- SP_GET_INDR_CREDIT_CONSOLIDATED
-- Purpose: 查詢間接授信相關帳號資訊
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB18757         2020.04.07  Create
-- **************************************************
  PROCEDURE SP_GET_INDR_CREDIT_CONSOLIDATED
  ( i_customer_id IN VARCHAR2                  -- 銀行歸戶統編
  , i_account_no IN VARCHAR2                   -- 帳號
  , i_account_status_list IN ITEM_ARRAY        -- 帳號狀態
  , i_exclude_closed IN VARCHAR2               -- 未結清
  , i_exclude_chg_category IN VARCHAR2         -- 排除科目變更
  , i_loan_status_update_date IN VARCHAR2      -- 帳號狀態更新日
  , i_ccy_type IN VARCHAR2                     -- 幣別種類
  , i_paid_fire_insurance_query_mk IN VARCHAR2 -- 墊付火險保費查詢註記
  , i_credit_effective_mk IN VARCHAR2          -- 信保有效註記
  , i_is_guaranteed IN VARCHAR2                -- 有無擔保註記
  , i_hide_expired_info IN VARCHAR2            -- 不顯示過期資訊
  , i_exclude_cg_mark IN VARCHAR2              -- 排除信保有擔註記
  , i_exclude_n_cg_mark IN VARCHAR2            -- 排除信保無擔註記
  , i_sell_debit_mark IN VARCHAR2              -- 出售債權註記
  , i_loan_credit_mark_list IN ITEM_ARRAY      -- 授信債權註記
  , i_under_branch IN VARCHAR2                 -- 交易分行
  , i_appr_doc_no IN VARCHAR2                  -- 批覆書編號
  , i_data_convert_source_list IN ITEM_ARRAY   -- 批覆書資料轉換來源
  , i_limit_type_list IN ITEM_ARRAY            -- 額度種類
  , i_business_type_list IN ITEM_ARRAY         -- 業務類別
  , i_operation_branch IN VARCHAR2             -- 作業分行
  , i_project_code_list IN ITEM_ARRAY          -- 專案屬性註記
  , i_cur_biz_day IN VARCHAR2                  -- 現在交易日
  , i_start IN NUMBER                          -- 起始筆數
  , i_end IN NUMBER                            -- 結束筆數
  , o_cur OUT SYS_REFCURSOR                    -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
      WITH TOTAL_RESULT AS (SELECT cl.CUSTOMER_LOAN_SEQ_NO
                                 , cl.CUST_TYPE
                                 , ad.APPR_DOC_SEQ_NO
                                 , ad.APPR_DOC_NO
                                 , ad.PHASE APPR_PHASE
                                 , ad.MATU_DATE APPR_MATU_DATE
                                 , ad.OPER_BRANCH
                                 , ad.PROFIT_BRANCH
                                 , lt.LIMIT_SEQ_NO
                                 , lt.LIMIT_TYPE
                                 , lt.BUSINESS_TYPE
                                 , lt.CURRENCY
                                 , lt.APPRD_SUB_LIMIT_AMT
                                 , lt.LIMIT_DRAWDOWN_TYPE
                                 , ltp.LIMIT_PROFILE_SEQ_NO
                                 , ltp.LOAN_SUBCATEGORY
                                 , ltp.CREDIT_LOAN_PROD_CODE
                                 , ltp.COLLATERAL_TYPE
                                 , ic.INDR_CREDIT_SEQ_NO
                                 , ic.ACC_NO
                                 , ic.ACC_BRANCH
                                 , ic.PROD_CODE
                                 , ic.SUB_PROD_CODE
                                 , ic.ACC_PHASE_AMEND_DATE
                                 , ic.PHASE
                                 , ic.LOAN_SERIAL_CNT
                                 , ic.LOAN_CLAIM_EFFEC_DATE
                                 , ic.LOAN_CLAIM_MK
                                 , ic.OVERDUE_MK
                                 , ic.GUARA_DOC_NO
                                 , ic.DRAFT_NO
                                 , ic.LC_DOC_NO
                                 , ic.LC_EFFEC_DATE
                                 , ic.GUARA_SDATE
                                 , ic.FIRST_DISB_AMT
                                 , ic.SDATE
                                 , ic.MATU_DATE
                                 , ic.PRNP_BALANCE
                                 , ic.FEE_EDATE
                                 , ic.PREPAID_BALANCE
                                 , ic.PENALTY_SDATE
                                 , ic.TOTAL_BD_RECOV_AMT
                                 , ic.CLAIM_MATU_DATE
                                 , ic.DATA_SOURCE
                                 , ic.TRANS_OVERDUE_CENTER_MK
                                 , ic.SELL_CLAIM_MK
                                 , ic.INTST_RECEIV
                                 , ic.OUTTER_OFFSET_INTST
                                 , ic.OUTTER_OFFSET_PENALTY
                                 , ic.OUTTER_LAW_AMT
                                 , ic.INNER_PRNP
                                 , ic.INNER_IR
                                 , ic.INNER_FX801_AMT
                                 , ic.INNER_LAW_AMT
                                 , iccg.CREDIT_GUARA_PERC
                                 , iccg.CREDIT_GUARA_EFFEC_MK
                                 , (SELECT LISTAGG(PROJECT_CODE, ',') FROM EDLS.TB_LIMIT_PROJ_COND_PROF WHERE LIMIT_PROFILE_SEQ_NO = ltp.LIMIT_PROFILE_SEQ_NO) PROJECT_CODE_LIST
                              FROM EDLS.TB_CUSTOMER_LOAN cl
                             INNER JOIN EDLS.TB_APPR_DOC ad
                                ON cl.CUSTOMER_LOAN_SEQ_NO = ad.CUSTOMER_LOAN_SEQ_NO
                             INNER JOIN EDLS.TB_LIMIT lt
                                ON ad.APPR_DOC_SEQ_NO = lt.APPR_DOC_SEQ_NO
                             INNER JOIN EDLS.TB_LIMIT_PROFILE ltp
                                ON lt.LIMIT_SEQ_NO = ltp.LIMIT_SEQ_NO
                             INNER JOIN EDLS.TB_INDR_CREDIT ic
                                ON cl.CUSTOMER_LOAN_SEQ_NO = ic.CUSTOMER_LOAN_SEQ_NO AND lt.LIMIT_SEQ_NO = ic.LIMIT_SEQ_NO
                             INNER JOIN EDLS.TB_ACC_USED au
                                ON ic.ACC_NO = au.ACC
                             INNER JOIN EDLS.TB_LOAN_CATEGORY_CONFIG lcc
                                ON ic.PROD_CODE = lcc.PRODUCT_NO AND ic.SUB_PROD_CODE = lcc.PRODUCT_SUB_NO
                              LEFT JOIN EDLS.TB_INDR_CREDIT_CREDIT_GUARANTE iccg
                                ON ic.INDR_CREDIT_SEQ_NO = iccg.INDR_CREDIT_SEQ_NO
                              LEFT JOIN EDLS.TB_LIMIT_PROJ_COND_PROF lpcp
                                ON ltp.LIMIT_PROFILE_SEQ_NO = lpcp.LIMIT_PROFILE_SEQ_NO
                             WHERE cl.CUST_ID = i_customer_id
                               AND (i_account_no IS NULL OR ic.ACC_NO = i_account_no)
                               AND (NOT EXISTS(SELECT * FROM TABLE (i_account_status_list)) OR ic.PHASE IN (SELECT * FROM TABLE (i_account_status_list)))
                               AND (i_exclude_closed IS NULL OR (ic.PHASE IN ('3', '4', '7') OR (ic.PHASE = '8' AND ic.LOAN_CLAIM_MK IS NULL)))
                               AND (i_exclude_chg_category IS NULL OR (ic.TRANS_ACC_MK != '1'))
                               AND (i_loan_status_update_date IS NULL OR ic.ACC_PHASE_AMEND_DATE >= i_loan_status_update_date)
                               AND (i_under_branch IS NULL OR ic.ACC_BRANCH != i_under_branch)
                               AND (i_sell_debit_mark IS NULL OR ic.SELL_CLAIM_MK = i_sell_debit_mark)
                               AND (NOT EXISTS(SELECT * FROM TABLE (i_loan_credit_mark_list)) OR ic.LOAN_CLAIM_MK IN (SELECT * FROM TABLE (i_loan_credit_mark_list)))
                               AND (i_appr_doc_no IS NULL OR ad.APPR_DOC_NO = i_appr_doc_no)
                               AND (i_operation_branch IS NULL OR ad.OPER_BRANCH = i_operation_branch)
                               AND (NOT EXISTS(SELECT * FROM TABLE (i_project_code_list)) OR lpcp.PROJECT_CODE IN (SELECT * FROM TABLE (i_project_code_list)))
                               AND (NOT EXISTS(SELECT * FROM TABLE (i_limit_type_list)) OR lt.LIMIT_TYPE IN (SELECT * FROM TABLE (i_limit_type_list)))
                               AND (NOT EXISTS(SELECT * FROM TABLE (i_business_type_list)) OR lcc.BUSINESS_TYPE IN (SELECT * FROM TABLE (i_business_type_list)))
                               AND (i_ccy_type IS NULL OR lt.CCY_TYPE = i_ccy_type)
                               AND (i_credit_effective_mk IS NULL OR (iccg.CREDIT_GUARA_EFFEC_MK = i_credit_effective_mk OR (i_credit_effective_mk = 'N'  AND iccg.INDR_CREDIT_SEQ_NO IS NULL)))
                               AND (i_is_guaranteed IS NULL OR ic.IS_GUARANTEED = i_is_guaranteed)
                               AND (i_hide_expired_info != 'Y' OR i_hide_expired_info IS NULL OR ic.MATU_DATE >= i_cur_biz_day)
                               AND (NOT EXISTS(SELECT * FROM TABLE (i_data_convert_source_list)) OR ad.DATA_CONVERT_SOURCE IN (SELECT * FROM TABLE (i_data_convert_source_list)))
                               AND (i_exclude_cg_mark != 'Y' OR i_exclude_cg_mark IS NULL OR (
                                     (iccg.CREDIT_GUARA_EFFEC_MK = 'Y' AND lcc.IS_GUARANTEED = 'N')
                                  OR (iccg.CREDIT_GUARA_EFFEC_MK != 'Y' OR iccg.INDR_CREDIT_SEQ_NO IS NULL)
                               ))
                               AND (i_exclude_n_cg_mark != 'Y' OR i_exclude_n_cg_mark IS NULL OR (
                                     (iccg.CREDIT_GUARA_EFFEC_MK = 'Y' AND lcc.IS_GUARANTEED = 'Y')
                                  OR (iccg.CREDIT_GUARA_EFFEC_MK != 'Y' OR iccg.INDR_CREDIT_SEQ_NO IS NULL)
                               ))
                             GROUP BY cl.CUSTOMER_LOAN_SEQ_NO, cl.CUST_TYPE, ad.APPR_DOC_SEQ_NO, ad.APPR_DOC_NO, ad.PHASE, ad.MATU_DATE, ad.OPER_BRANCH, ad.PROFIT_BRANCH, lt.LIMIT_SEQ_NO, lt.LIMIT_TYPE, lt.BUSINESS_TYPE, lt.CURRENCY, lt.APPRD_SUB_LIMIT_AMT, lt.LIMIT_DRAWDOWN_TYPE, ltp.LIMIT_PROFILE_SEQ_NO, ltp.LOAN_SUBCATEGORY, ltp.CREDIT_LOAN_PROD_CODE, ltp.COLLATERAL_TYPE, ic.INDR_CREDIT_SEQ_NO, ic.ACC_NO, ic.ACC_BRANCH, ic.PROD_CODE, ic.SUB_PROD_CODE, ic.ACC_PHASE_AMEND_DATE, ic.PHASE, ic.LOAN_SERIAL_CNT, ic.LOAN_CLAIM_EFFEC_DATE, ic.LOAN_CLAIM_MK, ic.OVERDUE_MK, ic.GUARA_DOC_NO, ic.DRAFT_NO, ic.LC_DOC_NO, ic.LC_EFFEC_DATE, ic.GUARA_SDATE, ic.FIRST_DISB_AMT, ic.SDATE, ic.MATU_DATE, ic.PRNP_BALANCE, ic.FEE_EDATE, ic.PREPAID_BALANCE, ic.PENALTY_SDATE, ic.TOTAL_BD_RECOV_AMT, ic.CLAIM_MATU_DATE, ic.DATA_SOURCE, ic.TRANS_OVERDUE_CENTER_MK, ic.SELL_CLAIM_MK, ic.INTST_RECEIV, ic.OUTTER_OFFSET_INTST, ic.OUTTER_OFFSET_PENALTY, ic.OUTTER_LAW_AMT, ic.INNER_PRNP, ic.INNER_IR, ic.INNER_FX801_AMT, ic.INNER_LAW_AMT, iccg.CREDIT_GUARA_PERC, iccg.CREDIT_GUARA_EFFEC_MK
                             ORDER BY ic.ACC_NO),
           TOTAL_COUNT AS (SELECT COUNT(1) TOTAL_COUNT FROM TOTAL_RESULT),
           TARGET AS (SELECT * FROM TOTAL_RESULT ORDER BY ACC_NO OFFSET i_start ROWS FETCH NEXT i_end - i_start ROWS ONLY)
      SELECT TARGET.*, TOTAL_COUNT.TOTAL_COUNT FROM TOTAL_COUNT LEFT JOIN TARGET ON TOTAL_COUNT.TOTAL_COUNT = TOTAL_COUNT.TOTAL_COUNT;
  END SP_GET_INDR_CREDIT_CONSOLIDATED;

-- **************************************************
-- SP_GET_FOREIGN_CONSOLIDATED
-- Purpose: 查詢外匯相關帳號資訊
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB18757         2020.04.07  Create
-- **************************************************
  PROCEDURE SP_GET_FOREIGN_CONSOLIDATED
  ( i_customer_id IN VARCHAR2                  -- 銀行歸戶統編
  , i_account_no IN VARCHAR2                   -- 帳號
  , i_account_status_list IN ITEM_ARRAY        -- 帳號狀態
  , i_exclude_closed IN VARCHAR2               -- 未結清
  , i_exclude_chg_category IN VARCHAR2         -- 排除科目變更
  , i_loan_status_update_date IN VARCHAR2      -- 帳號狀態更新日
  , i_ccy_type IN VARCHAR2                     -- 幣別種類
  , i_paid_fire_insurance_query_mk IN VARCHAR2 -- 墊付火險保費查詢註記
  , i_credit_effective_mk IN VARCHAR2          -- 信保有效註記
  , i_is_guaranteed IN VARCHAR2                -- 有無擔保註記
  , i_hide_expired_info IN VARCHAR2            -- 不顯示過期資訊
  , i_exclude_cg_mark IN VARCHAR2              -- 排除信保有擔註記
  , i_sell_debit_mark IN VARCHAR2              -- 出售債權註記
  , i_loan_credit_mark_list IN ITEM_ARRAY      -- 授信債權註記
  , i_under_branch IN VARCHAR2                 -- 交易分行
  , i_appr_doc_no IN VARCHAR2                  -- 批覆書編號
  , i_data_convert_source_list IN ITEM_ARRAY   -- 批覆書資料轉換來源
  , i_limit_type_list IN ITEM_ARRAY            -- 額度種類
  , i_business_type_list IN ITEM_ARRAY         -- 業務類別
  , i_operation_branch IN VARCHAR2             -- 作業分行
  , i_project_code_list IN ITEM_ARRAY          -- 專案屬性註記
  , i_cur_biz_day IN VARCHAR2                  -- 現在交易日
  , i_start IN NUMBER                          -- 起始筆數
  , i_end IN NUMBER                            -- 結束筆數
  , o_cur OUT SYS_REFCURSOR                    -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
      WITH TOTAL_RESULT AS (SELECT cl.CUSTOMER_LOAN_SEQ_NO
                                 , cl.CUST_TYPE
                                 , ad.APPR_DOC_SEQ_NO
                                 , ad.APPR_DOC_NO
                                 , ad.PHASE APPR_PHASE
                                 , ad.MATU_DATE APPR_MATU_DATE
                                 , ad.OPER_BRANCH
                                 , ad.PROFIT_BRANCH
                                 , lt.LIMIT_SEQ_NO
                                 , lt.LIMIT_TYPE
                                 , lt.BUSINESS_TYPE
                                 , lt.CURRENCY
                                 , lt.APPRD_SUB_LIMIT_AMT
                                 , lt.LIMIT_DRAWDOWN_TYPE
                                 , ltp.LIMIT_PROFILE_SEQ_NO
                                 , ltp.LOAN_SUBCATEGORY
                                 , ltp.CREDIT_LOAN_PROD_CODE
                                 , ltp.COLLATERAL_TYPE
                                 , fn.FOREIGN_SEQ_NO
                                 , fn.REF_NO
                                 , fn.PHASE
                                 , fn.LAST_TXN_DATE ACC_PHASE_AMEND_DATE
                                 , fn.INTST_SDATE
                                 , fn.MATU_DATE
                                 , fn.ACC_BRANCH
                                 , fn.CG_PENCENT
                                 , (SELECT INTST_RATE FROM EDLS.TB_FOREIGN_DRAWDOWN_DTL WHERE FOREIGN_SEQ_NO = fn.FOREIGN_SEQ_NO ORDER BY CREATE_DATE DESC FETCH NEXT 1 ROWS ONLY) INTST_RATE
                                 , (SELECT LISTAGG(PROJECT_CODE, ',') FROM EDLS.TB_LIMIT_PROJ_COND_PROF WHERE LIMIT_PROFILE_SEQ_NO = ltp.LIMIT_PROFILE_SEQ_NO) PROJECT_CODE_LIST
                              FROM EDLS.TB_CUSTOMER_LOAN cl
                             INNER JOIN EDLS.TB_APPR_DOC ad
                                ON cl.CUSTOMER_LOAN_SEQ_NO = ad.CUSTOMER_LOAN_SEQ_NO
                             INNER JOIN EDLS.TB_LIMIT lt
                                ON ad.APPR_DOC_SEQ_NO = lt.APPR_DOC_SEQ_NO
                             INNER JOIN EDLS.TB_LIMIT_PROFILE ltp
                                ON lt.LIMIT_SEQ_NO = ltp.LIMIT_SEQ_NO
                             INNER JOIN EDLS.TB_FOREIGN fn
                                ON cl.CUSTOMER_LOAN_SEQ_NO = fn.CUSTOMER_LOAN_SEQ_NO AND lt.LIMIT_SEQ_NO = fn.LIMIT_SEQ_NO
                              LEFT JOIN EDLS.TB_LIMIT_PROJ_COND_PROF lpcp
                                ON ltp.LIMIT_PROFILE_SEQ_NO = lpcp.LIMIT_PROFILE_SEQ_NO
                             WHERE cl.CUST_ID = i_customer_id
                               AND (i_account_no IS NULL OR fn.REF_NO = i_account_no)
                               AND (NOT EXISTS(SELECT * FROM TABLE (i_account_status_list)) OR fn.PHASE IN (SELECT * FROM TABLE (i_account_status_list)))
                               AND (i_exclude_closed IS NULL OR fn.PHASE IN ('3', '4', '7', '8'))
                               AND (i_under_branch IS NULL OR fn.ACC_BRANCH != i_under_branch)
                               AND (i_appr_doc_no IS NULL OR ad.APPR_DOC_NO = i_appr_doc_no)
                               AND (i_operation_branch IS NULL OR ad.OPER_BRANCH = i_operation_branch)
                               AND (NOT EXISTS(SELECT * FROM TABLE (i_limit_type_list)) OR lt.LIMIT_TYPE IN (SELECT * FROM TABLE (i_limit_type_list)))
                               AND (i_ccy_type IS NULL OR lt.CCY_TYPE = i_ccy_type)
                               AND (NOT EXISTS(SELECT * FROM TABLE (i_data_convert_source_list)) OR ad.DATA_CONVERT_SOURCE IN (SELECT * FROM TABLE (i_data_convert_source_list)))
                             GROUP BY cl.CUSTOMER_LOAN_SEQ_NO, cl.CUST_TYPE, ad.APPR_DOC_SEQ_NO, ad.APPR_DOC_NO, ad.PHASE, ad.MATU_DATE, ad.OPER_BRANCH, ad.PROFIT_BRANCH, lt.LIMIT_SEQ_NO, lt.LIMIT_TYPE, lt.BUSINESS_TYPE, lt.CURRENCY, lt.APPRD_SUB_LIMIT_AMT, lt.LIMIT_DRAWDOWN_TYPE, ltp.LIMIT_PROFILE_SEQ_NO, ltp.LOAN_SUBCATEGORY, ltp.CREDIT_LOAN_PROD_CODE, ltp.COLLATERAL_TYPE, fn.FOREIGN_SEQ_NO, fn.REF_NO, fn.PHASE, fn.LAST_TXN_DATE, fn.INTST_SDATE, fn.MATU_DATE, fn.ACC_BRANCH, fn.CG_PENCENT
                             ORDER BY fn.REF_NO),
           TOTAL_COUNT AS (SELECT COUNT(1) TOTAL_COUNT FROM TOTAL_RESULT),
           TARGET AS (SELECT * FROM TOTAL_RESULT ORDER BY REF_NO OFFSET i_start ROWS FETCH NEXT i_end - i_start ROWS ONLY)
      SELECT TARGET.*, TOTAL_COUNT.TOTAL_COUNT FROM TOTAL_COUNT LEFT JOIN TARGET ON TOTAL_COUNT.TOTAL_COUNT = TOTAL_COUNT.TOTAL_COUNT;
  END SP_GET_FOREIGN_CONSOLIDATED;

-- **************************************************
-- SP_GET_MAIN_LOAN_CONSOLIDATED
-- Purpose: 查詢Mail Loan相關帳號資訊
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB18757         2020.04.07  Create
-- **************************************************
  PROCEDURE SP_GET_MAIN_LOAN_CONSOLIDATED
  ( i_customer_id IN VARCHAR2                  -- 銀行歸戶統編
  , i_account_no IN VARCHAR2                   -- 帳號
  , i_account_status_list IN ITEM_ARRAY        -- 帳號狀態
  , i_exclude_closed IN VARCHAR2               -- 未結清
  , i_exclude_chg_category IN VARCHAR2         -- 排除科目變更
  , i_loan_status_update_date IN VARCHAR2      -- 帳號狀態更新日
  , i_ccy_type IN VARCHAR2                     -- 幣別種類
  , i_paid_fire_insurance_query_mk IN VARCHAR2 -- 墊付火險保費查詢註記
  , i_credit_effective_mk IN VARCHAR2          -- 信保有效註記
  , i_is_guaranteed IN VARCHAR2                -- 有無擔保註記
  , i_hide_expired_info IN VARCHAR2            -- 不顯示過期資訊
  , i_exclude_cg_mark IN VARCHAR2              -- 排除信保有擔註記
  , i_sell_debit_mark IN VARCHAR2              -- 出售債權註記
  , i_loan_credit_mark_list IN ITEM_ARRAY      -- 授信債權註記
  , i_under_branch IN VARCHAR2                 -- 交易分行
  , i_appr_doc_no IN VARCHAR2                  -- 批覆書編號
  , i_data_convert_source_list IN ITEM_ARRAY   -- 批覆書資料轉換來源
  , i_limit_type_list IN ITEM_ARRAY            -- 額度種類
  , i_business_type_list IN ITEM_ARRAY         -- 業務類別
  , i_operation_branch IN VARCHAR2             -- 作業分行
  , i_project_code_list IN ITEM_ARRAY          -- 專案屬性註記
  , i_cur_biz_day IN VARCHAR2                  -- 現在交易日
  , i_start IN NUMBER                          -- 起始筆數
  , i_end IN NUMBER                            -- 結束筆數
  , o_cur OUT SYS_REFCURSOR                    -- 回傳資料
  ) AS
  BEGIN
    OPEN o_cur FOR
      WITH TOTAL_RESULT AS(SELECT cl.CUSTOMER_LOAN_SEQ_NO
                                , cl.CUST_TYPE
                                , ml.LOAN_NO
                                , ml.APPR_DOC_NO
                                , ml.LIMIT_TYPE
                                , ml.PHASE
                                , ml.UPD_DATE
                                , ml.START_DATE
                                , ml.MATU_DATE
                                , ml.FIRST_LOAN_AMT
                                , ml.BASE_RATE_TYPE
                                , ml.INNER_LAW_AMT
                                , ml.INNER_PRNP
                                , ml.INNER_IR
                                , ml.OUT_LAW_AMT
                                , ml.OUT_OFFSET_PENALTY
                                , ml.IR_AMT
                                , ml.OUT_OFFSET_INTST
                                , ml.LOAN_BALANCE
                                , ml.LOAN_CLAIM_MK
                                , ml.LOAN_CLAIM_EFFEC_DATE
                             FROM EDLS.TB_CUSTOMER_LOAN cl
                            INNER JOIN EDLS.TB_MAIL_LOAN ml
                               ON cl.CUSTOMER_LOAN_SEQ_NO = ml.CUSTOMER_LOAN_SEQ_NO
                            INNER JOIN EDLS.TB_ACC_USED au
                               ON ml.LOAN_NO = au.ACC
                            WHERE cl.CUST_ID = i_customer_id
                              AND (i_account_no IS NULL OR ml.LOAN_NO = i_account_no)
                              AND (NOT EXISTS(SELECT * FROM TABLE (i_account_status_list)) OR ml.PHASE IN (SELECT * FROM TABLE (i_account_status_list)))
                              AND (i_exclude_closed IS NULL OR ml.PHASE IN ('3', '4', '7', '8'))
                              AND (i_exclude_chg_category IS NULL OR (ml.TRANS_ACC_MK != '1'))
                              AND (i_loan_status_update_date IS NULL OR ml.UPD_DATE >= i_loan_status_update_date)
                              AND (NOT EXISTS(SELECT * FROM TABLE (i_loan_credit_mark_list)) OR ml.LOAN_CLAIM_MK IN (SELECT * FROM TABLE (i_loan_credit_mark_list)))
                              AND (i_hide_expired_info != 'Y' OR i_hide_expired_info IS NULL OR ml.MATU_DATE >= i_cur_biz_day)
                            GROUP BY cl.CUSTOMER_LOAN_SEQ_NO, cl.CUST_TYPE, ml.LOAN_NO, ml.APPR_DOC_NO, ml.LIMIT_TYPE, ml.PHASE, ml.UPD_DATE, ml.START_DATE, ml.MATU_DATE, ml.FIRST_LOAN_AMT, ml.BASE_RATE_TYPE, ml.INNER_LAW_AMT, ml.INNER_PRNP, ml.INNER_IR, ml.OUT_LAW_AMT, ml.OUT_OFFSET_PENALTY, ml.IR_AMT, ml.OUT_OFFSET_INTST, ml.LOAN_BALANCE, ml.LOAN_CLAIM_MK, ml.LOAN_CLAIM_EFFEC_DATE
                            ORDER BY ml.LOAN_NO),
           TOTAL_COUNT AS (SELECT COUNT(1) TOTAL_COUNT FROM TOTAL_RESULT),
           TARGET AS (SELECT * FROM TOTAL_RESULT ORDER BY LOAN_NO OFFSET i_start ROWS FETCH NEXT i_end - i_start ROWS ONLY)
      SELECT TARGET.*, TOTAL_COUNT.TOTAL_COUNT FROM TOTAL_COUNT LEFT JOIN TARGET ON TOTAL_COUNT.TOTAL_COUNT = TOTAL_COUNT.TOTAL_COUNT;
  END SP_GET_MAIN_LOAN_CONSOLIDATED;

  -- **************************************************
-- SP_GET_CUST_ID_BY_VIRTUAL_ACC
-- Purpose: 虛擬帳號查詢顧客統編
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB19408         2021.10.04  Create
-- ESB19408			2022.01.18	修改篩選邏輯
-- **************************************************
  PROCEDURE SP_GET_CUST_ID_BY_VIRTUAL_ACC
  ( i_virtual_acc IN VARCHAR2                  	 -- 銀行歸戶統編
	, o_cur OUT SYS_REFCURSOR                    -- 回傳資料
  )AS
  BEGIN
	OPEN o_cur FOR
		SELECT LOAN_NO
			 , CUST_ID
		FROM
			(SELECT ln.LOAN_NO
				  , cl.CUST_ID
			FROM EDLS.TB_LOAN_VIRTUAL_ACC_PAYMT lv
				INNER JOIN EDLS.TB_LOAN ln ON lv.LOAN_SEQ_NO = ln.LOAN_SEQ_NO
				INNER JOIN EDLS.TB_CUSTOMER_LOAN cl ON ln.CUSTOMER_LOAN_SEQ_NO = cl.CUSTOMER_LOAN_SEQ_NO
			WHERE lv.VIRTUAL_ACC_NO = i_virtual_acc
			ORDER BY lv.REG_DATE desc, lv.REG_TIME desc)
		WHERE ROWNUM = 1
		UNION
		SELECT LOAN_NO
			 , CUST_ID
		FROM
			(SELECT ln.LOAN_NO
				  , cl.CUST_ID 
			FROM EDLS.TB_VIRTUAL_ACC_PAYMT va
				INNER JOIN EDLS.TB_LOAN ln ON va.LOAN_SEQ_NO = ln.LOAN_SEQ_NO
				INNER JOIN EDLS.TB_CUSTOMER_LOAN cl ON ln.CUSTOMER_LOAN_SEQ_NO = cl.CUSTOMER_LOAN_SEQ_NO
			WHERE va.VIRTUAL_ACC = i_virtual_acc
			ORDER BY ln.LOAN_SDATE desc)
		WHERE ROWNUM = 1
		FETCH FIRST 1 ROW ONLY
		;
  END SP_GET_CUST_ID_BY_VIRTUAL_ACC;

-- **************************************************
-- SP_UPD_LAST_TXN_DATE
-- Purpose: 更新授信戶主檔(上次交易日)
-- 
-- Person           Date        Comments
-- ---------------  ----------  --------------------
-- ESB20568         2020.06.24  Create
-- **************************************************
  PROCEDURE  SP_UPD_LAST_TXN_DATE
  ( i_customer_loan_seq_no  IN NUMBER    -- 授信戶主檔序號
   ,i_last_txn_date  IN VARCHAR2         -- 上次交易日
   )AS
  BEGIN
    UPDATE EDLS.TB_CUSTOMER_LOAN
       SET LAST_TXN_DATE = i_last_txn_date
         , AMEND_DATE = SYSTIMESTAMP
     WHERE CUSTOMER_LOAN_SEQ_NO = i_customer_loan_seq_no;
  END SP_UPD_LAST_TXN_DATE;

END PG_CUST_LOAN;