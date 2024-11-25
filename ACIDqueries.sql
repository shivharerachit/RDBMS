-- Atomicity

-- Insert User and Assign Role
START TRANSACTION;

-- Insert a user
INSERT INTO Users (name, email, role, password_hash) 
VALUES ('John Doe', 'john.doe@example.com', 'student', SHA2('password123', 256));

-- Assign the user to a class
INSERT INTO Students (student_id, class_id, date_of_birth, guardian_name, address) 
VALUES (LAST_INSERT_ID(), 1, '2005-05-15', 'Jane Doe', '123 Main St');

-- Commit transaction if all queries succeed
COMMIT;

-- Rollback if there is any error
ROLLBACK;


-- Consistency

-- Add a CHECK constraint to ensure salary is positive
ALTER TABLE Teachers
ADD CONSTRAINT chk_salary_positive CHECK (salary > 0);

-- Add a CHECK constraint for valid attendance status
ALTER TABLE Attendance
ADD CONSTRAINT chk_status_valid CHECK (status IN (0, 1));


-- Isolation

-- Set isolation level for the current session
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

START TRANSACTION;

-- Perform operations here...

COMMIT;


-- Durability

-- mysqldump -u root -p schoolDB > schoolDB_backup.sql


-- Relationships

SELECT 
    Classes.class_name,
    Students.student_id,
    Users.name AS student_name,
    Users.email AS student_email
FROM 
    Classes
JOIN 
    Students ON Classes.class_id = Students.class_id
JOIN 
    Users ON Students.student_id = Users.user_id;


-- Normalization -- smajh nhi aya

-- Normalization reduces redundancy and organizes data effectively. The database already follows 3NF:
-- 	•	1NF: Each column contains atomic values.
-- 	•	2NF: All non-key columns depend on the primary key.
-- 	•	3NF: No transitive dependency.


-- Indexing -- smajh aya but aur smjhna h

-- Index on email for quick lookup
CREATE INDEX idx_email ON Users(email);

-- Index on foreign key columns
CREATE INDEX idx_class_id ON Students(class_id);
CREATE INDEX idx_subject_id ON Exams(subject_id);



-- Triggers

CREATE TRIGGER update_attendance
AFTER INSERT ON Attendance
FOR EACH ROW
BEGIN
    IF NEW.status = 1 THEN
        UPDATE Students SET attendance_count = attendance_count + 1
        WHERE student_id = NEW.student_id;
    END IF;
END;




-- Stored Procedures -- aur smjhenge

DELIMITER $$

CREATE PROCEDURE GetStudentResults(IN studentID INT)
BEGIN
    SELECT 
        Results.result_id,
        Exams.type AS exam_type,
        Results.marks_obtained
    FROM 
        Results
    JOIN 
        Exams ON Results.exam_id = Exams.exam_id
    WHERE 
        Results.student_id = studentID;
END $$

DELIMITER ;

CALL GetStudentResults(101);


-- Views -- aur smjhna h

CREATE VIEW ClassAttendance AS
SELECT 
    Classes.class_name,
    COUNT(CASE WHEN Attendance.status = 1 THEN 1 END) AS total_present,
    COUNT(CASE WHEN Attendance.status = 0 THEN 1 END) AS total_absent
FROM 
    Classes
JOIN 
    Students ON Classes.class_id = Students.class_id
JOIN 
    Attendance ON Students.student_id = Attendance.student_id
GROUP BY 
    Classes.class_name;