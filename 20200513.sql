CREATE TABLE dept_test2 AS
SELECT *
FROM dept
WHERE 1 = 1;

�� �� �������� dept_test2 ���̺� ���� �� ���� ���ǿ� �´� �ε����� ����

CREATE UNIQUE INDEX idx_unique_deptno
ON dept_test2 (deptno);

CREATE INDEX idx_nonunique_dname
ON dept_test2 (dname);

CREATE INDEX idx_nonunique_deptno_dname
ON dept_test2 (deptno, dname);

�� ������ �ε����� ����
DROP INDEX idx_unique_deptno;

DROP INDEX idx_nonunique_dname;

DROP INDEX idx_nonunique_deptno_dname;

�� �ý��ۿ��� ����ϴ� ������ ������ ���ٰ� �� �� ������ emp ���̺� �ʿ��ϴٰ� �����Ǵ� �ε�����
���� ��ũ��Ʈ�� ��������

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

�ٰ��� �ǽ�4

���� ��ȹ

�����ð��� ��� ����
==> ������ ���� ����, ������ΰ� �ƴ�
INNER JOIN : ���ο� �����ϴ� �����͸� ��ȸ�ϴ� ���
OUTER JOIN : ���ο� �����ص� ������ �Ǵ� ���̺��� �÷������� ��ȸ�ϴ� ���
CROSS JOIN : ������ ����(īƼ�� ���δ�Ʈ), ���� ������ ������� �ʾƼ�
             ���� ������ ��� ����� ���� ���εǴ� ���� ���
SELF JOIN : ���� ���̺��� ���� �ϴ� ����

�����ڰ� DBMS�� SQL�� ���� ��û�ϸ� DBMS�� SQL�� �м��ؼ� ��� �� ���̺��� ������ ���� ����
3���� ����� ���� ���(������ ���� ���, ������� ��)

1. Nested Loop Join
2. Sort Merge Join
3. Hash Join

Nested Loop Join
- ���� ������ ����
- ���� ���̺�(Outer table)
- ���� ���̺�(Inner table)
- �ҷ��� �����͸� ������ �� ����
- ���� �Ϲ������� ����Ѵ�
- 

OLTP (OnLine Transaction Processing) : �ǽð� ó�� ==> ������ ����� �ϴ� �ý���(�Ϲ����� �� ����)
OAP (OnLine Analysis Processing) : �ϰ�ó�� ==> ��ü ó�� �ӵ��� �߿��� ���(���� ���� ���)

Sort Merge Join
- ���� �÷��� �ε����� ���� ���
- �뷮�� �����͸� �����ϴ� ���
- ���εǴ� ���̺��� ���� ����(sort)
- ���ĵǾ� �����Ƿ� ���� ���ǿ� �ش��ϴ� �����͸� ã�Ⱑ ����
- �������ǿ� �ش��ϴ� �����͸� ����(merge)
- ������ ������ ������ �����ϹǷ� ������ ����
- ���� ������ ���� ==> Hash Join���� ��ü
- ���̺� ������ =�� �ƴϾ ����

Hash Join
- ���� �÷��� �ε����� ���� ���
- ���� ���̺��� �Ǽ��� ������ ���� ������ ���� ���
- ���� ������ =�� ���
- �����Ϸ��� ���̺� ������ ���� ��� �����ϴ�(�ؽ� ���̺��� ���� ���� �� �ֱ� ����)
- ����� �÷��� ���� �ؽ��Լ��� �̿��Ͽ� ����
- = ������ �ƴ� ���� ���ǿ� ���ؼ��� ��� �Ұ�

Index�� Ȱ������ ���ϴ� ���
- �÷����� : Idex�� WHERE ���ǿ� �º��� �����ϱ����� ������ �����ϱ� ������
- ������ ����
- NULL ��
- LIKE ����� ���� ���ϵ� ī��