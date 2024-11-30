# School Management System - ER Diagram

## Entities and Their Relationships

### Users
- **User** (Base entity for all users)
  - user_id (PK)
  - username
  - password_hash
  - email
  - first_name
  - last_name
  - role_id (FK to Roles)
  - created_at
  - last_login
  - status

### Roles and Permissions
- **Role**
  - role_id (PK)
  - role_name (admin, principal, teacher, student, parent)
  - description

- **Permission**
  - permission_id (PK)
  - permission_name
  - description

- **RolePermission**
  - role_id (PK, FK to Role)
  - permission_id (PK, FK to Permission)

### Academic Structure
- **Class**
  - class_id (PK)
  - class_name
  - grade_level
  - section
  - academic_year
  - class_teacher_id (FK to User)

- **Subject**
  - subject_id (PK)
  - subject_name
  - subject_code
  - description

- **ClassSubject**
  - class_subject_id (PK)
  - class_id (FK to Class)
  - subject_id (FK to Subject)
  - teacher_id (FK to User)
  - schedule_info

### Student Management
- **Student** (Extends User)
  - student_id (PK, FK to User)
  - admission_number
  - date_of_birth
  - current_class_id (FK to Class)
  - admission_date
  - parent_id (FK to Parent)

- **Parent** (Extends User)
  - parent_id (PK, FK to User)
  - occupation
  - phone_number
  - address

### Attendance
- **Attendance**
  - attendance_id (PK)
  - student_id (FK to Student)
  - class_id (FK to Class)
  - date
  - status (present/absent/late)
  - marked_by (FK to User)
  - remarks

### Assignments
- **Assignment**
  - assignment_id (PK)
  - title
  - description
  - class_subject_id (FK to ClassSubject)
  - due_date
  - created_by (FK to User)
  - created_at
  - max_score

- **StudentAssignment**
  - student_assignment_id (PK)
  - assignment_id (FK to Assignment)
  - student_id (FK to Student)
  - submission_date
  - score
  - feedback
  - status

### Examinations
- **Exam**
  - exam_id (PK)
  - exam_name
  - exam_type
  - start_date
  - end_date
  - academic_year

- **ExamSchedule**
  - schedule_id (PK)
  - exam_id (FK to Exam)
  - class_subject_id (FK to ClassSubject)
  - exam_date
  - start_time
  - end_time
  - venue

- **ExamResult**
  - result_id (PK)
  - exam_id (FK to Exam)
  - student_id (FK to Student)
  - subject_id (FK to Subject)
  - marks_obtained
  - max_marks
  - grade
  - remarks

### Communication
- **Notice**
  - notice_id (PK)
  - title
  - content
  - created_by (FK to User)
  - created_at
  - target_audience (all/teachers/students/parents)
  - expiry_date

- **Event**
  - event_id (PK)
  - title
  - description
  - start_date
  - end_date
  - venue
  - organizer_id (FK to User)
  - target_audience
  - status

- **Message**
  - message_id (PK)
  - sender_id (FK to User)
  - receiver_id (FK to User)
  - subject
  - content
  - sent_at
  - read_status
  - parent_message_id (FK to Message, for threads)

## Key Relationships

1. User-Role: One-to-Many (Each user has one role)
2. Role-Permission: Many-to-Many (Through RolePermission)
3. Class-Teacher: One-to-One (Each class has one class teacher)
4. Student-Parent: One-to-Many (Each student has one parent, parent can have multiple students)
5. Class-Subject: Many-to-Many (Through ClassSubject)
6. Student-Assignment: Many-to-Many (Through StudentAssignment)
7. Student-Attendance: One-to-Many (Each student has multiple attendance records)
8. Student-ExamResult: One-to-Many (Each student has multiple exam results)

## Indexes

1. User table: username, email
2. Student table: admission_number
3. Attendance table: (student_id, date)
4. Assignment table: due_date
5. Message table: (sender_id, receiver_id)
6. Notice table: created_at
7. Event table: start_date

## Constraints

1. User roles must be one of: admin, principal, teacher, student, parent
2. Attendance status must be: present, absent, or late
3. Assignment scores must be between 0 and max_score
4. Exam marks must be between 0 and max_marks
5. Notice expiry_date must be after created_at
6. Event end_date must be after start_date