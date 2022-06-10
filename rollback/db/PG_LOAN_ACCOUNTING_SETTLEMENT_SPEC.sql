CREATE OR REPLACE PACKAGE "EDLS"."PG_LOAN_ACCOUNTING_SETTLEMENT" AS

--**************************************************************************
-- 870 SP_GET_LOAN_CIF_ACCOUNTING
-- Purpose: 1   查詢授信戶列銷帳主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.19  created
--
--**************************************************************************
  PROCEDURE SP_GET_LOAN_CIF_ACCOUNTING
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , i_acc_branch           IN VARCHAR2       -- 設帳分行
  , i_acc_category         IN VARCHAR2       -- 設帳科目
  , i_ccy                  IN VARCHAR2       -- 幣別
  , i_type                 IN VARCHAR2       -- 種類
  , i_fee_code             IN VARCHAR2       -- 費用代碼
  , i_amt                  IN NUMBER         -- 金額
  , o_cur                  OUT SYS_REFCURSOR -- o_cur
  );

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
  ( i_cif_accounting_seq_no IN NUMBER   -- 授信戶列帳主檔序號
  , i_customer_loan_seq_no  IN NUMBER   -- 授信戶主檔序號
  , i_acc_branch            IN VARCHAR2 -- 設帳分行
  , i_acc_category          IN VARCHAR2 -- 設帳科目
  , i_ccy                   IN VARCHAR2 -- 幣別
  , i_type                  IN VARCHAR2 -- 種類
  , i_fee_code              IN VARCHAR2 -- 費用代碼
  , i_amt                   IN NUMBER   -- 金額
  , o_row_count             OUT NUMBER  -- o_row_count
  );
 
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
  ( i_customer_loan_seq_no  IN NUMBER   -- 授信戶主檔序號
  , i_acc_branch            IN VARCHAR2 -- 設帳分行
  , i_acc_category          IN VARCHAR2 -- 設帳科目
  , i_ccy                   IN VARCHAR2 -- 幣別
  , i_type                  IN VARCHAR2 -- 種類
  , i_fee_code              IN VARCHAR2 -- 費用代碼
  , i_amt                   IN NUMBER   -- 金額
  , o_cur                   OUT NUMBER  -- O_SEQ_NO
  );

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
  );

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
  ( i_customer_loan_seq_no IN NUMBER   -- 授信戶主檔序號
  , i_txn_date             IN VARCHAR2 -- 交易日期
  , o_cur                  OUT NUMBER  -- 當日最大的交易日期序號
  );

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
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , i_txn_date             IN VARCHAR2       -- 交易日期
  , i_host_sno             IN VARCHAR2       -- 主機交易序號
  , o_cur                  OUT SYS_REFCURSOR -- 授信戶列銷帳交易明細
  );

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
  ( i_each_settlement_seq_no IN NUMBER   -- 列帳明細檔序號
  , i_loan_accounting_seq_no IN NUMBER   -- 列帳主檔序號
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
  , o_row_count              OUT NUMBER  -- 授信戶列銷帳交易明細
  );
  
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
  ( i_customer_loan_seq_no IN NUMBER   -- 授信戶主檔序號
  , i_acc_branch           IN VARCHAR2 -- 設帳分行
  , i_ccy                  IN VARCHAR2 -- 幣別
  , i_type                 IN VARCHAR2 -- 種類
  , i_fee_code             IN VARCHAR2 -- 費用代碼
  , o_row_count            OUT NUMBER  -- 各交易明細資料筆數
  ); 

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
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , i_acc_branch           IN VARCHAR2       -- 設帳分行
  , i_ccy                  IN VARCHAR2       -- 幣別
  , i_type                 IN VARCHAR2       -- 種類
  , i_fee_code             IN VARCHAR2       -- 費用代碼
  , i_begin_idx            IN NUMBER         -- oracle offset 筆數
  , i_count                IN NUMBER         -- oracle fetch next 筆數
  , o_cur                  OUT SYS_REFCURSOR -- o_cur
  ); 
  
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
  ( i_accounting_no        IN VARCHAR2 -- 列帳主檔鍵值
  , i_customer_loan_seq_no IN NUMBER   -- 授信戶主檔序號
  , i_acc_branch           IN VARCHAR2 -- 設帳分行
  , i_acc_category         IN VARCHAR2 -- 設帳科目
  , i_ccy                  IN VARCHAR2 -- 幣別
  , i_txn_branch           IN VARCHAR2 -- 交易分行
  , i_accounting_date      IN VARCHAR2 -- 列帳日期
  , i_accounting_amt       IN NUMBER   -- 列帳金額
  , i_settlement_amt       IN NUMBER   -- 銷帳金額
  , i_cust_center_branch   IN VARCHAR2 -- 顧客所屬企金中心
  , i_acc_center_branch    IN VARCHAR2 -- 帳號所屬中心
  , i_invoice_no           IN VARCHAR2 -- 發票號碼
  , i_loan_no              IN VARCHAR2 -- 放款帳號
  , i_paymt_type           IN VARCHAR2 -- 還款種類
  , i_dw_source            IN VARCHAR2 -- 扣款來源
  , i_from_acct_no         IN VARCHAR2 -- 轉出帳號
  , i_tel_no               IN VARCHAR2 -- 電話
  , i_host_sno             IN VARCHAR2 -- 主機交易序號
  , i_remark               IN VARCHAR2 -- 備註
  , i_fee_code             IN VARCHAR2 -- 費用代碼  
  , i_ref_no               IN VARCHAR2 -- REF_NO
  , i_accounting_serial_no IN NUMBER   -- 列帳序號    
  , o_cur                  OUT NUMBER  -- O_SEQ_NO
  );
 
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
  ( i_loan_accounting_seq_no IN NUMBER         -- 列帳主檔序號
  , o_cur                    OUT SYS_REFCURSOR -- O_SEQ_NO
  );

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
  ( i_loan_accounting_seq_no IN  NUMBER -- 列帳主檔序號
  , o_row_count              OUT NUMBER -- o_row_count
  );

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
  );

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
  PROCEDURE  SP_UPD_LOAN_EACH_ACCOUNTING 
  ( i_loan_accounting_seq_no IN NUMBER   -- 列帳主檔序號
  , i_accounting_no          IN VARCHAR2 -- 列帳主檔鍵值
  , i_customer_loan_seq_no   IN NUMBER   -- 授信戶主檔序號
  , i_acc_branch             IN VARCHAR2 -- 設帳分行
  , i_acc_category           IN VARCHAR2 -- 設帳科目
  , i_ccy                    IN VARCHAR2 -- 幣別
  , i_fee_code               IN VARCHAR2 -- 費用代碼     
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
  , i_ref_no                 IN VARCHAR2 -- REF_NO
  , i_accounting_serial_no   IN NUMBER   -- 列帳序號 
  , o_row_count              OUT NUMBER  -- o_row_count
  );

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
  PROCEDURE  SP_GET_MAX_CIFSETTLEMENTSEQNO 
  ( i_customer_loan_seq_no IN NUMBER   -- 授信戶主檔序號
  , i_txn_date             IN VARCHAR2 -- 交易日期
  , o_cur                  OUT NUMBER  -- 當日最大的交易日期序號
  );

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
  ( i_customer_loan_seq_no IN NUMBER   -- 授信戶主檔序號
  , i_txn_date             IN NUMBER   -- 交易日期
  , i_txn_date_sno         IN VARCHAR2 -- 交易日期序號
  , i_txn_time             IN VARCHAR2 -- 交易時間
  , i_txn_branch           IN VARCHAR2 -- 交易分行
  , i_txn_id               IN VARCHAR2 -- 交易代碼
  , i_txn_type             IN VARCHAR2 -- 交易分類
  , i_txn_memo             IN VARCHAR2 -- 交易摘要
  , i_sup_emp_id           IN VARCHAR2 -- 授權主管員編
  , i_teller_emp_id        IN VARCHAR2 -- 執行櫃員員編
  , i_sup_card             IN VARCHAR2 -- 授權主管卡號
  , i_dc_code              IN VARCHAR2 -- 借貸別
  , i_acc_branch           IN VARCHAR2 -- 設帳分行
  , i_acc_category         IN VARCHAR2 -- 設帳科目
  , i_fee_code             IN VARCHAR2 -- 費用代碼
  , i_ccy                  IN VARCHAR2 -- 幣別
  , i_txn_amt              IN NUMBER   -- 交易金額
  , i_ec_mk                IN VARCHAR2 -- 是否為沖正交易
  , i_host_sno             IN VARCHAR2 -- 主機交易序號
  , i_memo                 IN VARCHAR2 -- 全形摘要
  , i_appr_doc_no          IN VARCHAR2 -- 批覆書編號
  , i_type                 IN VARCHAR2 -- 種類
  , i_loan_no              IN VARCHAR2 -- 放款帳號
  , i_eval_company_code    IN VARCHAR2 -- 鑑估機構
  , i_eval_no              IN VARCHAR2 -- 鑑估編號
  , i_action_code          IN VARCHAR2 -- 執行動作
  , i_exec_tell            IN VARCHAR2 -- 執行櫃員代碼
  , i_draft_pay_bank       IN VARCHAR2 -- 票據付款行
  , i_draft_no             IN VARCHAR2 -- 票據號碼
  , i_coll_cr_acc_no       IN VARCHAR2 -- 託收存入帳號
  , i_boun_cheq_mk         IN VARCHAR2 -- 退票註記
  , i_info_asset_no        IN VARCHAR2 -- 資訊資產代號
  , i_fahgu_id             IN VARCHAR2 -- 全域流水號
  , i_action_type          IN VARCHAR2 -- 執行類別
  , i_draft_mk             IN VARCHAR2 -- 票據註記
  , o_seq_no               OUT NUMBER  --  o_seq_no
  );

