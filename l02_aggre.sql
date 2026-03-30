SELECT SUM(GRADE) FROM STUDENT;
SELECT AVG(GRADE) FROM STUDENT;
SELECT COUNT(*) FROM STUDENT;

SELECT AVG(GRADE) FROM STUDENT WHERE DEPT_ID='D01';
SELECT MIN(GRADE),MAX(GRADE),AVG(GRADE) FROM STUDENT WHERE DEPT_ID='D01';


-- 참조의 무결성 : ORA-02291: 무결성 제약조건(DBCLASS.SYS_C008230)이 위배되었습니다- 부모 키가 없습니다
INSERT INTO student (student_id, name, dept_id, grade, entrance_date)
VALUES (2026002, '박서준', 'D02', 1, '2026-03-02');
-- CONNECT dbclass/Dbclass123@localhost:1521/XEPDB1
-- DROP 삭제
DROP TABLE exam_score;
-- 복합키 : 두개 이상의 필드로 대표키를 생성 (학생은 한과목만 시험을 본다)
CREATE TABLE exam_score (
                            student_id NUMBER(7)    NOT NULL,
                            subject    VARCHAR2(20) NOT NULL,
                            score      NUMBER(3),
                            exam_date  DATE,
                            PRIMARY KEY (student_id, subject),
                            FOREIGN KEY (student_id) REFERENCES STUDENT(student_id)
);
INSERT INTO exam_score VALUES (2026001, 'DATABASE', 95, DATE '2026-04-10');
INSERT INTO exam_score VALUES (2026001, 'JAVA',     88, DATE '2026-04-20');

INSERT INTO exam_score VALUES (2026002, 'DATABASE', 76, DATE '2026-04-10');
INSERT INTO exam_score VALUES (2026002, 'JAVA',    NULL, DATE '2026-04-20');

INSERT INTO exam_score VALUES (2025003, 'DATABASE', 91, DATE '2026-04-10');
INSERT INTO exam_score VALUES (2025003, 'JAVA',     84, DATE '2026-04-20');

INSERT INTO exam_score VALUES (2024004, 'DATABASE', 67, DATE '2026-04-10');
INSERT INTO exam_score VALUES (2024004, 'JAVA',     73, DATE '2026-04-20');

INSERT INTO exam_score VALUES (2026005, 'DATABASE', 82, DATE '2026-04-10');
INSERT INTO exam_score VALUES (2026005, 'JAVA',     79, DATE '2026-04-20');

COMMIT;

SELECT * FROM exam_score;

SELECT SUM(score) FROM exam_score;

SELECT SUM(score) FROM exam_score WHERE subject='JAVA';
SELECT SUM(score) FROM exam_score WHERE subject='DATABASE';

SELECT AVG(score) as "평균 점수" FROM exam_score;
-- SELECT AVG(score) as "평균 점수",student_id FROM exam_score;
SELECT COUNT(*), MAX(score), MIN(score) FROM exam_score;

-- distinct 집계 (같은 것 끼리 묶는 집계)

SELECT distinct subject FROM exam_score;
-- SELECT distinct subject, SUM(score)  FROM exam_score;

-- GROUP BY 는 distinct 처럼 같은 것 끼리 묶는데 다른 집계함수를 사용가능
SELECT subject FROM exam_score GROUP BY subject;
SELECT subject, SUM(score), AVG(score) FROM exam_score GROUP BY subject;
SELECT * FROM exam_score;
SELECT student_id,
    SUM(score), AVG(score)
    FROM exam_score
    GROUP BY student_id
    ORDER BY student_id DESC;

-- 집계된 결과로 조건 조회는 where로 할 수 없다. **having
SELECT student_id, AVG(score) FROM exam_score GROUP BY student_id;
SELECT student_id, AVG(score) FROM exam_score GROUP BY student_id HAVING AVG(score)>=80;
-- SELECT student_id, AVG(score) 평균 FROM exam_score GROUP BY student_id HAVING 평균>=80;

SELECT score as 성적 FROM exam_score WHERE score>=80;
-- 오라클은 별칭을 만드는 시점이 조회가 끝이 나서다.
-- SELECT score as 성적 FROM exam_score WHERE 성적>=80;
SELECT * FROM (SELECT score as 성적 FROM exam_score) WHERE 성적>=80;




