SELECT ���� ���� :
    ��¥ ����(+, -) : ��¥ +����, -���� => ��¥���� +-������ �� ���� Ȥ�� �̷������� ����Ʈ Ÿ�� ��ȯ
    ���� ����
    ���ڿ� ����
        ���ͷ� : ǥ����
                ���� ���ͷ� : ���ڷ� ǥ��
                ���� ���ͷ� : java : "���ڿ�" / sql : 'sql'
                            SELECT SELECT * FROM || table_name => �߸�ǥ��
                            SELECT 'SELECT * FROM ' || table_name
                        ���ڿ� ���տ����� +�� �ƴ϶� ||(java : +)
                ��¥ ??   : TO_DATE('��¥���ڿ�', '��¥ ���ڿ��� ���� ����')
                            TO_DATE('20200417', 'yyyymmdd')
                            
WHERE : ����� ���ǿ� �����ϴ� �ุ ��ȸ �ǵ��� ����;

SELECT *
FROM users
WHERE userid = 'brown';

sal���� 1000���� ũ�ų� ����, 2000���� �۰ų� ���� ������ ��ȸ ==> BETWEEN AND;
�񱳴�� �÷� / �� BETWEEN ���۰� AND ���ᰪ
���۰��� ���ᰪ�� ��ġ�� �ٲٸ� ���� �������� ����

sql --> sal >= 1000 AND sal <= 2000

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

exclusive or (��Ÿ�� or)
a or b a = true, b = true ==> true
a exclusive or b a = true, b = true ==> false

SELECT *
FROM emp
WHERE sal >= 1000
  AND sal <= 2000;

emp ���̺��� �Ի� ���ڰ� 1992�� 1�� 1�� ���ĺ��� 1983�� 1�� 1�� ������ ����� ename, hiredate �����͸� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
�� �����ڴ� between�� ����Ѵ�.

SELECT ename, hiredate
FROM emp
WHERE hiredate 
BETWEEN TO_DATE('19820101', 'YYYYMMDD')
AND TO_DATE('19830101', 'YYYYMMDD');

SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'YYYYMMDD')
AND hiredate <= TO_DATE('19830101', 'YYYYMMDD');

IN ������
�÷�|Ư���� IN (��1, ��2, ....)
�÷��̳� Ư������ ��ȣ ���� ���߿� �ϳ��� ��ġ�� �ϸ� TRUE

SELECT *
FROM emp
WHERE deptno IN (10, 30);
==> deptno�� 10�̰ų� 30���� ����
deptno = 10 OR deptno = 30

SELECT *
FROM emp
WHERE deptno = 10
   OR deptno = 30;
   
users ���̺��� userid�� brown, cony, sally�� �����͸� ������ ���� ��ȸ�Ͻÿ�(IN ������ ���) => ���̵� �̸� ����
SELECT userid as ���̵�, usernm as �̸�, alias as ����
FROM users
WHERE userid IN ('brown', 'cony', 'sally');

���ڿ� ��Ī ���� : LIKE / JAVA : .startsWith(prefix), .endsWith(suffix)
�÷�|Ư���� LIKE ���� ���ڿ�
����ŷ ���ڿ� : % - ��� ���ڿ�(���� ����)
              _ - � ���ڿ��̵��� �� �ϳ��� ����
���ڿ��� �Ϻΰ� ������ TRUE

'cony' : cony�� ���ڿ�
'co%' : ���ڿ��� co�� �����ϰ� �ڿ��� � ���ڿ��̵� �� �� �ִ� ���ڿ�
    => 'cony', 'con', 'co' ��� ������

'%co%' : co�� �����ϴ� ���ڿ�
    => 'cony', 'sally cony' ��� ������
    
'co_ _' : co�� �����ϰ� �ڿ� �� ���� ���ڰ� ���� ���ڿ�

'_co_' : ��� �� ���ڰ� co�̰� �յڷ� � ���ڿ��̵��� �ϳ��� ���ڰ� �� �� �ִ� ���ڿ�

���� �̸�(ename)�� �빮�� S�� �����ϴ� ������ ��ȸ

SELECT *
FROM emp
WHERE ename LIKE 'S%';

member ���̺��� ȸ���� ���� [��]���� ����� mem_id, mem_name�� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�(mem_id, mem_name)
SELECT *
FROM member;

SELECT mem_id, mem_name
FROM member
where mem_name LIKE '��%';

member ���̺��� ȸ���� �̸��� ����[��]�� ���� ��� ����� mem_id, mem_name�� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�(mem_id, mem_name)
SELECT mem_id, mem_name
FROM member
where mem_name LIKE '��%';

