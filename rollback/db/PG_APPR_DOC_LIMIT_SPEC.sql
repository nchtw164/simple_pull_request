CREATE OR REPLACE PACKAGE "EDLS"."PG_APPR_DOC_LIMIT" AS
 
 --**************************************************************************
-- SP_UPD_APPR_DOC
-- Purpose: 更新批覆書主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
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
  );

 --**************************************************************************
-- SP_GET_APPR_DOC_LIST
-- Purpose: 查詢批覆書主檔列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_APPR_DOC_LIST
  ( i_cust_id      IN VARCHAR2       -- 銀行歸戶統編
  , i_appr_doc_no  IN VARCHAR2       -- 批覆書編號
  , i_phase_marker IN VARCHAR2       -- 批覆書狀態註記
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料 
  );

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
  );

--**************************************************************************
-- SP_GET_LIMIT_LIST
-- Purpose: 查詢分項額度主檔與分項批示條件設定檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_GET_LIMIT_LIST
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , i_limit_type      IN VARCHAR2       -- 額度種類
  , i_serial_no       IN VARCHAR2       -- 序號
  , i_ccy_type        IN VARCHAR2       -- 幣別種類
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_LIMIT_PROJ_COND_PROF
-- Purpose: 查詢分項額度下的所有專案屬性註記
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_PROJ_COND_PROF
  ( i_limit_seq_no IN VARCHAR2       -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_LIMIT_BOOKING_LIST
-- Purpose: 查詢分項額度下所有預佔額度資訊列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BOOKING_LIST
  ( i_limit_seq_no        IN NUMBER         -- 分項額度主檔序號
  , i_serial_no           IN VARCHAR2       -- 預佔序號
  , i_book_amount_marker  IN VARCHAR2       -- 預佔額度註記
  , i_proj_condition_list IN VARCHAR2       -- 專案屬性註記
  , i_business_type_list  IN VARCHAR2       -- 業務類別
  , o_cur                 OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_LIMIT_BOOK_LIST_BY_LT
-- Purpose: 查詢分項額度下所有預佔額度資訊列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 謝宇倫     2019.09.10  created
--
--**************************************************************************
 PROCEDURE SP_GET_LIMIT_BOOK_LIST_BY_LT
  ( i_limit_seq_no        IN NUMBER         -- 分項額度主檔序號
  , o_cur                 OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_INS_LIMIT_BOOKING
-- Purpose: 新增預佔額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
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
  );

--**************************************************************************
-- SP_UPD_LIMIT_BOOKING
-- Purpose: 更新預佔額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_UPD_LIMIT_BOOKING
  ( i_limit_booking_seq_no             IN NUMBER   -- 預佔額度檔序號
  , i_limit_seq_no                     IN NUMBER   -- 分項額度主檔序號
  , i_ccy                              IN VARCHAR2 -- 幣別
  , i_serial_no                        IN VARCHAR2 -- 預佔序號
  , i_last_txn_date                    IN VARCHAR2 -- 上次交易日
  , i_total_drawdown_amt               IN NUMBER   -- 預佔累積動用金額
  , i_total_today_repaymt_amt          IN NUMBER   -- 當日累積還款金額
  , i_drawdown_branch                  IN VARCHAR2 -- 動用分行
  , i_total_drawdown_appr_doc_amt      IN NUMBER   -- 預佔佔用批覆書額度累積金額
  , i_intst_sdate                      IN VARCHAR2 -- 放款起息日
  , i_matu_date                        IN VARCHAR2 -- 放款到期日
  , i_is_book                          IN VARCHAR2 -- 預佔註記
  , i_teller_emp_id                    IN VARCHAR2 -- 經辦員編
  , i_sup_emp_id                       IN VARCHAR2 -- 主管員編
  , i_host_sno                         IN VARCHAR2 -- 主機交易序號
  , i_txn_time                         IN VARCHAR2 -- 交易時間
  , o_row_count                        OUT NUMBER  -- 回傳更新筆數
  );

--**************************************************************************
-- SP_GET_LIMIT_BOOKING
-- Purpose: 查詢特定的預佔額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BOOKING
  ( i_cust_id     IN VARCHAR2       -- 銀行歸戶統編
  , i_appr_doc_no IN VARCHAR2       -- 批覆書編號
  , i_limit_type  IN VARCHAR2       -- 額度種類
  , i_currency    IN VARCHAR2       -- 幣別
  , i_serial_no   IN VARCHAR2       -- 序號
  , o_cur         OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_DEL_LIMIT_BOOKING
-- Purpose: 刪除特定的預佔額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_BOOKING
  ( i_limit_booking_seq_no IN VARCHAR2 -- 預佔額度檔序號
  , o_row_count            OUT NUMBER  -- 回傳筆數
  );

--**************************************************************************
-- SP_GET_OVERDRAFT_LIST
-- Purpose: 查詢分項額度透支資訊檔列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_OVERDRAFT_LIST
  ( i_limit_seq_no      IN NUMBER         -- 分項額度主檔序號
  , i_ccy               IN VARCHAR2       -- 幣別
  , i_overdraft_account IN NUMBER         -- 帳號序號
  , i_acc_type          IN VARCHAR2       -- 帳號類別
  , o_cur               OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_UPD_OVERDRAFT
-- Purpose: 
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
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
  );

--**************************************************************************
-- SP_UPD_LIMIT
-- Purpose: 
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  --TOTAL_NEGO_AMT, TOTAL_APPR_DOC_DRAWDOWN_AMT, TOTAL_REPAYMT_AMT,TOTAL_DRAWDOWN_AMT --DB已刪除 沒記錄 Modified 2019.03.05
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
  );

--**************************************************************************
-- SP_INS_LIMIT_DTL
-- Purpose: 新增分項額度彙計檔資訊 
--          刪除會計科目(ERD調整_20190327)
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
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
  );

 --**************************************************************************
-- SP_INS_OVERDRAFT
-- Purpose: 
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_INS_OVERDRAFT
  ( i_limit_seq_no           IN NUMBER    -- 分項額度主檔序號
  , i_acc_type               IN VARCHAR2  -- 帳號類別
  , i_acc_no                 IN NUMBER    -- 帳號序號
  , i_ccy                    IN VARCHAR2  -- 幣別
  , i_overdraft_balance_amt  IN NUMBER    -- 透支餘額
  , i_account_status         IN VARCHAR2  -- 帳號狀態
  , o_overdraft_seq_no       OUT NUMBER   -- 分項額度透支資訊檔序號
  );

--**************************************************************************
-- SP_GET_LIMIT_COMBINED_P
-- Purpose: 查詢組合額度主檔與組合額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_COMBINED_P
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號 
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_INS_LIMIT_COMBINED
-- Purpose: 新增組合額度主檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_INS_LIMIT_COMBINED
  ( i_appr_doc_seq_no       IN NUMBER   -- 批覆書主檔序號
  , i_no                    IN VARCHAR2 -- 組合額度編號
  , i_ccy                   IN VARCHAR2 -- 組合額度幣別
  , i_amt                   IN NUMBER   -- 組合額度金額
  , o_limit_combined_seq_no OUT NUMBER  -- 組合額度主檔序號
  );

--**************************************************************************
-- SP_DEL_LIMIT_COMBINED
-- Purpose: 刪除組合額度主檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_COMBINED
  ( i_limit_combined_seq_no IN NUMBER  -- 組合額度主檔序號
  , o_row_count             OUT NUMBER -- 回傳筆數
  );

--**************************************************************************
-- SP_DEL_LIMIT_COMBINED_PROFILE
-- Purpose: 刪除組合額度設定檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_DEL_LIMIT_COMBINED_PROFILE
  ( i_limit_combined_seq_no IN NUMBER  -- 組合額度主檔序號
  , o_row_count             OUT NUMBER -- 回傳筆數
  );

--**************************************************************************
-- SP_INS_LIMIT_COMBINED_PROFILE
-- Purpose: 新增組合額度設定檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
 PROCEDURE SP_INS_LIMIT_COMBINED_PROFILE
  ( i_limit_combined_seq_no  IN NUMBER   --組合額度主檔序號
  , i_limit_seq_no           IN NUMBER   --分項額度主檔序號
  , o_seq_no                 OUT NUMBER  --組合額度設定檔序號
  );

--**************************************************************************
-- SP_GET_LIMIT_COMBINED
-- Purpose: 查詢組合額度主檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_GET_LIMIT_COMBINED
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_LIMIT_COMBINED_PROFILE
-- Purpose: 查詢組合額度設定檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_GET_LIMIT_COMBINED_PROFILE
  ( i_limit_combined_seq_no IN NUMBER         -- 組合額度主檔序號
  , o_cur                   OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_INS_APPR_DOC_HISTORY
-- Purpose: 新增批覆書變更紀錄
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  --CHANNEL_CODE --DB已刪除 沒記錄
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
  );

  --變更需求 查詢批覆書變更紀錄及變更紀錄明細檔
  --Modified by 佑慈 2019.03.25 
  --PROCEDURE SP_GET_APPR_DOC_HISTORY( i_appr_doc_seq_no IN NUMBER, i_transaction_type_operator IN VARCHAR2, i_transaction_type IN VARCHAR2, o_cur OUT SYS_REFCURSOR);
--**************************************************************************
-- SP_GET_APPR_DOC_HISTORY
-- Purpose: 查詢批覆書變更紀錄
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_APPR_DOC_HISTORY
  ( i_appr_doc_seq_no IN NUMBER             -- 批覆書主檔序號
  , i_transaction_type_operator IN VARCHAR2 -- 交易分類運算子
  , i_transaction_type IN VARCHAR2          -- 交易分類
  , i_modify_code_operator IN VARCHAR2      -- 變更代號運算子
  , i_modify_code IN VARCHAR2               -- 變更代號
  , i_offset IN NUMBER                      -- 偏移設定
  , i_page_size IN NUMBER                   -- 分頁大小
  , o_cur OUT SYS_REFCURSOR                 -- 回傳資料
  );

--**************************************************************************
-- SP_INS_APPR_DOC_HISTORY_DTL
-- Purpose: 新增批覆書變更紀錄明細檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 黃偉庭    2019.01.10  created
--
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
  );

--**************************************************************************
-- SP_GET_APPR_DOC_HISTORY_DTL
-- Purpose: 查詢批覆書變更紀錄明細檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 黃偉庭    2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_GET_APPR_DOC_HISTORY_DTL
  ( i_appr_doc_history_seq_no IN NUMBER         -- 批覆書變更記錄主檔序號
  , i_modify_code_operator    IN VARCHAR2       -- 變更代號運算子
  , i_modify_code             IN VARCHAR2       -- 變更代號 
  , i_offset                  IN NUMBER         -- 偏移設定
  , i_page_size               IN NUMBER         -- 分頁大小
  , o_cur                     OUT SYS_REFCURSOR -- 回傳資料
  );

--*************************************************************************
-- SP_GET_LIMIT_SHARE_BY_CUST
-- Purpose: 透過銀行歸戶統編查詢共用額度資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 黃偉庭   2019.07.30  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_SHARE_BY_CUST
  ( i_customer_id         IN VARCHAR2        -- 銀行歸戶統編
  , i_appr_doc_no         IN VARCHAR2        -- 批覆書編號
  , o_cur                 OUT SYS_REFCURSOR  -- 回傳資料
  );

--**************************************************************************
-- SP_GET_LIMIT_SHARE
-- Purpose: 查詢共用額度主檔資訊。
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 黃偉庭    2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_GET_LIMIT_SHARE
  ( i_customer_loan_seq_no IN NUMBER          -- 授信戶主檔序號
  , i_serial_no            IN VARCHAR2        -- 共用額度序號
  , o_cur                  OUT SYS_REFCURSOR  -- 回傳資料
  );

--**************************************************************************
-- SP_INS_LIMIT_SHARE
-- Purpose: 新增共用額度主檔資訊。
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 黃偉庭    2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_INS_LIMIT_SHARE
  ( i_customer_loan_seq_no  IN NUMBER   -- 授信戶主檔序號
  , i_serial_no             IN VARCHAR2 -- 共用額度序號
  , i_ccy                   IN VARCHAR2 -- 共用額度幣別
  , i_apprd_amt             IN NUMBER   -- 共用額度金額
  , o_limit_share_seq_no    OUT NUMBER  -- 共用額度主檔序號
  );

