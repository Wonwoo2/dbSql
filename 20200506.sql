����1) fastfood ���̺�� tax ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� SQL �ۼ�
1. �õ� ���ñ����� ���ù��������� ���ϰ�(������ ���� ���ð� ������ ����)
2. �δ� ���� �Ű���� ���� �õ� �ñ������� ������ ���Ͽ�
3. ���ù��������� �δ� �Ű�� ������ ���� ������ ���� �����Ͽ� �Ʒ��� ���� �÷��� ��ȸ�ǵ��� SQL �ۼ�
���� �õ� �ñ��� �ܹ��� ���ù�������, ����û �õ�, ����û �ñ���, ����û �������� �ݾ�1�δ� �Ű��

SELECT sido, sigungu, COUNT(gb) cnt
                    FROM fastfood
                    WHERE gb = '����ŷ'
                    GROUP BY sido, sigungu, gb;

SELECT ROWNUM srn, ci.sido, ci.sigungu, ci.city_idx, k.sido ta_sido, k.sigungu ta_sigungu, k.sp ta_sp
FROM
    (SELECT ROWNUM crn, a.sido, a.sigungu, a.city_idx
        FROM
    (SELECT bk.sido, bk.sigungu, bk.cnt, lot.cnt, ROUND((bk.cnt + kfc.cnt + mac.cnt)/ lot.cnt, 2) city_idx
        FROM
            (SELECT sido, sigungu, COUNT(gb) cnt
                    FROM fastfood
                    WHERE gb = '����ŷ'
                    GROUP BY sido, sigungu, gb) bk,

            (SELECT sido, sigungu, COUNT(gb) cnt
                    FROM fastfood
                    WHERE gb = 'KFC'
                    GROUP BY sido, sigungu, gb) kfc,

            (SELECT sido, sigungu, COUNT(gb) cnt
                    FROM fastfood
                    WHERE gb = '�Ƶ�����'
                    GROUP BY sido, sigungu, gb) mac,
            (SELECT sido, sigungu, COUNT(gb) cnt
                    FROM fastfood
                    WHERE gb = '�Ե�����'
                    GROUP BY sido, sigungu, gb) lot
            WHERE bk.sido = kfc.sido
            AND bk.sigungu = kfc.sigungu
            AND bk.sido = mac.sido
            AND bk.sigungu = mac.sigungu
            AND bk.sido = lot.sido
            AND bk.sigungu = lot.sigungu
            ORDER BY city_idx DESC ) a) ci,

    (SELECT ROWNUM trn, ta.sido, ta.sigungu, ta.sp
        FROM
        (SELECT sido, sigungu, ROUND(sal/people, 2) sp
            FROM tax
            GROUP BY sido, sigungu, people, sal
            ORDER BY sp DESC) ta) k
    WHERE k.trn = ci.crn;

����2)
�ܹ��� ���ù��� ������ ���ϱ� ���� 4���� �ζ��� �並 ����Ͽ��µ� (fastfood ���̺��� 4�� ���)
�̸� �����Ͽ� ���̺��� �ѹ��� �д� ���·� ������ ���� (fastfood ���̺��� 1���� ���)
NVL(DECODE(gb, '�Ե�����', COUNT(gb)), 0) lot;
SELECT e.sido, e.sigungu, e.gb
    FROM fastfood e, fastfood f
    WHERE e.gb IN('����ŷ', 'KFC', '�Ƶ�����', '�Ե�����')
    AND e.sido = f.sido
    AND e.sigungu = f.sigungu
    GROUP BY e.sido, e.sigungu, e.gb
    ORDER BY e.sido;
    
SELECT sido, sigungu, gb, COUNT(*)
    FROM fastfood
    WHERE gb != '�����̽�'
    AND gb != '������ġ'
    GROUP BY sido, sigungu, gb
    ORDER BY sido;
    
SELECT sido, sigungu,
        NVL(DECODE(gb, '�Ƶ�����', COUNT(gb)), 0)
        NVL(DECODE(gb, '����ŷ', COUNT(gb)), 0)
        NVL(DECODE(gb, 'KFC', COUNT(gb)), 0) 
        NVL(DECODE(gb, '�Ե�����', COUNT(gb)), 0)