NULL ��
SQL �� ������ :
    WHERE usernm = 'brown'

MGR�÷� ���� ���� ��� ������ ��ȸ    
SELECT *
FROM emp
WHERE mgr = null;

SQL���� NULL ���� ���� ��� �Ϲ����� �񱳿����� (=)�� ������� ���Ѵ�.
IS �����ڸ� ����Ѵ�.

MGR�÷� ���� ���� ��� ������ ��ȸ    
SELECT *
FROM emp
WHERE mgr IS NULL;

���� �ִ� ��Ȳ���� � �� : =, !=, <>
NULL : IS NULL, IS NOT NULL

emp ���̺��� mgr �÷� ���� NULL�� �ƴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

emp ���̺��� ��(comm)�� �ִ� ȸ���� ������ ������ ���� ��ȸ�ǵ��� ������ �ۼ��Ͻÿ�

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

IN�����ڸ� �� �����ڷ� ����
SELECT *
FROM emp
WHERE mgr IN (7698, 7839);
==> WHERE mgr = 7698 OR mgr = 7839

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839);
==> WHERE (mgr != 7698 AND mgr != 7839)

emp ���̺��� job�� SALESMAN �̰� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���
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

��Ű���忡 ���ؼ��� ��ҹ��� ������ ���� ������ ������ ���ڿ��� ��ҹ��� ������ �Ѵ�.

emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ �ϼ���
(IN, NOT IN ������ ������)
empno, ename, job, mgr, hiredate, sal, comm, deptno;

SELECT *
FROM emp
WHERE deptno != 10
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

NOT IN ������ ���
SELECT *
FROM emp
WHERE deptno NOT IN ( 10 )
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

emp ���̺��� �μ���ȣ�� 10���� �ƴϰ� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ�ϼ���
(�μ��� 10, 20, 30�� �ִٰ� �����ϰ� IN �����ڸ� ���)
empno, ename, job, mgr, hiredate, sal, comm, deptno;

SELECT *
FROM emp
WHERE deptno NOT IN (10)
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT *
FROM emp
WHERE deptno IN (20, 30)
AND hiredate >= TO_DATE('19810601', 'YYYYMMDD');

emp ���̺��� job�� SALESMAN�̰ų� �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ�ϼ���
empno, ename, job, mgr, hiredate, sal, comm, deptno;

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR hiredate >= TO_DATE('19810601', 'YYYYMMDD');

SELECT *
FROM emp
WHERE job IN ('SALESMAN')
OR hiredate >= TO_DATE('19810601', 'YYYYMMDD');

emp ���̺��� job�� SALESMAN�̰ų� �����ȣ�� 78�� �����ϴ� ������ ������ ������ ���� ��ȸ�ϼ���
empno, ename, job, mgr, hiredate, sal, comm, deptno

SELECT *
FROM emp
WHERE job IN ('SALESMAN')
OR empno LIKE '78%';

emp ���̺��� job�� SALESMAN�̰ų� 78�� �����ϴ� ������ ������ ������ ���� ��ȸ�ϼ���
(LIKE ������ ������)
empno, ename, job, mgr, hiredate, sal, comm, deptno;

SELECT *
FROM emp
WHERE job IN ('SALESMAN')
OR (empno >= 7800 and empno < 7900);

SELECT *
FROM emp
WHERE job = ('SALESMAN')
OR (empno >= 7800 and empno < 7900);

emp ���̺��� job�� SALESMAN�̰ų� �����ȣ�� 78�� �����ϸ鼭 �Ի����ڰ� 1981�� 6�� 1�� ������ ������ ������ ������ ���� ��ȸ�ϼ���
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


���� : {a, b, c} == {a, c, b}
������ ����.
RDBMS - ������ �����ͺ��̽�(���հ� ���������� ������ ����.)
table���� ��ȸ, ����� ������ ����.(�������� ����) (���հ� ������ ����)

SQL ������ �����͸� �����Ϸ��� ������ ������ �ʿ��ϴ�
�� ORDER BY
ORDER BY �÷��� [��������], �÷���2 [��������]
�������¸� ������� ������ �⺻������ ������������ ����

������ ���� : ��������(DEFAULT) - ASC, �������� - DESC

���� �̸����� ������������
SELECT *
FROM emp
ORDER BY ename;

���� �̸����� ������������
SELECT *
FROM emp
ORDER BY ename DESC;

job�� �������� ���� ���������ϰ� job�� ������� �Ի����ڷ� �������� ����
��� ������ ��ȸ

SELECT *
FROM emp
ORDER BY job ASC, hiredate DESC;

