CREATE TABLE Department (
    DepartmentID SERIAL PRIMARY KEY,
    DepartmentName TEXT
);

-- Table to store sections
CREATE TABLE Section (
    SectionID SERIAL PRIMARY KEY,
    SectionName TEXT,
    Year INTEGER
);

-- Table to store faculty details, now with a reference to the department
CREATE TABLE Faculty (
    FacultyID SERIAL PRIMARY KEY,
    Name TEXT,
    DepartmentID INTEGER,
    Email TEXT,
    PhoneNumber BIGINT UNIQUE,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- Table to store Bloom's taxonomy levels
CREATE TABLE BloomsTaxonomy (
    LevelID SERIAL PRIMARY KEY,
    LevelName TEXT
);

-- Table to store student details, now with a reference to the department and section
CREATE TABLE Student (
    RollNumber SERIAL PRIMARY KEY,
    Name TEXT,
    Gender TEXT,
    Address TEXT,
    PhoneNumber BIGINT UNIQUE,
    DepartmentID INTEGER,
    Year INTEGER,
    SectionID INTEGER,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY (SectionID) REFERENCES Section(SectionID)
);

-- Table to store exam details
CREATE TABLE Exam (
    ExamID SERIAL PRIMARY KEY,
    ExamName TEXT,
    FacultyID INTEGER,
    TotalMarks INTEGER,
    Date DATE,
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID)
);

-- Table to store questions and their Bloom's taxonomy level
CREATE TABLE Question (
    QuestionID SERIAL PRIMARY KEY,
    ExamID INTEGER,
    QuestionText TEXT,
    MaxMarks INTEGER,
    BloomsLevelID INTEGER,
    FOREIGN KEY (ExamID) REFERENCES Exam(ExamID),
    FOREIGN KEY (BloomsLevelID) REFERENCES BloomsTaxonomy(LevelID)
);

-- Table to store marks scored by each student in each question
CREATE TABLE Marks (
    MarksID SERIAL PRIMARY KEY,
    RollNumber INTEGER,
    QuestionID INTEGER,
    MarksObtained INTEGER,
    FOREIGN KEY (RollNumber) REFERENCES Student(RollNumber),
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

-- Table to generate reports for student performance based on Bloom's taxonomy
CREATE TABLE PerformanceReport (
    ReportID SERIAL PRIMARY KEY,
    RollNumber INTEGER,
    BloomsLevelID INTEGER,
    TotalMarksObtained INTEGER,
    AverageMarks FLOAT,
    FOREIGN KEY (RollNumber) REFERENCES Student(RollNumber),
    FOREIGN KEY (BloomsLevelID) REFERENCES BloomsTaxonomy(LevelID)
);

-- Table to store overall exam results for each student
CREATE TABLE ExamResult (
    ResultID SERIAL PRIMARY KEY,
    RollNumber INTEGER,
    ExamID INTEGER,
    TotalMarksObtained INTEGER,
    Percentage FLOAT,
    Grade TEXT,
    FOREIGN KEY (RollNumber) REFERENCES Student(RollNumber),
    FOREIGN KEY (ExamID) REFERENCES Exam(ExamID)
);
