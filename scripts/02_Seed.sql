use SchoolDatabase


Insert into Department (Depart_Name,Lead_Teacher_ID)
values
('Computer Science',null),
('Mathematics',NULL),
('Physics',NULL);
Go

Insert into Teacher(Teacher_Name,Supervisor_ID,Depart_ID)
VALUES
('Essam Abdelnaby',   NULL, 1),
('Mohamed Samir', NULL, 1),
('Mohamed Elsayed', NULL, 2),
('Omar Khaled',  NULL, 2),
('Mohamed Ekrami',  NULL, 3),
('Youssef Tarek', NULL, 3);
GO


update Department
set Lead_Teacher_ID =1 
where Dept_ID= 1;

UPDATE Department
SET Lead_Teacher_ID = 3
WHERE Dept_ID = 2;

UPDATE Department
SET Lead_Teacher_ID = 5
WHERE Dept_ID = 3;
GO




UPDATE Teacher
SET Supervisor_ID = 1
WHERE Teacher_ID = 2;

UPDATE Teacher
SET Supervisor_ID = 3
WHERE Teacher_ID = 4;

UPDATE Teacher
SET Supervisor_ID = 5
WHERE Teacher_ID = 6;
GO

INsert into Student (Stud_Name,Depart_ID)
values 
('Mohamed Ahmed', 1),
('Ali Mohamed', 1),
('Omar Hassan', 1),
('Sara Mohamed', 2),
('Ahmed Ali', 2),
('Hassan Tarek', 2),
('Nour Ahmed', 3),
('Khaled Samir', 3);
Go



Insert into Course (Course_Name,Depart_ID,Teacher_ID)
Values
('ASP.Net',1,1),
('Object Oriented Programming', 1, 2),
('C#',2,3),
('HTML',2,4),
('LINQ',3,5),
('C++',3,6);
Go


INSERT INTO Enrollment
    (Stud_ID, Course_ID, Enrollment_Date, Grade)
VALUES
(1, 1, '2026-08-20', 85.00),
(1, 2, '2026-08-21', 90.00),
(2, 1, '2026-08-20', 78.00),
(2, 2, '2026-08-21', NULL),
(3, 1, '2026-08-22', 88.00),

(4, 3, '2026-08-20', 92.00),
(4, 4, '2026-08-21', 87.00),
(5, 3, '2026-08-20', 75.00),
(6, 4, '2026-08-22', NULL),

(7, 5, '2026-08-20', 81.00),
(7, 6, '2026-08-21', 89.00),
(8, 5, '2026-08-22', 76.00);
GO

INSERT INTO Course (Course_Name, Depart_ID, Teacher_ID)
VALUES
('SQL Server', 1, 1),
('Entity Framework Core', 1, 1),
('LINQ Advanced', 1, 1);
GO