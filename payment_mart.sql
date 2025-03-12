CREATE OR REPLACE TABLE `atarayo.0040_kanda_sample.payment_mart`
(
  claim_number STRING OPTIONS(description="債権番号"),
  assignment_date TIMESTAMP OPTIONS(description="受任日"),
  claim_status STRING OPTIONS(description="債権状況"),
  return_date STRING OPTIONS(description="返却日"),
  debtor_name STRING OPTIONS(description="債務者名"),
  debtor_name_kana STRING OPTIONS(description="債務者名（カナ）"),
  phone_number STRING OPTIONS(description="電話番号"),
  customer_number STRING OPTIONS(description="顧客番号"),
  customer_number_sub STRING OPTIONS(description="顧客番号（サブ）"),
  invoice_number STRING OPTIONS(description="伝票番号"),
  invoice_number_sub STRING OPTIONS(description="伝票番号（サブ）"),
  center_code STRING OPTIONS(description="センターコード"),
  center_name STRING OPTIONS(description="センター名"),
  purchasing_company_name STRING OPTIONS(description="購入社名"),
  claim_amount_at_assignment FLOAT64 OPTIONS(description="受任時債権額"),
  late_payment_penalty_at_assignment FLOAT64 OPTIONS(description="受任時遅延損害金"),
  collection_fee FLOAT64 OPTIONS(description="督促手数料"),
  adjustment_amount FLOAT64 OPTIONS(description="調整額"),
  adjustment_description STRING OPTIONS(description="調整内容"),
  contract_date STRING OPTIONS(description="契約日"),
  interest_calculation_start_date STRING OPTIONS(description="遅延損害金起算日"),
  write_off_date TIMESTAMP OPTIONS(description="消込日"),
  payment_date TIMESTAMP OPTIONS(description="入金日"),
  payment_id STRING OPTIONS(description="入金ID"),
  payment_method STRING OPTIONS(description="入金方法"),
  payer_name STRING OPTIONS(description="振込人名"),
  settlement_amount FLOAT64 OPTIONS(description="和解額"),
  payment_amount FLOAT64 OPTIONS(description="入金額"),
  allocated_amount FLOAT64 OPTIONS(description="充当金額"),
  allocated_amount_excluding_overpayment FLOAT64 OPTIONS(description="充当金額(過入金除く）"),
  payment_amount_principal FLOAT64 OPTIONS(description="入金額(元本相当分)"),
  payment_amount_interest FLOAT64 OPTIONS(description="入金額(遅延損害金相当分)"),
  remaining_claim_amount FLOAT64 OPTIONS(description="残債権額"),
  remaining_claim_amount_principal FLOAT64 OPTIONS(description="残債権額(元本分)"),
  remaining_claim_amount_interest FLOAT64 OPTIONS(description="残債権額(遅延損害金相当分)"),
  overpayment FLOAT64 OPTIONS(description="過入金"),
  excess_payment_amount_remitted FLOAT64 OPTIONS(description="過剰入金額（貴社送金）"),
  commission_rate FLOAT64 OPTIONS(description="報酬率")
)
AS
SELECT
claim_number,
CASE EXTRACT(year from assignment_date) WHEN 2024 THEN 
  CASE WHEN EXTRACT(month from assignment_date) IN (5,6) THEN 
    TIMESTAMP(DATE_ADD(DATE(assignment_date), INTERVAL 3 MONTH))
  WHEN EXTRACT(month from assignment_date) = 7 THEN 
    TIMESTAMP(DATE_ADD(DATE(assignment_date), INTERVAL -2 MONTH))
  WHEN EXTRACT(month from assignment_date) = 8 THEN 
    TIMESTAMP(DATE_ADD(DATE(assignment_date), INTERVAL -1 MONTH))
  WHEN EXTRACT(month from assignment_date) = 9 THEN 
    TIMESTAMP(DATE_ADD(DATE(assignment_date), INTERVAL -3 MONTH))
  ELSE assignment_date
  END
