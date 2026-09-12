-- 1
CREATE OR ALTER FUNCTION fn_CalculateAge (@DateOfBirth DATE)
returns INT
AS
BEGIN 

 RETURN DATEDIFF(YEAR, @DateOfBirth, GETDATE());
END
go

-- 2

create or alter function fn_GetCoursesByStudent
(
    @StudentId INT
)
RETURNS TABLE
AS
return 
(
SELECT
        c.Course_ID,
        c.Course_Name,
        e.Enrollment_Date,
        e.Grade
    FROM Enrollment AS e
    INNER JOIN Course AS c
        ON e.Course_ID = c.Course_ID
    WHERE e.Stud_ID = @StudentId);
go


--3

create or alter function fn_GetTopStudentsByCourse (@CourseId INT , @TopN int)
returns table 
as 
return 
(
select Stud_ID,
Stud_Name, StudentRank , Course_ID,Grade
from 
(
select 
ROW_NUMBER() over 
(
  PARTITION BY e.Course_ID
  ORDER BY e.Grade DESC
) as StudentRank,
  s.Stud_ID,
  s.Stud_Name,
  e.Course_ID,
  e.Grade
from Enrollment as e
inner join Student as s on e.Stud_ID = s.Stud_ID
where e.Course_ID = @CourseId
) as RankedStudents
where StudentRank <= @TopN);
go

-- 4

create or alter function fn_IsPassed (@Grade decimal(5,2))
returns varchar(10)
as
begin
   if @Grade IS NULL
   return 'Pending';

   if @Grade >= 50
   return 'Passed'

   return 'Failed'

End;

