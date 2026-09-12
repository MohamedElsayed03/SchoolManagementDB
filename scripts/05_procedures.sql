 

 -- (1)
CREATE OR ALTER Procedure sp_GetStudentsByDepartment @DepartmentId int
as
Begin
select s.Stud_ID ,s.Stud_Name
from Student as s
where s.Depart_ID = @DepartmentId
End;

go

-- (2)

Create Or Alter PRoc sp_EnrollStudent (@StudentId int , @CourseId int)
as
Begin 

INsert into Enrollment(Stud_ID, Course_ID,Enrollment_Date,Grade)
values
(@StudentId,@CourseId,GETDATE(),NULL);

End;
go
 -- (3)

 Create Or Alter PRoc sp_EnrollStudent (@StudentId int , @CourseId int)
as
Begin 
 
 if Exists
 (
 select 1 
 from Enrollment
 where Stud_ID = @StudentId AND Course_ID = @CourseId
 )
 Begin
 select 'Student is already enrolled in this course.';
 return;
 end

INsert into Enrollment(Stud_ID, Course_ID,Enrollment_Date,Grade)
values
(@StudentId,@CourseId,GETDATE(),NULL);

End;

go

-- (4) The Final Version 
 Create Or Alter PRoc sp_EnrollStudent (@StudentId int , @CourseId int)
as
Begin 
 
 if Exists
 (
 select 1 
 from Enrollment
 where Stud_ID = @StudentId AND Course_ID = @CourseId
 )
 Begin
 select 'Student is already enrolled in this course.';
 return;
 end
 
 IF Not Exists 
 (
 select 1
 from Student as s
 inner join Course as c on s.Depart_ID = c.Depart_ID
WHERE s.Stud_ID = @StudentId AND c.Course_ID = @CourseId
 )
 begin 
   SELECT 'Student and Course must belong to the same Department.';
 return;
 end

INsert into Enrollment(Stud_ID, Course_ID,Enrollment_Date,Grade)
values
(@StudentId,@CourseId,CAST(GETDATE() as date),NULL);
PRINT 'Student enrolled successfully.';
End;
go

-- (5)
CREATE OR ALTER proc sp_TransferStudent  @StudentId int, @NewDepartmentId int
as
begin 
update Student
set Depart_ID = @NewDepartmentId
where Stud_ID = @StudentId
end

go

-- (6)
CREATE OR ALTER PROCEDURE sp_TransferStudent
    @StudentId INT,
    @NewDepartmentId INT
AS
BEGIN
   
   Begin Transaction;
   update Student
   set Depart_ID = @NewDepartmentId
   where Stud_ID = @StudentId
     COMMIT TRANSACTION;

    SELECT 'Student transferred successfully.';
END;
GO




-- (7)   The Final Version
CREATE OR ALTER PROCEDURE sp_TransferStudent
    @StudentId INT,
    @NewDepartmentId INT
AS
begin

BEGIN TRY

    BEGIN TRANSACTION;
    update Student
      set Depart_ID = @NewDepartmentId
   where Stud_ID = @StudentId

   if exists
   (
   select 1 
   from Enrollment as e
   inner join Course as c on e.Course_ID = c.Course_ID
   where e.Stud_ID = @StudentId
   AND c.Depart_ID <> @NewDepartmentId
    )
    Begin; 
         throw 50001,'Transaction failed becouse the Student has enroll in anthor department',1;
   
   END;

    COMMIT TRANSACTION;
   
    SELECT 'Student transferred successfully.'; 
     END TRY


     BEGIN CATCH
     if @@trancount > 0
        rollback
         SELECT ERROR_MESSAGE() AS ErrorMessage;
     end catch
END;
GO



--  Test Cases

--  (1) test get the Student by Department

Exec sp_GetStudentsByDepartment(10)



--(4) test  Enroll Student   St_id , Courseid
           exec sp_EnrollStudent( 1, 2)


--(7) Transfer Student to a new Department With update
   exec sp_TransferStudent(1,3)

