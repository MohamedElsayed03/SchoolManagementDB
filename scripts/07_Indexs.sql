-- 1

CREATE  INDEX IX_Enrollment_StudentId
ON Enrollment(Stud_ID);
go



-- 2
CREATE  INDEX IX_Enrollment_StudentId_CourseId
ON Enrollment(Stud_ID, Course_ID);



-- 3
CREATE  INDEX IX_Enrollment_CourseId_Grade
ON Enrollment(Course_ID, Grade DESC)
INCLUDE (Stud_ID);