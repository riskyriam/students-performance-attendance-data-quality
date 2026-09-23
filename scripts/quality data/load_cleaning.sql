/*============================================================================== 
LOAD CLEANING DATA
This script loads the cleaned data into the clean schema after applying the 
defined data quality rules.
===============================================================================*/
TRUNCATE TABLE clean.attendance
GO
WITH standardized AS (
    SELECT
    Student_ID,
    Date,
    Subject,
     CASE  WHEN TRIM(Attendance_Status) = 'PRESENT' THEN 'Present'
        WHEN TRIM(Attendance_Status) = 'late' THEN 'Late'
        WHEN TRIM(Attendance_Status) = 'excused' THEN 'Excused'
        WHEN TRIM(Attendance_Status) = 'left early' THEN 'Left Early'
        WHEN TRIM(Attendance_Status) = 'absnt' THEN 'Absent'
        ELSE TRIM(Attendance_Status)
    END as Attendance_Status
FROM raw.attendance
),
conflict_check AS (
    SELECT
        Student_ID,
        Date,
        Subject,
        COUNT(DISTINCT Attendance_Status) AS status_count
    FROM standardized 
    GROUP BY
        Student_ID,
        Date,
        Subject
),
conflict_flag AS (
    SELECT 
        Student_ID,
        Date,
        Subject,
        CASE WHEN status_count > 1 THEN 1
        ELSE 0
        END AS conflict_flag
    FROM conflict_check
),
numbered as (
    SELECT 
        s.student_ID,
        s.Date,
        s.Subject,
        s.Attendance_Status,
        cf.conflict_flag,
        ROW_NUMBER() OVER (
            PARTITION BY
                s.Student_ID,
                s.Date,
                s.Subject,
                s.Attendance_Status
                ORDER BY (SELECT NULL)
        ) AS flag
    FROM standardized as s
    INNER JOIN conflict_flag as cf
    ON s.student_ID = cf.Student_ID 
        AND s.Date = cf.Date
        AND s.Subject = cf.Subject
)
INSERT INTO clean.attendance (
    Student_ID,
    Date,
    Subject,
    Attendance_Status,
    Conflict_Flag
)
SELECT 
    Student_ID,
    Date,
    Subject,
    Attendance_Status,
    Conflict_Flag
FROM numbered
WHERE flag = 1

SELECT * FROM clean.attendance
WHERE Conflict_Flag = 1


-----------------------------------------------------------------
TRUNCATE TABLE clean.homework;
GO
INSERT INTO clean.homework (
    Student_ID,
    Subject,
    Assignment_Name,
    Due_Date,
    Status,
    Grade_Feedback,
    Guardian_Signature
)
  SELECT 
    Student_ID,
    Subject,
    Assignment_Name,
    Due_Date,
    CASE WHEN TRIM(Status) = 'pending' THEN 'Pending'
         WHEN TRIM(Status) = 'not done' THEN 'Not Done'
         WHEN TRIM(Status) = N'✔' THEN 'Done'
         WHEN TRIM(Status) = N'❌' THEN 'Not Done'
         WHEN TRIM(Status) = N'✅' THEN 'Done'
         ELSE TRIM(Status)
    END as Status,
    Grade_Feedback,
    CASE WHEN Guardian_Signature = ' ' THEN 'N/A'
         ELSE Guardian_Signature
    END as Guardian_Signature
   FROM raw.homework

------------------------------------
TRUNCATE TABLE clean.students;
GO
INSERT INTO clean.students(
    Student_ID,
    Full_Name,
    Date_of_Birth,
    Grade_Level,
    Emergency_Contact,
    Age_Grade_Anomaly_Flag
)
SELECT 
    Student_ID,
    Full_Name,
    Date_of_Birth,
    Grade_Level,
    CASE WHEN Emergency_Contact IS NULL THEN 'N/A'
             ELSE REPLACE(REPLACE(REPLACE(Emergency_Contact, '.', '-'),'(', ''), ')', '-')
        END AS Emergency_Contact,
    CASE
            WHEN Grade_Level = 'Grade 1'
                 AND (YEAR(Date_of_Birth) < 2016 OR YEAR(Date_of_Birth) > 2018)
                THEN 1

            WHEN Grade_Level = 'Grade 2'
                 AND (YEAR(Date_of_Birth) < 2015 OR YEAR(Date_of_Birth) > 2017)
                THEN 1

            WHEN Grade_Level = 'Grade 3'
                 AND (YEAR(Date_of_Birth) < 2014 OR YEAR(Date_of_Birth) > 2016)
                THEN 1

            WHEN Grade_Level = 'Grade 4'
                 AND (YEAR(Date_of_Birth) < 2013 OR YEAR(Date_of_Birth) > 2015)
                THEN 1

            WHEN Grade_Level = 'Grade 5'
                 AND (YEAR(Date_of_Birth) < 2012 OR YEAR(Date_of_Birth) > 2014)
                THEN 1

            ELSE 0
        END AS Age_Grade_Anomaly_Flag
FROM raw.students

---------------------------------------------------------------------------
TRUNCATE TABLE clean.students_performance;
INSERT INTO clean.students_performance (
    Student_ID,
	Subject,
	Exam_Score,
	Homework_Completion,
	Flag,
	Teacher_Comments
)
SELECT
	Student_ID,
	Subject,
	Exam_Score,
			TRY_CAST(REPLACE(TRIM(Homework_Completion),'%','') AS INT)  as Homework_Completion,
			CASE WHEN Exam_Score > 100 THEN 1
				 WHEN TRY_CAST(REPLACE(TRIM(Homework_Completion),'%','') AS INT) < 0 THEN 1
				ELSE 0
			END AS Flag,
			CASE WHEN Teacher_Comments = ' ' THEN 'N/A'
				ELSE Teacher_Comments
			END as Teacher_Comments
   FROM raw.students_performance
	
-----------------------------------------------------
TRUNCATE TABLE clean.teacher_parent_communication;
INSERT INTO clean.teacher_parent_communication (
    Student_ID,
    Date,
    Message_Type,
    Message_Content
)
    SELECT 
    Student_ID,
    Date,
    Message_Type,
    CASE WHEN Message_Content = ' ' THEN 'N/A'
	     ELSE Message_Content
    END AS Message_Content
    FROM raw.teacher_parent_communication