 ������ ���� �μ��� ������ ��ȸ�ϴ� ������ �ۼ��Ͻÿ�(emp ���̺� ���)
 => dept ���̺��� Ȯ���ϸ� �� 4���� �μ� ������ ���� ==> ȸ�� ���� �����ϴ� ��� �μ�����
 emp ���̺��� �����Ǵ� �������� ���� ���� �μ������� ���� ==>  10, 20, 30 : 3��
 
 SELECT *
 FROM emp;
 
 SELECT COUNT(*) cnt
 FROM
 (SELECT deptno /* deptno �÷��� 1�� ����, row�� 3���� ���̺� */
 FROM emp
 GROUP BY deptno);
 
 DBMS : Database Management System
  ==> DB
 RDBMS : Relational DataBase Management System
  ==> ������ �����ͺ��̽� ���� �ý���
  
 JOIN ������ ����
 ANSI - ǥ��
 �������� ���� (ORACLE)
 
 JOIN�� ��� �ٸ� ���̺��� �÷��� ����� �� �ֱ� ������
 SELECT �� �� �ִ� �÷��� ������ ��������(���� Ȯ��)
 
 ���տ��� ==> ���� Ȯ�� (���� ��������)
 
 NATURAL JOIN
    - �����Ϸ��� �� ���̺��� ����� �÷��� �̸� ���� ���
    - emp, dept ���̺��� deptno��� �����(������ �̸�, ������ Ÿ��) ����� �÷��� ����
    - �ٸ� ANSI-SQL ������ ���ؼ� ��ü�� �����ϰ�, ���� ���̺���� �÷����� �������� ������ 
        ����� �Ұ����ϱ� ������ ���󵵴� �ټ� ����
 
 * emp ���̺� : 14��;
 SELECT *
 FROM emp;
 
 * dept ���̺� : 4��;
 
 SELECT *
 FROM dept;
 
 ���� �Ϸ��� �ϴ� �÷��� ������� ���� ����
 SELECT *
 FROM emp NATURAL JOIN dept; => ����� �÷��� �̸� deptno�� ���� ���
 
 ORACLE ���� ������ ANSI ����ó�� ����ȭ ���� ����
 ����Ŭ ���� ����
  1. ������ ���̺� ����� FROM ���� ����ϸ� �����ڴ� �ݷ�(,)
  2. ����� ������ WHERE ���� ����ϸ� �ȴ� (ex : WHERE emp.deptno = deptno.deptno)
  
 SELECT *
 FROM emp, dept
 WHERE emp.deptno = dept.deptno;
 
 deptno�� 10���� �����鸸 dept ���̺�� �����Ͽ� ��ȸ;
 
 SELECT *
 FROM emp, dept
 WHERE emp.deptno = dept.deptno -- ���� ����� ���
    AND emp.deptno = 10; -- �࿡ ���� ���� ���� ���;
    
 ANSI-SQL : JOIN with USING
    - join �Ϸ��� ���̺� �̸��� ���� �÷��� 2�� �̻��� ��
    - �����ڰ� �ϳ��� �÷����θ� �����ϰ� ���� �� ���� �÷����� ���(�÷����� ����ϰ� �;)
    
 SELECT *
 FROM emp JOIN dept USING (deptno); ==>� �÷����� �������� ���������Ѵ�
 
 ANSI-SQL : JOIN with ON
    - �����Ϸ��� �� ���̺� �÷����� �ٸ� ��
    - ON���� ����� ������ ���
 
 SELECT *
 FROM emp JOIN dept ON (emp.deptno = dept.deptno);
 
 ORACLE �������� �� SQL�� �ۼ�
 
 SELECT * 
 FROM emp, dept
 WHERE emp.deptno = dept.deptno;
 
 JOIN�� ������ ����
 SELF JOIN : �����Ϸ��� ���̺��� ���� ���� ��
 
 emp ���̺��� ������ ������ ������ ��Ÿ���� ������ ���� �� mgr �÷��� �ش� ������ ������ ����� ����
 �ش� ������ �������� �̸��� �˰� ���� ��
 
 ANSI-SQL�� SQL ����
    - �����Ϸ��� �ϴ� ���̺� EMP(����), EMP(������ ������)
    - ����� �÷� : ����.MGR = ������.EMPNO
    - ���� �÷� �̸��� �ٸ���(MGR, EMPNO)
    - NATURAL JOIN, JOIN with USING�� ����� �Ұ����� ����
    - JOIN with ON ���
    
 SELECT *
 FROM emp e JOIN emp d ON (e.mgr = d.empno); => SELECT ������ AS�� ����ϵ��� ���̺����� ����� �� �ִ�
 
 NONEQUI JOIN : ����� ������ =�� �ƴ� ��
 �׵��� WHERE���� ����� ������ : =, !=, <>, <=, <, >, >=, AND, OR, NOT, LIKE (%, __), IN, BETWEEN AND (>=, <=�� ���� �ǹ�)
 
 SELECT *
 FROM emp;
 
 SELECT *
 FROM salgrade;
 
 SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
 FROM emp 
 JOIN salgrade 
 ON (emp.sal BETWEEN salgrade.losal AND salgrade.hisal); 
 ==> ORCLE ���� �������� ����
 
 SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
 FROM emp, salgrade
 WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;
 
 emp, dept ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���
 
 SELECT e.empno, e.ename, d.deptno, d.dname
 FROM emp e JOIN dept d ON (e.deptno = d.deptno);
 
 emp, dept ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���
 (�μ���ȣ�� 10, 30�� �����͸� ��ȸ);
 
 SELECT empno, ename, emp.deptno, dname
 FROM emp, dept 
 WHERE emp.deptno = dept.deptno 
    AND dept.deptno IN(10, 30)
    AND emp.deptno IN(10, 30); ==> �����ȹ�� ���������� �������� ������ ������ �� �� ����
    
 emp, dept ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���
 (�޿��� 2500 �ʰ�);
 
 SELECT empno, ename, sal, emp.deptno, dname
 FROM emp, dept
 WHERE emp.deptno = dept.deptno
    AND emp.sal > 2500;
    
 SELECT empno, ename, sal, emp.deptno, dname
 FROM emp JOIN dept ON emp.deptno = dept.deptno
 AND emp.sal > 2500;
 
 emp, dept ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���
 (�޿� 2500�ʰ�, ����� 7600���� ū ����);
 
 SELECT empno, ename, sal, emp.deptno, dname
 FROM emp join dept ON emp.deptno = dept.deptno
 AND (sal > 2500 AND empno > 7600);
 
 emp, dept ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���
 (�޿� 2500 �ʰ�, ����� 7600���� ũ��, RESEARCH �μ��� ���ϴ� ����);
 
 SELECT empno, ename, sal, emp.deptno, dname
 FROM emp join dept ON emp.deptno = dept.deptno
 AND sal > 2500 
 AND empno > 7600
 AND dept.dname = 'RESEARCH';
 
 SELECT empno, ename, emp.deptno, dname
 FROM emp JOIN dept ON (emp.deptno != dept.deptno);
 
 erd�� �����Ͽ� prod���̺�� lprod���̺��� �����Ͽ� ������ ���� ����� ������ ������ �ۼ��غ�����
 
 SELECT lprod_gu, lprod_nm, prod.prod_id, prod.prod_name
 FROM lprod JOIN prod ON lprod.lprod_gu = prod.prod_lgu;
 
 
 
 
 
 
 
 
 