--**************************************************************************
-- 1172 SP_GET_LOAN_CIF_ACC_ALL_REC
-- Purpose: 以銀行歸戶統編、設帳分行、幣別、種類、費用代碼查詢授信戶列銷帳主檔全部的資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.20  created
--
--**************************************************************************
  PROCEDURE SP_GET_LOAN_CIF_ACC_ALL_REC
  ( i_cust_id              IN VARCHAR2       -- 銀行歸戶統編
  , i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號    
  , i_acc_branch           IN VARCHAR2       -- 設帳分行
  , i_ccy                  IN VARCHAR2       -- 幣別
  , i_type                 IN VARCHAR2       -- 種類
  , i_fee_code             IN VARCHAR2       -- 費用代碼
  , o_cur                  OUT SYS_REFCURSOR -- o_cur
  );

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
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , i_acc_branch           IN VARCHAR2       -- 設帳分行
  , i_ccy                  IN VARCHAR2       -- 幣別
  , i_type                 IN VARCHAR2       -- 種類
  , i_fee_code             IN VARCHAR2       -- 費用代碼
  , i_begin_idx            IN NUMBER         -- oracle offset 筆數
  , i_count                IN NUMBER         -- oracle fetch next 筆數
  , o_cur                  OUT SYS_REFCURSOR --o_cur
  );

