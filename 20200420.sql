table���� ��ȸ/���� ������ ����
==> ORDER BY �÷��� ���Ĺ��, .....

����*
ORDER BY �÷����� ��ȣ �� ���� ����
==> SELECT �÷��� ������ �ٲ�ų�, �÷� �߰��� �Ǹ� ���� �ǵ���� �������� ���� ���ɼ��� ����

SELECT�� 3��° �÷��� �������� ����

SELECT * FROM emp
ORDER BY 3;

��Ī���� ����
�÷����ٰ� ������ ���� ���ο� �÷��� ����� ���
SAL*DEPTNO, SAL_DEPT
SELECT empno, ename, sal, deptno, sal*deptno sal_dept
FROM emp
ORDER BY sal_dept;

dept ���̺��� ��� ������ �μ��̸����� �������� ���ķ� ��ȸ�ǵ��� ������ �ۼ��ϼ���

SELECT *
FROM dept
ORDER BY dname ASC;

dept ���̺��� ��� ������ �μ���ġ�� �������� ���ķ� ��ȸ�ǵ��� ������ �ۼ��ϼ���

SELECT *
FROM dept
ORDER BY loc DESC;

emp ���̺��� ��(comm) ������ �ִ� ����鸸 ��ȸ�ϰ�, ��(comm)�� ���� �޴� ����� ����
��ȸ�ǵ��� �ϰ�, �󿩰� ���� ��� ������� �������� �����ϼ���(�󿩰� 0�� ����� �󿩰� ����
������ ����)

SELECT *
FROM emp
WHERE comm > 0
ORDER BY comm DESC, empno ASC;

emp ���̺��� �����ڰ� �ִ� ����鸸 ��ȸ�ϰ�, ����(job) ������ �������� �����ϰ�, ������
���� ��� ����� ū ����� ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���

SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno DESC;

SELECT *
FROM emp
WHERE mgr !=0
ORDER BY job, empno DESC;

emp ���̺��� 10�� �μ�(deptno) Ȥ�� 30�� �μ��� ���ϴ� ��� ��
�޿�(sal)�� 1500�� �Ѵ� ����鸸 ��ȸ�ϰ� �̸����� �������� ���ĵǵ���
������ �ۼ��ϼ���

SELECT *
FROM emp
WHERE (deptno = 10
OR deptno = 30)
AND sal > 1500
ORDER BY ename DESC;

����¡ ó���� �ϴ� ����
 - �����Ͱ� �ʹ� ���� ������
 - �� ȭ�鿡 ������ ��뼺�� ��������
 - ���ɸ鿡�� ��������

����Ŭ���� ����¡ ó�� ��� ==> ROWNUM

ROWNUM : SELECT ������� 1������ ���ʴ�� ��ȣ�� �ο����ִ� Ư�� KEWORD

SELECT ROWNUM, empno, ename
FROM emp;

SELECT���� * ǥ���ϰ� �޸��� ����
�ٸ� ǥ��(ex ROWNUM)�� ����� ���
* �տ� � ���̺� ���Ѱ��� ���̺� ��Ī/��Ī�� ����ؾ� �Ѵ�

SELECT ROWNUM, e.*
FROM emp e;

����¡ ó���� ���� �ʿ��� ����
 - ������ ������(10)
 - ������ ���� ����

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

ROWNUM�� Ư¡
1. ORACLE���� ����
    - �ٸ� DBMS�� ��� ����¡ ó���� ���� ������ Ű���尡 ���� (LIMIT)
2. 1������ ���������� �д°�츸 ����
    - ROWNUM BETWEEN 1 AND 10 ==> 1 ~ 10
    - ROWNUM BETWEEN 11 AND 20 ==> 1 ~ 10�� SKIP�ϰ� 11 ~ 20�� �������� �õ�
    
WHERE ������ ROWNUM�� ����� ��� ���� ����
    ROWNUM = 1;
    ROWNUM BETWEEN 1 AND N;
    ROWNUM <, <= N (1 ~ N)
    
SELECT ROWNUM, empno, ename
FROM emp
ORDER BY empno;

SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename;

ROWNUM�� ORDER BY ������ ����
SELECT -> ROWNUM -> ORDER BY

ROWNUM�� ��������� ���� ������ �Ȼ��·� ROWNUM�� �ο��Ϸ��� IN-LINE VIEW�� ����ؾ� �Ѵ�
** IN-LINE : ���� ����� �ߴٶ�� ���� ����;

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

INLINE-VIEW�� �񱳸� ���� VIEW�� ���� ����(�����н�, ���߿� ����)
VIEW - ���� (view ���̺�-x) ��� ��ü�� ����

DML - Data Manipulantion Language : SELECT, INSERT, UPDATE, DELETE
DDL - Data Definition Language : CREATE, DROP, MODIFY, RENAME

CREATE OR REPLACE VIEW emp_ord_by_ename AS
    SELECT empno, ename
    FROM emp
    ORDER BY ename;
    
IN-LINE VIEW�� �ۼ��� ����
SELECT *
FROM (SELECT empno, ename
    FROM emp
    ORDER BY ename);

view�� �ۼ��� ����
SELECT *
FROM emp_ord_by_ename;

emp ���̺� �����͸� �߰��ϸ�
in-line view, view�� ����� ������ ����� ��� ������ ������?

INSERT INTO emp (empno, ename) VALUES(9999, '����');
SELECT empno, ename
FROM emp;

���� �ۼ��� ������ ã�ư���
java : �����
SQL : ����� ���� ����(������ ���� ������)

����¡ ó�� ==> ����, ROWNUM
����, ROWNUM�� �ϳ��� �������� ������ ��� ROWNUM���� ������ �Ͽ����ڰ� ���̴� ���� �߻�
==> INLINE-VIEW
    ���Ŀ� ���� LINE-VIEW
    ROWNUM�� ���� INLINE-VIEW

SELECT *
FROM
(SELECT ROWNUM rn, a.* 
FROM 
(SELECT empno, ename
FROM emp
ORDER BY ename) a) a
WHERE rn BETWEEN 1 AND 10;

==> �ȿ� �ִ� ������ ������ ���ϰ� ������ �ٱ��κ��� ������ ����
emp ���̺��� ��� ������ �̸��÷����� �������� ���� ���� ���� 11 ~ 14��° ���� ������ ���� ��ȸ�ϴ� ������ �ۼ��ϼ���

SELECT *
FROM
(SELECT ROWNUM rn, a.* 
FROM 
(SELECT empno, ename
FROM emp
ORDER BY ename) a) a
WHERE rn BETWEEN 11 AND 14;

PROD ���̺��� PROD_LGU (��������), PROD_COST(���� ����)���� �����Ͽ� ����¡ ó�� ������ �ۼ��ϼ���
�� ������ ������� 5
���ε� ���� ����� ��

SELECT *
FROM
(SELECT ROWNUM rn, a.*
FROM
(SELECT *
FROM prod
ORDER BY prod_lgu DESC, prod_cost ASC) a) a
WHERE RN BETWEEN (:page-1)* :pageSize + 1 AND :page * :pageSize;