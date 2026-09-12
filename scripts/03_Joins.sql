

--  (1) -->  Get every student with their department name

select  s.Stud_ID, s.Stud_Name,d.Depart_Name 
from Student as s
Inner join Department as d
on s.Depart_ID = d.Dept_ID;



-- (2) --> Get every Teacher who teaches more than 3 Courses using JOIN, GROUP BY, and HAVING


select  T.Teacher_Name ,Count(c.Course_ID) as TotalCourse
from Teacher as T
Inner join Course as C
on T.Teacher_ID = C.Teacher_ID
Group By 
T.Teacher_ID,
T.Teacher_Name
Having Count(c.Course_ID) > 3


-- (3) -->  Get Every Student who has not received a Grade in any enrolled Course

SELECT S.Stud_ID, S.Stud_Name
FROM Student AS S
INNER JOIN Enrollment AS E
    ON S.Stud_ID = E.Stud_ID
GROUP BY S.Stud_ID, S.Stud_Name
HAVING COUNT(E.Grade) = 0;



-- (4) --> Get Every department whose Lead Teacher supervises more than 5 Teachers using a Self JOIN and aggregation.

select D.Depart_Name, T.Teacher_Name AS LeadTeacher,COUNT(S.Teacher_ID) AS Supervised_Teachers
from Department AS D
INNER JOIN Teacher AS T
    ON D.Lead_Teacher_ID = T.Teacher_ID
INNER JOIN Teacher AS S
    ON T.Teacher_ID = S.Supervisor_ID
GROUP BY
    D.Dept_ID,
    D.Depart_Name,
    T.Teacher_Name

HAVING COUNT(S.Teacher_ID) > 5;


-- (5) --> This Query Return Student INformation along With their 
--            department, courses, teachers, grades, and enrollment dates by joining the related tables together.

select s.Stud_ID as ID ,s.Stud_Name as Name ,d.Depart_Name , c.Course_Name ,t.Teacher_Name,e.Grade,e.Enrollment_Date
FROM Student AS s
INNER JOIN Department as d
    ON s.Depart_ID = d.Dept_ID
INNER JOIN Enrollment as e
    ON s.Stud_ID = e.Stud_ID
INNER JOIN Course as c
    ON e.Course_ID = c.Course_ID
INNER JOIN Teacher as t
    ON c.Teacher_ID = t.Teacher_ID;