--**************************************************************************
-- 1243 SP_GET_LAW_AMOUNT_TXN_DETAIL
-- Purpose: 訴訟代墊款交易明細查詢
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.21  created
--
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
  ); 

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
  ( i_customer_loan_seq_no IN NUMBER   -- 授信戶主檔序號
  , i_acc_category         IN VARCHAR2 -- 設帳科目
  , i_accounting_date      IN VARCHAR2 -- 現在交易日
  , o_row_count            OUT NUMBER  -- o_row_count
  );
 
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
  ( i_acccounting_seq_no IN NUMBER  -- 列帳主檔序號
  , o_row_count          OUT NUMBER -- 銷帳明細序號最大號
  );

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
  );

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
  ( i_customer_loan_seq_no IN NUMBER          -- 授信戶主檔序號
  , i_acc_branch           IN VARCHAR2        -- 設帳分行
  , i_acc_category         IN VARCHAR2        -- 設帳科目
  , i_ccy                  IN VARCHAR2        -- 幣別
  , i_type                 IN VARCHAR2        -- 種類
  , i_fee_code             IN VARCHAR2        -- 費用代碼
  , i_amt                  IN NUMBER          -- 金額
  , o_cur                  OUT SYS_REFCURSOR  -- o_cur
  );

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
  ( i_each_settlement_seq_no IN NUMBER          -- 列帳明細檔序號
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
  );

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
  ( i_cust_id              IN  VARCHAR2      -- 銀行歸戶統編
  , i_acc_branch           IN  VARCHAR2      -- 設帳分行
  , i_acc_category         IN  VARCHAR2      -- 設帳科目
  , i_ccy                  IN  VARCHAR2      -- 幣別
  , i_fee_code             IN  VARCHAR2      -- 費用代碼
  , i_start_date           IN  VARCHAR2      -- 查詢起日
  , i_end_date             IN  VARCHAR2      -- 查詢訖日
  , O_CUR                  OUT SYS_REFCURSOR -- o_cur
  );

