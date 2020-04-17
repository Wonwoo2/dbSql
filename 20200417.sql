SELECT 에서 연산 :
    날짜 연산(+, -) : 날짜 +정수, -정수 => 날짜에서 +-정수를 한 과거 혹은 미래일자의 데이트 타입 반환
    정수 연산
    문자열 연산
        리터럴 : 표기방법
                숫자 리터럴 : 숫자로 표현
                문자 리터럴 : java : "문자열" / sql : 'sql'
                            SELECT SELECT * FROM || table_name => 잘못표기
                            SELECT 'SELECT * FROM ' || table_name
                        문자열 결합연산은 +가 아니라 ||(java : +)
                날짜 ??   : TO_DATE('날짜문자열', '날짜 문자열에 대한 포멧')
                            TO_DATE('20200417', 'yyyymmdd')
                            
WHERE : 기술한 조건에 만족하는 행만 조회 되도록 제한;

SELECT *
FROM users
WHERE userid = 'brown';

sal값이 1000보다 크거나 같고, 2000보다 작거나 같은 직원만 조회 ==> BETWEEN AND;
비교대상 컬럼 / 값 BETWEEN 시작값 AND 종료값
시작값과 종료값의 위치를 바꾸면 정상 동작하지 않음

sql --> sal >= 1000 AND sal <= 2000

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

exclusive or (배타적 or)
a or b a = true, b = true ==> true
a exclusive or b a = true, b = true ==> false

SELECT *
FROM emp
WHERE sal >= 1000
  AND sal <= 2000;

emp 테이블에서 입사 일자가 1992년 1월 1일 이후부터 1983년 1월 1일 이전인 사원의 ename, hiredate 데이터를 조회하는 쿼리를 작성하시오
단 연산자는 between을 사용한다.

SELECT ename, hiredate
FROM emp
WHERE hiredate 
BETWEEN TO_DATE('19820101', 'YYYYMMDD')
AND TO_DATE('19830101', 'YYYYMMDD');

SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'YYYYMMDD')
AND hiredate <= TO_DATE('19830101', 'YYYYMMDD');

IN 연산자
컬럼|특정값 IN (값1, 값2, ....)
컬럼이나 특정값이 괄호 안의 값중에 하나라도 일치를 하면 TRUE

SELECT *
FROM emp
WHERE deptno IN (10, 30);
==> deptno가 10이거나 30번인 직원
deptno = 10 OR deptno = 30

SELECT *
FROM emp
WHERE deptno = 10
   OR deptno = 30;
   
users 테이블에서 userid가 brown, cony, sally인 테이터를 다음과 같이 조회하시오(IN 연산자 사용) => 아이디 이름 별명
SELECT userid as 아이디, usernm as 이름, alias as 별명
FROM users
WHERE userid IN ('brown', 'cony', 'sally');

문자열 매칭 연산 : LIKE / JAVA : .startsWith(prefix), .endsWith(suffix)
컬럼|특정값 LIKE 패턴 문자열
마스킹 문자열 : % - 모든 문자열(공백 포함)
              _ - 어떤 문자열이든지 딱 하나의 문자
문자열의 일부가 맞으면 TRUE

'cony' : cony인 문자열
'co%' : 문자열이 co로 시작하고 뒤에는 어떤 문자열이든 올 수 있는 문자열
    => 'cony', 'con', 'co' 모두 만족함

'%co%' : co를 포함하는 문자열
    => 'cony', 'sally cony' 모두 만족함
    
'co_ _' : co로 시작하고 뒤에 두 개의 문자가 오는 문자열

'_co_' : 가운데 두 글자가 co이고 앞뒤로 어떤 문자열이든지 하나의 문자가 올 수 있는 문자열

직원 이름(ename)이 대문자 S로 시작하는 직원만 조회

SELECT *
FROM emp
WHERE ename LIKE 'S%';

member 테이블에서 회원의 성이 [신]씨인 사람의 mem_id, mem_name을 조회하는 쿼리를 작성하시오(mem_id, mem_name)
SELECT *
FROM member;

SELECT mem_id, mem_name
FROM member
where mem_name LIKE '신%';

member 테이블에서 회원의 이름에 글자[이]가 들어가는 모든 사람의 mem_id, mem_name을 조회하는 쿼리를 작성하시오(mem_id, mem_name)
SELECT mem_id, mem_name
FROM member
where mem_name LIKE '이%';

NULL 비교
SQL 비교 연산자 :
    WHERE usernm = 'brown'

MGR컬럼 값이 없는 모든 직원을 조회    
SELECT *
FROM emp
WHERE mgr = null;

SQL에서 NULL 값을 비교할 경우 일반적인 비교연산자 (=)를 사용하지 못한다.
IS 연산자를 사용한다.

