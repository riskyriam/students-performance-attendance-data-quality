/*
=================================================================
CREATE DATA CLEANING RESULTS TABLE
=================================================================
Stores cleaned and standardized data after applying
data quality rules and cleaning transformations.
=================================================================
*/
IF OBJECT_ID('clean.attendance ', 'U') IS NOT NULL
    DROP TABLE quality.clean.attendance ;
GO
CREATE TABLE clean.attendance (
	Student_ID NVARCHAR(50),
	Date DATE,
	Subject NVARCHAR(50),
	Attendance_status NVARCHAR(50),
	Conflict_Flag INT
)
-----------------------------------------
IF OBJECT_ID('clean.homework ', 'U') IS NOT NULL
    DROP TABLE clean.homework ;
GO
CREATE TABLE clean.homework (
	Student_ID NVARCHAR(50),
	Subject NVARCHAR(50),
	Assignment_Name NVARCHAR(1000),
	Due_Date DATE,
	Status NVARCHAR(50),
	Grade_Feedback NVARCHAR(1000),
	Guardian_Signature NVARCHAR(50)
)

--------------------------------------
IF OBJECT_ID('clean.students ', 'U') IS NOT NULL
    DROP TABLE clean.students ;
GO
CREATE TABLE clean.students (
	Student_ID NVARCHAR(50),
	Full_Name NVARCHAR(50),
	Date_of_Birth DATE ,
	Grade_Level NVARCHAR(50),
	Emergency_Contact NVARCHAR(50),
	Age_Grade_Anomaly_Flag INT
)
----------------------------------------
IF OBJECT_ID('clean.students_performance', 'U') IS NOT NULL
	DROP TABLE clean.students_performance;
CREATE TABLE clean.students_performance (
		Student_ID NVARCHAR(50),
		Subject NVARCHAR(50),
		Exam_Score INT,
		Homework_Completion INT,
		Flag INT,
		Teacher_Comments NVARCHAR(1000)
)
-----------------------------------------
IF OBJECT_ID('clean.teacher_parent_communication', 'U') IS NOT NULL
	DROP TABLE clean.teacher_parent_communication;
CREATE TABLE clean.teacher_parent_communication (
	Student_ID NVARCHAR(50),
	Date DATE,
	Message_Type NVARCHAR(100),
	Message_Content NVARCHAR(1000)
)