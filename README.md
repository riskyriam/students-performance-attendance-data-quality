# students-performance-attendance-data-quality
# SQL Data Quality & Cleaning Pipeline

This is my second project as I continue learning SQL and exploring data engineering workflows.

I’m fully aware that there might be mistakes, inconsistencies, or a flow that could be improved. But that’s part of the learning process, so… so be it lol.

# Disclaimer

The dataset used in this project is not originally mine. It was obtained from Kaggle and is used here for learning and practice purposes.

## **Project Initialization**

**Project Name**: Students Performance & Attendance Data Quality Pipeline

**Project Type:** SQL-based Data Quality & Data Cleaning Pipeline

**Primary Focus:** Data Quality, Data Cleaning, SQL, Relational Data Validation

**Main Tool:** SQL Server

**Objective:** Build a SQL-based data quality and cleaning pipeline to identify, analyze, clean, validate, and prepare students' performance and attendance data for reliable downstream use.

**Scope**

- Explore and profile the source data
- Identify data quality issues
- Define data quality rules
- Develop SQL-based cleaning and transformation logic
- Validate data consistency and integrity
- Produce clean and reliable datasets
- Document the data quality process and results

## Source Data Exploration

Tables:  5

1. Table Name: Attendance
    
    Column: Student_ID, Date, Subject, Attendance_Status
    
    Row: 364.681
    
2. Table Name: Peformance
    
    Column: Student_ID, Subject, Exam_Score, Homework_Completion_%, Teacher_Comments
    
    Row: 36.469
    
3. Table Name: teacher_parent_communication
    
    Column: Student_ID, Date, Message_Type, Message_Content
    
    Row: 24.313
    
4. Table Name: students
    
    Column: Student_ID, Full_Name, Date_of_Birth, Grade_Level, Emergency_Contact
    
    Row: 12.157
    
5. Table Name: homework
    
    Column: Student_ID, Subject, Assignment_name, Due_Date, Status, Grade_Feedback, Guardian_Signature
    

## Database & Schema Setup

Database Name: DataQuality

Schema divided into three: raw, quality, and clean

- raw: This is where the source data is ingested into the database. The data remains in its original form, preserving the structure and values from the source.
    
    table name: raw.attendance, raw.homework, raw.students, raw.students_performance, raw.teacher_parent_communication
    
- quality: This is where data anomalies and quality issues are identified and documented. It also helps determine the appropriate actions for addressing these issues based on business rules and decisions.
    
    table name: quality.data_quality_issues, quality. data_quality_rules
    
- clean: This is where data is cleaned and transformed based on the identified data quality issues and defined quality rules.
    
    table name:  clean.attendance, clean.homework, clean.students, clean.students_performance, clean.teacher_parent_communication
    

## Raw, Quality, and Clean Table Creation (DDL)

The DDL scripts for creating the Raw, Quality, and Clean tables are available in my GitHub repository.

## Data Profiling

Data profiling was performed in the Quality schema to assess the structure, completeness, consistency, and validity of the source data and identify potential data quality issues.

## Identify Data Quality Issues and Define Data Quality Rules

These steps were also performed in the Quality schema. The columns of each table were examined individually to identify data quality issues and define appropriate data quality rules for addressing them.

## Design Cleaning / Transformation Logic

Cleaning and transformation logic was designed based on the identified data quality issues and defined quality rules.

## Build Cleaning Pipeline

The cleaning process was implemented using SQL transformations to standardize values, handle missing data, remove duplicates where appropriate, and flag records requiring further review.

## Data Quality Validation

The cleaned tables were validated one by one to ensure that the defined cleaning and transformation rules were applied correctly. No unexpected errors or unusual results were found during the validation process.

## Testing & Reconciliation

The Raw and Clean tables were reconciled to verify that the cleaning process did not unintentionally remove or alter data. Row counts were compared between the Raw and Clean tables, and the 515 rows removed from the Attendance table were confirmed to be duplicate records identified by the cleaning logic. The other tables maintained consistent row counts after cleaning.