--**************************************************************************
-- SP_DEL_LIMIT_SHARE
-- Purpose: 刪除共用額度主檔資訊。
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 黃偉庭    2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_DEL_LIMIT_SHARE
  ( i_limit_share_seq_no IN NUMBER -- 共用額度主檔序號
  );

--**************************************************************************
-- SP_GET_LIMIT_SHARE_PROFILE
-- Purpose: 查詢共用額度設定檔資訊列表。
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 黃偉庭    2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_GET_LIMIT_SHARE_PROFILE
  ( i_limit_share_seq_no IN NUMBER         -- 共用額度主檔序號
  , o_cur                OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_INS_LIMIT_SHARE_PROFILE
-- Purpose: 新增共用額度設定檔資訊列表。
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 黃偉庭    2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_INS_LIMIT_SHARE_PROFILE
  ( i_limit_share_seq_no         IN NUMBER  -- 共用額度主檔序號
  , i_appr_doc_seq_no            IN NUMBER  -- 批覆書主檔序號
  , i_limit_seq_no               IN NUMBER  -- 分項額度主檔序號
  , o_limit_share_profile_seq_no OUT NUMBER -- 回傳序號
  );

--**************************************************************************
-- SP_DEL_LIMIT_SHARE_PROFILE
-- Purpose: 新增共用額度設定檔資訊列表。
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 黃偉庭    2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_DEL_LIMIT_SHARE_PROFILE
  ( i_limit_share_seq_no IN NUMBER -- 共用額度設定檔序號
  );

--**************************************************************************
-- SP_FILTER_LIMIT_SHARE_PROFILE
-- Purpose: 過濾查詢共用額度設定檔資料。
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 黃偉庭    2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_FILTER_LIMIT_SHARE_PROFILE
  ( i_limit_share_seq_no IN NUMBER         -- 共用額度主檔序號
  , i_appr_doc_seq_no    IN NUMBER         -- 批覆書主檔序號
  , i_limit_seq_no       IN NUMBER         -- 分項額度主檔序號
  , o_cur                OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_LIMIT_LIST_N_SYND_LOAN
-- Purpose: 查詢分項額度主檔與分項批示條件設定檔資訊且專案屬性註記非聯貸案06, 12。
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_GET_LIMIT_LIST_N_SYND_LOAN
  ( i_appr_doc_seq_no IN VARCHAR2       -- 批覆書主檔序號
  , i_limit_type      IN VARCHAR2       -- 額度種類
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  );

  --**************************************************************************
-- SP_UPD_LIMIT_SHARE
-- Purpose: 更新共用額度主檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 黃偉庭    2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_UPD_LIMIT_SHARE
  ( i_limit_share_seq_no   IN NUMBER   -- 共用額度主檔序號
  , i_customer_loan_seq_no IN NUMBER   -- 授信戶主檔序號
  , i_serial_no            IN VARCHAR2 -- 共用額度序號
  , i_ccy                  IN VARCHAR2 -- 共用額度幣別
  , i_apprd_amt            IN NUMBER   -- 共用額度金額
  , o_count                OUT NUMBER  -- 執行筆數
  );

--**************************************************************************
-- SP_GET_LIMIT_SHARE_BY_SEQ
-- Purpose: 查詢共用額度主檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 黃偉庭    2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_GET_LIMIT_SHARE_BY_SEQ 
  ( i_limit_share_seq_no IN NUMBER         -- 共用額度主檔序號
  , o_cur                OUT SYS_REFCURSOR -- 回傳資料
  );

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
  );

--**************************************************************************
-- SP_GET_LIMIT_BY_SEQ
-- Purpose: 查詢分項額度主檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BY_SEQ
  ( i_limit_seq_no IN NUMBER         -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料
  );

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
  );

--**************************************************************************
-- SP_GET_APPR_DOC_BY_SEQ
-- Purpose: 查詢批覆書主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_APPR_DOC_BY_SEQ
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號 
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_INS_LIMIT_DTL_HISTORY
-- Purpose: 新增額度更新軌跡檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 黃偉庭    2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_INS_LIMIT_DTL_HISTORY
  ( i_limit_dtl_seq_no                 IN NUMBER   -- 分項額度彙計檔序號
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
  );

--**************************************************************************
-- SP_GET_LIMIT_BUYER
-- Purpose: 查詢買方額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER 
  ( i_cust_id IN VARCHAR2       -- 銀行歸戶統編
  , o_cur     OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_LIMIT_BUYER_LIST
-- Purpose: 查詢買方額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER_LIST 
  ( i_cust_id_list_str IN VARCHAR2       -- 銀行歸戶統編
  , o_cur              OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_INS_LIMIT_BUYER
-- Purpose: 新增買方額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
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
  );

--**************************************************************************
-- SP_DEL_LIMIT_BUYER
-- Purpose: 刪除買方額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_BUYER
  ( i_limit_buyer_seq_no IN VARCHAR2  -- 買方額度序號
  );

--**************************************************************************
-- SP_UPD_LIMIT_BUYER
-- Purpose: 更新買方額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
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
  );