FROM fastfood
GROUP BY sido, sigungu, gb;

SELECT sido, sigungu, COUNT(gb) cnt
FROM fastfood
WHERE gb = '�Ƶ�����'
GROUP BY sido, sigungu, gb;

SELECT sido, sigungu, gb
FROM fastfood
WHERE sido = '��⵵'
AND sigungu = '���ֽ�'
AND gb = '�Ƶ�����';


����3)
�ܹ��� ���� sql�� �ٸ� ���·� �����ϱ�

------------------------------------------------------
1.
SELECT job, COUNT(*)
FROM emp 
GROUP BY job;

2.
SELECT mgr, COUNT(*)
FROM emp
GROUP BY mgr;

3.
SELECT manager_id, department_id, COUNT(*)
FROM employees
GROUP BY manager_id, department_id;

fastfood ���̺� �ѹ��� �а� ���ù������� ���ϱ�;

���� �ܹ������� �ּ� (�����̽�, ������ġ �����ϰ� ���)

SELECT a.rank, a.sido, a.sigungu, a.city_idx, b.sido, b.sigungu, b.tax
FROM
    (SELECT ROWNUM rank, sido, sigungu, city_idx
    FROM
        (SELECT sido, sigungu, ROUND((kfc + mac + bk) / lot, 2) city_idx
        FROM
        (SELECT sido, sigungu,
                    NVL(SUM(CASE WHEN gb = 'KFC' THEN 1 END), 0) kfc,
                    NVL(SUM(CASE WHEN gb = '�Ƶ�����' THEN 1 END), 0) mac,
                    NVL(SUM(CASE WHEN gb = '����ŷ' THEN 1 END), 0) bk,
                    NVL(SUM(CASE WHEN gb = '�Ե�����' THEN 1 END), 1) lot
        FROM fastfood
        WHERE gb IN ('����ŷ', 'KFC', '�Ƶ�����', '�Ե�����')
        GROUP BY sido, sigungu)
        ORDER BY city_idx DESC)) a,
    
    (SELECT ROWNUM rank, sido, sigungu, tax
    FROM
        (SELECT sido, sigungu, ROUND(sal/people, 2) tax
        FROM tax
        ORDER BY tax DESC)) b
WHERE a.rank(+) = b.rank
ORDER BY b.rank;
    
�����տ������� ������ ������ �� �� �ִ�

--------------------------------------------------------------------------

DML
- �����͸� �Է�(INSERT), ����(UPDATE), ����(DELETE) �� �� ����ϴ� SQL

