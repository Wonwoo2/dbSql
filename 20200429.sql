 Join(08)
 
 erd를 참고하여 countries, regions 테이블을 지역별 소속 국가를 다음과 같은 결과가 나오도록 쿼리를 작성해보세요
 (지역은 유럽만 한정);
 
 SELECT *
 FROM countries;
  
 SELECT *
 FROM regions;
 
 SELECT regions.region_id, region_name, country_name
 FROM regions, countries
 WHERE regions.region_id = countries.region_id
 AND region_name = 'Europe';
  
 Join(09)
  
 erd를 참고하여 countries, regions, locations 테이블을 이용하여 지역별 소속 국가, 국가에 소속된 도시 이름을 다음과 같은
 결과가 나오도록 쿼리를 작성해보세요 (지역은 유럽만 한정)
 
 SELECT *
 FROM countries;
 
 SELECT *
 FROM regions;
 
 SELECT *
 FROM locations;
  
 SELECT regions.region_id, region_name, country_name, city
 FROM regions, countries, locations
 WHERE regions.region_id = countries.region_id
 AND countries.country_id = locations.country_id
 AND region_name = 'Europe';
  
 조인(10)
 
 erd를 참고하여 countries, regions, locations, departments 테이블을 이용하여 지역별 소속 국가, 국가에
 소속된 도시 이름 및 도시에 있는 부서를 다음과 같은 결과가 나오도록 쿼리를 작성해보세요 (지역은 유럽만 한정)
 
 SELECT *
 FROM countries;
 
 SELECT *
 FROM regions;
 
 SELECT *
 FROM locations;
 
 SELECT *
 FROM departments;
 
 SELECT regions.region_id, region_name, country_name, city, department_name
 FROM regions, countries, locations, departments
 WHERE regions.region_id = countries.region_id
 AND countries.country_id = locations.country_id
 AND locations.location_id = departments.location_id
 AND region_name = 'Europe';
  
 조인(11)
  
 erd를 참고하여 countries, regions, locations, departments, employees 테이블을 이용하여 지역별 소속 국가, 국가에
 소속된 도시 이름 및 도시에 있는 부서, 부서에 소속된 직원 정보를 다음과 같은 결과가 나오도록 쿼리를 작성해보세요 
 (지역은 유럽만 한정)
  
 SELECT *
 FROM countries;
  
 SELECT *
 FROM regions;
  
 SELECT *
 FROM locations;
 
 SELECT *
 FROM departments;
  
 SELECT *
 FROM employees;
 
 SELECT regions.region_id, region_name, country_name, city, (first_name || last_name) AS name
 FROM regions, countries, locations, departments, employees
 WHERE regions.region_id = countries.region_id
 AND countries.country_id = locations.country_id
 AND locations.location_id = departments.location_id
 AND departments.department_id = employees.department_id
 AND region_name = 'Europe';
  
 조인(12)
  
 erd를 참고하여 employees, jobs 테이블을 이용하여 직원의 담당업무 명칭을 포함하여 다음과 같은 결과가
 나오도록 쿼리를작성해보세요 

 SELECT *
 FROM employees;
  
 SELECT *
 FROM jobs;
  
 SELECT employee_id, first_name || last_name AS name, jobs.job_id, job_title
 FROM employees, jobs
 WHERE employees.job_id = jobs.job_id;
  
 조인(13)
  
 erd를 참고하여 employees, jobs 테이블을 이용하여 직원의 담당업무 명칭, 직원의 매니저 정보 포함하여 다음과 같은 결과가
 나오도록 쿼리를작성해보세요
  
 SELECT *
 FROM employees;
  
 SELECT *
 FROM jobs;
 
 SELECT e.manager_id AS mgr_id, m.first_name || m.last_name AS name, e.employee_id,  jobs.job_id, job_title
 FROM employees e, jobs, employees m
 WHERE e.job_id = jobs.job_id
    AND e.manager_id = m.employee_id;
    
 OUTER JOIN
 테이블 연결 조건이 실패해도, 기준으로 삼은 테이블의 컴럼은 조회가 되도록 하는 조인 방식
 <==> INNER JOIN(지금까지 배운 방식)
 
 LEFT OUTER JOIN     : 기준이 되는 테이블이 JOIN 키워드 왼쪽에 위치
 RIGHT OUTER JOIN    : 기준이 되는 테이블이 JOIN 키워드 오른쪽에 위치
 FULL OUTER JOIN     : LEFT OUTER JOIN + RIGHT OUTER JOIN - (중복되는 데이터가 한건만 남도록 처리)
 
 emp 테이블의 컬럼중 mgr컬럼을 통해 해당 직원의 관리자 정보를 찾아갈 수 있다. 하지만 KING 직원의 경우 상급자가 없기 때문에 
 일반적인 inner 조인 처리시 조인에 실패하기때문에 KING을 제외한 13건의 데이터만 조회가 된다
 
 INNER 조인 복습
 
 직원의 직속 상급자 사번, 상급자 이름, 직원 사번, 직원 이름
 
 SELECT *
 FROM emp;
 
 조인이 성공해야지만 데이터가 조회된다
 ==> KING의 상급자 정보(mgr)는 NULL이기 때문에 조인에 실패하고
     KING의 정보는 나오지 않는다 (emp 테이블 건수 14건 ==> 조인 결과 13건)
 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp e, emp m
 WHERE e.mgr = m.empno;
 
 ANSI-SQL
 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp e JOIN emp m
 ON e.mgr = m.empno;
 
 위의 쿼리를 OUTER 조인으로 변경
 (KING 직원이 조인에 실패하도 본인 정보에 대해서는 나오도록, 하지만 상급자 정보는 없기 때문에 나오지 않는다);
 
 ANSI-SQL : OUTER
 
 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp e LEFT OUTER JOIN emp m
 ON e.mgr = m.empno; 
 기준 = 왼쪽의 직원 테이블
 
 테이블 조인키워드 테이블
 ※ 조인키워드에 따라 기준이 되는 테이블이 달라진다
 
 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp m RIGHT OUTER JOIN emp e
 ON e.mgr = m.empno; 
 기준 = 오른쪽의 직원 테이블
 
 ORACLE-SQL : OUTER(ANSI-SQL 과 가장 문법적으로 차이남)
 oracle join
 1. FROM절에 조인할 테이블 기술(콤마로 구분)
 2. WHERE 절에 조인 조건을 기술
 3. 조인 컬럼(연결고리) 중 조인이 실패하여 데이터가 없는 쪽의 컬럼에 (+)을 붙여준다
    ==> 마스터 테이블 반대편쪽 테이블의 컬럼

 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp e, emp m
 WHERE e.mgr = m.empno(+);
 
 OUTER 조인의 조건 기술 위치에 따른 결과 변화
 
 직원의 상급자 이름, 아이디를 포함해서 조회
 단, 직원의 소속부서가 10번에 속하는 직원들만 한정해서;
 
 조건을 ON절에 기술했을 때
 SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
 FROM emp e LEFT OUTER JOIN emp m
 ON (e.mgr = m.empno AND e.deptno = 10);
 ON절은 JOIN에 대한 조건을 기술한다
 
 조건을 WHERE절에 기술했을 때
 SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
 FROM emp e LEFT OUTER JOIN emp m
 ON e.mgr = m.empno
 WHERE e.deptno = 10; ==> WHERE절에 기술함으로 INNER 조인과 같다
 
 OUTER 조인을 하고 싶은 것이라면 조건을 ON절에 기술하는게 맞다
 
 oracle OUTER JOIN
 
 SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
 FROM emp e, emp m
 WHERE (e.mgr = m.empno(+)
 AND e.deptno = 10);
 
 OUTER JOIN(01)
 
 buyprod 테이블에 구매일자가 2005년 1월 25일 데이터는 3품목 밖에 없다
 모든 품목이 나올 수 있도록 쿼리를 작성해보세요
 
 SELECT * 
 FROM buyprod;
 
 SELECT *
 FROM prod;
 
 ANSI-SQL
 
 SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
 FROM prod p LEFT OUTER JOIN buyprod bp
 ON p.prod_id = bp.buy_prod 
 AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');
 
 ORACLE-SQL
 
 SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
 FROM prod p, buyprod bp
 WHERE p.prod_id = bp.buy_prod(+)
 AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');
 
 OUTER JOIN(02)
 
 outerjoin1에서 작업을 시작하세요 by_date 컬럼이 null인 항목이 안나오도록 다음처럼 데이터를 채워지도록 쿼리를 작성하세요
 
 SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD') as by_date, buy_prod, prod_id, prod_name, buy_qty
 FROM prod p, buyprod bp
 WHERE p.prod_id = bp.buy_prod(+)
 AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');
 
 OUTER JOIN(03)
 
 outerjoin1에서 작업을 시작하세요 by_qty 컬럼이 null일 경우 0으로 보이도록 쿼리를 수정하세요
 
 SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD') as by_date, buy_prod, prod_id, prod_name, NVL(buy_qty, 0) buy_qty
 FROM prod p, buyprod bp
 WHERE p.prod_id = bp.buy_prod(+)
 AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD'); ==> 컬럼에 상수로 표현하면 해결가능
 
 OUTER JOIN(04)
 
 cycle, product 테이블을 이용하여 고객이 애음하는 제품 명칭을 표현하고, 
 (애음하지 않는 제품 ==> product 테이블이 기준이 되는걸 알수 있음)
 도 다음과 같이 조회되도록쿼리를 작성하세요
 (고객은 cid = 1인 고객만 나오도록 제한, null 처리);
 
 SELECT *
 FROM cycle;
 
 SELECT *
 FROM product;
 
 SELECT p.pid, p.pnm, 1 as cid, NVL(day, 0) day, NVL(cnt, 0) cnt
 FROM cycle c RIGHT OUTER JOIN product p
 ON p.pid = c.pid
 AND c.cid = 1;
 
 SELECT p.pid, p.pnm, 1 as cid, NVL(day, 0) day, NVL(cnt, 0) cnt
 FROM cycle c RIGHT OUTER JOIN product p
 ON p.pid = c.pid
 AND c.cid = 1;
 
 OUTER JOIN(05)
 
 cycle, product, customer 테이블을 이용하여 고객이 애음하는 제품 명칭을 표현하고,
 애음하지 않는 제품도 다음과 같이 조회되며 고객이름을 포함하여 쿼리를 작성하세요
 (고객은 cid = 1인 고객만 나오도록 제한, null 처리);
 
 SELECT *
 FROM cycle;
 
 SELECT *
 FROM product;
 
 SELECT *
 FROM customer;
 
 SELECT a.pid, a.pnm, a.cid, cm.cnm, a.day, a.cnt
 FROM
 (SELECT p.pid, p.pnm, 1 as cid, NVL(day, 0) day, NVL(cnt, 0) cnt
 FROM cycle c RIGHT OUTER JOIN product p
 ON p.pid = c.pid
 AND c.cid = 1) a JOIN customer cm
 ON a.cid = cm.cid;
 
 쿼리 작성할때 많이 실수하는 것 : 3개의 테이블을 조인할 때 2가지의 조건이 나와야하는데 누락하는 경우가 많다
 SELECT *
 FROM product, cycle, customer
 WHERE product.pid = cycle.pid;
 2가지의 조건을 모두 기술 했을 경우 행의 갯수 15
 위의 쿼리로 조회했을 경우 행의 갯수 45
 3배 ==> customer의 행의 갯수
 
 CROSS JOIN
 조인 조건을 기술하지 않은 경우
 모든 가능한 행의 조합으로 결과가 조회된다
 
 ANSI-SQL
 
 emp 14 * dept 4 = 56 (행의 갯수)
 SELECT *
 FROM emp CROSS JOIN dept;
 
 ORACLE-SQL (조인 테이블만 기술하고 WHERE 절에 조건을 기술하지 않는다)
 
 SELECT *
 FROM emp, dept;
 
 CROSS JOIN(01)
 
 customer, product 테이블을 이용하여 애음 가능한 모든 제품의 정보를 결합하여 다음과 같이
 조회되도록 쿼리를 작성하세요
 
 SELECT cid, cnm, pid, pnm
 FROM customer, product;
 
 SELECT cid, cnm, pid, pnm
 FROM customer CROSS JOIN product;
 
 서브쿼리
 WHERE : 조건을 만족하는 행만 조회되도록 제한
 
 SELECT *
 FROM emp
 WHERE 1 = 1;
 
 서브 <==> 메인
 서브쿼리는 다른 쿼리 안에서 작성된 쿼리
 
 서브쿼리 가능한 위치(제약이 있다)
    1. SELECT
        - SCALAR SUB QUERY
        - * 스칼라 서브쿼리는 조회되는 행이 1행이고, 컬럼이 한개의 컬럼이어야 한다
            EX) DUAL 테이블
    2. FROM
        - INLINE-VIEW
        - SELECT 쿼리를 괄호로 묶은 것
    3. WHERE
        - SUB QUERY
        WHERE 절에 사용된 쿼리(별다른 정의가 없다)
 
 SMITH가 속한 부서에 속한 직원들은 누가 있을까?
 
 1. SMITH가 속한 부서가 몇번인지?
 2. 1번에서 알아낸 부서번호에 속하는 직원을 조회
 
 ==> 독립적인 2개의 쿼리를 각각 실행
     두번째 쿼리는 첫번째 쿼리의 결과에 따라 값을 다르게 가져와야 한다
     (SMITH(20) => WARD(30) ==> 두번째 쿼리 작성시 10번에서 30번으로 조건을 변경)
     ==> 유지보수 측면에서 좋지 않음
 
 첫번째 쿼리;
 SELECT deptno -- 20
 FROM emp
 WHERE ename = 'SMITH';
        
 두번째 쿼리;
 SELECT *
 FROM emp
 WHERE deptno = 20;
 
 서브쿼리를 통한 쿼리 통합
 SELECT *
 FROM emp
 WHERE deptno = (SELECT deptno
                    FROM emp
                    WHERE ename = 'SMITH'); WHERE절 ==> 문제에 따라 바뀌는 값
                    
 SELECT *
 FROM emp
 WHERE deptno = (SELECT deptno
                    FROM emp
                    WHERE ename = :ename); ==> :ename 바인드변수를 사용하는 것
                    
 서브쿼리 실습(01)
 
 평균 급여보다 높은 급여를 받는 직원의 수를 조회하세요
 
 SELECT AVG(sal)
 FROM emp;
 
 SELECT COUNT(*)
 FROM emp
 WHERE sal > 2073.21;
 
 SELECT COUNT(*)
 FROM emp
 WHERE sal > (SELECT ROUND(AVG(sal), 0)
 FROM emp);
 
 서브쿼리 실습(02)
 
 평균 급여보다 높은 급여를 받는 직원의 정보를 조회하세요
 
 SELECT *
 FROM emp
 WHERE sal > (SELECT ROUND(AVG(sal), 0)
 FROM emp);
 
 
 
 