/*
=================================================================
CREATE RAW TABLES
=================================================================
Stores source data in its original form before data cleaning
and transformation.
=================================================================
*/
IF OBJECT_ID('raw.students_performance','U') IS NOT NULL
	DROP TABLE raw.students_performance
GO
CREATE TABLE raw.students_performance (
	Student_ID INT,
	Subject NVARCHAR(50),
	Exam_Score INT,
	Homework_Completion NVARCHAR(50),
	Teacher_Comments NVARCHAR(50)
)
GO
IF OBJECT_ID('raw.teacher_parent_communication','U') IS NOT NULL
	DROP TABLE raw.teacher_parent_communication
GO
CREATE TABLE raw.teacher_parent_communication (
	Student_ID INT,
	Date DATE,
	Message_Type NVARCHAR(50),
	Message_Content NVARCHAR(50)
)
GO
IF OBJECT_ID('raw.students','U') IS NOT NULL
	DROP TABLE raw.students
GO
CREATE TABLE raw.students (
	Student_ID INT,
	Full_Name NVARCHAR(50),
	Date_of_Birth DATE ,
	Grade_Level NVARCHAR(50),
	Emergency_Contact NVARCHAR(50)
)
GO
IF OBJECT_ID('raw.attendance','U') IS NOT NULL
	DROP TABLE raw.attendance
GO
CREATE TABLE raw.attendance (
	Student_ID INT,
	Date DATE,
	Subject NVARCHAR(50),
	Attendance_Status NVARCHAR(50)
)
GO
IF OBJECT_ID('raw.homework','U') IS NOT NULL
	DROP TABLE raw.homework
GO
CREATE TABLE raw.homework (
	Student_ID INT,
	Subject NVARCHAR(50),
	Assignment_Name NVARCHAR(50),
	Due_Date DATE,
	Status NVARCHAR(50),
	Grade_Feedback NVARCHAR(50),
	Guardian_Signature NVARCHAR(50)
)