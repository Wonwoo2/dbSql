SELECT *    -- 모든 컬럼정보를 조회
FROM prod;  -- 데이터를 조회할 테이블 기술
            -- 키워드는 대문자, 나머지는 소문자(룰)

-- 특정 컬럼에 대해서만 조회 : SELECT 컬럼1, 컬럼2, .....

SELECT prod_id, prod_name
FROM prod; -- prod_id, prod_name컬럼만 prod 테이블에서 조회

SELECT * 
FROM lprod; -- lprod 테이블에서 모든 데이터를 조회하는 쿼리

SELECT buyer_id, buyer_name
FROM buyer; -- buyer 테이블에서 buyer_id, buyer_name 컬럼만 조회하는 쿼리

SELECT *
FROM cart; -- cart 테이블에서 모든 데이터를 조회하는 쿼리

SELECT mem_id, mem_pass, mem_name
FROM member; -- member 테이블에서 mem_id, mem_pass, mem_name 컬럼만 조회하는 쿼리

    SQL 연산 : JAVA와 다르게 대입 연산자가 없고, 일반적인 사칙연산을 따른다.
    int b = 2; = 대입 연산자, == 비교;
    SQL 데이터 타입 : 문자, 숫자, 날짜(data);

-- USERS 테이블이 존재
SELECT *
FROM USERS; -- USERS 테이블의 모든 데이터를 조회;

    날짜 타입에 대한 연산 : 날짜는 +, - 연산 가능
    date type + 정수 : date에서 정수 날짜만큼 미래 날짜로 이동
    data type - 정수 : data에서 정수 날짜만큼 과거 날짜로 이동

SELECT userid, reg_dt, reg_dt + 5, reg_dt - 5
FROM users; -- SELECT문은 원본 데이터에 영향을 주지 않는다.

    컬럼 별칭 : 기존 컬럼명을 변경 하고 싶을 때
    syntax : 기존 컬럼명 [as] 별칭명
    별칭 명에 공백이 표현되어야 할 경우 더블 쿼테이션으로 묶는다.
    또한 오라클에서는 객체명을 대문자 처리 하기 때문에 소문자로 별칭을 지정하기 위해서도 더블쿼테이션을 사용한다.

SELECT userid as id, userid id2, userid 아이디, userid "아 이 디"
FROM users;

SELECT prod_id as id, prod_name as name
FROM prod; -- prod 테이블에서 prod_id, prod_name 두 컬럼을 조회하는 쿼리(단, prod_id -> id, prod_name -> name 으로 컬럼 별칭 지정)

SELECT lprod_gu as gu, lprod_nm as nm
FROM lprod; -- lprod 테이블에서 lprod_gu, lprod_nm 두 컬럼을 조회하는 쿼리(단, lprod_gu -> gu, lprod_nm -> nm 으로 컬럼 별칭 지정)

SELECT buyer_id as 바이어아이디, buyer_name as 이름
FROM buyer; -- buyer 테이블에서 buter_id, buter_name 두 컬럼을 조회하는 쿼리(단, buyer_id -> 바이어아이디, buyer_name -> 이름 으로 컬럼 별칭 지정)

    문자열 연산(결합연산) : || (결합연산자는 +가 아니다.)
    
    ※자바의 경우 => string str = "hello";
                str = str + ", worrld"; // str : hello, world

SELECT /*userid + 'test'*/ userid || 'test'  as concat, reg_dt + 5
FROM users;

예시
SELECT '경 ' || userid || ' 축'
FROM users;

SELECT userid, usernm, userid || usernm
FROM users;

SELECT userid || usernm as id_name,
        CONCAT(userid, usernm) as concat_id_name
FROM users;

user_tables : oracle에서 관리하는 테이블 정보를 담고 있는 테이블(view) ==> data dictionary;

SELECT table_name
FROM user_tables; -- 현재 접속한 사용자가 소유한 테이블 목록을 조회

SELECT 'SELECT * FROM ' || table_name || ';' as query
FROM user_tables; -- 문자열 결합을 이용

SELECT CONCAT('SELECT * FROM ', table_name) || ';' as query
FROM user_tables;

테이블의 구성 컬럼을 확인
1. tool을 통해 확인
    테이블 - 확인하고자 하는 테이블
2. SELECT *
    FROM 테이블
    일단 전체 조회 --> 모든 컬럼이 표시
3. DESC 테이블명
4. data dictionary : user_tab_columns

DESC emp;

SELECT * 
FROM user_tab_columns;

지금까지 배운 SELECT 구문
조회하고자 하는 컬럼 기술 : SELECT
조회할 테이블 기술 : FROM
조회할 행을 제한하는 조건을 기술 : WHERE
WHERE 절에 기술한 조건이 참(TRUE)일 때 결과를 조회

JAVA의 비교 연산 : a변수와 b변수의 값이 같은지 비교
int a = 5;
int b = 2;
a랑 b의 값이 같을 때만 특정로직 실행 
if( a == b ) {

}

sql의 비교 연산 : =

SELECT * 
FROM users
WHERE userid = 'cony';

SELECT * 
FROM users
WHERE 1 = 1;

emp테이블의 컬럼과 데이터 타입을 확인

DESC emp;

SELECT *
FROM emp;
    emp : employee 직원 테이블
    empno : 사원번호
    ename : 사원 이름
    job : 담당업무(직책)
    mgr : 담당자(관리자)
    hiredate : 입사일자
    sal : 급여
    comm : 성과급
    deptno : 부서번호
    
SELECT * 
FROM dept;

emp 테이블에서 직원이 속한 부서번호가 30번 보다 큰 부서에 속한 직원을 조회

SELECT *
FROM emp
WHERE deptno >= 30;

!= 다를 때
users 테이블에서  사용자 아이디가 (userid)가 brown이 아닌 사용자를 조회

SELECT *
FROM users
WHERE userid != 'brown';


SQL 리터럴
    숫자 : ....20, 30, 40
    문자 : 싱글 쿼테이션(' ')
    날짜 : TO_DATA('날짜문자열', '날짜 문자열의 형식');

SELECT *
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'YYYYMMDD'); -- 1982년 1월 1일 이후에 입사한 직원만 조회, 직원의 입사일자 : hiredate 컬럼

emp 테이블의 직원 : 14명
1982년 1월 1일 이후 입사자 : 3명
1982년 1월 1일 이전 입사자 : 11명