INSERT ����
- INSERT INTO ���̺�� [(���̺��� �÷���, ...)] VALUES (�Է��� ��, ....);
- ũ�� �ΰ��� ���·� ���
- ���̺��� ��� �÷��� ���� �Է��ϴ°�� �÷Ÿ��� �������� �ʾƵ� �ȴ�(��, �Է��� ���� ������ ���̺� ���ǵ� �÷� ������
  �νĵȴ�
  : INSERT INTO ���̺�� VALUES (�Է��� ��, �Է��� ��2 ...);
- �Է��ϰ��� �ϴ� �÷��� ����ϴ� ���, ����ڰ� �Է��ϰ��� �ϴ� �÷��� �����Ͽ� �����͸� �Է��� ���
  ��, ���̺� NOT NULL ������ �Ǿ��ִ� �÷��� �����Ǹ� INSERT�� �����Ѵ�
  : INSERT INTO ���̺�� (�÷�1, �÷�2) VALUES (�Է��� ��, �Է��� ��2 ...);
- SELECT ����� INSERT - SELECT ������ �̿��ؼ� ������ ���� ��ȸ�Ǵ� ����� ���̺� �Է� ����
  => �������� �����͸� �ϳ��� ������ �Է� ����(ONE-QUERY) ==> ���� ����
  
  ����ڷκ��� �����͸� ���� �Է� �޴� ��� (ex ȸ������)�� ������ �Ұ�
  db�� �����ϴ� �����͸� ���� �����ϴ� ��� Ȱ�� ����(�̷� ��찡 ����)
  : INSERT INTO ���̺�� [(�÷���1, �÷���2...)]
    SELECT ....
    FROM ....
  
dept ���̺� deptno 99, dname DDIT, loc daejeon ���� �Է��ϴ� INSERT ���� �ۼ�
INSERT INTO dept VALUES('99', 'DDIT', 'daejeon');
������ �Է��� Ȯ�� �������� : commit  Ʈ����� �Ϸ�
������ �Է��� Ȯ�� ��ҷ��� : rollback  Ʈ����� �Ϸ�
INSERT INTO dept (loc, deptno, dname) VALUES('99', 'DDIT', 'daejeon');

rollback;

SELECT *
FROM dept;

���� INSERT ������ ������ ���ڿ�, ����� �Է��� ��� INSERT�������� ��Į�� ��������, �Լ��� ��밡��
EX : ���̺� �����Ͱ� �� ����� �Ͻ������� ��� �ϴ� ��찡 ���� ==> SYSDATE

SELECT *
FROM emp;

emp ���̺��� ��� �÷� �� ������ 9�� , NOT NULL�� 1��(empno)

empno�� 9999�̰� ename�� �����̸�, hiredate�� ���� �Ͻø� �����ϴ� INSERT ������ �ۼ�

INSERT INTO emp (empno, ename, hiredate) VALUES (9999, 'wonwoo', SYSDATE);

9998�� ������� wonwoo ����� �Է�, �Ի����ڴ� 2020�� 4�� 13��
INSERT INTO emp (empno, ename, hiredate) VALUES (9998, 'wonwoo', TO_DATE('2020/04/13', 'YYYY/MM/DD'));

SELECT ����� ���̺� �Է��ϱ� (�뷮 �Է�);

dept ���̺��� 4���� �����Ͱ� ����(10 ~ 40)
�Ʒ� ������ �����ϸ� ���� ���� 4�� + SELECT�� �ԷµǴ� 4�� �� 8���� �����Ͱ� dept ���̺� �Էµ�
INSERT INTO dept
SELECT *
FROM dept;

������ �۾��� INSERT ������ ���
ROLLBACK;

UPDATE : ������ ����
UPDATE ���̺�� SET �������÷�1 = ������ ��1, 
                    {�������÷�2 = ������ ��2, ....]
[WHERE condition-SELECT ������ ��� WHERE���� ����, ������ ���� �ν��ϴ� ������ ���]

detp ���̺� 99, DDIT, daejeon;

INSERT INTO dept VALUES (99, 'DDIT', 'daejeo');

SELECT *
FROM dept;

99�� �μ��� �μ����� ���IT��, ��ġ�� ���κ������� ����
UPDATE dept SET dname = '���IT', loc = '���κ���'
WHERE deptno = 99;

�Ʒ� ������ dept ���̺� ��� ���� �μ���� ��ġ�� �����ϴ� ����
UPDATE dept SET dname = '���IT', loc = '���κ���'

INSERT : ���� �� ���� ����
UPDATE, DELETE : ������ �ִ°� ����, ����
    ==> ������ �ۼ��� ��� ����
        1. WHERE���� �������� �ʾҴ��� Ȯ��
        2. UPDATE, DELETE ���� �����ϱ����� WHERE���� �����ؼ� SELECT�� �Ͽ� ������ ���� ���� ������ Ȯ��
ROLLBACK;

���������� �̿��� ������ ����
INSERT INTO emp (empno, ename, job) VALUES (9999, 'brown', NULL);

9999�� ������ deptno, job �ΰ��� �÷��� SMITH ����� ������ �����ϰ� ����
UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'),
                job = (SELECT job FROM emp WHERE ename = 'SMITH')
                WHERE empno = 9999;
�Ϲ����� UPDATE ���������� �÷����� ���������� �ۼ��Ͽ� ��ȿ���� ����
==> MERGE ������ ���� ��ȿ���� ������ �� �ִ�

SELECT *
FROM emp
WHERE empno = 9999;

SELECT *
FROM emp;

ROLLBACK;

DELETE : ���̺� �����ϴ� �����͸� ����
����

DELETE [FROM] ���̺��
[WHERE condition]
������
1. Ư�� �÷��� ���� ���� ==> �ش� �÷��� NULL�� UPDATE
    DELETE���� �� ��ü�� ����

���� �׽�Ʈ ������ �Է�
INSERT INTO emp (empno, ename, job) VALUES (9999, 'brown', NULL);

����� 999���� ���� ���� �ϴ� ���� �ۼ�
DELETE emp
WHERE empno = 9999;

�Ʒ� ������ �ǹ� : emp ���̺��� ��� ���� ����
DELETE emp;

SELECT *
FROM emp;

ROLLBACK;

UPDATE, DELETE ���� ��� ���̺� �����ϴ� �����Ϳ� ����, ������ �ϴ� ���̱� ������
��� ���� �����ϱ� ���� WHERE ���� ����� �� �ְ�
WHERE���� SELECT ������ ����� ������ ������ �� �ִ�
���� ��� ���������� ���� ���� ������ ����

�Ŵ����� 76798�� �������� ��� ���� �ϰ� ���� ��
DELETE emp
WHERE empno IN(
    SELECT empno
    FROM emp
    WHERE mgr = 7698);
    
DML : SELECT, INSERT, UPDATE, DELETE
WHERE ���� ��� ������ DML : SELECT, UPDATE, DELETE
    3���� ������ �����͸� �ĺ��ϴ� WHERE���� ���� �� �ִ�
    �����͸� �ĺ��ϴ� �ӵ��� ���� ������ ���� ������ �¿�ȴ�
    
INSERT : ������� �ű� �����͸� �Է� �ϴ� ��
        ������� �ĺ��ϴ°� �߿�
        ==> �����ڰ� �� �� �ִ� Ʃ�� ����Ʈ�� ���� ����
        
���̺��� �����͸� ����� ��� (��� ������ �����)
1. DELETE : WHERE���� ������� ������ �ȴ�
2. TRUNCATE
    ���� : TRUNCATE TABLE ���̺��
    Ư¡ : 1) ������ �α׸� ������ ���� ==> ������ �Ұ���
          2) �α׸� ������ �ʱ� ������ ���� �ӵ��� ������ ==> �ȯ�濡���� �� ������� ���� (������ �ȵǱ� ������)
            - �׽�Ʈ ȯ�濡�� �ַ� ���
            
