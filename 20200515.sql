ROLLUP : ����׷� ���� - ����� �÷��� �����ʿ������� ���������� GROUP BY�� ����

�Ʒ� ������ ����׷�
1. GROUP BY job, deptno
2. GROUP BY job
3. GROUP BY ==> ��ü

ROULLUP ��� �� �����Ǵ� ���� �׷��� ���� : ROLLUP�� ����� �÷��� + 1

SELECT DECODE(GROUPING(job), 1, '�Ѱ�', 0, job) job, deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT DECODE(GROUPING(job), 1, '��', 0, job) job,
        DECODE(GROUPING(deptno), 1, DECODE(GROUPING(job), 1, '��', 0, '�Ұ�'), 0, deptno) deptno
        , SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT 
    CASE
        WHEN GROUPING(job) = 1 THEN '��'
        ELSE job
        END job,
    CASE
        WHEN GROUPING(job) = 1 AND GROUPING(deptno) = 1 THEN '��'
        WHEN GROUPING(deptno) = 1 THEN '�Ұ�'
        ELSE TO_CHAR(deptno)
        END deptno,
    SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

ROLLUP ���� ��� �Ǵ� �÷��� ������ ��ȸ ����� ������ ��ģ��
        ==> ���� �׷��� ����� �÷��� ������ ���� 

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

SELECT DECODE(dname, NULL, '����', dname) dname, job, SUM(sal) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dname, job);

2. GROUPING SETS
ROLLUP�� ���� : ���� ���� ����׷쵵 ���� �ؾ��Ѵ�
               ROLLUP���� ����� �÷��� �����ʿ��� ���������� ������
               ���� �߰������� �ִ� ����׷��� ���ʿ� �� ��� ����
               
GROUPING SETS : �����ڰ� ���� ������ ����׷��� ���
                ROLLUP���� �ٸ��� ���⼺�� ����
���� : GROUP BY GROUPING SETS (�÷�1, �÷�2..) ,�� ����׷��� ����
GROUP BY GROUPING SETS (�÷�1, �÷�2)
GROUP BY �÷�1
UNION ALL
GROUP BY �÷�2

GROUP BY GROUPING SETS (�÷�2, �÷�1)
GROUP BY �÷�2
UNION ALL
GROUP BY �÷�1

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno);

�׷������
    - job, deptno
    - mgr

SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY GROUPING SETS((job, deptno), mgr);

REPORT GROUP FUNCTION ==> Ȯ��� GROUP BY
REPORT GROUP FUNCTION�� ��� ���ϸ� ���� ���� SQL�ۼ�, UNION ALL�� ���ؼ� �ϳ��� ����� ��ġ�� ����

3. CUBE
���� : GROUP BY CUBE (�÷�1, �÷�2..)
����� �÷��� ������ ��� ���� (������ ��Ų��)

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
    
�������� REPORT GROUP ����ϱ�
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

��ȣ ���� �������� ������Ʈ
1. emp���̺��� �̿��Ͽ� emp_test ���̺� ����
2. emp_test ���̺� dname�÷� �߰�(dept ���̺� ����)
3. subquery�� �̿��Ͽ� emp_test ���̺� �߰��� dname �÷��� ������Ʈ ���ִ� ����

1.
CREATE TABLE emp_test AS
SELECT * 
FROM emp;

2.
DESC dept;

ALTER TABLE emp_test ADD (dname VARCHAR(14));

DESC emp_test;

3.
emp_test�� dname�÷��� ���� dept ���̺��� dname �÷����� ������Ʈ
emp_test���̺��� deptno���� Ȯ���ؼ� dept���̺��� deptno���̶� ��ġ�ϴ� dname �÷����� ������ update

update ����� �Ǵ� �� : 14 ==> WHERE ���� ������� ����
��� ������ ������� dname �÷��� dept ���̺��� ��ȸ�Ͽ� ������Ʈ
UPDATE emp_test e SET dname = (SELECT dname
                                FROM dept
                                WHERE e.deptno = dept.deptno);

SELECT *
FROM emp_test;

1. dept ���̺��� �̿��Ͽ� dept_test ���̺� ����

2. dept_test ���̺� empcnt (NUMBER) �÷� �߰�

3. subquery�� �̿��Ͽ� dept_test ���̺��� empcnt �÷��� �ش� �μ���
   ���� update�ϴ� ����
   
DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD (empcnt NUMBER(10, 0));
UPDATE dept_test d SET empcnt = (SELECT COUNT(*)
                                FROM emp_test e
                                WHERE e.deptno = d.deptno);
                                
SELECT ��� ��ü�� ������� �׷� �Լ��� ������ ���
���Ǵ� ���� ������ 0���� ����

SELECT COUNT(*)
FROM emp
WHERE 1 = 2;

GROUP BY ���� ����� ��� ����� �Ǵ� ���� ������� ��ȸ�Ǵ� ���� ����
SELECT COUNT(*)
FROM emp
WHERE 1 = 2
GROUP BY deptno;
                                
SELECT *
FROM dept_test;