--**************************************************************************
-- SP_GET_LIMIT_BUYER_SHARE
-- Purpose: 查詢買方共用額度
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER_SHARE
  ( i_cust_id IN VARCHAR2       -- 銀行歸戶統編
  , o_cur     OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_LIMIT_BUYER_SHARE_LIST
-- Purpose: 查詢買方共用額度
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER_SHARE_LIST
  ( i_cust_id_list_str IN VARCHAR2       -- 銀行歸戶統編
  , o_cur              OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_INS_LIMIT_BUYER_SHARE
-- Purpose: 新增買方共用額度
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_INS_LIMIT_BUYER_SHARE
  ( i_customer_loan_seq_no     IN VARCHAR2 -- 授信戶主檔序號
  , i_appr_limit_amt           IN NUMBER   -- 買方共用核准額度
  , i_matu_date                IN VARCHAR2 -- 買方共用額度核准到期日
  , o_limit_buyer_share_seq_no OUT NUMBER  -- 買方共用額度主檔序號 
  );

--**************************************************************************
-- SP_UPD_LIMIT_BUYER_SHARE
-- Purpose: 更新買方共用額度
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_UPD_LIMIT_BUYER_SHARE
  ( i_limit_buyer_share_seq_no IN NUMBER   -- 買方共用額度主檔序號
  , i_customer_loan_seq_no     IN NUMBER   -- 授信戶主檔序號
  , i_appr_limit_amt           IN NUMBER   -- 買方共用核准額度
  , i_matu_date                IN VARCHAR2 -- 買方共用額度核准到期日
  , o_limit_buyer_share_seq_no OUT NUMBER  -- 更新筆數
  );

--**************************************************************************
-- SP_DEL_LIMIT_BUYER_SHARE
-- Purpose: 刪除買方共用額度
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_BUYER_SHARE
  ( i_limit_buyer_share_seq_no IN VARCHAR2 -- 買方共用額度主檔序號
  );

--**************************************************************************
-- SP_GET_LIMIT_BUYER_BOOKING
-- Purpose: 查詢買方預佔額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER_BOOKING
  ( i_cust_id  IN VARCHAR2       -- 銀行歸戶統編
  , i_txn_date IN VARCHAR2       -- 登錄日期
  , i_txn_sno  IN NUMBER         -- 交易日期序號
  , o_cur      OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_LIMIT_BUYER_BY_SHARE
-- Purpose: 查詢買方共用額度下的買方額度
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER_BY_SHARE
  ( i_limit_buyer_share_seq_no IN NUMBER         -- 買方共用額度主檔序號
  , o_cur                      OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_LIMIT_BUYER_S_BY_SEQ
-- Purpose: 查詢買方共用主檔序號對應的買方共用額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER_S_BY_SEQ
  ( i_limit_buyer_share_seq_no IN NUMBER         -- 買方共用額度主檔序號
  , o_cur                      OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_LIMIT_BUYER_BK_LIST
-- Purpose: 查詢買方預佔額度資訊列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER_BK_LIST
  ( i_cust_id IN VARCHAR2       -- 銀行歸戶統編
  , o_cur     OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_INS_LIMIT_BUYER_BOOKING
-- Purpose: Insert買方預佔額度資訊列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
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
  );


--**************************************************************************
-- SP_DEL_LIMIT_BUYER_BOOKING
-- Purpose: 刪除買方預佔額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_BUYER_BOOKING
  ( i_limit_buyer_booking_seq_no IN NUMBER  -- 買方預佔額度序號
  );

--**************************************************************************
-- SP_UPD_LIMIT_BUYER_BOOKING
-- Purpose: 更新買方預佔額度
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_UPD_LIMIT_BUYER_BOOKING
  ( i_limit_buyer_booking_seq_no IN NUMBER   -- 買方預佔額度序號
  , i_customer_loan_seq_no       IN NUMBER   -- 授信戶主檔序號
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
  , o_limit_buyer_booking_seq_no OUT NUMBER  -- 買方預佔額度序號
  );

--**************************************************************************
-- SP_GET_LIMIT_BUYER_S_RELATED
-- Purpose: 查詢關聯的買方共用額度，並排除自身更新前關聯
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER_S_RELATED
  ( i_limit_buyer_share_seq_no IN NUMBER         -- 買方共用額度主檔序號
  , i_cust_id                  IN VARCHAR2       -- 銀行歸戶統編
  , o_cur                      OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_LIMIT_BUYER_BK_BY_CUST
-- Purpose: 查詢歸戶下買方預佔額度
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BUYER_BK_BY_CUST
  ( i_cust_id IN VARCHAR2       -- 銀行歸戶統編
  , o_cur     OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_SEL_ADVHANDFEE_FK
-- Purpose: 以放款主檔序號(外鍵)查詢預收手續費資訊。
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_SEL_ADVHANDFEE_FK 
  ( i_loan_seq_no IN NUMBER          -- 放款主檔序號
   , o_cur         OUT SYS_REFCURSOR -- 回傳資料
   );

--**************************************************************************
-- SP_INS_LOAN_ADV_HANDLING_FEE
-- Purpose: 
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
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
  );

--**************************************************************************
-- SP_UPD_LOAN_ADV_HANDLING_FEE
-- Purpose: 
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
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
  );

--**************************************************************************
-- SP_INS_LOAN_SYNDEST_RECOV_PRNP
-- Purpose: 
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
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
  );

--**************************************************************************
-- SP_UPD_LOAN_SYNDEST_RECOV_PRNP
-- Purpose: 
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
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
  );

--**************************************************************************
-- SP_GET_LOAN_SYNDEST_RECOV_PRNP
-- Purpose: 
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_LOAN_SYNDEST_RECOV_PRNP 
  ( i_join_bank_fee_amortiz_seq_no IN NUMBER         -- 預收手續費資訊序號
  , o_cur                          OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_ADVHANDFEE_FK_FCODE
-- Purpose: 查詢預收手續費資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_ADVHANDFEE_FK_FCODE 
  ( i_loan_seq_no IN NUMBER         -- 預收手續費資訊序號
  , i_fee_code    IN VARCHAR2       -- 手續費代碼
  , o_cur         OUT SYS_REFCURSOR -- 回傳資料
  );

--  PROCEDURE SP_DEL_LOAN_SYNDEST_RECOV_PRNP ( i_join_bank_fee_amortiz_seq_no IN NUMBER, i_sno IN NUMBER, i_est_recov_prnp_sdate IN VARCHAR2, i_est_recov_prnp_amt IN NUMBER, i_est_recov_prnp_perc IN NUMBER, i_est_recov_prnp_cnt IN NUMBER, i_est_recov_prnp_freq IN NUMBER, o_row_count OUT NUMBER);
--**************************************************************************
-- SP_DEL_LOAN_SYNDEST_RECOV_PRNP
-- Purpose: 刪除聯貸案預估可回收本金資料檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_LOAN_SYNDEST_RECOV_PRNP 
  ( i_join_bank_fee_amortiz_seq_no IN NUMBER  -- 預收手續費資訊序號
  , o_row_count                    OUT NUMBER -- 刪除筆數
  );

--**************************************************************************
-- SP_INS_RRSAC_AUTO_TRANS
-- Purpose: 新增備償專戶自動轉帳登錄
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
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
  );

--**************************************************************************
-- SP_GET_RRSAC_AUTO_TRANS
-- Purpose: 以備償帳號查詢授信戶主檔下關聯之備償專戶自動轉帳登錄資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_RRSAC_AUTO_TRANS 
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , i_rrsac_acc_no         IN VARCHAR2       -- 備償專戶帳號
  , o_cur                  OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_RRSAC_AUTO_TRANS_U
-- Purpose: 以備償帳號查詢授信戶主檔下關聯之備償專戶自動轉帳登錄資料 FOR UPDATE
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_RRSAC_AUTO_TRANS_U 
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , i_rrsac_acc_no         IN VARCHAR2       -- 備償專戶帳號
  , o_cur                  OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_UPD_RRSAC_AUTO_TRANS
-- Purpose: 更新備償專戶自動轉帳登錄資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
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
  );

--**************************************************************************
-- SP_DEL_RRSAC_AUTO_TRANS
-- Purpose: 刪除備償專戶自動轉帳登錄資料(修改STATUS)
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_RRSAC_AUTO_TRANS 
  ( i_rrsac_auto_transfer_seq_no IN NUMBER  -- 備償專戶自動轉帳登錄序號
  , o_row_count                  OUT NUMBER -- 刪除筆數
  );

--**************************************************************************
-- SP_INS_RRSAC_AUTO_TRANS_PROF
-- Purpose: 新增備償專戶自動轉帳設定資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
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
  );

--**************************************************************************
-- SP_GET_RRSAC_AUTO_TRANS_PROF
-- Purpose: 以批覆書及分項額度查詢備償專戶自動轉帳登錄下關聯之備償專戶自動轉帳設定資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_RRSAC_AUTO_TRANS_PROF 
  ( i_rrsac_auto_transfer_seq_no IN NUMBER         -- 備償專戶自動轉帳登錄序號
  , i_limit_seq_no               IN NUMBER         -- 分項額度主檔序號
  , i_appr_doc_seq_no            IN NUMBER         -- 批覆書主檔序號
  , o_cur                        OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_RRSAC_AUTO_TRANS_PROF_U
-- Purpose: 以批覆書及分項額度查詢備償專戶自動轉帳登錄下關聯之備償專戶自動轉帳設定資料 FOR UPDATE
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_RRSAC_AUTO_TRANS_PROF_U 
  ( i_rrsac_auto_transfer_seq_no IN NUMBER         -- 備償專戶自動轉帳登錄序號
  , i_limit_seq_no               IN NUMBER         -- 分項額度主檔序號
  , i_appr_doc_seq_no 			 IN NUMBER         -- 批覆書主檔序號
  , o_cur                        OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_RRSAC_AUTO_TRANS_PROFS
-- Purpose: 取得備償專戶自動轉帳登錄下所有自動轉帳設定資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_RRSAC_AUTO_TRANS_PROFS
  ( i_rrsac_auto_transfer_seq_no IN NUMBER         -- 備償專戶自動轉帳登錄序號
  , o_cur                        OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_UPD_RRSAC_AUTO_TRANS_PROF
-- Purpose: 更新備償專戶自動轉帳設定資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
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
  );

--**************************************************************************
-- SP_DEL_RRSAC_AUTO_TRANS_PROF
-- Purpose: 刪除備償專戶自動轉帳登錄項下所有備償專戶自動轉帳設定資料(修改STATUS)
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_RRSAC_AUTO_TRANS_PROF 
  ( i_rrsac_auto_transfer_seq_no IN NUMBER  -- 備償專戶自動轉帳設定檔序號
  , o_row_count                  OUT NUMBER -- 刪除筆數
  );

--*************************************************************************
-- SP_INS_GUARANTOR
-- Purpose: 新增[保證人資料檔]資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2018.11.26  created
--
--**************************************************************************
  PROCEDURE SP_INS_GUARANTOR
  ( i_appr_doc_seq_no          IN NUMBER   -- 批覆書主檔序號
  , i_limit_seq_no             IN NUMBER   -- 分項額度主檔序號
  , i_customer_loan_seq_no     IN NUMBER   -- 授信戶主檔序號
  , i_identity_code            IN VARCHAR2 -- 相關身份代號
  , i_country                  IN VARCHAR2 -- 保證人國別
  , i_phase                    IN VARCHAR2 -- 保證狀態
  , i_cancel_reason_mk         IN VARCHAR2 -- 解除原因註記
  , i_percentage               IN NUMBER   -- 保證比率
  , i_relationship_code        IN VARCHAR2 -- 與主債務人關係
  , i_relation_with_min_debtor IN VARCHAR2 -- 與主債務人次要關係
  , i_is_finan_instit          IN VARCHAR2 -- 金融機構註記
  , i_change_date              IN VARCHAR2 -- 異動日期
  , i_bind_all_mark            IN VARCHAR2 -- 綁定整張註記
  , o_guarantor_seq_no         OUT  NUMBER -- 回傳保證人序號
  );

--*************************************************************************
-- SP_GET_GUARANTOR_BY_PK
-- Purpose: 使用保證人資料檔序號取得[保證人資料檔]資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2018.11.26  created
--
--**************************************************************************
  PROCEDURE SP_GET_GUARANTOR_BY_PK
  ( i_guarantor_seq_no IN  NUMBER         --保證人資料檔序號
  , o_cur              OUT SYS_REFCURSOR  --回傳資料
  );

--*************************************************************************
-- SP_GET_GUARANTOR
-- Purpose: 取得[保證人資料檔]資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2018.11.26  created
--
--**************************************************************************
  PROCEDURE SP_GET_GUARANTOR
  ( i_appr_doc_seq_no IN  NUMBER        --批覆書主檔序號
  , i_limit_seq_no    IN  NUMBER        --分項額度主檔序號
  , o_cur             OUT SYS_REFCURSOR --回傳資料
  );

--*************************************************************************
-- SP_UPD_GUARANTOR
-- Purpose: 更新[保證人資料檔]資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2018.11.26  created
--
--**************************************************************************
  PROCEDURE SP_UPD_GUARANTOR
  ( i_guarantor_seq_no         IN NUMBER   -- 保證人資料檔序號
  , i_appr_doc_seq_no          IN NUMBER   -- 批覆書主檔序號
  , i_limit_seq_no             IN NUMBER   -- 分項額度主檔序號
  , i_customer_loan_seq_no     IN NUMBER   -- 授信戶主檔序號
  , i_identity_code            IN VARCHAR2 -- 相關身份代號
  , i_country                  IN VARCHAR2 -- 保證人國別
  , i_phase                    IN VARCHAR2 -- 保證狀態
  , i_cancel_reason_mk         IN VARCHAR2 -- 解除原因註記
  , i_percentage               IN NUMBER   -- 保證比率
  , i_relationship_code        IN VARCHAR2 -- 與主債務人關係
  , i_relation_with_min_debtor IN VARCHAR2 -- 與主債務人次要關係
  , i_is_finan_instit          IN VARCHAR2 -- 金融機構註記
  , i_change_date              IN VARCHAR2 -- 異動日期
  , i_bind_all_mark            IN VARCHAR2 -- 綁定整張註記
  , o_modify_count             OUT  NUMBER -- 回傳更新筆數
  );

--*************************************************************************
-- SP_DEL_GUARANTOR_BY_PK
-- Purpose: 刪除[保證人資料檔]資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2018.11.26  created
--
--**************************************************************************
  PROCEDURE SP_DEL_GUARANTOR_BY_PK
  ( i_guarantor_seq_no IN  NUMBER  --保證人資料檔序號
  , o_count            OUT NUMBER  --回傳更新筆數
  );

--**************************************************************************
-- SP_GET_LIMIT_BY_FK
-- Purpose: 透過[批覆書主檔序號]取得分項額度主檔資訊。
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_GET_LIMIT_BY_FK
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  ,  o_cur            OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_APPR_DOC_BY_CUST_KEY
-- Purpose: 查詢批覆書主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_GET_APPR_DOC_BY_CUST_KEY
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , i_appr_doc_no          IN VARCHAR2       -- 批覆書編號
  , o_cur                  OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_APPR_DOC_ACTIVITYLIST
-- Purpose: 取得批覆書活動設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_GET_APPR_DOC_ACTIVITYLIST
  ( i_appr_doc_seq_no IN NUMBER          -- 批覆書主檔序號
  , o_cur             OUT SYS_REFCURSOR  -- 回傳資料
  );

--**************************************************************************
-- SP_GET_LIMIT_PROFILE
-- Purpose: 取得分項批示條件設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_GET_LIMIT_PROFILE
  ( i_limit_seq_no IN NUMBER         -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料
  );

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
  );

--**************************************************************************
-- SP_GET_LIMITP
-- Purpose: 查詢分項額度主檔與分項批示條件設定檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_GET_LIMITP
  ( i_limit_seq_no IN NUMBER          -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR  -- 回傳資料
  );

--**************************************************************************
-- SP_GET_LIMITP_NO_LOCK
-- Purpose: 查詢分項額度主檔與分項批示條件設定檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_GET_LIMITP_NO_LOCK
  ( i_limit_seq_no IN NUMBER          -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR  -- 回傳資料
  );

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
  );

--**************************************************************************
-- SP_UPD_APPR_DOC_FDD
-- Purpose: 批覆書主檔首次動撥日以及狀態
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_UPD_APPR_DOC_FDD
  ( i_appr_doc_seq_no IN NUMBER   -- 批覆書主檔序號
  , i_date            IN VARCHAR2 -- 第一次動用截止日
  );

--**************************************************************************
-- SP_UPD_LIMIT_FDD
-- Purpose: 更新分項額度主檔首次動用
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_UPD_LIMIT_FDD
  ( i_limit_seq_no IN NUMBER -- 分項額度主檔序號
  );

--**************************************************************************
-- SP_UPD_LIMIT_PROFILE
-- Purpose: 更新分項批示條件設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_UPD_LIMIT_PROFILE
  ( i_limit_profile_seq_no   IN NUMBER   -- 分項批示條件檔序號
  , i_limit_seq_no           IN NUMBER   -- 分項額度主檔序號
  , i_base_rate_type         IN VARCHAR2 -- 基放類別
  , i_spread_rate            IN NUMBER   -- 放款利率加減碼值
  , i_interest_rate          IN NUMBER   -- 放款利率
  , i_fee_rate               IN NUMBER   -- 手續費率
  , i_jcic_loan_biz_code     IN VARCHAR2 -- 融資業務分類
  , i_interest_rate_type     IN VARCHAR2 -- 利率類別
  , i_interest_schedule_type IN VARCHAR2 -- 利率計劃類別
  , i_apprd_drawdown_unit    IN VARCHAR2 -- 核准動用期間單位
  , i_apprd_drawdown_period  IN NUMBER   -- 核准動用期間
  , i_purpose_code           IN VARCHAR2 -- 用途別
  , i_loan_subcategory       IN VARCHAR2 -- 貸放細目
  , i_credit_loan_prod_code  IN VARCHAR2 -- 信貸產品編號
  , i_repaymt_source         IN VARCHAR2 -- 償還來源
  , i_prnp_grace_period      IN NUMBER   -- 還本寬限期
  , i_allow_drawdown_mk      IN VARCHAR2 -- 是否可動用註記
  , i_collateral_type        IN VARCHAR2 -- 擔保品種類
  , i_appr_intst_rate        IN NUMBER   -- 批覆時核貸利率
  , i_pd_value               IN NUMBER   -- PD值
  , i_lgd_value              IN NUMBER   -- LGD值
  , i_first_drawdown_date    IN VARCHAR2 -- 分項首次動撥日
  , i_overdraft_ext_mk       IN VARCHAR2 -- 自動展期註記
  , i_credit_guara_fee_rate  IN NUMBER   -- 信保手續費率 
  , i_paymt_type             IN VARCHAR2 -- 償還方法
  , i_consign_paymt_acc      IN VARCHAR2 -- 委託繳息帳號
  , i_intst_upper_rate       IN NUMBER   -- 上限利率
  , i_intst_lower_rate       IN NUMBER   -- 下限利率
  , i_guara_calc_type        IN VARCHAR2 -- 保證計費方式
  , i_trans_accept_fee_rate  IN NUMBER   -- 信用狀轉承兌費率
  , i_service_fee_data       IN VARCHAR2 -- 手續費設定條款
  , i_deposit_pledge_mk      IN VARCHAR2 -- 存單質借註記
  );

--**************************************************************************
-- SP_GET_PROD_MORTGAGE_PROF
-- Purpose: 查詢分項額度下的所有房貸種類註記
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_GET_PROD_MORTGAGE_PROF
  ( i_limit_seq_no IN NUMBER         -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_INS_LIMIT_PROFILE
-- Purpose: 新增分項批示條件設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_INS_LIMIT_PROFILE
  ( i_limit_seq_no           IN NUMBER   -- 分項額度主檔序號
  , i_base_rate_type         IN VARCHAR2 -- 基放類別
  , i_spread_rate            IN NUMBER   -- 放款利率加減碼值
  , i_interest_rate          IN NUMBER   -- 放款利率
  , i_fee_rate               IN NUMBER   -- 手續費率
  , i_jcic_loan_biz_code     IN VARCHAR2 -- 融資業務分類
  , i_interest_rate_type     IN VARCHAR2 -- 利率類別
  , i_interest_schedule_type IN VARCHAR2 -- 利率計劃類別
  , i_apprd_drawdown_unit    IN VARCHAR2 -- 核准動用期間單位
  , i_apprd_drawdown_period  IN NUMBER   -- 核准動用期間
  , i_purpose_code           IN VARCHAR2 -- 用途別
  , i_loan_subcategory       IN VARCHAR2 -- 貸放細目
  , i_credit_loan_prod_code  IN VARCHAR2 -- 信貸產品編號
  , i_repaymt_source         IN VARCHAR2 -- 償還來源
  , i_prnp_grace_period      IN NUMBER   -- 還本寬限期
  , i_allow_drawdown_mk      IN VARCHAR2 -- 是否可動用註記
  , i_collateral_type        IN VARCHAR2 -- 擔保品種類
  , i_appr_intst_rate        IN NUMBER   -- 批覆時核貸利率
  , i_pd_value               IN NUMBER   -- PD值
  , i_lgd_value              IN NUMBER   -- LGD值
  , i_first_drawdown_date    IN VARCHAR2 -- 分項首次動撥日
  , i_overdraft_ext_mk       IN VARCHAR2 -- 自動展期註記
  , i_credit_guara_fee_rate  IN NUMBER   -- 信保手續費率 
  , i_paymt_type             IN VARCHAR2 -- 償還方法
  , i_consign_paymt_acc      IN VARCHAR2 -- 委託繳息帳號
  , i_intst_upper_rate       IN NUMBER   -- 上限利率
  , i_intst_lower_rate       IN NUMBER   -- 下限利率
  , i_guara_calc_type        IN VARCHAR2 -- 保證計費方式
  , i_trans_accept_fee_rate  IN NUMBER   -- 信用狀轉承兌費率
  , i_service_fee_data       IN VARCHAR2 -- 手續費設定條款
  , i_deposit_pledge_mk      IN VARCHAR2 -- 存單質借註記
  , o_seq_no                 OUT NUMBER  -- 分項批示條件檔序號
  );

--**************************************************************************
-- SP_UPD_LIMIT_PROFILE_FDD
-- Purpose: 更新分項批示條件檔首次動撥日
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_UPD_LIMIT_PROFILE_FDD
  ( i_limit_seq_no IN NUMBER   -- 分項額度主檔序號
  , i_date         IN VARCHAR2 -- 第一次動用截止日
  );

--**************************************************************************
-- SP_INS_PREPAID_STOCK_TXN
-- Purpose: 新增墊付股款交易紀錄
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
 PROCEDURE SP_INS_PREPAID_STOCK_TXN
  ( i_limit_seq_no         IN NUMBER    -- 分項額度主檔序號
  , i_txn_date             IN VARCHAR2  -- 交易日期
  , i_txn_sno              IN NUMBER    -- 交易日期序號
  , i_txn_time             IN VARCHAR2  -- 交易時間
  , i_branch               IN VARCHAR2  -- 分行代號
  , i_host_sno             IN VARCHAR2  -- 主機交易序號
  , i_sup_card_code        IN VARCHAR2  -- 主管授權卡號
  , i_txn_id               IN VARCHAR2  -- 交易代號
  , i_txn_memo             IN VARCHAR2  -- 交易摘要
  , i_acc_branch           IN VARCHAR2  -- 設帳分行
  , i_dc_code              IN VARCHAR2  -- 借貸別
  , i_action_code          IN VARCHAR2  -- 執行類別
  , i_txn_amt              IN NUMBER    -- 交易金額
  , i_prepaid_balance      IN NUMBER    -- 墊款餘額
  , i_saving_acc_no        IN VARCHAR2  -- 存款帳號
  , i_saving_acc_cust_id   IN VARCHAR2  -- 存款帳號統編
  , i_prepaid_acc_category IN VARCHAR2  -- 墊款科目
  , i_debit_acc_no         IN VARCHAR2  -- 轉出帳號
  , i_to_saving_acc_no     IN VARCHAR2  -- 轉入帳號
  , i_appr_doc_seq_no      IN NUMBER    -- 批覆書主檔序號
  , i_limit_type           IN VARCHAR2  -- 額度種類
  , i_is_ec                IN VARCHAR2  -- 是否為沖正交易註記
  , o_seq_no               OUT NUMBER   -- PREPAID_STOCK_TXN_SEQ_NO
  );

--**************************************************************************
-- SP_GET_PREPAID_STOCK_TXN_LIST
-- Purpose: 查詢在起訖日間符合查詢條件的交易紀錄
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_GET_PREPAID_STOCK_TXN_LIST
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , i_limit_type      IN VARCHAR2       -- 額度種類
  , i_start_date      IN VARCHAR2       -- 交易日期起日
  , i_end_date        IN VARCHAR2       -- 交易日期迄日
  , i_action_code     IN VARCHAR2       -- 執行類別
  , i_saving_acc_no   IN VARCHAR2       -- 存款帳號
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_PREPAID_STOCK_NEXT_SNO
-- Purpose: 取得此墊付股款交易紀錄的下一交易日期序號
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_GET_PREPAID_STOCK_NEXT_SNO
  ( i_appr_doc_seq_no IN NUMBER   -- 批覆書主檔序號
  , i_limit_type      IN VARCHAR2 -- 額度種類
  , i_txn_date        IN VARCHAR2 -- 交易日期
  , o_seq_no          OUT NUMBER  -- 墊付股款交易記錄序號
  );

--**************************************************************************
-- SP_INS_PREPAY_STOCK
-- Purpose: 新增墊付股款額度設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_INS_PREPAY_STOCK
  ( i_limit_seq_no       IN NUMBER   -- 分項額度主檔序號
  , i_sub_company_id     IN VARCHAR2 -- 子公司統編
  , i_appr_limit_amt     IN NUMBER   -- 核准額度
  , i_total_drawdown_amt IN NUMBER   -- 預佔累積動用金額
  , o_seq_no             OUT NUMBER  -- 墊付股款額度設定檔序號
  );

--**************************************************************************
-- SP_GET_PREPAY_STOCK
-- Purpose: 查詢墊付股款額度設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_GET_PREPAY_STOCK
  ( i_limit_seq_no   IN NUMBER         -- 分項額度主檔序號
  , i_sub_company_id IN VARCHAR2       -- 子公司統編
  , o_cur            OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_PREPAY_STOCK_U
-- Purpose: 查詢墊付股款額度設定檔FOR UPDATE
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--************************************************************************** 
  PROCEDURE SP_GET_PREPAY_STOCK_U
  ( i_limit_seq_no   IN NUMBER         -- 分項額度主檔序號
  , i_sub_company_id IN VARCHAR2       -- 子公司統編 
  , o_cur            OUT SYS_REFCURSOR -- 回傳資料
  );

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
  );

--**************************************************************************
-- SP_UPD_PREPAY_STOCK
-- Purpose: 更新墊付股款額度設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_UPD_PREPAY_STOCK
  ( i_prepaid_stock_seq_no IN NUMBER   -- 墊付股款額度設定檔序號
  , i_limit_seq_no         IN NUMBER   -- 分項額度主檔序號
  , i_sub_company_id       IN VARCHAR2 -- 子公司統編
  , i_appr_limit_amt       IN NUMBER   -- 核准額度
  , i_total_drawdown_amt   IN NUMBER   -- 預佔累積動用金額
  , o_row_count            OUT NUMBER  -- 異動筆數
  );

--**************************************************************************
-- SP_DEL_PREPAY_STOCK_PK
-- Purpose: 以序號刪除對應墊付股款額度設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_PREPAY_STOCK_PK
  ( i_prepaid_stock_seq_no IN NUMBER  -- 墊付股款額度設定檔序號
  , o_row_count            OUT NUMBER -- 刪除筆數
  );

--**************************************************************************
-- SP_DEL_PREPAY_STOCK
-- Purpose: 刪除墊付股款額度設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_PREPAY_STOCK
  ( i_limit_seq_no IN NUMBER  -- 分項額度主檔序號
  , o_row_count    OUT NUMBER -- 刪除筆數
  );

 --**************************************************************************
-- SP_INS_APPR_DOC
-- Purpose: 新增批覆書主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
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
  );

--**************************************************************************
-- SP_INS_APPR_DOC_ACTIVITY_PROF
-- Purpose: 新增批覆書活動設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_INS_APPR_DOC_ACTIVITY_PROF
  ( i_appr_doc_seq_no IN NUMBER   -- 批覆書主檔序號
  , i_activity_code   IN VARCHAR2 -- 活動代號
  , o_seq_no          OUT NUMBER  -- 批覆書活動設定檔序號
  );

--**************************************************************************
-- SP_DEL_APPR_DOC
-- Purpose: 刪除批覆書主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_APPR_DOC
  ( i_appr_doc_seq_no IN NUMBER  -- 批覆書主檔序號
  , o_row_count       OUT NUMBER -- 刪除筆數
  );

--**************************************************************************
-- SP_DEL_APPR_DOC_ACTIVITY_PROF
-- Purpose: 刪除批覆書活動設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_APPR_DOC_ACTIVITY_PROF
  ( i_appr_doc_seq_no IN NUMBER  -- 批覆書主檔序號
  , o_row_count       OUT NUMBER -- 刪除筆數
  );

--**************************************************************************
-- SP_DEL_LIMIT
-- Purpose: 刪除分項額度主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT
  ( i_limit_seq_no IN NUMBER  -- 分項額度主檔序號
  , o_row_count    OUT NUMBER -- 刪除筆數
  );

--**************************************************************************
-- SP_DEL_LIMIT_PROFILE
-- Purpose: 刪除分項批示條件設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_PROFILE
  ( i_limit_seq_no IN NUMBER  -- 分項額度主檔序號
  , o_row_count    OUT NUMBER -- 刪除筆數
  );

--**************************************************************************
-- SP_DEL_LIMIT_PROJ_COND_PROF
-- Purpose: 刪除專案屬性批示條件檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_PROJ_COND_PROF
  ( i_limit_profile_seq_no IN NUMBER  -- 分項批示條件檔序號
  , o_row_count            OUT NUMBER -- 回傳筆數
  );

--**************************************************************************
-- SP_INS_PROD_MORTGAGE_PROF
-- Purpose: 新增房屋產品種類批示條件檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_INS_PROD_MORTGAGE_PROF
  ( i_limit_profile_seq_no IN NUMBER   -- 分項批示條件檔序號
  , i_mortgage_product     IN VARCHAR2 -- 房貸產品種類
  , o_seq_no               OUT NUMBER  -- 房貸產品種類批示條件檔序號
  );

  /*
  * 刪除房屋產品種類批示條件檔
  */
  PROCEDURE SP_DEL_PROD_MORTGAGE_PROF( i_limit_profile_seq_no IN NUMBER, o_row_count OUT NUMBER);

--**************************************************************************
-- SP_GET_PRE_CLOSURE_FEE_PROF
-- Purpose: 取得提前清償違約金設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_PRE_CLOSURE_FEE_PROF
  ( i_limit_profile_seq_no IN NUMBER         -- 分項批示條件設定檔序號
  , o_cur                  OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_INS_PRE_CLOSURE_FEE_PROF
-- Purpose: 新增提前清償違約金設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_INS_PRE_CLOSURE_FEE_PROF
  ( i_limit_profile_seq_no       IN NUMBER  -- 分項批示條件設定檔序號
  , i_terms                      IN NUMBER  -- 段數
  , i_penalty_clause_start_month IN NUMBER  -- 違約條款起月
  , i_penalty_clause_end_month   IN NUMBER  -- 違約條款迄月
  , i_percentage                 IN NUMBER  -- 百分比
  , o_seq_no                     OUT NUMBER -- 提前清償違約金設定檔序號
  );

--**************************************************************************
-- SP_UPD_PRE_CLOSURE_FEE_PROF
-- Purpose: 修改提前清償違約金設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_UPD_PRE_CLOSURE_FEE_PROF
  ( i_pre_closure_fee_prof_seq_no IN NUMBER  -- 提前清償違約金設定檔序號
  , i_limit_profile_seq_no        IN NUMBER  -- 分項批示條件設定檔序號
  , i_terms                       IN NUMBER  -- 段數
  , i_penalty_clause_start_month  IN NUMBER  -- 違約條款起月
  , i_penalty_clause_end_month    IN NUMBER  -- 違約條款迄月
  , i_percentage                  IN NUMBER  -- 百分比
  , o_row_count                   OUT NUMBER -- 異動筆數
  );

--**************************************************************************
-- SP_DEL_PRE_CLOSURE_FEE_PROF
-- Purpose: 刪除提前清償違約金設定檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_PRE_CLOSURE_FEE_PROF
  ( i_limit_profile_seq_no IN NUMBER  -- 分項批示條件設定檔序號
  , o_row_count            OUT NUMBER -- 刪除筆數
  );

--**************************************************************************
-- SP_GET_APPR_DOC_INLOAN_PROF
-- Purpose: 取得間接授信批示條件檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_APPR_DOC_INLOAN_PROF
  ( i_limit_seq_no IN NUMBER         -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_INS_APPR_DOC_INLOAN_PROF
-- Purpose: 新增間接授信批示條件檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
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
  );

--**************************************************************************
-- SP_UPD_APPR_DOC_INLOAN_PROF
-- Purpose: 修改間接授信批示條件檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_UPD_APPR_DOC_INLOAN_PROF
  ( i_inloan_profile_seq_no IN NUMBER   -- 間接授信批示條件檔序號
  , i_limit_seq_no          IN NUMBER   -- 分項額度主檔序號
  , i_ccy_mk                IN VARCHAR2 -- 幣別註記
  , i_base_rate_type        IN VARCHAR2 -- 基放類別
  , i_intst_rate_type       IN VARCHAR2 -- 利率類別
  , i_intst_spread_rate     IN NUMBER   -- 利率加減碼
  , i_paymt_type            IN VARCHAR2 -- 償還方法
  , i_consign_paymt_acc     IN VARCHAR2 -- 委託繳息帳號
  , o_row_count             OUT NUMBER  -- 回傳更新筆數
  );

--**************************************************************************
-- SP_DEL_APPR_DOC_INLOAN_PROF
-- Purpose: 刪除間接授信批示條件檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_APPR_DOC_INLOAN_PROF
  ( i_inloan_profile_seq_no IN NUMBER  -- 間接授信批示條件檔序號
  , o_row_count             OUT NUMBER -- 回傳筆數
  );

--**************************************************************************
-- SP_GET_LIMIT_AR
-- Purpose: 取得應收帳款預支價金額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_AR
  ( i_limit_seq_no IN NUMBER         -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_INS_LIMIT_AR
-- Purpose: 新增應收帳款預支價金額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_INS_LIMIT_AR
  ( i_limit_seq_no        IN NUMBER   -- 分項額度主檔序號
  , i_txn_branch          IN VARCHAR2 -- 交易分行
  , i_host_sno            IN VARCHAR2 -- 主機交易序號
  , i_txn_date            IN VARCHAR2 -- 登錄日期
  , i_registry_mk         IN VARCHAR2 -- 登錄解除註記
  , i_pre_paid_balance    IN NUMBER   -- 預支現欠
  , i_pre_paid_percentage IN NUMBER   -- 預支成數
  , i_invoice_balance_amt IN NUMBER   -- 發票轉讓餘額
  , i_paymt_type          IN VARCHAR2 -- 償還方法
  , o_seq_no              OUT NUMBER  -- 應收帳款預支價金額度資訊序號
  );

--**************************************************************************
-- SP_UPD_LIMIT_AR
-- Purpose: 修改應收帳款預支價金額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_UPD_LIMIT_AR
  ( i_limit_ar_seq_no     IN NUMBER   -- 應收帳款預支價金額度資訊序號
  , i_limit_seq_no        IN NUMBER   -- 分項額度主檔序號
  , i_txn_branch          IN VARCHAR2 -- 交易分行
  , i_host_sno            IN VARCHAR2 -- 主機交易序號
  , i_txn_date            IN VARCHAR2 -- 登錄日期
  , i_registry_mk         IN VARCHAR2 -- 登錄解除註記
  , i_pre_paid_balance    IN NUMBER   -- 預支現欠
  , i_pre_paid_percentage IN NUMBER   -- 預支成數
  , i_invoice_balance_amt IN NUMBER   -- 發票轉讓餘額
  , i_paymt_type          IN VARCHAR2 -- 償還方法
  , o_row_count           OUT NUMBER  -- 異動筆數
  );

--**************************************************************************
-- SP_DEL_LIMIT_AR
-- Purpose: 刪除應收帳款預支價金額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_AR
  ( i_limit_ar_seq_no IN NUMBER  -- 應收帳款預支價金額度資訊序號
  , o_row_count       OUT NUMBER -- 刪除筆數
  );

--**************************************************************************
-- SP_INS_LIMIT
-- Purpose: 新增分項額度主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
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
  );

--**************************************************************************
-- SP_GET_APPR_DOC_AUTHORIZER
-- Purpose: 查詢批覆書核轉人員
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_APPR_DOC_AUTHORIZER
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_INS_APPR_DOC_AUTHORIZER
-- Purpose: 新增批覆書核轉人員
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_INS_APPR_DOC_AUTHORIZER
  ( i_appr_doc_seq_no IN NUMBER   -- 批覆書主檔序號
  , i_auth_level_code IN VARCHAR2 -- 權限代號
  , i_right_order     IN NUMBER   -- 權限順位
  , i_cust_id         IN VARCHAR2 -- 核轉人員統編
  , i_realtor_name    IN VARCHAR2 -- 房屋仲介姓名
  , i_realtor_id      IN VARCHAR2 -- 房屋仲介統編
  , i_allograph_name  IN VARCHAR2 -- 代書人員姓名
  , i_is_fix_contract IN VARCHAR2 -- 是否為制式合約
  , o_seq_no          OUT NUMBER  -- 批覆書核轉人員序號
  );

  --**************************************************************************
-- SP_UPD_APPR_DOC_AUTHORIZER
-- Purpose: 修改批覆書核轉人員
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
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
  );

--**************************************************************************
-- SP_DEL_APPR_DOC_AUTHORIZER
-- Purpose: 刪除批覆書核轉人員
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************  
  PROCEDURE SP_DEL_APPR_DOC_AUTHORIZER
  ( i_appr_doc_authorizer_seq_no IN NUMBER  -- 批覆書核轉人員序號
  , o_row_count                  OUT NUMBER -- 刪除筆數
  );

--**************************************************************************
-- SP_INS_CLONE_APPR_DOC
-- Purpose: 複製批覆書主檔其下所有table
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_INS_CLONE_APPR_DOC
  ( i_appr_doc_seq_no      IN NUMBER   -- 批覆書主檔序號
  , i_customer_loan_seq_no IN NUMBER   -- 授信戶主檔序號 
  , i_appr_doc_no          IN VARCHAR2 -- 批覆書編號
  , i_date                 IN VARCHAR2 -- 現在交易日
  , i_branch               IN VARCHAR2 -- 交易分行
  , new_appr_doc_seq_no    OUT NUMBER  -- 新批覆書主檔序號
  );

--**************************************************************************
-- SP_GET_APPR_DOC_TEMPLIST
-- Purpose: 取得批覆書暫存資料檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_APPR_DOC_TEMPLIST
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  );

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
  );

