table에는 조회/저장 순서가 없다
==> ORDER BY 컬럼명 정렬방식, .....

참고*
ORDER BY 컬럼순서 번호 로 정렬 가능
==> SELECT 컬럼의 순서가 바뀌거나, 컬럼 추가가 되면 원래 의도대로 동작하지 않을 가능성이 있음

SELECT의 3번째 컬럼을 기준으로 정렬

SELECT * FROM emp
ORDER BY 3;

별칭으로 정렬
컬럼에다가 연산을 통해 새로운 컬럼을 만드는 경우
SAL*DEPTNO, SAL_DEPT
SELECT empno, ename, sal, deptno, sal*deptno sal_dept
FROM emp
ORDER BY sal_dept;

dept 테이블의 모든 정보를 부서이름으로 오름차순 정렬로 조회되도록 쿼리를 작성하세요

SELECT *
FROM dept
ORDER BY dname ASC;

dept 테이블의 모든 정보를 부서위치로 내림차순 정렬로 조회되도록 쿼리를 작성하세요

SELECT *
FROM dept
ORDER BY loc DESC;

emp 테이블에서 상여(comm) 정보가 있는 사람들만 조회하고, 상여(comm)를 많이 받는 사람이 먼저
조회되도록 하고, 상여가 같을 경우 사번으로 오름차순 정렬하세요(상여가 0인 사람은 상여가 없는
것으로 간주)

SELECT *
FROM emp
WHERE comm > 0
ORDER BY comm DESC, empno ASC;

emp 테이블에서 관리자가 있는 사람들만 조회하고, 직군(job) 순으로 오름차순 정렬하고, 직업이
같을 경우 사번이 큰 사원이 먼저 조회되도록 쿼리를 작성하세요

SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno DESC;

SELECT *
FROM emp
WHERE mgr !=0
ORDER BY job, empno DESC;

emp 테이블에서 10번 부서(deptno) 혹은 30번 부서에 속하는 사람 중
급여(sal)가 1500이 넘는 사람들만 조회하고 이름으로 내림차순 정렬되도록
쿼리를 작성하세요

SELECT *
FROM emp
WHERE (deptno = 10
OR deptno = 30)
AND sal > 1500
ORDER BY ename DESC;

페이징 처리를 하는 이유
 - 데이터가 너무 많기 때문에
 - 한 화면에 담으면 사용성이 떨어진다
 - 성능면에서 느려진다

오라클에서 페이징 처리 방법 ==> ROWNUM

ROWNUM : SELECT 순서대로 1번부터 차례대로 번호를 부여해주는 특수 KEWORD

SELECT ROWNUM, empno, ename
FROM emp;

SELECT절에 * 표기하고 콤마를 통해
다른 표현(ex ROWNUM)을 기술할 경우
* 앞에 어떤 테이블에 대한건지 테이블 명칭/별칭을 기술해야 한다

SELECT ROWNUM, e.*
FROM emp e;

페이징 처리를 위해 필요한 사항
 - 페이지 사이즈(10)
 - 데이터 정렬 기준

1-page : 1 ~ 10
2-page : 11 ~ 20 (11 ~ 14)
1 page
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM
BETWEEN 1 
AND 10;

2 page
SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM
BETWEEN 11 
AND 20;

ROWNUM의 특징
1. ORACLE에만 존재
    - 다른 DBMS의 경우 페이징 처리를 위한 별도의 키워드가 제공 (LIMIT)
2. 1번부터 순차적으로 읽는경우만 가능
    - ROWNUM BETWEEN 1 AND 10 ==> 1 ~ 10
    - ROWNUM BETWEEN 11 AND 20 ==> 1 ~ 10을 SKIP하고 11 ~ 20을 읽으려고 시도
    
WHERE 절에서 ROWNUM을 사용할 경우 다음 형태
    ROWNUM = 1;
    ROWNUM BETWEEN 1 AND N;
    ROWNUM <, <= N (1 ~ N)
    
SELECT ROWNUM, empno, ename
FROM emp
ORDER BY empno;

SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;

ROWNUM은 ORDER BY 이전에 실행
SELECT -> ROWNUM -> ORDER BY

ROWNUM의 실행순서에 의해 정렬이 된상태로 ROWNUM을 부여하려면 IN-LINE VIEW를 사용해야 한다
** IN-LINE : 직접 기술을 했다라는 것을 뜻함;

SELECT ROWNUM, a.*
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename) a) a
WHERE rn BETWEEN 1 + (:page - 1) * :pageSize AND :page * :pageSize;

WHERE rn BETWEEN 1 AND 10 : 1 PAGE
WHERE rn BETWEEN 11 AND 20 : 2PAGE
WHERE rn BETWEEN 21 AND 30 : 3PAGE

WHERE rn BETWEEN 1+(n-1)*10 AND pageSize * n ; n PAGE

SELECT *
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename);

INLINE-VIEW와 비교를 위해 VIEW를 직접 생성(선행학습, 나중에 나옴)
VIEW - 쿼리 (view 테이블-x) 뷰는 실체가 없다

DML - Data Manipulantion Language : SELECT, INSERT, UPDATE, DELETE
DDL - Data Definition Language : CREATE, DROP, MODIFY, RENAME

CREATE OR REPLACE VIEW emp_ord_by_ename AS
    SELECT empno, ename
    FROM emp
    ORDER BY ename;
    
IN-LINE VIEW로 작성한 쿼리
SELECT *
FROM (SELECT empno, ename
    FROM emp
    ORDER BY ename);

view로 작성한 쿼리
SELECT *
FROM emp_ord_by_ename;

emp 테이블에 데이터를 추가하면
in-line view, view를 사용한 쿼리의 결과는 어떻게 영향을 받을까?

INSERT INTO emp (empno, ename) VALUES(9999, '브라운');
SELECT empno, ename
FROM emp;

쿼리 작성시 문제점 찾아가기
java : 디버깅
SQL : 디버깅 툴이 없다(절차가 없기 때문에)

페이징 처리 ==> 정렬, ROWNUM
정렬, ROWNUM을 하나의 쿼리에서 실행할 경우 ROWNUM이후 정렬을 하여숫자가 섞이는 현상 발생
==> INLINE-VIEW
    정렬에 대한 LINE-VIEW
    ROWNUM에 대한 INLINE-VIEW

SELECT *
FROM
(SELECT ROWNUM rn, a.* 
FROM 
(SELECT empno, ename
FROM emp
ORDER BY ename) a) a
WHERE rn BETWEEN 1 AND 10;

==> 안에 있는 데이터 쿼리만 변하고 나머지 바깥부분은 변하지 않음
emp 테이블의 사원 정보를 이름컬럼으로 오름차순 적용 했을 때의 11 ~ 14번째 행을 다음과 같이 조회하는 쿼리를 작성하세요

SELECT *
FROM
(SELECT ROWNUM rn, a.* 
FROM 
(SELECT empno, ename
FROM emp
ORDER BY ename) a) a
WHERE rn BETWEEN 11 AND 14;

PROD 테이블을 PROD_LGU (내림차순), PROD_COST(오름 차순)으로 정렬하여 페이징 처리 쿼리를 작성하세요
단 페이지 사이즈는 5
바인드 변수 사용할 것

SELECT *
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT *
FROM prod
ORDER BY prod_lgu DESC, prod_cost ASC) a) a
WHERE RN BETWEEN (:page-1)* :pageSize + 1 AND :page * :pageSize;