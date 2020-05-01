 서브쿼리 복습
 
 한개의 행, 하나의 컬럼을 리턴하는 서브쿼리
 ex : 전체 직원의 급여 평균, SMITH 직원이 속한 부서의 부서번호
 
 WHERE절에서 사용가능한 연산잔
 WHERE deptno = 10
 ==> 
 부서번호가 10번 혹은 30번인 경우
 WHERE deptno IN(10, 30)
 WHERE deptno = 10 OR deptno = 30
 
 다중행 연산자
 다중행을 조회하는 서브쿼리의 경우 ( = 연산자를 사용불가 )
 ex WHERE deptno = (10, 30)
 
 WHERE deptno IN (여러개의 행을 리턴하고, 하나의 컬럼으로 이루어진 쿼리)
 
 SMITH - 20번, ALLEN은 30번 부서에 속함
  
 행이 여러개이고, 컬럼은 하나다 
 ==> 서브쿼리에서 사용가능한 연산자 IN(많이 사용,중요), (ANY, ALL) => 사용빈도 낮음
 
 IN : 서브쿼리의 결과값 중 동일한 값이 있을 때 TRUE
    WHERE 컬럼|표현식 IN (서브쿼리)
 ANY : 연산자를 만족하는 값이 하나라도 있을 때 TRUE
    WHERE 컬럼|표현식 연산자 ANY (서브쿼리)
 ALL : 서브쿼리의 모든 값이 연산자를 만족할 때 TRUE
    WHERE 컬럼|표현식 연산자 ALL (서브쿼리)

 SMITH 또는 ALLEN이 속하는 부서의 조직원 정보를 조회
 
 1. 서브쿼리를 사용하지 않을 경우 : 두 개의 쿼리를 실행
 1-1] SMITH, ALLEN이 속한 부서의 부서번호를 확인하는 ㅜ커리
 
 SELECT deptno
 FROM emp
 WHERE ename IN ('SMITH', 'ALLEN');
 
 1-2] 1-1]에서 얻은 부서번호로 IN연산을 통해 해당 부서에 속하는 직원 정보 조회
 
 SELECT *
 FROM emp
 WHERE deptno IN (20, 30);
 
 ==> 서브쿼리를 이용하면 하나의 SQL에서 실행가능
 
 SELECT *
 FROM emp
 WHERE deptno IN (SELECT deptno
 FROM emp
 WHERE ename IN ('SMITH', 'ALLEN'));
 
 서브쿼리 실습(03)
 
 SMITH와 WARD사원이 속한 부서의 모든 사원 정보를 조회하는 쿼리를 다음과 같이 작성하세요
 
 SELECT *
 FROM emp
 WHERE deptno IN (SELECT deptno
 FROM emp
 WHERE ename IN ('SMITH', 'WARD'));
 
 ANY, ALL
 SMITH(800)나 WARD(1250) 두 사원의 급여중 아무 값보다 작은 급여를 받는 직원 조회
 ==> sal < 1250과 동일한 의미
 SELECT *
 FROM emp
 WHERE sal < ANY(SELECT sal
                FROM emp
                WHERE ename IN('SMITH','WARD'));
                
 SMITH(800)나 WARD(1250) 두 사원의 급여보다 많은 급여를 받는 직원 조회
 ==> sal > 1250과 동일한 의미
 SELECT *
 FROM emp
 WHERE sal > ALL(SELECT sal
                FROM emp
                WHERE ename IN('SMITH', 'WARD'));
 
 IN 연산자의 부정
 소속부서가 20, 혹은 30인 경우
 ==> WHERE deptno IN (20, 30)
 
 소속부서가 20, 혹은 30에 속하지 않는 경우
 ==> WHERE deptno NOT IN (20, 30)
 
 NOT IN연산자를 사용할 경우 서브쿼리의 값에 NULL이 있는지 여부가 중요
 ==> NULL이 있을경우 정상적으로 동작하지 않는다
 
 아래 쿼리가 조회하는 결과는 어떤 의미인가??
 
 SELECT *
 FROM emp
 WHERE empno NOT IN (SELECT mgr
                    FROM emp);
 ==> 누군가의 매니저가 아닌 사람을 조회(NULL값 때문에 정상 작동이 하지 않는다)
 
 NULL값을 갖는 행을 제거
 SELECT *
 FROM emp
 WHERE empno NOT IN (SELECT mgr
                    FROM emp
                    WHERE mgr IS NOT NULL);

 NULL처리 함수를 통해 쿼라에 영향이 가지 않는 값으로 치환             
 SELECT *
 FROM emp
 WHERE empno NOT IN (SELECT NVL(mgr, -1)
                    FROM emp);
                    
 복수 컬럼을 리턴하는 서브쿼리
 PAIRWISE 연산 (순서쌍) ==> 동시에 만족
 
 SELECT empno, mgr, deptno
 FROM emp
 WHERE empno IN (7499, 7782); 
 empno IN(7499) == empno = 7499;
 
 7499, 7782사번의 (직원과 같은 부서, 같은 매니저)인 모든 직원 정보 조회
 매니저가 7499이면서 소속부서가 30번인 경우
 매니저가 7482이면서 소속부서가 10인 경우

 mgr 컬럼과 deptno 컬럼의 연관성이 없다
 (mgr, deptno);
 
 SELECT *
 FROM emp
 WHERE mgr IN (7499, 7782)
    AND deptno IN (10, 30);
 ==> 경우의 수 (7499, 30), (7499, 10), (7782, 10), (7782, 30)가 나온다
 하지만 위의 문제에서 원하는 값은 (7499, 30), (7782, 10)
 
 PAIRWISE 적용
 SELECT *
 FROM emp
 WHERE (mgr, deptno) IN (SELECT mgr, deptno
                            FROM emp
                            WHERE empno IN(7499, 7482));
                            
 서브쿼리 구분 - 사용 위치
 SELECT - 스칼라 서브 쿼리
 FROM - 인라인 뷰
 WHERE - 서브쿼리
 
 서브쿼리 구분 - 반환하는 행, 컬럼의 수
 - 단일 행
    단일 컬럼
    복수 컬럼
 - 복수 행
    단일 컬럼(많이 쓰는 형태)
    복수 컬럼
    
 스칼라 서브쿼리
 - SELECT 절에 표현되는 서브쿼리
 - 단일행 단일 컬럼을 리턴하는 서브쿼리만 사용 가능
 - 메인 쿼리의 하나의 컬럼 처럼 인식;
 
 SELECT 'X',
 (SELECT SYSDATE
 FROM dual)
 FROM dual;
 
 스칼라 서브 쿼리는 하나의 행, 하나의 컬럼을 반환해야 한다

 SELECT 'X', (SELECT empno, ename 
                FROM emp
                WHERE ename = 'SMITH')
 FROM dual;
 ==> 행은 하나지만 컬럼은 2개이기 때문에 에러
 
 다중행 하나의 컬럼을 리턴하는 스칼라 서브쿼리
 SELECT 'X', (SELECT empno
                FROM emp)
 FROM dual;
 
 emp 테이블만 사용할 경우 해당 직원의 소속 부서 이름을 알 수가 없다 ==> 조인을 사용하여 해결 가능
 특정 부서의 부서 이름을 조회하는 쿼리
 
 SELECT dname
 FROM dept
 WHERE deptno = 10;
 
 JOIN 으로 구현
 SELECT empno, ename, dept.deptno, dname
 FROM emp, dept
 WHERE emp.deptno = dept.deptno;
 
 위 쿼리를 스칼라 서브쿼리로 변경
 
 SELECT empno, ename, emp.deptno, (SELECT dname
                                FROM dept
                                WHERE deptno = emp.deptno)
 FROM emp;
 
 서브쿼리 구분 - 메인쿼리의 컬럼을 서브쿼리에서 사용하는지 여부에 따른 구분
 상호연관 서브쿼리(corelated sub query)
    - 메인  쿼리가 실행 되어야 서브 쿼리가 실행이 가능하다
 비상호 연관 서브쿼리(non corelated sub query)
    - 메인 쿼리의 테이블을 먼저 조회할 수도 있고
    - 서브쿼리의 테이블을 먼저 조회할 수도 있다
    ==> 오라클이 판단했을 때 성능상 유리한 방향으로 실행 방향을 결정
 
 모든 직원의 급여평균 보다 많은 급여를 받는 직원 정보 조회(서브 쿼리 이용)
 
 SELECT *
 FROM emp
 WHERE sal > (SELECT avg(sal)
                FROM emp);
 ==> 비상호 연관 서브 쿼리
 생각해볼 문제, 위의 쿼리는 상호 연관 서브 쿼리인가? 비상호 연관 서브 쿼리인가? 
 구분 기준은 메인 쿼리의 컬럼을 서브쿼리에서 사용하는가로 구분
 
 직원이 속한 부서의 급여 평균보다 많은 급여를 받는 직원
 위의 문제와 비교하여 전체 직원의 급여 평균 ==> 직원이 속한 부서의 급여 평균
 
 특정 부서(10)의 급여 평균을 구하는 SQL
 SELECT avg(sal)
 FROM emp
 WHERE deptno = 10;
 
 SELECT avg(sal)
 FROM emp
 WHERE deptno = 20;
 
 SELECT avg(sal)
 FROM emp
 WHERE deptno = 30;
 
 SELECT avg(sal)
 FROM emp;
 
 SELECT *
 FROM emp e
 WHERE e.sal > (SELECT avg(sal)
                FROM emp 
                WHERE deptno = e.deptno); ==> 직원정보를 참조하는 쿼리를 구분하기 위해 alias를 부여
 ==> 상호 연관 서브쿼리 
 
 아우터 조인 ==> 조인이 실패되더라도 기준으로 삼은 테이블의 컬럼 정보는 조회가 되도록 하는 조인 방식
 TABLE1 LEFT OUTER JOIN TABLE2
 ==> TABLE1의 컬럼은 조인에 실패하더라도 조회가 된다
 (oracle 9i 이전 까지는 기준이 되는 테이블 부터 읽는다
 ==> oracle 10g이후 부터는 성능상 유리한 테이블 부터 읽는다);
 
 SELECT *
 FROM dept;
                
 INSERT INTO dept VALUES(99, 'ddit', 'daejeon');
 ==> 데이터를 삽입하는 쿼리
 
 서브쿼리 실습(04)
 
 dept 테이블에는 신규 등록된 99번 부서에 속한 사람은 없음
 직원이 속하지 않은 부서를 조회하는 쿼리를 작성해보세요
 
 ==> emp테이블에 등록된 직원들은 10, 20, 30번 부서에만 소속이 되어있음
    직원이 소속되지 않은 부서는 : 40, 99
 
 SELECT *
 FROM dept
 WHERE deptno NOT IN (SELECT deptno
                FROM emp);
                
 직원이 속한 부서 정보 조회(직원이 한명이라도 존재하는 부서
 
 WHERE deptno = 10
    OR deptno = 10
    OR deptno = 10
    ==> 이렇게 중복되어도 결과는 똑같다
 SELECT *
 FROM dept
 WHERE deptno IN (10, 20, 30, 10, 20, 10); ==> 집합의 의미로, 중복이되어도 상관없다 10이 여러번나와도, 20이 여러번 나와도 상관없다는 뜻
 
 서브쿼리를 이용하여 IN연산자를 통해 일치하는 값이 있는지 조사할 때
 값이 여러개 있어도 상관 없다(집합)
 
 SELECT *
 FROM dept d
 WHERE deptno IN (SELECT deptno
                FROM emp);
                
 서브쿼리 실습(05)
 
 cycle, product 테이블을 이용하여 cid = 1인 고객이 애음하지 않는 
 (제품을 조회하는 쿼리)를 작성하세요
 ==> product 테이블을 조회한다는 것
 SELECT *
 FROM cycle;
 
 SELECT *
 FROM product;
 
 SELECT *
 FROM product
 WHERE pid NOT IN(SELECT pid
                FROM cycle
                WHERE cid = 1);
                
 서브쿼리 실습(06)
 
 cycle 테이블을 이용하여 cid = 1인 고객이 애음하는 제품 중 cid = 2인 고객도 애음하는 제품의
 애음정보를 조회하는 쿼리를 작성하세요
 ==> 1번 고객이 중심
 
 SELECT *
 FROM cycle;
 
 SELECT *
 FROM cycle
 WHERE cid = 1
 AND pid IN(SELECT pid
            FROM cycle
            WHERE cid = 2);
            
 서브쿼리 실습(07)
 
 customer, cycle, product 테이블을 이용하여 cid = 1인 고객이
 애음하는 제품중 cid = 2인 고객도 애음하는 제품의 애음정보를 조회하고
 고객명과 제품명까지 포함하는 쿼리를 작성하세요
 
 SELECT *
 FROM customer;
 
 SELECT *
 FROM cycle;
 
 SELECT *
 FROM product;
 
 SELECT cm.cid, cnm, c.pid, pnm, day, cnt
 FROM customer cm, cycle c, product p
 
 WHERE cm.cid = c.cid
 AND c.pid = p.pid -- 조인할때 조인 조건을 기술하지 않았었음 그래서 데이터가 많이나옴(모르고 있던것)
 
 AND cm.cid = 1
 AND c.pid IN(SELECT pid
            FROM cycle 
            WHERE cid = 2);
 ==> 조인을 사용한 해결, 스칼라 서브쿼리를 이용한 해결방법보다 효율적이다
            
 SELECT cid,(SELECT cnm
                FROM customer
                WHERE cid = cycle.cid) cnm, 
             pid, 
             (SELECT pnm 
                FROM product
                WHERE pid = cycle.pid) pnm,
            day, cnt
 FROM cycle
 WHERE cid = 1
    AND pid IN (SELECT pid
                    FROM cycle
                    WHERE cid = 2);             
 ==> 스칼라 쿼리를 이용한 해결
        
 