--**************************************************************************
-- SP_GET_APPR_DOC_EXTLIST
-- Purpose: 取得批覆書延伸資訊檔資訊列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_APPR_DOC_EXTLIST
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , i_limit_seq_no    IN NUMBER         -- 分項額度主檔序號
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_REMAND_LIMIT_BOOKING
-- Purpose: 查詢仍有預佔額度的預佔額度檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李建邦    2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_REMAND_LIMIT_BOOKING
  ( i_limit_seq_no_list IN ITEM_NUM_ARRAY -- 分項額度主檔序號
  , o_amount            OUT NUMBER        -- 筆數
  );

--**************************************************************************
-- SP_GET_FILTER_LIMIT_BY_MORT
-- Purpose: 查詢含有特定房貸種類的分項額度個數
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李建邦    2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_FILTER_LIMIT_BY_MORT
  ( i_limit_seq_no_list IN ITEM_NUM_ARRAY -- 分項額度主檔序號
  , i_mortgage_product  IN VARCHAR2       -- 房貸產品種類
  , o_amount            OUT NUMBER        -- 筆數
  );

--**************************************************************************
-- SP_GET_COUNT_UNMODIFIABLE_ACC
-- Purpose: 取得不可執行變更交易的對應帳號的分項額度個數
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李建邦    2018.12.21  created
--
--**************************************************************************  
  PROCEDURE SP_GET_COUNT_UNMODIFIABLE_ACC
  ( i_limit_seq_no_list IN ITEM_NUM_ARRAY -- 分項額度主檔序號
  , o_amount            OUT NUMBER        -- 筆數
  );

