CREATE DATABASE ss5_bt3;
USE ss5_bt3;
CREATE TABLE students
(
    student_id   INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    student_name varchar(255),
    age          INT,
    email        varchar(100)
);
CREATE TABLE classes
(
    class_id   INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    class_name varchar(100)
);

CREATE TABLE classStudent
(
    student_id INT,
    class_id   INT
);

ALTER TABLE classStudent
    ADD CONSTRAINT fk_student FOREIGN KEY (student_id)
        REFERENCES students (student_id);
ALTER TABLE classStudent
    ADD CONSTRAINT fk_class FOREIGN KEY (class_id)
        REFERENCES classes (class_id);

CREATE TABLE subjects
(
    subject_id   INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    subject_name varchar(255)
);

CREATE TABLE marks
(
    mark       INT,
    subject_id INT,
    student_id INT
);

ALTER TABLE marks
    ADD CONSTRAINT fk_subject FOREIGN KEY (subject_id)
        REFERENCES subjects (subject_id);

ALTER TABLE marks
    ADD CONSTRAINT fk_student_mark FOREIGN KEY (student_id)
        REFERENCES students (student_id);

-- them du lieu
INSERT INTO students(student_name, age, email)
VALUES ('Nguyen Quang An',18 , 'an@gmail.com'),
       ('Nguyen Cong Vinh',20 , 'vinh@gmail.com'),
       ('Nguyen Van Quyen',19 , 'quyen@gmail.com'),
       ('Pham Thanh Binh',25 , 'binh@gmail.com'),
       ('Nguyen Van Tai Em',30 , 'taiem@gmail.com');

INSERT INTO classes(class_name)
VALUES ('CO706L'), ('C0708G');

INSERT INTO classStudent(student_id, class_id)
VALUES (1,1),
       (2,1),
       (3,2),
       (4,2),
       (5,2);

INSERT INTO subjects(subject_name)
VALUES ('SQL'),
       ('Java'),
       ('C'),
       ('Vusual Basic');

INSERT INTO marks(mark, subject_id, student_id)
VALUES (8,1,1),
       (4,2,1),
       (9,1,1),
       (7,1,3),
       (3,1,4),
       (5,2,5),
       (8,3,3),
       (1,3,5),
       (3,2,4);

#Hien thi danh sach tat ca cac hoc vien
SELECT * from students;
#Hien thi danh sach tat ca cac mon hoc
SELECT * from subjects;
#Tinh diem trung binh
SELECT AVG(mark) as Diem_trung_binh from marks;
#Hien thi mon hoc nao co hoc sinh thi duoc diem cao nhat
SELECT subject_name from subjects
join marks m on subjects.subject_id = m.subject_id
where mark IN ( SELECT max(mark) from marks);
#Danh so thu tu cua diem theo chieu giam
SELECT * from marks
order by mark ;
#Thay doi kieu du lieu cua cot SubjectName trong bang Subjects thanh nvarchar(max)
ALTER TABLE subjects
MODIFY subject_name varchar(255);
#Cap nhat them dong chu « Day la mon hoc « vao truoc cac ban ghi tren cot SubjectName trong bang Subjects
SELECT concat('Day la mon hoc ' , subject_name) from subjects
where subject_id is not null ;
#Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50
ALTER TABLE students
ADD CONSTRAINT check_age CHECK ( age BETWEEN 15 and 50) ;
#Loai bo tat ca quan he giua cac bang
ALTER TABLE classStudent
DROP FOREIGN KEY fk_student;
ALTER TABLE classStudent
    DROP FOREIGN KEY fk_class;

ALTER TABLE marks
    DROP FOREIGN KEY fk_subject;
ALTER TABLE marks
    DROP FOREIGN KEY fk_student_mark;
#Xoa hoc vien co StudentID la 1
DELETE from students where student_id = 1 ;
#Trong bang Student them mot column Status co kieu du lieu la Bit va co gia tri Default la 1
ALTER TABLE students
ADD student_status bit default 1 ;
ALTER TABLE students
DROP student_status  ;
SELECT * from students;
#Cap nhap gia tri Status trong bang Student thanh 0
UPDATE students SET student_status = 0 where student_id is not null;