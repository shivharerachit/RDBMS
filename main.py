from eralchemy import render_er

# Define the ER diagram in text form based on the given SQL schema
erd_text = """
[Users] {
    user_id INT PK
    name VARCHAR
    email VARCHAR UNIQUE
    role ENUM
    password_hash VARCHAR
    created_at DATETIME
}
[Students] {
    student_id INT PK
    class_id INT FK
    date_of_birth DATE
    guardian_name VARCHAR
    address VARCHAR
}
[Teachers] {
    teachers_id INT PK
    subject_id INT FK
    joining_date DATE
    salary NUMERIC
}
[Classes] {
    class_id INT PK
    class_name VARCHAR
    teacher_id INT FK
    schedule VARCHAR
}
[Subjects] {
    subject_id INT PK
    subject_name VARCHAR
    class_id INT FK
}
[Attendance] {
    attendance_id INT PK
    student_id INT FK
    date DATE
    status BOOLEAN
}
[Exams] {
    exam_id INT PK
    class_id INT FK
    subject_id INT FK
    date DATE
    type ENUM
}
[Results] {
    result_id INT PK
    exam_id INT FK
    student_id INT FK
    marks_obtained INT
}

Users.user_id > Students.student_id
Users.user_id > Teachers.teachers_id
Students.class_id > Classes.class_id
Teachers.subject_id > Subjects.subject_id
Classes.teacher_id > Teachers.teachers_id
Subjects.class_id > Classes.class_id
Attendance.student_id > Students.student_id
Exams.class_id > Classes.class_id
Exams.subject_id > Subjects.subject_id
Results.exam_id > Exams.exam_id
Results.student_id > Students.student_id
"""

# Generate the ER diagram image
output_path = "/schoolDB_ER_diagram.png"
render_er(erd_text, output_path)

print(f"ER diagram saved at {output_path}")