--**************************************************************************
-- SP_GET_LIMIT_LIST_BY_TYPELIST
-- Purpose: 利用分項額度主檔序號列表查詢分項額度彙計檔資料列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李建邦    2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_LIST_BY_TYPELIST
  ( i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , i_limit_type_list IN ITEM_ARRAY     -- 額度種類
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_LIMIT_DTL
-- Purpose: 查詢分項額度彙計檔資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李建邦    2019.06.06  created
-- 1.1 ESB18627  2019.10.23  performance adjust
-- 1.2 ESB18757  2020.04.15  新增查詢欄位-外匯業務類別
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_DTL
  ( i_limit_seq_no         IN VARCHAR2       -- 分項額度主檔序號
  , i_currency             IN VARCHAR2       -- 分項額度幣別
  , i_forign_business_type IN VARCHAR2       -- 外匯業務類別
  , o_cur                 OUT SYS_REFCURSOR  -- 回傳資料
  );

--**************************************************************************
-- SP_GET_LT_DTL_LIST_BY_S_LIST
-- Purpose: 利用分項額度主檔序號列表查詢分項額度彙計檔資料列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李建邦    2018.12.21  created
--
--**************************************************************************
  PROCEDURE SP_GET_LT_DTL_LIST_BY_S_LIST
  ( i_limit_seq_no_list IN ITEM_NUM_ARRAY -- 分項額度主檔序號
  , o_cur               OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_LT_AR_LIST_BY_S_LIST
-- Purpose: 利用分項額度主檔序號列表查詢應收帳款預支價金資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_GET_LT_AR_LIST_BY_S_LIST
  ( i_limit_seq_no_list IN ITEM_NUM_ARRAY -- 分項額度主檔序號
  , o_cur               OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_DEL_LIMIT_AR_BY_LIMIT
-- Purpose: 利用分項額度主檔序號刪除應收帳款預支價金額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_LIMIT_AR_BY_LIMIT
  ( i_limit_seq_no IN NUMBER  -- 分項額度主檔序號
  , o_row_count    OUT NUMBER -- 回傳筆數
  );

--**************************************************************************
-- SP_DEL_ALL_AD_AUTHORIZER
-- Purpose: 
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 XXXXX     2019.06.06  created
--
--**************************************************************************
  PROCEDURE SP_DEL_ALL_AD_AUTHORIZER
  ( i_appr_doc_seq_no IN NUMBER  -- 批覆書主檔序號
  , o_row_count       OUT NUMBER -- 回傳筆數 
  );

--**************************************************************************
-- SP_INS_SYND_LOAN_ADV_FEE
-- Purpose: 新增聯貸案預收手續費
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.01.03  created
--
--**************************************************************************
  PROCEDURE SP_INS_SYND_LOAN_ADV_FEE
  ( i_appr_doc_seq_no          IN NUMBER    --批覆書主檔序號
  , i_txn_branch               IN VARCHAR2  --交易分行
  , i_host_sno                 IN VARCHAR2  --主機交易序號
  , i_txn_date                 IN VARCHAR2  --登錄日期
  , i_registry_mk              IN VARCHAR2  --登錄解除註記
  , i_first_amort_date         IN VARCHAR2  --手續費首次入帳日
  , i_drawdown_expired_date    IN VARCHAR2  --可動用最後期限
  , i_fee_category             IN VARCHAR2  --預收手續費科目
  , i_fee_code                 IN VARCHAR2  --手續費代碼
  , i_fee_ccy                  IN VARCHAR2  --手續費幣別
  , i_total_fee_amt            IN NUMBER    --手續費累計總收取原幣金額
  , i_amort_amt_to_loan_acc_no IN NUMBER    --手續費已攤銷掛到帳號的原幣金額
  , i_amort_amt_to_ad_no       IN NUMBER    --手續費已攤銷但無掛到帳號之原幣金額
  , i_unamorit_fee_amt         IN NUMBER    --手續費尚未攤銷原幣金額
  , i_acc_branch               IN VARCHAR2  --預收手續費作帳單位
  , i_new_case_flag            IN VARCHAR2  --新舊案註記
  , i_old_case_total_amort_amt IN NUMBER    --舊案累計已攤銷金額
  , i_old_case_unamort_amt     IN NUMBER    --舊案尚未攤銷金額
  , o_seq_no                   OUT NUMBER   --回傳序號
  );

--**************************************************************************
-- SP_GET_SYND_LOAN_ADV_FEE
-- Purpose: 查詢聯貸案預收手續費
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.01.03  created
--
--**************************************************************************
  PROCEDURE SP_GET_SYND_LOAN_ADV_FEE
  ( i_appr_doc_seq_no IN NUMBER          --批覆書主檔序號
  , o_cur             OUT SYS_REFCURSOR  --回傳資料
  );

--**************************************************************************
-- SP_GET_SYND_LOAN_ADV_FEE_ONE
-- Purpose: 查詢聯貸案預收手續費
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.01.03  created
--
--**************************************************************************
  PROCEDURE SP_GET_SYND_LOAN_ADV_FEE_ONE
  ( i_appr_doc_seq_no IN NUMBER          --批覆書主檔序號
  , i_fee_code        IN VARCHAR2        --手續費代碼
  , o_cur             OUT SYS_REFCURSOR  --回傳資料
  );

--**************************************************************************
-- SP_UPD_SYND_LOAN_ADV_FEE
-- Purpose: 更新聯貸案預收手續費
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.01.03  created
--
--**************************************************************************
  PROCEDURE SP_UPD_SYND_LOAN_ADV_FEE
  ( i_synd_loan_advance_fee_seq_no IN NUMBER    -- 聯貸案預收手續費序號
  , i_appr_doc_seq_no              IN NUMBER    -- 批覆書主檔序號
  , i_txn_branch                   IN VARCHAR2  -- 交易分行
  , i_host_sno                     IN VARCHAR2  -- 主機交易序號
  , i_txn_date                     IN VARCHAR2  -- 登錄日期
  , i_registry_mk                  IN VARCHAR2  -- 登錄解除註記
  , i_first_amort_date             IN VARCHAR2  -- 手續費首次入帳日
  , i_drawdown_expired_date        IN VARCHAR2  -- 可動用最後期限
  , i_fee_category                 IN VARCHAR2  -- 預收手續費科目
  , i_fee_code                     IN VARCHAR2  -- 手續費代碼
  , i_fee_ccy                      IN VARCHAR2  -- 手續費幣別
  , i_total_fee_amt                IN NUMBER    -- 手續費累計總收取原幣金額
  , i_amort_amt_to_loan_acc_no     IN NUMBER    -- 手續費已攤銷掛到帳號的原幣金額
  , i_amort_amt_to_ad_no           IN NUMBER    -- 手續費已攤銷但無掛到帳號之原幣金額
  , i_unamorit_fee_amt             IN NUMBER    -- 手續費尚未攤銷原幣金額
  , i_acc_branch                   IN VARCHAR2  -- 預收手續費作帳單位
  , i_new_case_flag                IN VARCHAR2  -- 新舊案註記
  , i_old_case_total_amort_amt     IN NUMBER    -- 舊案累計已攤銷金額
  , i_old_case_unamort_amt         IN NUMBER    -- 舊案尚未攤銷金額
  , o_row_count                    OUT NUMBER   -- 回傳更新筆數
  );

--**************************************************************************
-- SP_DEL_SYND_LOAN_ADV_FEE_PK
-- Purpose: 刪除聯貸案預收手續費
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.01.03  created
--
--**************************************************************************
  PROCEDURE SP_DEL_SYND_LOAN_ADV_FEE_PK
  ( i_synd_loan_advance_fee_seq_no IN NUMBER   -- 聯貸案預收手續費序號
  , o_row_count                    OUT NUMBER  -- 回傳更新筆數
  );

--**************************************************************************
-- SP_GET_LOAN_ADV_HANDLING_FEE
-- Purpose: 查詢預收手續費資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 吳筠宜   2019.01.04 created
-- 
--**************************************************************************
  PROCEDURE SP_GET_LOAN_ADV_HANDLING_FEE 
  ( i_loan_seq_no         IN NUMBER         -- 放款主檔序號
  , i_last_amort_date     IN VARCHAR2       -- 最近一次的攤銷日期
  , i_total_amort_fee     IN NUMBER         -- 本帳號累積攤銷的手續費
  , i_monthly_amort_amt   IN NUMBER         -- 當月內累積攤銷的手續費
  , i_ccy                 IN VARCHAR2       -- 幣別
  , i_reg_doc_no          IN VARCHAR2       -- 登錄文件號碼
  , i_reg_date            IN VARCHAR2       -- 登錄日期
  , i_reg_host_sno        IN VARCHAR2       -- 登錄主機交易序號
  , i_reg_txn_branch      IN VARCHAR2       -- 登錄交易分行
  , i_reg_sup_emp_id      IN VARCHAR2       -- 登錄交易主管員編
  , i_reg_teller_emp_id   IN VARCHAR2       -- 登錄交易櫃員員編
  , i_reg_time            IN VARCHAR2       -- 登錄時間
  , i_reg_sup_card        IN VARCHAR2       -- 登錄授權主管卡號
  , i_adv_category        IN VARCHAR2       -- 預收手續費科目
  , i_adv_amrtiz_category IN VARCHAR2       -- 預收攤提收入科目
  , i_recov_type          IN VARCHAR2       -- 聯貸收回方式 
  , i_fee_code            IN VARCHAR2       -- 手續費科目
  , o_cur                 OUT SYS_REFCURSOR -- 回傳資料
  );

--**************************************************************************
-- SP_GET_ADV_HANDLING_FEE_BY_CAT
-- Purpose: 查詢預收手續費資訊
--
-- Modification History
-- Person    Date    Comments
-- ----------  ---------- ---------------------------------------------
-- 1.0 吳筠宜   2019.01.04 created
-- 
--**************************************************************************
  PROCEDURE SP_GET_ADV_HANDLING_FEE_BY_CAT 
  ( i_loan_seq_no  IN NUMBER         -- 放款主檔序號
  , i_adv_category IN VARCHAR2       -- 預收手續費科目
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料
  );

--*************************************************************************
-- SP_DEL_LOAN_ADV_HANDLING_FEE_PK
-- Purpose: 刪除預收手續費資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2018.01.04  created
--
--**************************************************************************
  PROCEDURE SP_DEL_LOAN_ADV_HANDLING_FEE_PK
  ( i_loan_adv_handling_fee_seq_no IN NUMBER  -- 預收手續費資訊序號
  , o_row_count                    OUT NUMBER -- 回傳更新筆數
  );

--*************************************************************************
-- SP_INS_LIMIT_PROJ_COND_PROF
-- Purpose: 專案屬性註記批示條件檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈     2019.01.08 created
--
--**************************************************************************
  PROCEDURE SP_INS_LIMIT_PROJ_COND_PROF
  ( i_limit_profile_seq_no IN NUMBER   -- 分項批示條件檔序號
  , i_project_code         IN VARCHAR2 -- 專案屬性註記
  , o_seq_no               OUT NUMBER  -- 屬性註記批示條件檔序號
  );

--*************************************************************************
-- SP_DEL_APPR_DOC_ALL_BY_PK
-- Purpose: 放款存單質借動用沖正需刪除「批覆書、批覆書核轉人員、擔保品、分項額度、分項額度批示設定檔」
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 謝宇倫    2019.01.08   created
--
--**************************************************************************
  PROCEDURE SP_DEL_APPR_DOC_ALL_BY_PK
  ( i_appr_doc_seq_no IN NUMBER -- 批覆書主檔序號
  , i_limit_seq_no    IN NUMBER -- 分項額度主檔序號
  , o_row_count OUT NUMBER
  );

--*************************************************************************
-- SP_CNT_PROJECT_CODE
-- Purpose: 專案屬性註記筆數，專案屬性註記條件為字串轉陣列A,B,C,D -> ('A','B','C','D')
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 Cooper     2019.01.24  created
--
--**************************************************************************
  PROCEDURE SP_CNT_PROJECT_CODE 
  ( i_limit_seq_no IN NUMBER   -- 分項額度主檔序號
  , i_project_code IN VARCHAR2 -- 專案屬性註記
  , o_cnt          OUT NUMBER  -- 回傳資料
  );

--*************************************************************************
-- SP_CNT_PROD_MORTGAGE_PROFILE
-- Purpose: 房貸產品種類數量，房貸產品種類條件為字串轉陣列A,B,C,D -> ('A','B','C','D')
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 Cooper     2019.01.24  created
--
--**************************************************************************
  PROCEDURE SP_CNT_PROD_MORTGAGE_PROFILE 
  ( i_limit_seq_no     IN NUMBER   -- 分項額度主檔序號
  , i_mortgage_product IN VARCHAR2 -- 房貸產品種類
  , o_cnt              OUT NUMBER  -- 回傳資料
  );

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
  );

--**************************************************************************
-- 719 SP_GET_GUAR_BY_DOCSQN
-- Purpose: 以批覆書主檔序號取得保證人資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.01.21  created
--
--**************************************************************************
  PROCEDURE SP_GET_GUAR_BY_DOCSQN
  ( i_appr_doc_seq_no IN NUMBER             -- 批覆書主檔序號
  , o_cur             OUT SYS_REFCURSOR     -- 回傳保證人資料
  );

--**************************************************************************
-- 722 SP_GET_GUAR_BY_GCID_PHR_PAGE
-- Purpose: 以保證人銀行歸戶統編及保證狀態取得保證人資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.01.21  created
--
--**************************************************************************
  PROCEDURE SP_GET_GUAR_BY_GCID_PHR_PAGE
  ( i_customer_id  IN VARCHAR2       -- 銀行歸戶統編
  , i_phase        IN VARCHAR2       -- 保證狀態
  , o_cur          OUT SYS_REFCURSOR -- 回傳保證人資料
  );

--**************************************************************************
-- 860 SP_GET_BWR_GUAR_ALL
-- Purpose: 借保戶查詢全部（借戶及保戶）
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.01.21  created
-- 1.1 葉庭宇     2019.05.28 modified
--**************************************************************************
  PROCEDURE SP_GET_BWR_GUAR_ALL
  ( i_customer_id   IN VARCHAR2       -- 銀行歸戶統編
  , i_phase         IN VARCHAR2       -- 保證狀態
  , i_start_row     IN NUMBER         -- 起始筆數
  , i_record_number IN NUMBER         -- 每頁筆數
  , o_cur           OUT SYS_REFCURSOR -- 回傳保證人資料   
  );

--*************************************************************************
-- SP_DEL_APPR_DOC_AUTH_BY_APDSNO
-- Purpose: 刪除批覆書核轉人員資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 謝宇倫     2019.01.18 created
--
--**************************************************************************
  PROCEDURE SP_DEL_APPR_DOC_AUTH_BY_APDSNO
  ( i_appr_doc_seq_no IN NUMBER -- 批覆書主檔序號
  );

--***************************************************
-- SP_GET_LIMIT_DTL_LIST
-- Purpose: 查詢分項額度彙計檔資料
--
-- Modification History
-- Person              Date          Comments
-- --------------      ----------    -----------------
-- 1.0 劉佑慈           2019.01.28    created
--
--****************************************************
  PROCEDURE SP_GET_LIMIT_DTL_LIST
  ( i_limit_seq_no IN NUMBER         -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料
  );

--*************************************************************************
-- SP_GET_COUNT_LOAN
-- Purpose: 查詢放款主檔總數
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈     2019.02.01 created
--
--**************************************************************************
  PROCEDURE SP_GET_COUNT_LOAN
  ( i_appr_doc_seq_no IN NUMBER  -- 批覆書主檔序號
  , o_count           OUT NUMBER
  );

--*************************************************************************
-- SP_GET_COUNT_FOREIGN
-- Purpose: 查詢外匯交易主檔總數
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈     2019.02.01 created
--
--**************************************************************************
  PROCEDURE SP_GET_COUNT_FOREIGN
  ( i_appr_doc_seq_no IN NUMBER  -- 批覆書主檔序號
  , o_count           OUT NUMBER -- 查詢筆數
  );

--*************************************************************************
-- SP_GET_COUNT_INDIR_CREDIT
-- Purpose:
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈     2019.02.11 created
--
--**************************************************************************
  PROCEDURE SP_GET_COUNT_INDIR_CREDIT
  ( i_appr_doc_seq_no IN NUMBER  -- 批覆書主檔序號
  , o_count           OUT NUMBER -- 查詢筆數
  );

--*************************************************************************
-- SP_GET_COUNT_OVERDRAFT
-- Purpose: 查詢分項額度透支資訊檔總數
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈     2019.02.01 created
--
--**************************************************************************
  PROCEDURE SP_GET_COUNT_OVERDRAFT
  ( i_appr_doc_seq_no IN NUMBER  -- 批覆書主檔序號
  , o_count           OUT NUMBER -- 查詢筆數
  );

--*************************************************************************
-- SP_UPD_LIMIT_USED
-- Purpose: 將分項額度狀態未使用改為使用中
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈    2019.02.18  created
--
--**************************************************************************
  PROCEDURE SP_UPD_LIMIT_USED
  ( i_limit_seq_no IN NUMBER  -- 分項額度主檔序號
  , o_row_count    OUT NUMBER -- 回傳異動筆數 
  );

--*************************************************************************
-- SP_UPD_LIMIT_PROFILE_FDD
-- Purpose: 更新分項批示條件檔首次動撥日
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈    2019.02.18  created
--
--**************************************************************************
  PROCEDURE SP_UPD_LIMIT_PROFILE_FDD
  ( i_limit_seq_no IN NUMBER   -- 分項額度主檔序號
  , i_date         IN VARCHAR2 -- 分項首次動撥日
  , o_row_count    OUT NUMBER  -- 異動筆數
  );

--*************************************************************************
-- SP_DEL_OVERDRAFT
-- Purpose: 刪除分項額度透支資訊檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈    2019.02.18  created
--
--**************************************************************************
  PROCEDURE SP_DEL_OVERDRAFT
  ( i_overdraft_seq_no IN NUMBER -- 分項額度透支資訊檔序號
  , o_row_count OUT NUMBER       -- 刪除筆數
  );

--*************************************************************************
-- SP_DEL_OVERDRAFT_BY_SELECT
-- Purpose: 搜尋刪除分項額度透支資訊檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈    2019.02.18  created
--
--**************************************************************************
  PROCEDURE SP_DEL_OVERDRAFT_BY_SELECT
  ( i_limit_seq_no IN NUMBER   -- 分項額度主檔序號
  , i_account_no   IN NUMBER   -- 帳號序號
  , i_account_type IN VARCHAR2 -- 帳號類別
  , i_currency     IN VARCHAR2 -- 幣別
  , o_row_count     OUT NUMBER -- 刪除筆數
  );

--*************************************************************************
-- SP_GET_FILTER_OVERDRAFT
-- Purpose: 過濾查詢透支明細
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈    2019.02.18  created
-- 1.1 ESB18627 2019.10.24  performance adjust /存款部分沒有INDEX，如有效能問題請存款新增INDEX
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
  );

--*************************************************************************
-- SP_GET_APPR_DOC_TEMP
-- Purpose: 取得批覆書暫存資料檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈    2019.02.18  created
--
--**************************************************************************
  PROCEDURE SP_GET_APPR_DOC_TEMP
  ( i_data_type       IN VARCHAR2       -- 資料類型
  , i_appr_doc_seq_no IN NUMBER         -- 批覆書主檔序號
  , i_limit_seq_no    IN NUMBER         -- 分項額度主檔序號
  , o_cur             OUT SYS_REFCURSOR -- 回傳資料
  );

--*************************************************************************
-- SP_INS_APPR_DOC_TEMP
-- Purpose: 新增批覆書暫存資料檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈    2019.02.18  created
--
--**************************************************************************
  PROCEDURE SP_INS_APPR_DOC_TEMP
  ( i_data_type       IN VARCHAR2 -- 資料類型
  , i_appr_doc_seq_no IN NUMBER   -- 批覆書主檔序號
  , i_limit_seq_no    IN NUMBER   -- 分項額度主檔序號
  , i_temp_data       IN VARCHAR2 -- 資料內容
  , o_seq_no          OUT NUMBER  -- 批覆書暫存資料檔序號
  );

--*************************************************************************
-- SP_DEL_APPR_DOC_TEMP
-- Purpose: 刪除批覆書暫存資料檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈    2019.02.18  created
--
--**************************************************************************
  PROCEDURE SP_DEL_APPR_DOC_TEMP
  ( i_type            IN VARCHAR2 -- 資料類型
  , i_appr_doc_seq_no IN NUMBER   -- 批覆書主檔序號
  , i_limit_seq_no    IN NUMBER   -- 分項額度主檔序號
  , o_row_count       OUT NUMBER  -- 回傳筆數 
  );

--*************************************************************************
-- SP_INS_VOSTRO_OVERDRAFT_LIMIT
-- Purpose: 新增同存透支額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.02.19  created
--
--**************************************************************************
  PROCEDURE SP_INS_VOSTRO_OVERDRAFT_LIMIT
  ( i_customer_loan_seq_no     IN NUMBER    -- 授信戶主檔序號
  , i_appr_date                IN VARCHAR2  -- 透支核准日
  , i_last_chg_date            IN VARCHAR2  -- 上次變更日
  , i_overdraft_limit_ccy      IN VARCHAR2  -- 透支額度幣別
  , i_intraday_apprd_amt       IN NUMBER    -- 日間透支核准額度
  , i_end_of_dal_apprd_amt     IN NUMBER    -- 日終透支核准額度
  , i_overdraft_limit_effec_mk IN VARCHAR2  -- 透支額度有效註記
  , i_approved_no              IN VARCHAR2  -- 核准文號
  , i_saving_acc_no            IN VARCHAR2  -- 存款帳號
  , o_seq_no                   OUT NUMBER   -- 回傳序號
  );

--*************************************************************************
-- SP_UPD_VOSTRO_OVERDRAFT_LIMIT
-- Purpose: 修改同存透支額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.02.19  created
--
--**************************************************************************
  PROCEDURE SP_UPD_VOSTRO_OVERDRAFT_LIMIT
  ( i_vostro_overdraft_limit_seq IN NUMBER    -- 同存透支額度資訊序號
  , i_customer_loan_seq_no       IN NUMBER    -- 授信戶主檔序號
  , i_appr_date                  IN VARCHAR2  -- 透支核准日
  , i_last_chg_date              IN VARCHAR2  -- 上次變更日
  , i_overdraft_limit_ccy        IN VARCHAR2  -- 透支額度幣別
  , i_intraday_apprd_amt         IN NUMBER    -- 日間透支核准額度
  , i_end_of_dal_apprd_amt       IN NUMBER    -- 日終透支核准額度
  , i_overdraft_limit_effec_mk   IN VARCHAR2  -- 透支額度有效註記
  , i_approved_no                IN VARCHAR2  -- 核准文號
  , i_saving_acc_no              IN VARCHAR2  -- 存款帳號
  , o_row_count                  OUT NUMBER   -- 回傳更新筆數
  );

--*************************************************************************
-- SP_GET_VOSTRO_OVERDRAFT_LIMIT
-- Purpose: 取得同存透支額度資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.02.19  created
--
--**************************************************************************
  PROCEDURE SP_GET_VOSTRO_OVERDRAFT_LIMIT
  ( i_cust_id   IN  VARCHAR2       -- 銀行歸戶統編
  , o_cur       OUT SYS_REFCURSOR  -- 回傳資料
  );

--*************************************************************************
-- SP_INS_CUST_LIMIT_DTL
-- Purpose: 新增授信戶額度彙計檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.02.19  created
--
--**************************************************************************
  PROCEDURE SP_INS_CUST_LIMIT_DTL
  ( i_customer_loan_seq_no        IN NUMBER    -- 授信戶主檔序號
  , i_ccy                         IN VARCHAR2  -- 幣別
  , i_business_type               IN VARCHAR2  -- 業務別
  , i_last_txn_date               IN VARCHAR2  -- 最後交易日
  , i_total_drawdown_amt          IN NUMBER    -- 累積動用金額
  , i_total_repaymt_amt           IN NUMBER    -- 累積還款金額
  , i_total_appr_doc_drawdown_amt IN NUMBER    -- 佔用批覆書累積額度
  , i_total_nego_amt              IN NUMBER    -- 累積和解總額 
  , o_seq_no                      OUT NUMBER   -- 回傳序號
  );

--*************************************************************************
-- SP_UPD_CUST_LIMIT_DTL
-- Purpose: 修改授信戶額度彙計檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.02.19  created
--
--**************************************************************************
  PROCEDURE SP_UPD_CUST_LIMIT_DTL
  ( i_cust_limit_dtl_seq_no        IN NUMBER    -- 授信戶額度彙計檔序號
  , i_customer_loan_seq_no         IN NUMBER    -- 授信戶主檔序號
  , i_ccy                          IN VARCHAR2  -- 幣別
  , i_last_txn_date                IN VARCHAR2  -- 最後交易日
  , i_business_type                IN VARCHAR2  -- 業務別
  , i_total_drawdown_amt           IN NUMBER    -- 累積動用金額
  , i_total_repaymt_amt            IN NUMBER    -- 累積還款金額
  , i_total_appr_doc_drawdown_amt  IN NUMBER    -- 佔用批覆書累積額度
  , i_total_nego_amt               IN NUMBER    -- 累積和解總額 
  , o_row_count                    OUT NUMBER   -- 回傳更新筆數
  );

--*************************************************************************
-- SP_GET_CUST_LIMIT_DTL
-- Purpose: 取得授信戶額度彙計檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.02.19  created
--
--**************************************************************************
  PROCEDURE SP_GET_CUST_LIMIT_DTL
  ( i_cust_id       IN VARCHAR2        -- 銀行歸戶統編
  , i_currency      IN VARCHAR2        -- 幣別
  , i_business_type IN VARCHAR2        -- 業務別
  , o_cur           OUT SYS_REFCURSOR  -- 回傳資料
  );

--*************************************************************************
-- SP_GET_LIMIT_COMBINED_LIST
-- Purpose: 以分項額度查詢組合額度設定檔列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈     2019.03.15  created
--
--**************************************************************************      
  PROCEDURE SP_GET_LIMIT_COMBINED_LIST
  ( i_limit_seq_no IN NUMBER         -- 分項額度主檔序號
  , o_cur          OUT SYS_REFCURSOR -- 回傳資料
  );

--*************************************************************************
-- SP_DEL_CUST_LIMIT_DTL
-- Purpose: 刪除授信戶額度彙計檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李建邦     2019.03.20  created
--
--**************************************************************************
  PROCEDURE SP_DEL_CUST_LIMIT_DTL
  ( i_loan_cust_seq_no IN NUMBER   -- 授信戶主檔序號
  , i_business_type    IN VARCHAR2 -- 業務別
  , i_currency         IN VARCHAR2 -- 幣別
  , o_row_count        OUT NUMBER  -- 刪除筆數
  );

--*************************************************************************
-- SP_UPD_LIMIT_DTL
-- Purpose: 更新分項額度彙計檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李建邦     2019.03.22  created
--
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
  );

