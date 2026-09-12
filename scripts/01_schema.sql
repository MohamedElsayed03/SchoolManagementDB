
CREATE TABLE Department
(
    Dept_ID INT IDENTITY(1,1) NOT NULL,
    Depart_Name NVARCHAR(100) NOT NULL,
    Lead_Teacher_ID INT NULL,

    CONSTRAINT PK_Department
        PRIMARY KEY (Dept_ID),

    CONSTRAINT UQ_Department_Name
        UNIQUE (Depart_Name)
);
GO


CREATE TABLE Teacher
(
    Teacher_ID INT IDENTITY(1,1) NOT NULL,
    Teacher_Name NVARCHAR(100) NOT NULL,
    Supervisor_ID INT NULL,
    Depart_ID INT NOT NULL,

    CONSTRAINT PK_Teacher
        PRIMARY KEY (Teacher_ID)
);
GO


CREATE TABLE Student
(
    Stud_ID INT IDENTITY(1,1) NOT NULL,
    Stud_Name NVARCHAR(100) NOT NULL,
    Depart_ID INT NOT NULL,

    CONSTRAINT PK_Student
        PRIMARY KEY (Stud_ID)
);
GO


CREATE TABLE Course
(
    Course_ID INT IDENTITY(1,1) NOT NULL,
    Course_Name NVARCHAR(100) NOT NULL,
    Depart_ID INT NOT NULL,
    Teacher_ID INT NOT NULL,

    CONSTRAINT PK_Course
        PRIMARY KEY (Course_ID)
);
GO


CREATE TABLE Enrollment
(
    Stud_ID INT NOT NULL,
    Course_ID INT NOT NULL,
    Enrollment_Date DATE NOT NULL,
    Grade DECIMAL(5,2) NULL,

    CONSTRAINT PK_Enrollment
        PRIMARY KEY (Stud_ID, Course_ID),

    CONSTRAINT CK_Enrollment_Grade
        CHECK (Grade IS NULL OR Grade BETWEEN 0 AND 100),

    CONSTRAINT CK_Enrollment_Date
        CHECK (Enrollment_Date <= CONVERT(DATE, GETDATE()))
);
GO



ALTER TABLE Teacher
ADD CONSTRAINT FK_Teacher_Department
FOREIGN KEY (Depart_ID)
REFERENCES Department(Dept_ID);
GO

ALTER TABLE Teacher
ADD CONSTRAINT FK_Teacher_Supervisor
FOREIGN KEY (Supervisor_ID)
REFERENCES Teacher(Teacher_ID);
GO

ALTER TABLE Student
ADD CONSTRAINT FK_Student_Department
FOREIGN KEY (Depart_ID)
REFERENCES Department(Dept_ID);
GO

ALTER TABLE Course
ADD CONSTRAINT FK_Course_Department
FOREIGN KEY (Depart_ID)
REFERENCES Department(Dept_ID);
GO

ALTER TABLE Course
ADD CONSTRAINT FK_Course_Teacher
FOREIGN KEY (Teacher_ID)
REFERENCES Teacher(Teacher_ID);
GO

ALTER TABLE Enrollment
ADD CONSTRAINT FK_Enrollment_Student
FOREIGN KEY (Stud_ID)
REFERENCES Student(Stud_ID);
GO

ALTER TABLE Enrollment
ADD CONSTRAINT FK_Enrollment_Course
FOREIGN KEY (Course_ID)
REFERENCES Course(Course_ID);
GO

ALTER TABLE Department
ADD CONSTRAINT FK_Department_LeadTeacher
FOREIGN KEY (Lead_Teacher_ID)
REFERENCES Teacher(Teacher_ID);
GO


