/*
=================================================================
LOAD SOURCE DATA INTO RAW TABLES
=================================================================
Loads source CSV files into raw tables without applying
cleaning or transformation.
=================================================================
*/

TRUNCATE TABLE raw.attendance;
BULK INSERT raw.attendance
FROM 'C:\Users\-\Documents\SQL-Learning\SQL Data Quality & Cleaning\Datasets\attendance.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a',
	TABLOCK
);
GO
---------------------------------------------------------------------------------------------

TRUNCATE TABLE raw.homework;
BULK INSERT raw.homework
FROM 'C:\Users\-\Documents\SQL-Learning\SQL Data Quality & Cleaning\Datasets\homework.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a',
	CODEPAGE = '65001',
	TABLOCK
);
GO
----------------------------------------------------------------------------------------------

TRUNCATE TABLE raw.students;
BULK INSERT raw.students
FROM 'C:\Users\-\Documents\SQL-Learning\SQL Data Quality & Cleaning\Datasets\students.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a',
	TABLOCK
);
GO
-----------------------------------------------------------------------------------------------

TRUNCATE TABLE raw.students_performance;
BULK INSERT raw.students_performance
FROM 'C:\Users\-\Documents\SQL-Learning\SQL Data Quality & Cleaning\Datasets\performance.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a',
	TABLOCK
);
GO
----------------------------------------------------------------------------------------------
TRUNCATE TABLE raw.teacher_parent_communication;
BULK INSERT raw.teacher_parent_communication
FROM 'C:\Users\-\Documents\SQL-Learning\SQL Data Quality & Cleaning\Datasets\teacher_parent_communication.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a',
	TABLOCK
);
GO