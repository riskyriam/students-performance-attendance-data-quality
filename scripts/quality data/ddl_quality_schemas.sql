/*
=================================================================
CREATE DATA QUALITY RESULTS TABLE
=================================================================
Stores data quality issues identified during profiling,
validation, and cleaning processes.
=================================================================
*/
IF OBJECT_ID('quality.data_quality_issues', 'U') IS NOT NULL
    DROP TABLE quality.data_quality_issues;
GO
CREATE TABLE quality.data_quality_issues (
    issue_id INT IDENTITY(1,1),
    table_name NVARCHAR(100),
    column_name NVARCHAR(100),
    issue_type NVARCHAR(50),
    issue_description NVARCHAR(500),
    issue_count INT,
    affected_rows INT,
    created_at DATETIME2 DEFAULT GETDATE()
);
GO

IF OBJECT_ID('quality.data_quality_rules', 'U') IS NOT NULL
    DROP TABLE quality.data_quality_rules;
GO
CREATE TABLE quality.data_quality_rules (
    rule_id INT IDENTITY(1,1),
    table_name NVARCHAR(100),
    column_name NVARCHAR(100),
    rule_type NVARCHAR(50),
    rule_description NVARCHAR(500),
    cleaning_action NVARCHAR(500)
);
