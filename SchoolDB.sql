IF DB_ID(N'SchoolDB') IS NULL
BEGIN
    CREATE DATABASE SchoolDB;
END;
GO
USE SchoolDB;
GO
IF OBJECT_ID(N'dbo.Departments', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Departments (
        DepartmentID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Departments PRIMARY KEY,
        Name NVARCHAR(50) NOT NULL,
        Budget DECIMAL(18,2) NOT NULL,
        StartDate DATE NOT NULL
    );
END;
IF OBJECT_ID(N'dbo.Instructors', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Instructors (
        InstructorID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Instructors PRIMARY KEY,
        FirstName NVARCHAR(50) NOT NULL,
        LastName NVARCHAR(50) NOT NULL,
        HireDate DATE NOT NULL
    );
END;
IF OBJECT_ID(N'dbo.Courses', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Courses (
        CourseID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Courses PRIMARY KEY,
        Title NVARCHAR(100) NOT NULL,
        Credits INT NOT NULL,
        DepartmentID INT NULL CONSTRAINT FK_Courses_Departments REFERENCES dbo.Departments(DepartmentID)
    );
END;
IF OBJECT_ID(N'dbo.Students', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Students (
        StudentID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Students PRIMARY KEY,
        FirstName NVARCHAR(50) NOT NULL,
        LastName NVARCHAR(50) NOT NULL,
        EnrollmentDate DATE NOT NULL
    );
END;
IF OBJECT_ID(N'dbo.Enrollments', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Enrollments (
        EnrollmentID INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Enrollments PRIMARY KEY,
        CourseID INT NULL CONSTRAINT FK_Enrollments_Courses REFERENCES dbo.Courses(CourseID),
        StudentID INT NULL CONSTRAINT FK_Enrollments_Students REFERENCES dbo.Students(StudentID),
        Grade DECIMAL(3,2) NULL
    );
END;
IF NOT EXISTS (SELECT 1 FROM dbo.Departments WHERE Name = N'Computer Science')
    INSERT dbo.Departments (Name, Budget, StartDate) VALUES (N'Computer Science', 120000.00, '2023-01-01');
IF NOT EXISTS (SELECT 1 FROM dbo.Departments WHERE Name = N'Mathematics')
    INSERT dbo.Departments (Name, Budget, StartDate) VALUES (N'Mathematics', 90000.00, '2022-08-15');
IF NOT EXISTS (SELECT 1 FROM dbo.Instructors WHERE FirstName = N'John' AND LastName = N'Doe')
    INSERT dbo.Instructors (FirstName, LastName, HireDate) VALUES (N'John', N'Doe', '2020-08-15');
IF NOT EXISTS (SELECT 1 FROM dbo.Instructors WHERE FirstName = N'Alice' AND LastName = N'Nguyen')
    INSERT dbo.Instructors (FirstName, LastName, HireDate) VALUES (N'Alice', N'Nguyen', '2021-09-01');
IF NOT EXISTS (SELECT 1 FROM dbo.Courses WHERE Title = N'Introduction to Programming')
    INSERT dbo.Courses (Title, Credits, DepartmentID) SELECT N'Introduction to Programming', 3, DepartmentID FROM dbo.Departments WHERE Name = N'Computer Science';
IF NOT EXISTS (SELECT 1 FROM dbo.Courses WHERE Title = N'Database Systems')
    INSERT dbo.Courses (Title, Credits, DepartmentID) SELECT N'Database Systems', 4, DepartmentID FROM dbo.Departments WHERE Name = N'Computer Science';
IF NOT EXISTS (SELECT 1 FROM dbo.Students WHERE FirstName = N'Jane' AND LastName = N'Smith')
    INSERT dbo.Students (FirstName, LastName, EnrollmentDate) VALUES (N'Jane', N'Smith', '2023-09-01');
IF NOT EXISTS (SELECT 1 FROM dbo.Students WHERE FirstName = N'Minh' AND LastName = N'Tran')
    INSERT dbo.Students (FirstName, LastName, EnrollmentDate) VALUES (N'Minh', N'Tran', '2024-01-15');
IF NOT EXISTS (SELECT 1 FROM dbo.Enrollments)
    INSERT dbo.Enrollments (CourseID, StudentID, Grade)
    SELECT c.CourseID, s.StudentID, 3.50 FROM dbo.Courses c CROSS JOIN dbo.Students s
    WHERE c.Title = N'Introduction to Programming' AND s.FirstName = N'Jane' AND s.LastName = N'Smith';
GO
