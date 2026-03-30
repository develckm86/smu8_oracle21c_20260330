SELECT username, account_status FROM user_users;
-- DDL(데이터 정의어) CRATE, ALTER, DROP
CREATE TABLE department (
                            dept_id VARCHAR2(10) PRIMARY KEY,
                            dept_name VARCHAR2(30) NOT NULL
);
-- DML(데이터 조작어) INSERT, UPDATE, DELETE, (DQL SELECT)
INSERT INTO department VALUES ('D01','컴퓨터공학');
INSERT INTO department VALUES ('D02','경영학과');
INSERT INTO department VALUES ('D03','산업디자인학과');
commit;
SELECT * FROM DEPARTMENT;
-- INSERT INTO department VALUES ('D03','시각디자인학과');
-- ORA-00001: 무결성 제약 조건(DBCLASS.SYS_C008221)
-- INSERT INTO department VALUES ('D04',null);
-- ORA-01400: NULL을 ("DBCLASS"."DEPARTMENT"."DEPT_NAME") 안에 삽입할 수 없습니다
-- 제약조건 : 데이터를 무결하게하는 조건



CREATE TABLE student(
                        student_id NUMBER(7) PRIMARY KEY ,
                        name VARCHAR2(30) NOT NULL,
                        grade NUMBER(1),
                        entrance_date DATE,
                        dept_id VARCHAR2(10),
                        CONSTRAINT fk_student_dept
                            FOREIGN KEY (dept_id)
                                REFERENCES department(dept_id)

);
INSERT INTO STUDENT (student_id, name, grade, entrance_date, dept_id)
VALUES (2026001,'김민지',1,'2026-03-02','D01');
commit;
INSERT INTO student (student_id, name, dept_id, grade, entrance_date)
VALUES (2026002, '박서준', 'D02', 1, '2026-03-02');

INSERT INTO student (student_id, name, dept_id, grade, entrance_date)
VALUES (2025003, '이수현', 'D01', 2, '2025-03-03');

INSERT INTO student (student_id, name, dept_id, grade, entrance_date)
VALUES (2024004, '최윤아', 'D03', 3, '2024-03-04');
commit;
--DQL (데이터 질의어)
SELECT * FROM STUDENT;

SELECT student_id as "학생 아이디", name as 이름 FROM STUDENT;

SELECT * FROM STUDENT WHERE grade=1;
-- 부서번호가 'd02'인 학생만 조회
SELECT * FROM STUDENT WHERE dept_id='D02';
-- 전체 삭제 (주의)
-- DELETE FROM STUDENT;
DELETE FROM STUDENT WHERE STUDENT_ID=2026002;
COMMIT;
UPDATE STUDENT SET grade=2 WHERE STUDENT_ID=2024004;
COMMIT;
-- 2026001 학생의 이름은 김민정으로 바꾸세요!
UPDATE STUDENT SET name='김민정' WHERE STUDENT_ID=2026001;
COMMIT ;

INSERT INTO student (student_id, name, dept_id, grade, entrance_date)
VALUES (2026005, '정하늘', 'D02', NULL, NULL);
COMMIT;
UPDATE STUDENT SET grade=4 WHERE STUDENT_ID=2026005;
COMMIT;
SELECT * FROM STUDENT ORDER BY student_id DESC;
SELECT * FROM STUDENT ORDER BY grade ASC;
SELECT * FROM STUDENT WHERE grade > 2;
UPDATE STUDENT SET grade=3 WHERE STUDENT_ID=2024004;
-- 2 이상 4이하 등급
SELECT * FROM STUDENT WHERE grade>=2 AND grade<=4;
SELECT * FROM STUDENT WHERE grade BETWEEN 2 AND 4;
-- 2,4 등급만
SELECT * FROM STUDENT WHERE grade=2 OR grade=4;
SELECT * FROM STUDENT WHERE grade IN (2,4);
SELECT * FROM STUDENT WHERE grade NOT IN (2,4);
-- 거의 모든 데이터 베이스는 null 을 비교할 수 없다.
SELECT * FROM STUDENT WHERE entrance_date=null;
SELECT * FROM STUDENT WHERE entrance_date is null;
SELECT * FROM STUDENT WHERE entrance_date is not null;
-- like+와일드카드(%_)로 문자열 찾기
SELECT * FROM STUDENT WHERE name='김민정';
SELECT * FROM STUDENT WHERE name='김';
SELECT * FROM STUDENT WHERE name like '김%';
-- 김으로 시작하는 이름
SELECT * FROM STUDENT WHERE name like '%김%';
-- 김을 포함하는 이름 이름
SELECT * FROM STUDENT WHERE name like '김__';
-- 김으로 시작하는데 글자길이가 3개인것

-- ORDER BY 정렬 (정렬은 조회가 끝난 데이터를 정렬하기 때문에 맨뒤에 작성)
SELECT * FROM STUDENT ORDER BY dept_id DESC, grade DESC;

SELECT * FROM STUDENT WHERE entrance_date is not null ORDER BY entrance_date DESC;
SELECT * FROM STUDENT ORDER BY entrance_date DESC NULLS LAST;

-- 정렬 이후 정렬 (첫번째 정렬이 집단으로 구성되어야 유효함)
SELECT * FROM STUDENT WHERE grade in (1,2,3) ORDER BY grade,name;
-- 문자열도 문자의 인코딩번호로 정렬됨
UPDATE STUDENT set grade=grade-1 WHERE student_id=2026001;
SELECT * FROM STUDENT;
ROLLBACK;
-- commit; 을 한 마지막 수정(Inset,Update,Delete)이력으로 되돌림, SELECT는 데이터를 수정하지 않음
commit;
-- 작업 시작
DELETE FROM STUDENT WHERE dept_id='D01';
DELETE FROM STUDENT WHERE dept_id='D02';
-- 논리적으로 묶은 작업의 단위
SELECT * FROM STUDENT;
ROLLBACK;
-- 작업 취소 (이전 작업으로 되돌림)
SELECT * FROM STUDENT;

SAVEPOINT s1;
DELETE FROM STUDENT WHERE name like '김%';
SAVEPOINT s2;
DELETE FROM STUDENT WHERE name like '이%';

ROLLBACK to s1;
SELECT * FROM STUDENT;
