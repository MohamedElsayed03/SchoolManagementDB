
use SchoolDatabase
Go


-- (1)
create or alter VIEW vw_DepartmentSummary
AS
SELECT 
    d.Dept_ID,
    d.Depart_Name,
 ISNULL( t.TotalTeachers, 0) AS TotalTeacher,
    ISNULL(s.TotalStudents, 0) AS TotalStudent
FROM Department AS d
LEFT JOIN (
    SELECT Depart_ID, COUNT(*) AS TotalTeachers 
    FROM Teacher 
    GROUP BY Depart_ID
) AS t ON d.Dept_ID = t.Depart_ID
LEFT JOIN (
    SELECT Depart_ID, COUNT(*) AS TotalStudents 
    FROM Student 
    GROUP BY Depart_ID
) AS s ON d.Dept_ID = s.Depart_ID;

go
-- (2) 
create view vw_TeacherCourseLoad
as 
select T.Teacher_ID , T.Teacher_Name , COUNT (C.Course_ID) as TotalCourses 
from Teacher as T
Left join Course as C
   on T.Teacher_ID = C.Teacher_ID
Group by 
T.Teacher_ID,
t.Teacher_Name

GO


-- (3)
create view vw_StudentFullReport
as 
select S.Stud_ID , S.Stud_Name , C.Course_Name , E.Grade , E.Enrollment_Date  , 
 CASE
 WHEN E.Grade Is NULL Then 'Pending'
  WHEN E.Grade >= 50 THEN 'Passed'
        ELSE 'Failed'
    END AS Status
from Student as S
INNER JOIN Enrollment as E
  on s.Stud_ID =e.Stud_ID
inner join Course as C
  on E.Course_ID = C.Course_ID;

  

GO


  -- (4)
CREATE VIEW vw_DepartmentTopStudent
AS
SELECT Stud_ID, Stud_Name, Depart_ID, AverageGrade
FROM
(
select Stud_ID, Stud_Name, Depart_ID, AverageGrade, 
RANK() OVER (
PARTITION BY Depart_ID 
ORDER BY AverageGrade DESC
    ) AS StudentRank
FROM
(
 SELECT S.Stud_ID, S.Stud_Name, S.Depart_ID, AVG(E.Grade) AS AverageGrade
 FROM Student AS S
 INNER JOIN Enrollment AS E
     ON S.Stud_ID = E.Stud_ID
 GROUP BY
     S.Stud_ID,
     S.Stud_Name,
     S.Depart_ID
) AS StudentAverage
) AS RankedStudents
where StudentRank =1


GO

-- (5) 
create view vw_IsPassed
as
SELECT
    E.Grade,
    CASE
        WHEN E.Grade IS NULL THEN 'Pending'
        WHEN E.Grade >= 50 THEN 'Passed'
        ELSE 'Failed'
    END AS Status
FROM Enrollment AS E;

go