�����͸� �����Ͽ� ���̺� ����(���� �غ���);
CREATE TABLE emp_copy AS
SELECT *
FROM emp;

SELECT *
FROM emp_copy;

emp_copy ���̺��� TRUNCATE ����� ���� ��� �����͸� ����
TRUNCATE TABLE emp_copy;

Ʈ����� : ������ ���� ����
ex : ATM- ��ݰ� �Ա��� �Ѵ� ���������� �̷������ ������ �߻����� ����
    ����� ���� ó�� �Ǿ����� �Ա��� ������ ó�� �Ǿ��ٸ�
    ���� ó���� ��ݵ� ��Ҹ� ����� �Ѵ�
    
����Ŭ������ ù��° DML�� ������ �Ǹ� Ʈ���� �������� �ν�
Ʈ������� ROLLBACK, COMMIT�� ���� ���ᰡ �ȴ�

Ʈ����� ������ ���ο� DML�� ����Ǹ� ���ο� Ʈ������� ����

��� ����ϴ� �Խ����� �����غ���
�Խñ� �Է��� �� �Է� �ϴ°� : ����(1��), ����(1��), ÷������(���� ����)
RDBMS������ �Ӽ��� �ߺ��� ��� ������ ����Ƽ(���̺�)�� �и��� �Ѵ�
�Խñ� ���̺�(����, ����) / �Խñ� ÷������ ���̺�(÷�����Ͽ� ���� ����)
INSERT INTO �Խñ� ���̺� (����, ����, �����, ����Ͻ�) VALUES (.....);
INSERT INTO �Խñ� ÷������ ���̺� (÷�����ϸ�, ÷������ ������) VALUES (.....);

�ΰ��� INSERT ������ �Խñ� ����� Ʈ����� ����
�� �ΰ��߿� �ϳ��� ������ ����� �Ϲ������� ROLLBACK�� ���� �� ���� INSERT ������ ���.