--*************************************************************************
-- SP_GET_PREPAID_STOCK_TXN
-- Purpose: 查詢特定墊付股款交易紀錄
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李栢陞     2019.03.25  created
--
--**************************************************************************
  PROCEDURE SP_GET_PREPAID_STOCK_TXN
  ( i_txn_date  IN  VARCHAR2      -- 登錄日期
  , i_branch    IN  VARCHAR2      -- 分行代號
  , i_host_sno  IN  VARCHAR2      -- 主機交易序號
  , o_cur       OUT SYS_REFCURSOR -- 回傳資料
  );

--*************************************************************************
-- SP_GET_COUNT_APPR_DOC_HISTORY
-- Purpose: 取得批覆書變更紀錄查詢總數
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈     2019.03.26  created
--
--**************************************************************************
  PROCEDURE SP_GET_COUNT_APPR_DOC_HISTORY
  ( i_appr_doc_seq_no           IN NUMBER   -- 批覆書主檔序號
  , i_modify_code_operator      IN VARCHAR2 -- 變更代號運算子
  , i_modify_code               IN VARCHAR2 -- 變更代號
  , i_transaction_type_operator IN VARCHAR2 -- 交易分類運算子
  , i_transaction_type          IN VARCHAR2 -- 交易分類
  , o_count                     OUT NUMBER  -- 回傳筆數 
  );