ELSE assignment_date
END AS assignment_date,
claim_status,
return_date,
debtor_name,
debtor_name_kana STRING,
phone_number,
customer_number,
customer_number_sub,
invoice_number,
invoice_number_sub,
center_code,
center_name,
purchasing_company_name,
claim_amount_at_assignment,
late_payment_penalty_at_assignment,
collection_fee,
adjustment_amount,
adjustment_description,
contract_date,
interest_calculation_start_date,
write_off_date,
CASE EXTRACT(year from assignment_date) WHEN 2024 THEN 
  CASE WHEN EXTRACT(month from assignment_date) IN (5,6) THEN 
    TIMESTAMP(DATE_ADD(DATE(payment_date), INTERVAL 3 MONTH))
  WHEN EXTRACT(month from assignment_date) = 7 THEN 
    TIMESTAMP(DATE_ADD(DATE(payment_date), INTERVAL -2 MONTH))
  WHEN EXTRACT(month from assignment_date) = 8 THEN 
    TIMESTAMP(DATE_ADD(DATE(payment_date), INTERVAL -1 MONTH))
  WHEN EXTRACT(month from assignment_date) = 9 THEN 
    TIMESTAMP(DATE_ADD(DATE(payment_date), INTERVAL -3 MONTH))
  ELSE payment_date
  END
ELSE payment_date
END AS payment_date,
payment_id,
payment_method,
payer_name,
settlement_amount,
-- CASE
--   WHEN payment_amount<=1000 THEN
--     GREATEST(payment_amount+Round(RAND()*1000)-500,1)
--   WHEN 1000<payment_amount AND payment_amount<=2000 THEN 
--     payment_amount+Round(RAND()*2000)-1000
--   WHEN 2000<payment_amount AND payment_amount<=3000 THEN 
--     payment_amount+Round(RAND()*4000)-2000
--   WHEN 3000<payment_amount AND payment_amount<=4000 THEN 
--     payment_amount+Round(RAND()*6000)-3000
--   WHEN 4000<payment_amount AND payment_amount<=5000 THEN 
--     payment_amount+Round(RAND()*8000)-4000
--   WHEN 5000<payment_amount AND payment_amount<=6000 THEN 
--     payment_amount+Round(RAND()*10000)-5000
--   WHEN 6000<payment_amount AND payment_amount<=7000 THEN 
--     payment_amount+Round(RAND()*12000)-6000
--   WHEN 7000<payment_amount AND payment_amount<=8000 THEN 
--     payment_amount+Round(RAND()*14000)-7000
--   WHEN 8000<payment_amount AND payment_amount<=9000 THEN 
--     payment_amount+Round(RAND()*16000)-8000
--   WHEN 9000<payment_amount AND payment_amount<=10000 THEN 
--     payment_amount+Round(RAND()*18000)-9000
--   WHEN 10000<payment_amount AND payment_amount<=20000 THEN 
--     payment_amount+Round(RAND()*20000)-10000
--   WHEN 20000<payment_amount AND payment_amount<=30000 THEN 
--     payment_amount+Round(RAND()*40000)-20000
--   WHEN 30000<payment_amount AND payment_amount<=40000 THEN 
--     payment_amount+Round(RAND()*60000)-30000
--   WHEN 40000<payment_amount AND payment_amount<=50000 THEN 
--     payment_amount+Round(RAND()*80000)-40000
--   WHEN 50000<payment_amount AND payment_amount<=60000 THEN 
--     payment_amount+Round(RAND()*100000)-50000
--   WHEN 60000<payment_amount AND payment_amount<=70000 THEN 
--     payment_amount+Round(RAND()*120000)-60000
--   WHEN 70000<payment_amount AND payment_amount<=80000 THEN 
--     payment_amount+Round(RAND()*140000)-70000
--   WHEN 80000<payment_amount AND payment_amount<=90000 THEN 
--     payment_amount+Round(RAND()*160000)-80000
--   WHEN 90000<payment_amount AND payment_amount<=100000 THEN 
--     payment_amount+Round(RAND()*180000)-90000
--   WHEN 100000<payment_amount THEN
--     payment_amount+Round(RAND()*200000)-100000
--   ELSE NULL
-- END 
ROUND(payment_amount*RAND()*2.5) AS payment_amount,
allocated_amount,
allocated_amount_excluding_overpayment,
payment_amount_principal,
payment_amount_interest,
remaining_claim_amount,
remaining_claim_amount_principal,
remaining_claim_amount_interest,
overpayment,
excess_payment_amount_remitted,
commission_rate
FROM `atarayo.0040_kanda_sample.deposit_log_raw`
WHERE MOD(CAST(customer_number AS INTEGER),5)!=2
;