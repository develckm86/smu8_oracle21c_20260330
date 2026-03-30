CREATE TABLE student(
    name varchar2(20) UNIQUE
);
INSERT into student VALUES ('경민');
-- INSERT into student VALUES ('경민');
INSERT into student VALUES (null);
INSERT into student VALUES (null);
INSERT into student VALUES (null);
SELECT * FROM student;
-- db는 null 을 비교하지 못한다.
-- 이미 Null 데이터가 존재하기 때문에 NOT NULL 로 수정 불가
ALTER TABLE student MODIFY name VARCHAR2(20) NOT NULL UNIQUE;

DELETE FROM student WHERE name IS NULL;
ALTER TABLE student MODIFY name VARCHAR2(20) NOT NULL;
INSERT INTO student VALUES (null);
INSERT INTO student VALUES ('경민코딩');

DROP TABLE student;
SELECT * FROM student;
CREATE TABLE student(
    id NUMBER(3) PRIMARY KEY,
    name VARCHAR2(20) not null
);
INSERT INTO student (id,name) VALUES (10,'경민');
INSERT INTO student VALUES (20,'순재');
INSERT INTO student VALUES (30,'코딩');
-- INSERT INTO student VALUES (30,'코딩');
-- INSERT INTO student VALUES (null,'코딩');
commit;
SELECT * FROM student;
SELECT * FROM student WHERE name='코딩';
-- pk 는 인덱스(색인)에 등록되어 검색이 빠르다.
-- pk 는 대표키로 대표키가 없는 테이블은 만들지 않는 것이 좋다!
SELECT * FROM student WHERE id=10;

DROP TABLE student;

-- 부모테이블을 먼저 만들고 자식테이블(참조하는)을 만들어야한다.
-- d01 d02... 102호
CREATE TABLE department(
    dept_id varchar2(3) PRIMARY KEY,
    name varchar2(20) UNIQUE NOT NULL,
    loc VARCHAR2(10)
);
CREATE TABLE student(
    stud_id NUMBER(3) PRIMARY KEY,
    name VARCHAR2(20) NOT NULL,
    dept_id VARCHAR2(3),
    FOREIGN KEY (dept_id)
        REFERENCES department(dept_id)
        ON DELETE CASCADE
);
-- ON UPDATE CASCADE(SET NULL) 오라클에서 지원하지 않음!

INSERT INTO department (dept_id, name, loc) VALUES ('d01','컴퓨터','101호');
INSERT INTO department (dept_id, name, loc) VALUES ('d02','AI','102호');
commit;
SELECT * FROM department;
INSERT INTO student (stud_id,name,dept_id) VALUES (100,'경만','d01');
INSERT INTO student (stud_id,name,dept_id) VALUES (200,'경민','d03');
ROLLBACK;
INSERT INTO student (stud_id,name,dept_id) VALUES (200,'경민','d02');
SELECT * FROM student;

DELETE FROM department WHERE dept_id='d02';
-- 제약조건 이름검색
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='STUDENT';
ALTER TABLE student
    DROP CONSTRAINT SYS_C008247;
ALTER TABLE student
    ADD CONSTRAINT fk_stu_dept FOREIGN KEY (dept_id) REFERENCES department(dept_id)
    ON DELETE SET NULL;
-- 제약조건은 변경이 안되고 삭제하고 다시 만들어야함 (ON DELETE CASCADE=>SET NULL)

SELECT * FROM department;
SELECT * FROM student;
DELETE FROM department WHERE dept_id='d01';
-- score 0~100
CREATE TABLE stud_score(
    score_id NUMBER PRIMARY KEY,
    stud_id NUMBER(3) REFERENCES student (stud_id),
    score NUMBER(3) default 0 CHECK ( score BETWEEN 0 AND 100 ),
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    create_time2 DATE DEFAULT SYSDATE
);
-- 1970 년부터 밀리초로 누적되는 타입 (TIMESTAMP)
SELECT CURRENT_TIMESTAMP FROM dual;
-- 년월일 시분초를 수로 저장하는 타입 (DATE)
SELECT SYSDATE FROM dual;

INSERT INTO stud_score (score_id,stud_id) VALUES (1,100);
INSERT INTO stud_score (score_id,stud_id,score) VALUES (2,100,98);
SELECT * FROM stud_score;
CREATE SEQUENCE stud_score_seq
START WITH 2 INCREMENT BY 1;
-- SELECT stud_score_seq.nextval FROM dual;

INSERT INTO stud_score (score_id,stud_id,score)VALUES (stud_score_seq.nextval,100,66);
INSERT INTO stud_score (score_id,stud_id,score)VALUES (stud_score_seq.nextval,100,77);
-- INSERT INTO stud_score (score_id,stud_id,score)VALUES (stud_score_seq.nextval,100,200);

SELECT * FROM stud_score;

CREATE SEQUENCE seq_notice START WITH 1 INCREMENT BY 1;
CREATE TABLE notice (
                                    notice_id NUMBER DEFAULT seq_notice.NEXTVAL PRIMARY KEY,
                                    title     VARCHAR2(100) NOT NULL
);
INSERT INTO notice (title) VALUES ('안녕');
INSERT INTO notice (title) VALUES ('잘가');
INSERT INTO notice (title) VALUES ('??');
SELECT * FROM notice;

