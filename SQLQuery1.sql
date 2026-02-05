CREATE DATABASE StudentProjectDB;
GO

USE StudentProjectDB;
GO

CREATE TABLE Student_Performance (
    Hours_Studied INT,
    Attendance INT,
    Parental_Involvement VARCHAR(50),
    Access_to_Resources VARCHAR(50),
    Extracurricular_Activities VARCHAR(10),
    Sleep_Hours INT,
    Previous_Scores INT,
    Motivation_Level VARCHAR(50),
    Internet_Access VARCHAR(10),
    Tutoring_Sessions INT,
    Family_Income VARCHAR(50),
    Teacher_Quality VARCHAR(50),
    School_Type VARCHAR(50),
    Peer_Influence VARCHAR(50),
    Physical_Activity INT,
    Learning_Disabilities VARCHAR(10),
    Parental_Education_Level VARCHAR(50),
    Gender VARCHAR(20),
    Exam_Score INT,
    Performance_Grade VARCHAR(10)
);

USE StudentProjectDB;
GO

SELECT name 
FROM sys.tables;

SELECT COUNT(*) AS Rows_Student_Performance FROM Student_Performance;
SELECT COUNT(*) AS Rows_Cleaned FROM student_performance_cleaned;

INSERT INTO Student_Performance
SELECT * FROM Student_Performance_cleaned;

USE StudentProjectDB;
GO

SELECT name 
FROM sys.tables
ORDER BY name;

SELECT 
    (SELECT COUNT(*) FROM Student_Performance) AS Rows_Student_Performance,
    (SELECT COUNT(*) FROM Student_Performance_cleaned) AS Rows_Cleaned;

-- Columns in Student_Performance
EXEC sp_columns Student_Performance;

-- Columns in Student_Performance_cleaned
EXEC sp_columns Student_Performance_cleaned;

USE StudentProjectDB;
GO

DROP TABLE IF EXISTS Student_Performance;

EXEC sp_rename 'Student_Performance_cleaned', 'Student_Performance';

USE StudentProjectDB;
GO

SELECT name 
FROM sys.tables;

SELECT COUNT(*) AS Total_Rows FROM Student_Performance;

SELECT TOP 10 * FROM Student_Performance;

/* 
====================================================
📌 Question 1: What is the average exam score by Gender?
====================================================
*/
SELECT Gender, AVG(Exam_Score) AS Avg_Score
FROM Student_Performance
GROUP BY Gender;



/* 
====================================================
📌 Question 2: What is the average exam score by School Type?
====================================================
*/
SELECT School_Type, AVG(Exam_Score) AS Avg_Score
FROM Student_Performance
GROUP BY School_Type;



/* 
====================================================
📌 Question 3: How do Tutoring Sessions affect performance?
====================================================
*/
SELECT Tutoring_Sessions, AVG(Exam_Score) AS Avg_Score
FROM Student_Performance
GROUP BY Tutoring_Sessions
ORDER BY Tutoring_Sessions;



/* 
====================================================
📌 Question 4: Does Internet Access impact exam scores?
====================================================
*/
SELECT Internet_Access, AVG(Exam_Score) AS Avg_Score
FROM Student_Performance
GROUP BY Internet_Access;



/* 
====================================================
📌 Question 5: What is the average exam score by Parental Education Level?
====================================================
*/
SELECT 
    Parental_Education_Level AS Parental_Education_Level, 
    AVG(Exam_Score) AS Avg_Score
FROM Student_Performance
GROUP BY Parental_Education_Level
ORDER BY Avg_Score DESC;

-- Q6: Percentage of students who participate in extracurricular activities
-- Since Extracurricular_Activities is a BIT (0 = No, 1 = Yes),
-- we can directly sum the column to count "Yes" values.

SELECT 
    CAST(
        100.0 * SUM(CAST(Extracurricular_Activities AS INT)) 
        / COUNT(*) 
        AS DECIMAL(5,2)
    ) AS Participation_Percentage
FROM Student_Performance;