MGR컬럼 값이 없는 모든 직원을 조회    
SELECT *
FROM emp
WHERE mgr IS NULL;

값이 있는 상황에서 등가 비교 : =, !=, <>
NULL : IS NULL, IS NOT NULL

emp 테이블에서 mgr 컬럼 값이 NULL이 아닌 직원을 조회
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

emp 테이블에서 상여(comm)가 있는 회원의 정보를 다음과 같이 조회되도록 쿼리를 작성하시오

empno, ename, job, mgr, hiredate, sal, comm, deptno
SELECT *
FROM emp
WHERE comm IS NOT NULL;


SELECT *
FROM emp
WHERE mgr = 7698
    AND sal > 1000;
    
SELECT *
FROM emp
WHERE mgr = 7698
    OR sal > 1000;

SELECT *
FROM emp
WHERE mgr IN (7698, 7839);
    
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839);

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839, NULL);

IN연산자를 비교 연산자로 변경
SELECT *
FROM emp
WHERE mgr IN (7698, 7839);
==> WHERE mgr = 7698 OR mgr = 7839

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839);
==> WHERE (mgr != 7698 AND mgr != 7839)

emp 테이블에서 job이 SALESMAN 이고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요
empno , ename, job, mgr, hiredate, sal, comm, deptno

SELECT *
FROM emp
WHERE job = 'SALESMAN' 
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT *
FROM emp
WHERE job IN 'SALESMAN' 
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT *
FROM emp
WHERE job IN 'SALESMAN' 
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD')
AND sal > 1300;

※키워드에 한해서는 대소문자 구분을 하지 않지만 데이터 문자열은 대소문자 구분을 한다.

emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요
(IN, NOT IN 연산자 사용금지)
empno, ename, job, mgr, hiredate, sal, comm, deptno;

SELECT *
FROM emp
WHERE deptno != 10
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

NOT IN 연산자 사용
SELECT *
FROM emp
WHERE deptno NOT IN ( 10 )
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요
(부서는 10, 20, 30만 있다고 가정하고 IN 연산자를 사용)
empno, ename, job, mgr, hiredate, sal, comm, deptno;

SELECT *
FROM emp
WHERE deptno NOT IN (10)
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT *
FROM emp
WHERE deptno IN (20, 30)
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

emp 테이블에서 job이 SALESMAN이거나 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요
empno, ename, job, mgr, hiredate, sal, comm, deptno;

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT *
FROM emp
WHERE job IN ('SALESMAN')
OR hiredate >= TO_DATE('19810601', 'YYYYMMDD');

emp 테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하는 직원의 정보를 다음과 같이 조회하세요
empno, ename, job, mgr, hiredate, sal, comm, deptno

SELECT *
FROM emp
WHERE job IN ('SALESMAN')
OR empno LIKE '78%';

emp 테이블에서 job이 SALESMAN이거나 78로 시작하는 직원의 정보를 다음과 같이 조회하세요
(LIKE 연산자 사용금지)
empno, ename, job, mgr, hiredate, sal, comm, deptno;

SELECT *
FROM emp
WHERE job IN ('SALESMAN')
OR (empno >= 7800 and empno < 7900);

SELECT *
FROM emp
WHERE job = ('SALESMAN')
OR (empno >= 7800 and empno < 7900);

emp 테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하면서 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요
empno, ename, job, mgr, hiredate, sal, comm, deptno;

SELECT *
FROM emp
WHERE job IN ('SALESMAN')
OR empno LIKE '78%' 
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT *
FROM emp
WHERE job = ('SALESMAN')
OR (empno >= 7800 AND empno < 7900)
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');


집합 : {a, b, c} == {a, c, b}
순서가 없다.
RDBMS - 관계형 데이터베이스(집합과 마찬가지로 순서가 없다.)
table에는 조회, 저장시 순서가 없다.(보장하지 않음) (집합과 유사한 개념)

SQL 에서는 데이터를 정렬하려면 별도의 구문이 필요하다
※ ORDER BY
ORDER BY 컬럼명 [정렬형태], 컬럼명2 [정렬형태]
정렬형태를 명시하지 않을시 기본적으로 오름차순으로 정렬

정렬의 형태 : 오름차순(DEFAULT) - ASC, 내림차순 - DESC

직원 이름으로 오름차순정렬
SELECT *
FROM emp
ORDER BY ename;

직원 이름으로 내림차순정렬
SELECT *
FROM emp
ORDER BY ename DESC;

job을 기준으로 오름 차순정렬하고 job이 같을경우 입사일자로 내림차순 정렬
모든 데이터 조회

SELECT *
FROM emp
ORDER BY job ASC, hiredate DESC;

