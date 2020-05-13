CREATE TABLE dept_test2 AS
SELECT *
FROM dept
WHERE 1 = 1;

▶ 위 구문으로 dept_test2 테이블 생성 후 다음 조건에 맞는 인덱스를 생성

CREATE UNIQUE INDEX idx_unique_deptno
ON dept_test2 (deptno);

CREATE INDEX idx_nonunique_dname
ON dept_test2 (dname);

CREATE INDEX idx_nonunique_deptno_dname
ON dept_test2 (deptno, dname);

▶ 생성한 인덱스를 삭제
DROP INDEX idx_unique_deptno;

DROP INDEX idx_nonunique_dname;

DROP INDEX idx_nonunique_deptno_dname;

▶ 시스템에서 사용하는 쿼리가 다음과 같다고 할 때 적절한 emp 테이블에 필요하다고 생각되는 인덱스를
생성 스크립트를 만들어보세요

1] empno (=) 1 Unique

2] ename (=) 1 nonUnique

3] deptno (=) 3 empno(LIKE : emp || '%') nonUnique

4] deptno (=) sal(BETWEEN :sal AND :sal) nonUnique 5

5] deptno (=) mgr (=)empno (=)

6] deptno, hiredate 4

SELECT deptno, TO_CHAR(hiredate, 'yyyymm')
FROM emp
GROUP BY deptno, TO_CHAR(hiredate, 'yyyymm');

SELECT deptno
FROM emp
GROUP BY deptno;

SELECT TO_CHAR(hiredate, 'yyyymm')
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyymm');

SELECT *
FROM emp;

CREATE TABLE emp_test2 AS
SELECT *
FROM emp
WHERE 1 = 1;

CREATE INDEX idx_emp_01 ON (empno);
CREATE INDEX idx_emp_02 ON (ename);
CREATE INDEX idx_emp_03 ON (deptno, mgr, empno);
CREATE INDEX idx_emp_04 ON (deptno, sal);
CREATE INDEX idx_emp_05 ON (hiredate, deptno);

☆과제 실습4

실행 계획

수업시간에 배운 조인
==> 논리적인 조인 형태, 기술적인것 아님
INNER JOIN : 조인에 성공하는 데이터만 조회하는 기법
OUTER JOIN : 조인에 실패해도 기준이 되는 테이블의 컬럼정보는 조회하는 기법
CROSS JOIN : 묻지마 조인(카티션 프로덕트), 조인 조건을 기술하지 않아서
             연결 가능한 모든 경우의 수로 조인되는 조인 기법
SELF JOIN : 같은 테이블끼리 조인 하는 형태

개발자가 DBMS에 SQL을 실행 요청하면 DBMS는 SQL을 분석해서 어떻게 두 테이블을 연결할 지를 결정
3가지 방식의 조인 방식(물리적 조인 방식, 기술적인 것)

1. Nested Loop Join
2. Sort Merge Join
3. Hash Join

Nested Loop Join
- 이중 루프와 유사
- 선행 테이블(Outer table)
- 후행 테이블(Inner table)
- 소량의 데이터를 조인할 때 유리
- 가장 일반적으로 사용한다
- 

OLTP (OnLine Transaction Processing) : 실시간 처리 ==> 응답이 빨라야 하는 시스템(일반적인 웹 서비스)
OAP (OnLine Analysis Processing) : 일괄처리 ==> 전체 처리 속도가 중요한 경우(은행 이자 계산)

Sort Merge Join
- 조인 컬럼에 인덱스가 없을 경우
- 대량의 데이터를 조인하는 경우
- 조인되는 테이블을 각각 정렬(sort)
- 정렬되어 있으므로 조인 조건에 해당하는 데이터를 찾기가 유리
- 조인조건에 해당하는 데이터를 연결(merge)
- 정렬이 끝나야 연결이 가능하므로 응답이 느림
- 많이 사용되지 않음 ==> Hash Join으로 대체
- 테이블 조건이 =이 아니어도 가능

Hash Join
- 조인 컬럼에 인덱스가 없을 경우
- 조인 테이블의 건수가 한쪽이 많고 한쪽이 적은 경우
- 연결 조건이 =인 경우
- 조인하려는 테이블 한쪽이 작을 경우 유리하다(해시 테이블을 빨리 만들 수 있기 때문)
- 연결고리 컬럼의 값을 해시함수를 이용하여 연결
- = 조건이 아닌 조인 조건에 대해서는 사용 불가

Index를 활용하지 못하는 경우
- 컬럼가공 : Idex는 WHERE 조건에 좌변을 가공하기전의 값으로 접근하기 때문에
- 부정형 연산
- NULL 비교
- LIKE 연산시 선행 와일드 카드