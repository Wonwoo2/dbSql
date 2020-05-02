 직원이 속한 부서의 개수를 조회하는 쿼리를 작성하시오(emp 테이블 사용)
 => dept 테이블을 확인하면 총 4개의 부서 정보가 존재 ==> 회사 내에 존재하는 모든 부서정보
 emp 테이블에서 관리되는 직원들이 실제 속한 부서정보의 개수 ==>  10, 20, 30 : 3개
 
 SELECT *
 FROM emp;
 
 SELECT COUNT(*) cnt
 FROM
 (SELECT deptno /* deptno 컬럼이 1개 존재, row는 3개인 테이블 */
 FROM emp
 GROUP BY deptno);
 
 DBMS : Database Management System
  ==> DB
 RDBMS : Relational DataBase Management System
  ==> 관계형 데이터베이스 관리 시스템
  
 JOIN 문법의 종류
 ANSI - 표준
 벤더사의 문법 (ORACLE)
 
 JOIN의 경우 다른 테이블의 컬럼을 사용할 수 있기 때문에
 SELECT 할 수 있는 컬럼의 개수가 많아진다(가로 확장)
 
 집합연산 ==> 세로 확장 (행이 많아진다)
 
 NATURAL JOIN
    - 조인하려는 두 테이블의 연결고리 컬럼의 이름 같을 경우
    - emp, dept 테이블에는 deptno라는 공통된(동일한 이름, 동일한 타입) 연결고리 컬럼이 존재
    - 다른 ANSI-SQL 문법을 통해서 대체가 가능하고, 조인 테이블들의 컬럼명이 동일하지 않으면 
        사용이 불가능하기 때문에 사용빈도는 다소 낮다
 
 * emp 테이블 : 14건;
 SELECT *
 FROM emp;
 
 * dept 테이블 : 4건;
 
 SELECT *
 FROM dept;
 
 조인 하려고 하는 컬럼을 별도기술 하지 않음
 SELECT *
 FROM emp NATURAL JOIN dept; => 연결고리 컬럼의 이름 deptno가 같은 경우
 
 ORACLE 조인 문법을 ANSI 문법처럼 세분화 하지 않음
 오라클 조인 문법
  1. 조인할 테이블 목록을 FROM 절에 기술하며 구분자는 콜론(,)
  2. 연결고리 조건을 WHERE 절에 기술하면 된다 (ex : WHERE emp.deptno = deptno.deptno)
  
 SELECT *
 FROM emp, dept
 WHERE emp.deptno = dept.deptno;
 
 deptno가 10번인 직원들만 dept 테이블과 조인하여 조회;
 
 SELECT *
 FROM emp, dept
 WHERE emp.deptno = dept.deptno -- 조인 연결고리 기술
    AND emp.deptno = 10; -- 행에 대한 제한 조건 기술;
    
 ANSI-SQL : JOIN with USING
    - join 하려는 테이블간 이름이 같은 컬럼이 2개 이상일 때
    - 개발자가 하나의 컬럼으로만 조인하고 싶을 때 조인 컬럼명을 기술(컬럼명을 명시하고 싶어서)
    
 SELECT *
 FROM emp JOIN dept USING (deptno); ==>어떤 컬럼으로 조인할지 기술해줘야한다
 
 ANSI-SQL : JOIN with ON
    - 조인하려는 두 테이블간 컬럼명이 다를 때
    - ON절에 연결고리 조건을 기술
 
 SELECT *
 FROM emp JOIN dept ON (emp.deptno = dept.deptno);
 
 ORACLE 문법으로 위 SQL을 작성
 
 SELECT * 
 FROM emp, dept
 WHERE emp.deptno = dept.deptno;
 
 JOIN의 논리적인 구분
 SELF JOIN : 조인하려는 테이블이 서로 같을 때
 
 emp 테이블의 한행은 직원의 정보를 나타내고 직원의 정보 중 mgr 컬럼은 해당 직원의 관리자 사번을 관리
 해당 직원의 관리자의 이름을 알고 싶을 때
 
 ANSI-SQL로 SQL 조인
    - 조인하려고 하는 테이블 EMP(직원), EMP(직원의 관리자)
    - 연결고리 컬럼 : 직원.MGR = 관리자.EMPNO
    - 조인 컬럼 이름이 다르다(MGR, EMPNO)
    - NATURAL JOIN, JOIN with USING은 사용이 불가능한 형태
    - JOIN with ON 사용
    
 SELECT *
 FROM emp e JOIN emp d ON (e.mgr = d.empno); => SELECT 절에서 AS를 사용하듯이 테이블에서도 사용할 수 있다
 
 NONEQUI JOIN : 연결고리 조건이 =이 아닐 때
 그동안 WHERE에서 사용한 연산자 : =, !=, <>, <=, <, >, >=, AND, OR, NOT, LIKE (%, __), IN, BETWEEN AND (>=, <=와 같은 의미)
 
 SELECT *
 FROM emp;
 
 SELECT *
 FROM salgrade;
 
 SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
 FROM emp 
 JOIN salgrade 
 ON (emp.sal BETWEEN salgrade.losal AND salgrade.hisal); 
 ==> ORCLE 조인 문법으로 변경
 
 SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
 FROM emp, salgrade
 WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;
 
 emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성하세요
 
 SELECT e.empno, e.ename, d.deptno, d.dname
 FROM emp e JOIN dept d ON (e.deptno = d.deptno);
 
 emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성하세요
 (부서번호가 10, 30인 데이터만 조회);
 
 SELECT empno, ename, emp.deptno, dname
 FROM emp, dept 
 WHERE emp.deptno = dept.deptno 
    AND dept.deptno IN(10, 30)
    AND emp.deptno IN(10, 30); ==> 실행계획을 보기전까지 쿼리문의 논리적인 절차를 알 수 없다
    
 emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성하세요
 (급여가 2500 초과);
 
 SELECT empno, ename, sal, emp.deptno, dname
 FROM emp, dept
 WHERE emp.deptno = dept.deptno
    AND emp.sal > 2500;
    
 SELECT empno, ename, sal, emp.deptno, dname
 FROM emp JOIN dept ON emp.deptno = dept.deptno
 AND emp.sal > 2500;
 
 emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성하세요
 (급여 2500초과, 사번이 7600보다 큰 직원);
 
 SELECT empno, ename, sal, emp.deptno, dname
 FROM emp join dept ON emp.deptno = dept.deptno
 AND (sal > 2500 AND empno > 7600);
 
 emp, dept 테이블을 이용하여 다음과 같이 조회되도록 쿼리를 작성하세요
 (급여 2500 초과, 사번이 7600보다 크고, RESEARCH 부서에 속하는 직원);
 
 SELECT empno, ename, sal, emp.deptno, dname
 FROM emp join dept ON emp.deptno = dept.deptno
 AND sal > 2500 
 AND empno > 7600
 AND dept.dname = 'RESEARCH';
 
 SELECT empno, ename, emp.deptno, dname
 FROM emp JOIN dept ON (emp.deptno != dept.deptno);
 
 erd를 참고하여 prod테이블과 lprod테이블을 조인하여 다음과 같은 결과가 나오는 쿼리를 작성해보세요
 
 SELECT lprod_gu, lprod_nm, prod.prod_id, prod.prod_name
 FROM lprod JOIN prod ON lprod.lprod_gu = prod.prod_lgu;
 
 
 
 
 
 
 
 
 