--*************************************************************************
-- SP_GET_CUST_APPR_DOC_LIST	
-- Purpose: 查詢歸戶下批覆書列表
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈     2019.03.26  created
--
--**************************************************************************
  PROCEDURE SP_GET_CUST_APPR_DOC_LIST
  ( i_cust_id    IN VARCHAR2       -- 銀行歸戶統編
  , i_limit_type IN VARCHAR2       -- 額度種類
  , i_date       IN VARCHAR2       -- 批覆書到期日
  , o_cur        OUT SYS_REFCURSOR -- 回傳資料
  );
  
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
  );

--*************************************************************************
-- 1834  SP_GET_APPR_DOC_BY_CUST_SEQ_NO
-- Purpose: 以授信戶主檔序號取得該授信戶所有的批覆書。
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維  2019.05.15  created
--
--**************************************************************************
  PROCEDURE  SP_GET_APPR_DOC_BY_CUST_SEQ_NO 
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , o_cur                  OUT SYS_REFCURSOR -- 批覆書資料
  );

--*************************************************************************
-- SP_GET_CORP_BUSINESS_ACC_NO
-- Purpose: 取得企金業務專戶
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 黃偉庭     2019.06.19  created
--
--**************************************************************************
  PROCEDURE  SP_GET_CORP_BUSINESS_ACC_NO 
  ( i_account_branch        IN VARCHAR2         -- 記帳單位
  , o_account_no            OUT VARCHAR2        -- 活存帳號
  );

