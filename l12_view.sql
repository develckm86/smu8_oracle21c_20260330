CREATE VIEW 누적평균사원 AS (
SELECT
    EMPNO,ENAME,SAL,
    ROUND(AVG(SAL) OVER ( ORDER BY SAL),2) 누적평균
FROM EMP);

SELECT * FROM 누적평균사원;

CREATE VIEW emp_dept AS
SELECT e.EMPNO,e.ENAME, d.*
FROM EMP e LEFT JOIN DEPT d ON e.DEPTNO=d.DEPTNO;

SELECT * FROM emp_dept;
SELECT * FROM emp_dept WHERE LOC='DALLAS';
-- 가상테이블 view 는 수정 삭제 불가!! (물리적으로 존재하는 테이블이 아니라 조회만 하기 때문)
DELETE FROM emp_dept WHERE EMPNO=7867;
COMMIT;

-- DROP VIEW emp_dept; 후 다시 만드는 것과 동일
CREATE OR REPLACE VIEW emp_dept AS
    SELECT * FROM EMP NATURAL LEFT JOIN DEPT;
SELECT * FROM emp_dept;






