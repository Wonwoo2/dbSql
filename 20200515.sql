ROLLUP : 서브그룹 생성 - 기술된 컬럼을 오른쪽에서부터 지워나가며 GROUP BY를 실행

아래 쿼리의 서브그룹
1. GROUP BY job, deptno
2. GROUP BY job
3. GROUP BY ==> 전체

ROULLUP 사용 시 생성되는 서브 그룹의 수는 : ROLLUP에 기술한 컬럼수 + 1

SELECT DECODE(GROUPING(job), 1, '총계', 0, job) job, deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT DECODE(GROUPING(job), 1, '총', 0, job) job,
        DECODE(GROUPING(deptno), 1, DECODE(GROUPING(job), 1, '계', 0, '소계'), 0, deptno) deptno
        , SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT 
    CASE
        WHEN GROUPING(job) = 1 THEN '총'
        ELSE job
        END job,
    CASE
        WHEN GROUPING(job) = 1 AND GROUPING(deptno) = 1 THEN '계'
        WHEN GROUPING(deptno) = 1 THEN '소계'
        ELSE TO_CHAR(deptno)
        END deptno,
    SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

ROLLUP 절에 기술 되는 컬럼의 순서는 조회 결과에 영향을 미친다
        ==> 서브 그룹을 기술된 컬럼의 오른쪽 부터 

SELECT dept.dname, a.job, sal
FROM
(SELECT deptno, job, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (deptno, job))a, dept
WHERE a.deptno = dept.deptno(+);

SELECT dname, job, SUM(sal) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dname, job);

SELECT DECODE(dname, NULL, '총합', dname) dname, job, SUM(sal) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dname, job);

2. GROUPING SETS
ROLLUP의 단점 : 관심 없는 서브그룹도 생성 해야한다
               ROLLUP절에 기술한 컬럼을 오른쪽에서 지워나가기 때문에
               만약 중간과정에 있는 서브그룹이 불필요 할 경우 낭비
               
GROUPING SETS : 개발자가 직접 생성할 서브그룹을 명시
                ROLLUP과는 다르게 방향성이 없다
사용법 : GROUP BY GROUPING SETS (컬럼1, 컬럼2..) ,로 서브그룹을 구분
GROUP BY GROUPING SETS (컬럼1, 컬럼2)
GROUP BY 컬럼1
UNION ALL
GROUP BY 컬럼2

GROUP BY GROUPING SETS (컬럼2, 컬럼1)
GROUP BY 컬럼2
UNION ALL
GROUP BY 컬럼1

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno);

그룹기준을
    - job, deptno
    - mgr

SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY GROUPING SETS((job, deptno), mgr);

REPORT GROUP FUNCTION ==> 확장된 GROUP BY
REPORT GROUP FUNCTION을 사용 안하면 여러 개의 SQL작성, UNION ALL을 통해서 하나의 결과로 합치는 과정

3. CUBE
사용법 : GROUP BY CUBE (컬럼1, 컬럼2..)
기술된 컬럼의 가능한 모든 조합 (순서는 지킨다)

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY CUBE(job, deptno);

    1       2      
    job     deptno  
    job     X
    X       deptno
    X       X
    
SELECT job, deptno, mgr, SUM(sal) sal
FROM emp
GROUP BY CUBE(job, deptno, mgr);

    1       2       3      
    job     deptno  X
    job     X       mgr
    job     X       X
    X       deptno  mgr
    X       deptno  X
    X       X       mgr
    X       X       X
    
여러개의 REPORT GROUP 사용하기
SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

    1       2       3
    job     deptno  X       ==> GROUP BY job, deptno, mgr
    job     X       mgr     ==> GROUP BY job, mgr
    job     deptno  X       ==> GROUP BY job, deptno
    job     X       mgr     ==> GROUP BY job
    
SELECT job, deptno, mgr, SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY job, ROLLUP(job, deptno), CUBE(mgr);

상호 연관 서브쿼리 업데이트
1. emp테이블을 이용하여 emp_test 테이블 생성
2. emp_test 테이블에 dname컬럼 추가(dept 테이블 참고)
3. subquery를 이용하여 emp_test 테이블에 추가된 dname 컬럼을 업데이트 해주는 쿼리

1.
CREATE TABLE emp_test AS
SELECT * 
FROM emp;

2.
DESC dept;

ALTER TABLE emp_test ADD (dname VARCHAR(14));

DESC emp_test;

3.
emp_test의 dname컬럼의 값을 dept 테이블의 dname 컬럼으로 업데이트
emp_test테이블의 deptno값을 확인해서 dept테이블의 deptno값이랑 일치하는 dname 컬럼값을 가져와 update

update 대상이 되는 행 : 14 ==> WHERE 절을 기술하지 않음
모든 직원을 대상으로 dname 컬럼을 dept 테이블에서 조회하여 업데이트
UPDATE emp_test e SET dname = (SELECT dname
                                FROM dept
                                WHERE e.deptno = dept.deptno);

SELECT *
FROM emp_test;

1. dept 테이블을 이용하여 dept_test 테이블 생성

2. dept_test 테이블에 empcnt (NUMBER) 컬럼 추가

3. subquery를 이용하여 dept_test 테이블의 empcnt 컬럼에 해당 부서원
   수를 update하는 쿼리
   
DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD (empcnt NUMBER(10, 0));
UPDATE dept_test d SET empcnt = (SELECT COUNT(*)
                                FROM emp_test e
                                WHERE e.deptno = d.deptno);
                                
SELECT 결과 전체를 대상으로 그룹 함수를 적용한 경우
대상되는 행이 없더라도 0값이 리턴

SELECT COUNT(*)
FROM emp
WHERE 1 = 2;

GROUP BY 절을 기술할 경우 대상이 되는 행이 없을경우 조회되는 행이 없다
SELECT COUNT(*)
FROM emp
WHERE 1 = 2
GROUP BY deptno;
                                
SELECT *
FROM dept_test;