--**************************************************************************
-- 1402  SP_GET_CIF_ACC_TXN_DTL
-- Purpose: 查詢授信戶列銷帳交易明細
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.20  created
--
--**************************************************************************
  PROCEDURE  SP_GET_CIF_ACC_TXN_DTL
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , i_acc_branch           IN VARCHAR2       -- 設帳分行
  , i_fee_code             IN VARCHAR2       -- 費用代碼
  , i_ccy                  IN VARCHAR2       -- 幣別
  , i_type                 IN VARCHAR2       -- 種類
  , i_enquiryStartDate     IN VARCHAR2       -- 查詢起日
  , i_enquiryEndDate       IN VARCHAR2       -- 查詢訖日
  , o_cur                  OUT SYS_REFCURSOR -- o_cur
  );

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
  PROCEDURE  SP_GET_CIF_SET_BY_CUST_ID
  ( i_cust_id  IN VARCHAR2       -- 銀行歸戶統編
  , i_txn_date IN VARCHAR2       -- 交易日期
  , i_host_sno IN VARCHAR2       -- 主機交易序號
  , i_ec_mk    IN VARCHAR2       -- 沖正交易註記
  , o_cur      OUT SYS_REFCURSOR -- o_cur
  ); 
  
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
  PROCEDURE  SP_GET_LOAN_CIF_ACC_TOTAL_AMT
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , i_acc_branch           IN VARCHAR2       -- 設帳分行
  , i_ccy                  IN VARCHAR2       -- 幣別
  , i_type                 IN VARCHAR2       -- 種類
  , i_fee_code             IN VARCHAR2       -- 費用代碼
  , o_cur                  OUT SYS_REFCURSOR -- o_cur
  ); 
  
--**************************************************************************
-- 1414 SP_GET_LOAN_CIF_SET_TXN_DTL
-- Purpose: 授信戶列銷帳交易明細查詢
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.02.20  created
--
--**************************************************************************
  PROCEDURE SP_GET_LOAN_CIF_SET_TXN_DTL
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , i_acc_branch           IN VARCHAR2       -- 設帳分行
  , i_fee_code             IN VARCHAR2       -- 費用代碼
  , i_ccy                  IN VARCHAR2       -- 幣別
  , i_type                 IN VARCHAR2       -- 種類
  , i_start_date           IN VARCHAR2       -- 查詢起日
  , i_end_date             IN VARCHAR2       -- 查詢訖日
  , o_cur                  OUT SYS_REFCURSOR -- o_cur
  ); 

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
  ( i_cif_settlement_seq_no IN NUMBER     -- 授信戶列銷帳交易明細序號
  , i_customer_loan_seq_no  IN NUMBER     -- 授信戶主檔序號
  , i_txn_date              IN NUMBER     -- 交易日期
  , i_txn_date_sno          IN VARCHAR2   -- 交易日期序號
  , i_txn_time              IN VARCHAR2   -- 交易時間
  , i_txn_branch            IN VARCHAR2   -- 交易分行
  , i_txn_id                IN VARCHAR2   -- 交易代碼
  , i_txn_type              IN VARCHAR2   -- 交易分類
  , i_txn_memo              IN VARCHAR2   -- 交易摘要
  , i_sup_emp_id            IN VARCHAR2   -- 授權主管員編
  , i_teller_emp_id         IN VARCHAR2   -- 執行櫃員員編
  , i_sup_card              IN VARCHAR2   -- 授權主管卡號
  , i_dc_code               IN VARCHAR2   -- 借貸別
  , i_acc_branch            IN VARCHAR2   -- 設帳分行
  , i_acc_category          IN VARCHAR2   -- 設帳科目
  , i_fee_code              IN VARCHAR2   -- 費用代碼
  , i_ccy                   IN VARCHAR2   -- 幣別
  , i_txn_amt               IN NUMBER     -- 交易金額
  , i_ec_mk                 IN VARCHAR2   -- 是否為沖正交易
  , i_host_sno              IN VARCHAR2   -- 主機交易序號
  , i_memo                  IN VARCHAR2   -- 全形摘要
  , i_appr_doc_no           IN VARCHAR2   -- 批覆書編號
  , i_type                  IN VARCHAR2   -- 種類
  , i_loan_no               IN VARCHAR2   -- 放款帳號
  , i_eval_company_code     IN VARCHAR2   -- 鑑估機構
  , i_eval_no               IN VARCHAR2   -- 鑑估編號
  , i_action_code           IN VARCHAR2   -- 執行動作
  , i_exec_tell             IN VARCHAR2   -- 執行櫃員代碼
  , i_draft_pay_bank        IN VARCHAR2   -- 票據付款行
  , i_draft_no              IN VARCHAR2   -- 票據號碼
  , i_coll_cr_acc_no        IN VARCHAR2   -- 託收存入帳號
  , i_boun_cheq_mk          IN VARCHAR2   -- 退票註記
  , i_info_asset_no         IN VARCHAR2   -- 資訊資產代號 
  , i_fahgu_id              IN VARCHAR2   -- 全域流水號
  , o_row_count             OUT NUMBER    -- o_row_count
  );

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
  ( i_customer_loan_seq_no IN NUMBER          -- 授信戶主檔序號
  , i_acc_branch           IN VARCHAR2        -- 設帳分行
  , i_ccy                  IN VARCHAR2        -- 幣別
  , i_type                 IN VARCHAR2        -- 種類
  , i_fee_code             IN VARCHAR2        -- 費用代碼
  , o_cur                  OUT SYS_REFCURSOR  -- o_cur
  );

