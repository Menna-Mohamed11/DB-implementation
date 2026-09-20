

CREATE TABLE university (
uni_id SERIAL PRIMARY KEY,
uni_name VARCHAR(50) NOT NULL
);

CREATE TABLE campus (
campus_id SERIAL PRIMARY KEY,
campus_name VARCHAR(50) NOT NULL,
uni_id INTEGER REFERENCES university(uni_id)
);

CREATE TABLE department (
dep_id SERIAL PRIMARY KEY,
dep_name VARCHAR(50) NOT NULL,
head_id INTEGER,
campus_id INTEGER REFERENCES campus(campus_id)
);

CREATE TABLE faculty (
faculty_id SERIAL PRIMARY KEY,
faculty_name VARCHAR(50) NOT NULL,
dep_id INTEGER REFERENCES department(dep_id)
);

-- Add Department Head relationship after Faculty exists
ALTER TABLE department
ADD CONSTRAINT fk_department_head
FOREIGN KEY (head_id) REFERENCES faculty(faculty_id);

CREATE TABLE programm (
program_id SERIAL PRIMARY KEY,
program_name VARCHAR(50) NOT NULL,
dep_id INTEGER REFERENCES department(dep_id)
);

CREATE TABLE students (
student_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
address VARCHAR(100),
advisor_id INTEGER REFERENCES faculty(faculty_id),
program_id INTEGER REFERENCES programm(program_id)
);

CREATE TABLE classroom (
class_id SERIAL PRIMARY KEY,
capacity INTEGER NOT NULL,
class_type VARCHAR(50),
campus_id INTEGER REFERENCES campus(campus_id)
);

CREATE TABLE course (
course_code SERIAL PRIMARY KEY,
course_title VARCHAR(50) NOT NULL,
course_level VARCHAR(50),
credit_hours INTEGER NOT NULL,
dep_id INTEGER REFERENCES department(dep_id)
);

CREATE TABLE offerings (
offering_id SERIAL PRIMARY KEY,
offering_name VARCHAR(50) NOT NULL,
semester VARCHAR(30) NOT NULL,
academic_year INTEGER NOT NULL,
start_time TIME,
end_time TIME,
course_code INTEGER REFERENCES course(course_code),
class_id INTEGER REFERENCES classroom(class_id),
primary_id INTEGER REFERENCES faculty(faculty_id),
campus_id INTEGER REFERENCES campus(campus_id)
);

CREATE TABLE enrollment (
enroll_id SERIAL PRIMARY KEY,
status VARCHAR(50),
enrollment_date DATE,
final_grade NUMERIC(4,1),
student_id INTEGER NOT NULL REFERENCES students(student_id),
offering_id INTEGER NOT NULL REFERENCES offerings(offering_id)
);

INSERT INTO university (uni_name,uni_id)
VALUES
('Horizon University',1);
INSERT INTO campus (campus_name,campus_id, uni_id)
VALUES
('Main Campus',1, 1),
('North Campus', 2,1),
('Downtown Campus',3, 1);
INSERT INTO department (dep_name,dep_id, campus_id)
VALUES
('Computer Science', 1,1),
('Information Systems',2, 1),
('Business Administration',3, 2),
('Artificial Intelligence', 4,3);
INSERT INTO faculty (faculty_name,faculty_id, dep_id)
VALUES
('Dr. Ahmed Hassan',1, 1),
('Dr. Sara Mohamed', 2,1),
('Dr. Omar Ali', 3,2),
('Dr. Menna Khaled',4, 2),
('Dr. Youssef Samir', 5,3),
('Dr. Salma Adel', 6,4),
('Dr. Karim Nabil', 7,4);
INSERT INTO programm (program_name,program_id, dep_id)
VALUES
('BSc Computer Science',1, 1),
('MSc Computer Science', 2,1),
('BSc Information Systems',3, 2),
('BSc Business Administration',4, 3),
('BSc Artificial Intelligence', 5,4);
INSERT INTO students
(first_name, last_name, address,student_id, advisor_id, program_id)
VALUES
('Ahmed', 'Mohamed', 'Cairo',1, 1, 1),
('Mariam', 'Ali', 'Giza', 2,2, 1),
('Omar', 'Hassan', 'Cairo', 3,3, 3),
('Nour', 'Khaled', 'Alexandria',4, 4, 3),
('Youssef', 'Adel', 'Giza', 5,5, 4),
('Salma', 'Omar', 'Cairo', 6,6, 5),
('Karim', 'Samir', 'Cairo', 7,7, 5),
('Laila', 'Hany', 'Giza', 8,1, 1),
('Adam', 'Tarek', 'Cairo', 9,2, 2),
('Jana', 'Mostafa', 'Alexandria',10, 6, 5);
INSERT INTO classroom
(capacity, class_type,class_id, campus_id)
VALUES
(40, 'Lecture Hall', 1,1),
(30, 'Computer Lab', 2,1),
(50, 'Lecture Hall', 3,2),
(25, 'Computer Lab', 4,3),
(35, 'Classroom', 5,3);
INSERT INTO course
(course_title, course_level, credit_hours,course_code, dep_id)
VALUES
('Programming Fundamentals', 'Undergraduate', 3, 1,1),
('Database Systems', 'Undergraduate', 3, 2,1),
('Data Structures', 'Undergraduate', 3, 3,1),
('Web Development', 'Undergraduate', 3, 4,1),
('Information Systems Analysis', 'Undergraduate', 3,5, 2),
('Business Management', 'Undergraduate', 3, 6,3),
('Artificial Intelligence', 'Undergraduate', 3,7, 4),
('Machine Learning', 'Undergraduate', 3, 8,4);
INSERT INTO offerings
(offering_name,semester,academic_year,start_time,end_time,offering_id,course_code,class_id,primary_id,campus_id)
VALUES
('Programming Fundamentals - Section A','Fall',2026,'09:00','11:00',1,1,1,1,1),

('Database Systems - Section A','Fall',2026,'11:00','13:00',2,2,2,2,1);
INSERT INTO enrollment
(student_id,offering_id,status,enrollment_date,final_grade)
VALUES
(1, 1, 'Completed', '2026-09-05', 90.0),
(1, 2, 'Completed', '2026-09-05', 87.0),
(3, 2, 'Enrolled', '2026-09-05', NULL);

SELECT * FROM university;

SELECT c.campus_id,c.campus_name,u.uni_name
FROM campus c
JOIN university u ON c.uni_id = u.uni_id;

SELECT d.dep_id,d.dep_name,c.campus_name
FROM department d
JOIN campus c ON d.campus_id = c.campus_id;

SELECT * FROM students s
JOIN programm p ON s.program_id = p.program_id;

SELECT * FROM classroom WHERE capacity >30;

