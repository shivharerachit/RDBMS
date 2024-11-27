Create database schoolDB;
use schoolDB;

-- 1. Users Table: Store details of all users (students, teachers, admins).
-- 2. Columns: user_id (PK), name, email, role, password_hash, created_at.
create table users(
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role ENUM('student', 'teacher', 'admin', 'principal') NOT NULL, -- Updated
    password_hash VARCHAR(255) NOT NULL, 
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 3. Students Table: Store details specific to students.
-- 4. Columns: student_id (PK, FK), class_id (FK), date_of_birth, guardian_name, address.
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    class_id INT,
    date_of_birth DATE NOT NULL,
    guardian_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES users(user_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

-- 5. Teachers Table: Store details specific to teachers.
-- 6. Columns: teacher_id (PK, FK), subject_id (FK), joining_date, salary.
Create table Teachers(
    teachers_id INT PRIMARY KEY,
    subject_id INT ,
    joining_date DATE NOT NULL,
    salary Numeric(10,2) NOT NULL,
    FOREIGN KEY (teachers_id) REFERENCES users(user_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

-- 7. Classes Table: Manage class-specific details.
-- 8. Columns: class_id (PK), class_name, teacher_id (FK), schedule.
Create table Classes(
    class_id INT PRIMARY KEY,
    class_name VARCHAR(10) NOT NULL,
    teacher_id INT,
    schedule VARCHAR(50),
    is_class_teacher BOOLEAN DEFAULT FALSE, -- Updated
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);

-- 9. Subjects Table: Define subjects offered.
-- 10. Columns: subject_id (PK), name, class_id (FK).
Create table Subjects (
    subject_id INT auto_increment PRIMARY KEY,
    subject_name VARCHAR(20) NOT NULL,
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);


-- 11. Attendance Table: Maintain attendance records.
-- 12. Columns: attendance_id (PK), student_id (FK), date, status.
create TABLE Attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY, 
    student_id INT NOT NULL,  
    date DATE NOT NULL,
    status BOOLEAN DEFAULT FALSE,
    FOREIGN KEY student_id REFERENCES Students(student_id)
)

-- 13. Exams Table: Track exams conducted.
-- 14. Columns: exam_id (PK), class_id (FK), subject_id (FK), date, type.
create TABLE Exams (
    exam_id INT AUTO_INCREMENT PRIMARY KEY, 
    class_id INT NOT NULL,
    subject_id INT NOT NULL,
    date DATE NOT NULL,
    type ENUM('midterm', 'final') NOT NULL,
    FOREIGN KEY class_id REFERENCES Classes(class_id),
    FOREIGN KEY subject_id REFERENCES Subjects(subject_id)
)

-- 15. Results Table: Store student exam results.
-- 16. Columns: result_id (PK), exam_id (FK), student_id (FK), marks_obtained.
create TABLE Results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,  --issue
    exam_id INT NOT NULL,  --issue
    student_id INT NOT NULL,  --issue
    marks_obtained INT NOT NULL, --issue
    total_marks INT DEFAULT 0, -- Updated
    max_total_marks INT DEFAULT 0, -- Updated
    FOREIGN KEY exam_id REFERENCES Exams(exam_id),
    FOREIGN KEY student_id REFERENCES Students(student_id)
)


-- Updated
-- 17. Tasks Table: Store and assign task to students.
-- 18. Columns: task_id (PK), teacher_id (FK), class_id (FK), task_description, due_date.
CREATE TABLE Tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_id INT NOT NULL,
    class_id INT,
    task_description JSON NOT NULL,
    due_date DATE DEFAULT (CURDATE() + INTERVAL 7 DAY),
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teachers_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);