--**************************************************************************
-- 1674 SP_GET_EACH_ACC_BY_STATUS
-- Purpose: 列帳主檔資料查詢
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.03.21  created
-- 1.2 康晉維     2019.12.16  modified
--**************************************************************************
  PROCEDURE SP_GET_EACH_ACC_BY_STATUS
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , i_txn_branch           IN VARCHAR2       -- 設帳分行
  , i_ccy                  IN VARCHAR2       -- 幣別
  , i_fee_code             IN VARCHAR2       -- 費用代碼
  , i_status               IN VARCHAR2       -- 狀態
  , i_start_date           IN  VARCHAR2      -- 查詢起日
  , i_end_date             IN  VARCHAR2      -- 查詢訖日
  , o_cur                  OUT SYS_REFCURSOR -- o_cur
  );

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
  );

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
  (  i_customer_loan_seq_no   IN NUMBER   -- 授信戶主檔序號
   , i_txn_date               IN VARCHAR2 -- 交易日期
   , o_cur                    OUT NUMBER  -- o_cur
  );
  
--**************************************************************************
-- SP_GET_EACH_ACC_BY_ACCNO
-- Purpose: 以列帳主檔建值查詢【列帳主檔】
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0  葉庭宇    2019.07.29  created
-- 1.1  林萬哲    2021.06.23  deprecated
--**************************************************************************
  PROCEDURE SP_GET_EACH_ACC_BY_ACCNO
  (  i_accounting_no   IN VARCHAR2   -- 列帳主檔鍵值
   , o_cur             OUT SYS_REFCURSOR    -- o_cur
  );

--**************************************************************************
-- SP_GET_EACH_ACC_BY_ACCNO
-- Purpose: 以列帳主檔建值、設帳分行查詢【列帳主檔】
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0  謝宇倫    2020.09.02  created
-- 1.1  林萬哲    2021.06.23  deprecated
--**************************************************************************
  PROCEDURE SP_GET_EACH_ACC_BY_ACCNO
  (  i_accounting_no   IN VARCHAR2   -- 列帳主檔鍵值
   , i_acc_branch	   IN VARCHAR2   -- 設帳分行
   , o_cur             OUT SYS_REFCURSOR    -- o_cur
  );
  
--**************************************************************************
-- SP_GET_EACH_ACC_BY_ACCNO
-- Purpose: 以顧客主檔序號、列帳主檔鍵值、設帳分行查詢【列帳主檔】
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0  林萬哲    2021.06.23  created
--**************************************************************************
  PROCEDURE SP_GET_EACH_ACC_BY_ACCNO
  (  i_customer_loan_seq_no IN VARCHAR2         -- 授信戶主檔序號
   , i_accounting_no        IN VARCHAR2         -- 列帳主檔鍵值
   , i_acc_branch	        IN VARCHAR2         -- 設帳分行
   , o_cur                  OUT SYS_REFCURSOR   -- o_cur
  );
  
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
  );
  
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
  );

END PG_LOAN_ACCOUNTING_SETTLEMENT;