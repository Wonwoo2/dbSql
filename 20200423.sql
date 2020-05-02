 NVL(expr1, expr2)
 if expr1 == null
    return expr2
 else
    return expr1
    
 NVL2(expr1, expr2, expr3)
 if expr1 != null
    return expr2
 else
    return expr3
    
 SELECT empno, ename, sal, comm, NVL2(comm, 100, 200)
 FROM emp;
 
 NULLIF(expr1, expr2)
 expr1 == expr2
    return null
 expr1 != expr2
    return expr2
    
 sal 컬럼의 값이 3000이면 null을 리턴
 SELECT empno, ename, sal, NULLIF(sal, 3000)
 FROM emp;
 
 가변인자 : 함수 인자의 갯수가 정해져 있지 않음
           ※ 가변인자들의 타입은 동일 해야함
           ex)display("test"), display("test", "test2", "test3")
 
 인자들 중에 가장 먼저 나오는 null이 아닌 인자 값을 리턴         
 coalesce(expr1, expr2...)
 expr1 != null
    return expr1
 exprl == null
    return coaleasce(expr2, expr3...) 첫번째 인자를 제외함
    
 mgr 컬럼 null
 comm 컬럼 null
 
 SELECT empno, ename, comm, sal, coalesce(comm, sal)
 FROM emp;
 
 emp 테이블의 정보를 다음과 같이 조회되도록 쿼리를 작성하세요
 (nvl, nvl2, coalesce);
 
 SELECT empno, ename, mgr, NVL(mgr, 9999) AS mgr_n, 
        NVL2(mgr, mgr, 9999) AS mgr_n_1, coalesce(mgr, 9999) AS mgr_n_2
 FROM emp;
 
 users 테이블의 정보를 다음과 같이 조회하도록 쿼리를 작성하세요
 reg_dt가 null일 경우 sysdate를 적용
 
 SELECT userid, usernm, reg_dt, NVL(reg_dt,TO_DATE(sysdate, 'YY/MM/DD')) AS n_reg_dt
 FROM users
 WHERE userid != 'brown';
 
 가상화 --> os 위에 다른 os 설치
 1. 하드웨어 자원을 뽑아먹음
 2. oracle mac 플랫폼을 지원X
 
 포트(1 ~ 2 ^ 16)
 http - 80
 mysql, 마리아 - 3306
 톰캣 - 8080
 오라클 - 1521
 
 가상화 => 8년전쯤 유행
        클라우드, 아마존(Web Service)
 도커 컨테이너
 
 오라클 계정 : scott/tiger
 
 condition
 조건에 따라 컬럼 혹은 표현식을 다른 값으로 대체
 java의 if, swtich 같은 개념
 - case 구문
 - decode 함수
 
 1. CASE
 CASE
    WHEN 참/거짓을 판별할 수 있는 식 THEN 리턴할 값
    [WHEN 참/거짓을 판별할 수 있는 식 THEN 리턴할 값]
    [ELSE 리턴할 값 (판별식이 참인 WHEN 절이 없을경우 실행)]
 END
 
 emp 테이블에 등록된 직원들에게 보너스를 추가적으로 지급할 예정
 해당 직원의 job이 SALESMAN일 경우 SAL에서 5%(5퍼센트) 인상된 금액을 보너스로 지급 (ex : sal 100 => 105)
 해당 직원의 mgr이 MANAGER일 경우 SAL에서 10%(10퍼센트) 인상된 금액을 보너스로 지급
 해당 직원의 job이 PRESIDENT일 경우 SAL에서 20%(20퍼센트) 인상된 금액을 보너스로 지급
 그외 직원들은 sal만큼만 지급
 
 SELECT empno, ename, job, sal,
        CASE
                WHEN job = 'SALEMAN' THEN sal * 1.05
                WHEN job = 'MANMAGER' THEN sal * 1.05
                WHEN job = 'SSAL' THEN sal * 1.05                
                ELSE sal           
        END bonus
 FROM emp;
 
 2. DECODE(expr1, serch1, return1, search2, return2, serch3, return3..... (default))
    DECODE(expr1, 
            serch1, return1, 
            search2, return2, 
            serch3, return3
            default);
    expr1 == serch1
        return return1
    expr1 == serch2
        return return2
    expr1 == serch3
        return return3
    .....
    else
        return default;
 
 SELECT empno, ename, job, sal,
        DECODE(job, 'SALESMAN', sal * 1.05,
                    'MANAGER', sal * 1.10,
                    'PRESIDENT', sal * 1.20,
                    sal) bonus
 FROM emp;
 
 emp 테이블을 이용하여 deptno에 따라 부서명으로 변경해서 다음과 같이 조회되는 쿼리를 작성하세요
    - 10 => 'ACCOUTNING'
    - 20 => 'RESEARCH'
    - 30 => 'SALES'
    - 40 => 'OPERATIONS'
    - 기타 다른값 => 'DDIT'
    
 SELECT empno, ename, deptno,
        CASE
            WHEN deptno = 10 THEN 'ACCOUNTING'
            WHEN deptno = 20 THEN 'RESEARCH'
            WHEN deptno = 30 THEN 'SALES'
            WHEN deptno = 40 THEN 'OPERATIONS'
            ELSE 'DDIT'
        END dname
 FROM emp;
 
 SELECT empno, ename, deptno,
        DECODE(deptno, 10, 'ACCOUNTING',
                    20, 'RESEARCH',
                    30, 'SALES',
                    40, 'OPERATIONS',
                    'DDIT') dname
 FROM emp;
 
 emp 테이블을 이용하여 hiredate에 따라 올해 건강보험 검진대상자인지 조회하는 쿼리를 작성하세요
 (생년을 기준으로 하나 여기서는 입사년도를 기준으로 한다);

 SELECT empno, ename,
        CASE
            WHEN MOD(TO_CHAR(SYSDATE, 'YY'), 2) = 0 AND MOD(TO_CHAR(hiredate, 'YY'), 2) = 0 THEN '건강검진 대상자' 
            WHEN MOD(TO_CHAR(SYSDATE, 'YY'), 2) = 1 AND MOD(TO_CHAR(hiredate, 'YY'), 2) = 0 THEN '건강검진 비대상자'
            WHEN MOD(TO_CHAR(SYSDATE, 'YY'), 2) = 0 AND MOD(TO_CHAR(hiredate, 'YY'), 2) = 1 THEN '건강검진 비대상자'
            WHEN MOD(TO_CHAR(SYSDATE, 'YY'), 2) = 1 AND MOD(TO_CHAR(hiredate, 'YY'), 2) = 1 THEN '건강검진 대상자'
        END contact_to_doctor
 FROM emp;
 
 users 테이블을 이용하여 reg_dt에 따라 올해 건강보험 검진 대상자인지 조회하는 쿼리를 작성하세요.
 (생년을 기준으로 하나 여기서는 reg_dt를 기준으로 한다);
 
 SELECT userid, usernm, alias, reg_dt,
        CASE
            WHEN MOD(TO_CHAR(SYSDATE, 'YY'), 2) = 0 AND MOD(TO_CHAR(reg_dt, 'YY'), 2) = 0 THEN '건강검진 대상자' 
            WHEN MOD(TO_CHAR(SYSDATE, 'YY'), 2) = 1 AND MOD(TO_CHAR(reg_dt, 'YY'), 2) = 0 THEN '건강검진 비대상자'
            WHEN MOD(TO_CHAR(SYSDATE, 'YY'), 2) = 0 AND MOD(TO_CHAR(reg_dt, 'YY'), 2) = 1 THEN '건강검진 비대상자'
            WHEN MOD(TO_CHAR(SYSDATE, 'YY'), 2) = 1 AND MOD(TO_CHAR(reg_dt, 'YY'), 2) = 1 THEN '건강검진 대상자'
            WHEN reg_dt IS NULL THEN '건강검진 비대상자'
        END contact_to_doctor
 FROM users;