--*************************************************************************
--  SP_DEL_APPR_DOC_ALL_DATA
-- Purpose: 以批覆書主檔序號刪除批覆書所有相關table
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 MARS      2019.07.03  created
--
--**************************************************************************
  PROCEDURE  SP_DEL_APPR_DOC_ALL_DATA 
  ( i_appr_doc_seqno IN item_num_array  -- 批覆書主檔序號(多筆)
  , o_count          OUT NUMBER         -- 筆數
  );

--*************************************************************************
--  SP_GET_LIMIT
-- Purpose: 以批覆書主檔序號查詢分項額度檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈      2019.07.03  created
--
--************************************************************************** 
  PROCEDURE SP_GET_LIMIT(i_appr_doc_seq_no IN NUMBER, o_cur OUT SYS_REFCURSOR);

  --*************************************************************************
--  SP_GET_GUARANTOR_UNDER_AD
-- Purpose:	取得批覆書下保證人資訊
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
  );

--*************************************************************************
--  SP_GET_APPR_DOC_BY_SEQNO
-- Purpose:	取得批覆書主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 劉佑慈      2019.07.03  created
--
--**************************************************************************    
  PROCEDURE SP_GET_APPR_DOC_BY_SEQNO( i_appr_doc_seq_no IN NUMBER, o_cur OUT SYS_REFCURSOR);

--**************************************************************************
-- SP_UPD_PREPAID_STOCK_TXN
-- Purpose: 更新特定墊付股款交易紀錄
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李柏陞     2019.07.05  created
--
--**************************************************************************  
  PROCEDURE SP_UPD_PREPAID_STOCK_TXN
  (     i_limit_seq_no              IN  NUMBER
    ,   i_txn_date                  IN  VARCHAR2
    ,   i_txn_sno                   IN  NUMBER
    ,   i_txn_time                  IN  VARCHAR2
    ,   i_branch                    IN  VARCHAR2
    ,   i_host_sno                  IN  VARCHAR2
    ,   i_sup_card_code             IN  VARCHAR2
    ,   i_txn_id                    IN  VARCHAR2
    ,   i_txn_memo                  IN  VARCHAR2
    ,   i_acc_branch                IN  VARCHAR2
    ,   i_dc_code                   IN  VARCHAR2
    ,   i_action_code               IN  VARCHAR2
    ,   i_txn_amt                   IN  NUMBER
    ,   i_prepaid_balance           IN  NUMBER
    ,   i_saving_acc_no             IN  VARCHAR2
    ,   i_saving_acc_cust_id        IN  VARCHAR2
    ,   i_prepaid_acc_category      IN  VARCHAR2
    ,   i_debit_acc_no              IN  VARCHAR2
    ,   i_to_saving_acc_no          IN  VARCHAR2
    ,   i_appr_doc_seq_no           IN  NUMBER
    ,   i_limit_type                IN  VARCHAR2
    ,   i_is_ec                     IN  VARCHAR2
    ,   o_row_count                 OUT NUMBER -- 回傳資料
  );

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
            ) ;

--**************************************************************************
-- SP_GET_LIMIT_BY_SEQNO_TYPE
-- Purpose: 以批覆書主檔序號及額度種類查詢分項額度主檔
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 李建邦     2019.07.22  created
--
--**************************************************************************
  PROCEDURE SP_GET_LIMIT_BY_SEQNO_TYPE
            ( i_appr_doc_seq_no IN NUMBER        --批覆書主檔序號
            , i_limit_type      IN VARCHAR2      --額度種類
            , o_cur            OUT SYS_REFCURSOR --回傳資料
            ) ;

--*************************************************************************
--  SP_GET_CUST_LIMIT_DTL_BY_CLSEQ
-- Purpose: 以授信戶主檔序號取得授信戶額度彙計檔資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維      2019.08.26  created
--
--**************************************************************************
  PROCEDURE  SP_GET_CUST_LIMIT_DTL_BY_CLSEQ
  ( i_customer_loan_seq_no  IN NUMBER        -- 授信戶主檔序號
  , o_cur                  OUT SYS_REFCURSOR -- 授信戶額度彙計檔
  );

--*************************************************************************
--  SP_GET_GUARANTOR_SEQS_BY_CLSEQ
-- Purpose: 以授信戶主檔序號取得[保證人資料檔]資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維      2019.08.26  created
--
--**************************************************************************
  PROCEDURE  SP_GET_GUARANTOR_SEQS_BY_CLSEQ
  ( i_customer_loan_seq_no  IN NUMBER        -- 授信戶主檔序號
  , o_cur                  OUT SYS_REFCURSOR -- 保證人資料檔
  );


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
  );

  --*************************************************************************
-- SP_GET_COUNT_LIMIT_UNTRANS
-- Purpose: 取得批覆書下未移轉額度數目。
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 吳筠宜     2019.09.17  created
--
--**************************************************************************
  PROCEDURE SP_GET_COUNT_LIMIT_UNTRANS
  ( i_appr_doc_seq_no     IN NUMBER  -- 批覆書主檔序號
  , o_count              OUT NUMBER  -- 未移轉額度數目
  );

--**************************************************************************
-- SP_GET_AD_LIMIT_FOR_CALC
-- Purpose: 取得批覆書下所有分項的各項金額總和，以分項流水號、已佔預佔的幣別做群組
--          (批覆書額度計算使用)
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
  );

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
  );

--**************************************************************************
-- SP_GET_LIMIT_PROJ_CODE_BY_AD
-- Purpose: 取得批覆書所有分項的專案代號
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
  );

--**************************************************************************
-- SP_GET_OVERDRAFT_LIST_BY_AD
-- Purpose: 查詢分項額度透支資訊檔列表(By批覆書)
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 ESB20276  2019.11.05  create
--**************************************************************************
  PROCEDURE SP_GET_OVERDRAFT_LIST_BY_AD
  ( i_appr_doc_seq_no      IN NUMBER         -- 分項額度主檔序號
  , o_cur               OUT SYS_REFCURSOR -- 回傳資料
  );
  
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
  );
  
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
  );
  
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
  );
  
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
  );

--*************************************************************************
-- SP_GET_GUARANTOR_APPDOC_LIMIT
-- Purpose: 取得[保證人資料檔]資訊
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 ELITE-Ryan 2019.12.20  created
--
--**************************************************************************
  PROCEDURE SP_GET_GUARANTOR_APPDOC_LIMIT
  ( i_appr_doc_seq_no IN  NUMBER        --批覆書主檔序號
  , i_limit_seq_no    IN  NUMBER        --分項額度主檔序號
  , o_cur             OUT SYS_REFCURSOR --回傳資料
  );

--**************************************************************************
-- SP_GET_CUST_RRSAC_AUTO_TRANS
-- Purpose: 以授信戶主檔序號查詢備償專戶自動轉帳登錄資料
--
-- Modification History
-- Person        Date        Comments
-- ----------    ----------  ---------------------------------------------
-- 1.0 康晉維     2019.12.24  created
--
--**************************************************************************
  PROCEDURE SP_GET_CUST_RRSAC_AUTO_TRANS 
  ( i_customer_loan_seq_no IN NUMBER         -- 授信戶主檔序號
  , o_cur                  OUT SYS_REFCURSOR -- 回傳資料
  ); 
  
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
  );
  
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
  ( i_customer_loan_seq_no    IN  NUMBER         -- 銀行歸戶統編
  , o_cur                    OUT  SYS_REFCURSOR  -- 回傳資料
  );

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
  );

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
  );

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
  );

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
  );

END PG_APPR_DOC_LIMIT;