 NULL ó�� �ϴ� ��� (4���� �߿� ���� ���Ѱɷ� �ϳ� �̻��� ���)
 NVL, NVL2.. => �Լ�
 
 condition : CASE, DECODE
 
 �����ȹ : �����ȹ�� ��������
            ���� ����
 
 SELECT empno, ename, sal, NVL(comm, 0)
 FROM emp;
 
 DESC emp;
 
 emp ���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
 �ش� ������ job�� SALESMAN�� ��� SAL���� 5%(5�ۼ�Ʈ) �λ�� �ݾ��� ���ʽ��� ���� (ex : sal 100 => 105)
 �ش� ������ job�� MANAGER�̸鼭 deptno�� 10�̸� SAL���� 30%(30�ۼ�Ʈ)  �λ�� �ݾ��� ���ʽ��� ����
                                �� ���� �μ��� ���ϴ� ����� 10%(10�ۼ�Ʈ) �λ�� �ݾ��� ���ʽ��� ����
 �ش� ������ job�� PRESIDENT�� ��� SAL���� 20%(20�ۼ�Ʈ) �λ�� �ݾ��� ���ʽ��� ����
 �׿� �������� sal��ŭ�� ����
 
 DECODE�� ���(CASE ��� ����)
 
 SELECT empno, ename, job, sal, deptno,
        DECODE(job, 'SALESMAN', sal * 1.05,
                    'MANAGER', DECODE(deptno, 10, sal * 1.30, sal * 1.10),
                    'PRESIDENT', sal * 1.20,
                    sal) bonus
 FROM emp;
 
 �Ҽ� : �ڽŰ� 1�� ����� �ϴ� ��
 
 ���� A = { 10, 15, 18, 23, 24, 25, 29, 30, 35, 37 }
 Prime Number �Ҽ� : { 23, 29, 37 }
 ��Ҽ� : { 10, 15, 18, 24, 25, 30, 35 }
 
 GROUP FUNCTION
 �������� �����͸� �̿��Ͽ� ���� �׷쳢�� ���� �����ϴ� �Լ�
 �������� �Է¹޾� �ϳ��� ������ ����� ���δ�
 EX : �μ��� �޿� ���
    emp ���̺��� 14���� ������ �ְ�, 14���� ������ 3���� �μ�(10, 20, 30)�� ���� �ִ�
    �μ��� �޿� ����� 3���� ������ ����� ��ȯ�ȴ�
 
 GROUP BY ����� ���ǻ��� : SELECT ����� �� �ִ� �÷��� ���ѵ�
 
 SELECT �׷��� ���� �÷�, �׷��Լ� => �׷��� ���� �÷��� �ƴ� �ٸ� �÷��� ���� ����
 FROM ���̺�
 GROUP BY �׷��� ���� �÷�
 [ORDER BY];
 
 �μ����� ���� ���� �޿� ��
 
 SELECT deptno, MAX(sal)
 FROM emp
 GROUP BY deptno;
 
 SELECT deptno, sal
 FROM emp
 ORDER BY deptno, sal;
 
 SELECT deptno,
        MAX(sal),   -- �μ����� ���� ���� �޿� ��
        MIN(sal),   -- �μ����� ���� ���� �޿� ��
        ROUND(AVG(sal), 2),   -- �μ��� �޿� ���
        SUM(sal),   -- �μ��� �޿� ��
        COUNT(sal), -- �μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT(*),   -- �μ��� ���� ��
        COUNT(mgr)  -- mgr�÷��� null�ƴ� �Ǽ�
 FROM emp
 GROUP BY deptno;
 
 * �׷� �Լ��� ���� �μ���ȣ �� ���� ���� �޿��� ���� ���� ������
    ���� ���� �޿��� �޴� ����� �̸��� �� ���� ����
        ==> ���� WINDOW FUNCTION�� ���� �ذ� ����
        
 emp ���̺��� �׷� ������ �μ���ȣ�� �ƴ� ��ü �������� ���� �ϴ� ���
 SELECT MAX(sal),   -- ��ü ���� �� ���� ���� �޿� ��
        MIN(sal),   -- ��ü ���� �� ���� ���� �޿� ��
        ROUND(AVG(sal), 2),   -- ��ü ���� �� �޿� ���
        SUM(sal),   -- ��ü ���� �� �޿� ��
        COUNT(sal), -- ��ü ���� �� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT(*),   -- ��ü ���� �� ���� ��
        COUNT(mgr)  -- mgr �÷��� null �ƴ� �Ǽ�
 FROM emp
 GROUP by deptno;
 
 �׷�ȭ�� ���� ���� ���ڿ�, ��� ���� SELECT ���� ǥ�� �� �� �ִ�(���� �ƴ�)
 SELECT deptno, 'TEST', 1,
        MAX(sal),   -- ��ü ���� �� ���� ���� �޿� ��
        MIN(sal),   -- ��ü ���� �� ���� ���� �޿� ��
        ROUND(AVG(sal), 2),   -- ��ü ���� �� �޿� ���
        SUM(sal),   -- ��ü ���� �� �޿� ��
        COUNT(sal), -- ��ü ���� �� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT(*),   -- ��ü ���� �� ���� ��
        COUNT(mgr)  -- mgr �÷��� null �ƴ� �Ǽ�
 FROM emp
 GROUP by deptno;
 
 GROUP �Լ� ����� NULL ���� ���ܰ� �ȴ�
 30�� �μ����� NULL���� ���� ���� ������ SUM(COMM)�� ���� ���������� ���� �� Ȯ�� �� �� �ִ�
 SELECT deptno, SUM(comm)
 FROM emp
 GROUP BY deptno;
 
 10��, 20�� �μ��� SUM(COMM) �÷��� NULL�� �ƴ϶� 0�� �������� NULLó��
 * Ư���� ������ �ƴϸ� �׷��Լ� ������� NULL ó���� �ϴ� ���� ���ɻ� ����
 
 NVL(SUM(comm), 0) : COMM�÷��� SUM �׷��Լ��� �����ϰ� ���� ����� NVL�� ����(1ȸ ȣ��)
 SUM(NVL(comm, 0)) : ��� COMM�÷��� NVL �Լ��� ���� ��(�ش� �׷��� ROW�� ��ŭ ȣ��) SUM �׷��Լ� ����
 SELECT deptno, NVL(SUM(comm), 0), SUM(NVL(comm, 0)) -- SUM(NVL(comm, 0)) ��ȿ����
 FROM emp
 GROUP BY deptno;
 
 single row �Լ��� WHERE���� ��� �� �� ������
 multi row �Լ�(group �Լ�)�� WHERE���� ����� �� ����
 GROUP BY�� ���� HAVING ���� ������ ���
 
 �μ��� �޿� ���� 9000�� �Ѵ� �μ��� ��ȸ
 SELECT deptno, SUM(sal)
 FROM emp
 WHERE SUM(sal) > 5000
 GROUP BY deptno; ==> ����;
 
 SELECT deptno, SUM(sal)
 FROM emp
 GROUP BY deptno
 HAVING SUM(sal) > 9000;
 
 emp ���̺��� �̿��Ͽ� ������ ���Ͻÿ�
    - ���� �� ���� ���� �޿�
    - ���� �� ���� ���� �޿�
    - ������ �޿� ���(�Ҽ��� ���ڸ����� �������� �ݿø�)
    - ������ �޿� ��
    - ���� �� �޿��� �ִ� ������ ��(null ����)
    - ���� �� ����ڰ� �ִ� ������ ��(null ����)
    - ��ü ������ ��

 SELECT MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal), 2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mgr,
        COUNT(*) count_all
 FROM emp;
 
 emp ���̺��� �̿��Ͽ� ������ ���Ͻÿ�
    - �μ����� ���� �� ���� ���� �޿�
    - �μ����� ���� �� ���� ���� �޿�
    - �μ����� ������ �޿� ���(�Ҽ��� 2�ڸ�����)
    - �μ����� ������ �޿� ��
    - �μ��� ���� �� �޿��� �ִ� ������ ��(null ����)
    - �μ��� ���� �� ����ڰ� �ִ� ������ ��(null ����)
    - �μ��� ���� ��
    
 SELECT deptno,
        MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal), 2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mgr,
        COUNT(*)
 FROM emp
 GROUP BY deptno;
 
 emp ���̺��� �̿��Ͽ� ������ ���Ͻÿ�
    - grp2���� �ۼ��� ������ Ȱ���Ͽ�
        deptno ��� �μ����� ���ü� �ֵ��� �����Ͻÿ�
 
 SELECT DECODE(deptno, 10, 'ACCOUTING',
                        20, 'RESEARCH',
                        30, 'SALES') dname,
        MAX(sal) max_sal,
        MIN(sal) min_sal,
        ROUND(AVG(sal), 2) avg_sal,
        SUM(sal) sum_sal,
        COUNT(sal) count_sal,
        COUNT(mgr) count_mgr,
        COUNT(*) count_all
 FROM emp
 GROUP BY deptno;
 
 emp���̺��� �̿��Ͽ� ������ ���Ͻÿ�
 ������ �Ի� ������� ����� ������ �Ի��ߴ��� ��ȸ�ϴ� ������ ��ȸ�Ͻÿ�
 
 SELECT TO_CHAR(hiredate, 'YYYYMM') hire_yyyymm,
        COUNT(*) CNT
 FROM emp
 GROUP BY TO_CHAR(hiredate, 'YYYYMM')
 ORDER BY TO_CHAR(hiredate, 'YYYYMM');
 
 emp ���̺��� �̿��Ͽ� ������ ���Ͻÿ�
 ������ �Ի� �⺰�� ����� ������ �Ի��ߴ��� ��ȸ�ϴ� ������ �ۼ��ϼ���
 
 SELECT TO_CHAR(hiredate, 'YYYY') hire_yyyymm,
        COUNT(*) CNT
 FROM emp
 GROUP BY TO_CHAR(hiredate, 'YYYY')
 ORDER BY TO_CHAR(hiredate, 'YYYY');
 
 ȸ�翡 �����ϴ� �μ��� ������ ����� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�(dept ���̺� ���)
 
 SELECT COUNT(*) cnt
 FROM dept;
 
 ������ ���� �μ��� ������ ��ȸ�ϴ� ������ �ۼ��Ͻÿ�(emp ���̺� ���)
 
 SELECT COUNT(COUNT(*)) cnt
 FROM emp
 GROUP BY deptno;