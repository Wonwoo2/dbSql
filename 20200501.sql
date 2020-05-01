 �������� ����
 
 �Ѱ��� ��, �ϳ��� �÷��� �����ϴ� ��������
 ex : ��ü ������ �޿� ���, SMITH ������ ���� �μ��� �μ���ȣ
 
 WHERE������ ��밡���� ������
 WHERE deptno = 10
 ==> 
 �μ���ȣ�� 10�� Ȥ�� 30���� ���
 WHERE deptno IN(10, 30)
 WHERE deptno = 10 OR deptno = 30
 
 ������ ������
 �������� ��ȸ�ϴ� ���������� ��� ( = �����ڸ� ���Ұ� )
 ex WHERE deptno = (10, 30)
 
 WHERE deptno IN (�������� ���� �����ϰ�, �ϳ��� �÷����� �̷���� ����)
 
 SMITH - 20��, ALLEN�� 30�� �μ��� ����
  
 ���� �������̰�, �÷��� �ϳ��� 
 ==> ������������ ��밡���� ������ IN(���� ���,�߿�), (ANY, ALL) => ���� ����
 
 IN : ���������� ����� �� ������ ���� ���� �� TRUE
    WHERE �÷�|ǥ���� IN (��������)
 ANY : �����ڸ� �����ϴ� ���� �ϳ��� ���� �� TRUE
    WHERE �÷�|ǥ���� ������ ANY (��������)
 ALL : ���������� ��� ���� �����ڸ� ������ �� TRUE
    WHERE �÷�|ǥ���� ������ ALL (��������)

 SMITH �Ǵ� ALLEN�� ���ϴ� �μ��� ������ ������ ��ȸ
 
 1. ���������� ������� ���� ��� : �� ���� ������ ����
 1-1] SMITH, ALLEN�� ���� �μ��� �μ���ȣ�� Ȯ���ϴ� ��Ŀ��
 
 SELECT deptno
 FROM emp
 WHERE ename IN ('SMITH', 'ALLEN');
 
 1-2] 1-1]���� ���� �μ���ȣ�� IN������ ���� �ش� �μ��� ���ϴ� ���� ���� ��ȸ
 
 SELECT *
 FROM emp
 WHERE deptno IN (20, 30);
 
 ==> ���������� �̿��ϸ� �ϳ��� SQL���� ���డ��
 
 SELECT *
 FROM emp
 WHERE deptno IN (SELECT deptno
 FROM emp
 WHERE ename IN ('SMITH', 'ALLEN'));
 
 �������� �ǽ�(03)
 
 SMITH�� WARD����� ���� �μ��� ��� ��� ������ ��ȸ�ϴ� ������ ������ ���� �ۼ��ϼ���
 
 SELECT *
 FROM emp
 WHERE deptno IN (SELECT deptno
 FROM emp
 WHERE ename IN ('SMITH', 'WARD'));
 
 ANY, ALL
 SMITH(800)�� WARD(1250) �� ����� �޿��� �ƹ� ������ ���� �޿��� �޴� ���� ��ȸ
 ==> sal < 1250�� ������ �ǹ�
 SELECT *
 FROM emp
 WHERE sal < ANY(SELECT sal
                FROM emp
                WHERE ename IN('SMITH','WARD'));
                
 SMITH(800)�� WARD(1250) �� ����� �޿����� ���� �޿��� �޴� ���� ��ȸ
 ==> sal > 1250�� ������ �ǹ�
 SELECT *
 FROM emp
 WHERE sal > ALL(SELECT sal
                FROM emp
                WHERE ename IN('SMITH', 'WARD'));
 
 IN �������� ����
 �ҼӺμ��� 20, Ȥ�� 30�� ���
 ==> WHERE deptno IN (20, 30)
 
 �ҼӺμ��� 20, Ȥ�� 30�� ������ �ʴ� ���
 ==> WHERE deptno NOT IN (20, 30)
 
 NOT IN�����ڸ� ����� ��� ���������� ���� NULL�� �ִ��� ���ΰ� �߿�
 ==> NULL�� ������� ���������� �������� �ʴ´�
 
 �Ʒ� ������ ��ȸ�ϴ� ����� � �ǹ��ΰ�??
 
 SELECT *
 FROM emp
 WHERE empno NOT IN (SELECT mgr
                    FROM emp);
 ==> �������� �Ŵ����� �ƴ� ����� ��ȸ(NULL�� ������ ���� �۵��� ���� �ʴ´�)
 
 NULL���� ���� ���� ����
 SELECT *
 FROM emp
 WHERE empno NOT IN (SELECT mgr
                    FROM emp
                    WHERE mgr IS NOT NULL);

 NULLó�� �Լ��� ���� ���� ������ ���� �ʴ� ������ ġȯ             
 SELECT *
 FROM emp
 WHERE empno NOT IN (SELECT NVL(mgr, -1)
                    FROM emp);
                    
 ���� �÷��� �����ϴ� ��������
 PAIRWISE ���� (������) ==> ���ÿ� ����
 
 SELECT empno, mgr, deptno
 FROM emp
 WHERE empno IN (7499, 7782); 
 empno IN(7499) == empno = 7499;
 
 7499, 7782����� (������ ���� �μ�, ���� �Ŵ���)�� ��� ���� ���� ��ȸ
 �Ŵ����� 7499�̸鼭 �ҼӺμ��� 30���� ���
 �Ŵ����� 7482�̸鼭 �ҼӺμ��� 10�� ���

 mgr �÷��� deptno �÷��� �������� ����
 (mgr, deptno);
 
 SELECT *
 FROM emp
 WHERE mgr IN (7499, 7782)
    AND deptno IN (10, 30);
 ==> ����� �� (7499, 30), (7499, 10), (7782, 10), (7782, 30)�� ���´�
 ������ ���� �������� ���ϴ� ���� (7499, 30), (7782, 10)
 
 PAIRWISE ����
 SELECT *
 FROM emp
 WHERE (mgr, deptno) IN (SELECT mgr, deptno
                            FROM emp
                            WHERE empno IN(7499, 7482));
                            
 �������� ���� - ��� ��ġ
 SELECT - ��Į�� ���� ����
 FROM - �ζ��� ��
 WHERE - ��������
 
 �������� ���� - ��ȯ�ϴ� ��, �÷��� ��
 - ���� ��
    ���� �÷�
    ���� �÷�
 - ���� ��
    ���� �÷�(���� ���� ����)
    ���� �÷�
    
 ��Į�� ��������
 - SELECT ���� ǥ���Ǵ� ��������
 - ������ ���� �÷��� �����ϴ� ���������� ��� ����
 - ���� ������ �ϳ��� �÷� ó�� �ν�;
 
 SELECT 'X',
 (SELECT SYSDATE
 FROM dual)
 FROM dual;
 
 ��Į�� ���� ������ �ϳ��� ��, �ϳ��� �÷��� ��ȯ�ؾ� �Ѵ�

 SELECT 'X', (SELECT empno, ename 
                FROM emp
                WHERE ename = 'SMITH')
 FROM dual;
 ==> ���� �ϳ����� �÷��� 2���̱� ������ ����
 
 ������ �ϳ��� �÷��� �����ϴ� ��Į�� ��������
 SELECT 'X', (SELECT empno
                FROM emp)
 FROM dual;
 
 emp ���̺� ����� ��� �ش� ������ �Ҽ� �μ� �̸��� �� ���� ���� ==> ������ ����Ͽ� �ذ� ����
 Ư�� �μ��� �μ� �̸��� ��ȸ�ϴ� ����
 
 SELECT dname
 FROM dept
 WHERE deptno = 10;
 
 JOIN ���� ����
 SELECT empno, ename, dept.deptno, dname
 FROM emp, dept
 WHERE emp.deptno = dept.deptno;
 
 �� ������ ��Į�� ���������� ����
 
 SELECT empno, ename, emp.deptno, (SELECT dname
                                FROM dept
                                WHERE deptno = emp.deptno)
 FROM emp;
 
 �������� ���� - ���������� �÷��� ������������ ����ϴ��� ���ο� ���� ����
 ��ȣ���� ��������(corelated sub query)
    - ����  ������ ���� �Ǿ�� ���� ������ ������ �����ϴ�
 ���ȣ ���� ��������(non corelated sub query)
    - ���� ������ ���̺��� ���� ��ȸ�� ���� �ְ�
    - ���������� ���̺��� ���� ��ȸ�� ���� �ִ�
    ==> ����Ŭ�� �Ǵ����� �� ���ɻ� ������ �������� ���� ������ ����
 
 ��� ������ �޿���� ���� ���� �޿��� �޴� ���� ���� ��ȸ(���� ���� �̿�)
 
 SELECT *
 FROM emp
 WHERE sal > (SELECT avg(sal)
                FROM emp);
 ==> ���ȣ ���� ���� ����
 �����غ� ����, ���� ������ ��ȣ ���� ���� �����ΰ�? ���ȣ ���� ���� �����ΰ�? 
 ���� ������ ���� ������ �÷��� ������������ ����ϴ°��� ����
 
 ������ ���� �μ��� �޿� ��պ��� ���� �޿��� �޴� ����
 ���� ������ ���Ͽ� ��ü ������ �޿� ��� ==> ������ ���� �μ��� �޿� ���
 
 Ư�� �μ�(10)�� �޿� ����� ���ϴ� SQL
 SELECT avg(sal)
 FROM emp
 WHERE deptno = 10;
 
 SELECT avg(sal)
 FROM emp
 WHERE deptno = 20;
 
 SELECT avg(sal)
 FROM emp
 WHERE deptno = 30;
 
 SELECT avg(sal)
 FROM emp;
 
 SELECT *
 FROM emp e
 WHERE e.sal > (SELECT avg(sal)
                FROM emp 
                WHERE deptno = e.deptno); ==> ���������� �����ϴ� ������ �����ϱ� ���� alias�� �ο�
 ==> ��ȣ ���� �������� 
 
 �ƿ��� ���� ==> ������ ���еǴ��� �������� ���� ���̺��� �÷� ������ ��ȸ�� �ǵ��� �ϴ� ���� ���
 TABLE1 LEFT OUTER JOIN TABLE2
 ==> TABLE1�� �÷��� ���ο� �����ϴ��� ��ȸ�� �ȴ�
 (oracle 9i ���� ������ ������ �Ǵ� ���̺� ���� �д´�
 ==> oracle 10g���� ���ʹ� ���ɻ� ������ ���̺� ���� �д´�);
 
 SELECT *
 FROM dept;
                
 INSERT INTO dept VALUES(99, 'ddit', 'daejeon');
 ==> �����͸� �����ϴ� ����
 
 �������� �ǽ�(04)
 
 dept ���̺��� �ű� ��ϵ� 99�� �μ��� ���� ����� ����
 ������ ������ ���� �μ��� ��ȸ�ϴ� ������ �ۼ��غ�����
 
 ==> emp���̺� ��ϵ� �������� 10, 20, 30�� �μ����� �Ҽ��� �Ǿ�����
    ������ �Ҽӵ��� ���� �μ��� : 40, 99
 
 SELECT *
 FROM dept
 WHERE deptno NOT IN (SELECT deptno
                FROM emp);
                
 ������ ���� �μ� ���� ��ȸ(������ �Ѹ��̶� �����ϴ� �μ�
 
 WHERE deptno = 10
    OR deptno = 10
    OR deptno = 10
    ==> �̷��� �ߺ��Ǿ ����� �Ȱ���
 SELECT *
 FROM dept
 WHERE deptno IN (10, 20, 30, 10, 20, 10); ==> ������ �ǹ̷�, �ߺ��̵Ǿ ������� 10�� ���������͵�, 20�� ������ ���͵� ������ٴ� ��
 
 ���������� �̿��Ͽ� IN�����ڸ� ���� ��ġ�ϴ� ���� �ִ��� ������ ��
 ���� ������ �־ ��� ����(����)
 
 SELECT *
 FROM dept d
 WHERE deptno IN (SELECT deptno
                FROM emp);
                
 �������� �ǽ�(05)
 
 cycle, product ���̺��� �̿��Ͽ� cid = 1�� ���� �������� �ʴ� 
 (��ǰ�� ��ȸ�ϴ� ����)�� �ۼ��ϼ���
 ==> product ���̺��� ��ȸ�Ѵٴ� ��
 SELECT *
 FROM cycle;
 
 SELECT *
 FROM product;
 
 SELECT *
 FROM product
 WHERE pid NOT IN(SELECT pid
                FROM cycle
                WHERE cid = 1);
                
 �������� �ǽ�(06)
 
 cycle ���̺��� �̿��Ͽ� cid = 1�� ���� �����ϴ� ��ǰ �� cid = 2�� ���� �����ϴ� ��ǰ��
 ���������� ��ȸ�ϴ� ������ �ۼ��ϼ���
 ==> 1�� ���� �߽�
 
 SELECT *
 FROM cycle;
 
 SELECT *
 FROM cycle
 WHERE cid = 1
 AND pid IN(SELECT pid
            FROM cycle
            WHERE cid = 2);
            
 �������� �ǽ�(07)
 
 customer, cycle, product ���̺��� �̿��Ͽ� cid = 1�� ����
 �����ϴ� ��ǰ�� cid = 2�� ���� �����ϴ� ��ǰ�� ���������� ��ȸ�ϰ�
 ����� ��ǰ����� �����ϴ� ������ �ۼ��ϼ���
 
 SELECT *
 FROM customer;
 
 SELECT *
 FROM cycle;
 
 SELECT *
 FROM product;
 
 SELECT cm.cid, cnm, c.pid, pnm, day, cnt
 FROM customer cm, cycle c, product p
 
 WHERE cm.cid = c.cid
 AND c.pid = p.pid -- �����Ҷ� ���� ������ ������� �ʾҾ��� �׷��� �����Ͱ� ���̳���(�𸣰� �ִ���)
 
 AND cm.cid = 1
 AND c.pid IN(SELECT pid
            FROM cycle 
            WHERE cid = 2);
 ==> ������ ����� �ذ�, ��Į�� ���������� �̿��� �ذ������� ȿ�����̴�
            
 SELECT cid,(SELECT cnm
                FROM customer
                WHERE cid = cycle.cid) cnm, 
             pid, 
             (SELECT pnm 
                FROM product
                WHERE pid = cycle.pid) pnm,
            day, cnt
 FROM cycle
 WHERE cid = 1
    AND pid IN (SELECT pid
                    FROM cycle
                    WHERE cid = 2);             
 ==> ��Į�� ������ �̿��� �ذ�
        
 