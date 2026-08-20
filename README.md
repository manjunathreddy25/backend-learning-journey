# Backend Learning Journey - SQL & Database Mastery

A structured repository containing 31 days of SQL learning, from basic DDL/DML to advanced query optimization, stored procedures, window functions, and real-world database case studies.

## Table of Contents

| File | Topic / SQL Concepts |
| :--- | :--- |
| [`01_database_basics.sql`](./01_database_basics.sql) | Database Creation (`CREATE DATABASE`, `USE`, `SHOW DATABASES`) |
| [`02_alter_table_and_duplicate_detection.sql`](./02_alter_table_and_duplicate_detection.sql) | `ALTER TABLE`, `GROUP BY`, `HAVING`, Self-Join for Duplicate Detection |
| [`03_basic_filtering_and_sorting.sql`](./03_basic_filtering_and_sorting.sql) | Basic Filtering & Sorting (`WHERE`, `BETWEEN`, `IN`, `ORDER BY`, `DISTINCT`, Basic Joins) |
| [`04_data_modification_and_string_functions.sql`](./04_data_modification_and_string_functions.sql) | `UPDATE`, `DELETE`, Soft Delete (`is_deleted`, `deleted_at`), String Functions (`CONCAT`, `SUBSTRING`, `TRIM`) |
| [`05_math_and_date_functions.sql`](./05_math_and_date_functions.sql) | Math Functions (`ROUND`, `CEIL`, `FLOOR`, `ABS`) & Date Functions (`EXTRACT`, `TIMESTAMPDIFF`, `DATEDIFF`, `DATE_ADD`) |
| [`06_aggregate_functions.sql`](./06_aggregate_functions.sql) | Aggregate Functions (`SUM`, `AVG`, `MIN`, `MAX`, `COUNT`) & Subquery Aggregations |
| [`07_group_by_and_having.sql`](./07_group_by_and_having.sql) | Grouping & Filtering Aggregates (`GROUP BY`, `HAVING`, `ORDER BY`, Multi-column Grouping) |
| [`08_foreign_keys_and_inner_joins.sql`](./08_foreign_keys_and_inner_joins.sql) | Referential Integrity (`PRIMARY KEY`, `FOREIGN KEY`) & `INNER JOIN` |
| [`09_outer_cross_and_self_joins.sql`](./09_outer_cross_and_self_joins.sql) | Outer, Cross & Self Joins (`LEFT JOIN`, `RIGHT JOIN`, `CROSS JOIN`, Simulated `FULL JOIN`) |
| [`10_referential_integrity_and_cascade.sql`](./10_referential_integrity_and_cascade.sql) | Relational Constraints & Cascades (`ON DELETE CASCADE`, `ON DELETE SET NULL`, Composite Primary Keys) |
| [`11_column_constraints.sql`](./11_column_constraints.sql) | Column Constraints (`UNIQUE`, `CHECK`, `DEFAULT`, `NOT NULL`) |
| [`12_subqueries_and_correlated_subqueries.sql`](./12_subqueries_and_correlated_subqueries.sql) | Subqueries & Correlated Subqueries (Scalar, Multi-row `IN`/`ANY`/`ALL`, Derived Tables) |
| [`13_set_operations.sql`](./13_set_operations.sql) | Set Operations (`UNION`, `UNION ALL`, `INTERSECT`, `EXCEPT`) |
| [`14_database_normalization.sql`](./14_database_normalization.sql) | Database Normalization (Unnormalized Form, 1NF, 2NF, 3NF Examples) |
| [`15_sql_views.sql`](./15_sql_views.sql) | SQL Views (`CREATE VIEW`, Aggregate Views, Filtered Views) |
| [`16_indexes_and_performance_tuning.sql`](./16_indexes_and_performance_tuning.sql) | Indexes & Query Hints (`CREATE INDEX`, `FULLTEXT INDEX`, `FORCE INDEX`, Invisible Indexes) |
| [`17_stored_procedures.sql`](./17_stored_procedures.sql) | Stored Procedures (`CREATE PROCEDURE`, `IN`, `OUT`, `INOUT` Parameters, CRUD Procedures) |
| [`18_user_defined_functions.sql`](./18_user_defined_functions.sql) | User-Defined Functions (`CREATE FUNCTION`, Scalar UDFs, Budget Calculations) |
| [`19_database_triggers_and_auditing.sql`](./19_database_triggers_and_auditing.sql) | Database Triggers & Audit Logging (`BEFORE`/`AFTER` Triggers for `INSERT`, `UPDATE`, `DELETE`) |
| [`20_transactions_and_savepoints.sql`](./20_transactions_and_savepoints.sql) | Transactions & Concurrency Control (`COMMIT`, `ROLLBACK`, `SAVEPOINT`, Autocommit) |
| [`21_query_optimization_and_explain.sql`](./21_query_optimization_and_explain.sql) | Query Optimization & Execution Analysis (`EXPLAIN`, Selective Projection, Index-friendly Queries) |
| [`22_ecommerce_cart_funnel_analysis.sql`](./22_ecommerce_cart_funnel_analysis.sql) | Case Study: E-Commerce Funnel & Cart Analysis (Abandoned Carts, Conversion Rates) |
| [`23_customer_clv_and_churn_analysis.sql`](./23_customer_clv_and_churn_analysis.sql) | Case Study: Customer Lifetime Value & Churn Analysis (CLV, Active vs Churned Customers) |
| [`24_inventory_reorder_and_stock_health.sql`](./24_inventory_reorder_and_stock_health.sql) | Case Study: Inventory Reorder & Stock Health (Safety Stock, 30-day Avg Daily Sales, Reorder View & Procedure) |
| [`25_promotion_impact_and_revenue_analysis.sql`](./25_promotion_impact_and_revenue_analysis.sql) | Case Study: Discount & Promotion Impact Analysis (YoY Revenue, AOV Changes, Promo-only Customers) |
| [`26_price_anomaly_detection.sql`](./26_price_anomaly_detection.sql) | Case Study: Price Anomaly Detection (`LAG`, Window Moving Averages, Price Spike Alerts) |
| [`27_banking_fraud_detection.sql`](./27_banking_fraud_detection.sql) | Case Study: Banking Fraud Detection (High-Frequency Transactions, Impossible Travel Self-Joins) |
| [`28_ledger_balance_reconciliation.sql`](./28_ledger_balance_reconciliation.sql) | Case Study: Ledger & Balance Reconciliation (Running Totals `SUM OVER`, Mismatch Auditing) |
| [`29_tiered_interest_and_backdated_adjustments.sql`](./29_tiered_interest_and_backdated_adjustments.sql) | Case Study: Tiered Interest & Backdated Adjustments (Complex `CASE`, Daily Snapshots, Audit Recalculation) |
| [`30_hr_attendance_and_overtime_payroll.sql`](./30_hr_attendance_and_overtime_payroll.sql) | Case Study: HR Attendance & Overtime Payroll (Time Arithmetic, Shift Overlaps, Weekly OT Rules) |
| [`31_salary_revisions_and_pay_parity.sql`](./31_salary_revisions_and_pay_parity.sql) | Case Study: Salary Revisions & Pay Parity (`LAG` Window Functions, Group Averages, Pay Stagnancy Detection) |
