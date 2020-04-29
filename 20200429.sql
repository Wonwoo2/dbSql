 Join(08)
 
 erd�� �����Ͽ� countries, regions ���̺��� ������ �Ҽ� ������ ������ ���� ����� �������� ������ �ۼ��غ�����
 (������ ������ ����);
 
 SELECT *
 FROM countries;
  
 SELECT *
 FROM regions;
 
 SELECT regions.region_id, region_name, country_name
 FROM regions, countries
 WHERE regions.region_id = countries.region_id
 AND region_name = 'Europe';
  
 Join(09)
  
 erd�� �����Ͽ� countries, regions, locations ���̺��� �̿��Ͽ� ������ �Ҽ� ����, ������ �Ҽӵ� ���� �̸��� ������ ����
 ����� �������� ������ �ۼ��غ����� (������ ������ ����)
 
 SELECT *
 FROM countries;
 
 SELECT *
 FROM regions;
 
 SELECT *
 FROM locations;
  
 SELECT regions.region_id, region_name, country_name, city
 FROM regions, countries, locations
 WHERE regions.region_id = countries.region_id
 AND countries.country_id = locations.country_id
 AND region_name = 'Europe';
  
 ����(10)
 
 erd�� �����Ͽ� countries, regions, locations, departments ���̺��� �̿��Ͽ� ������ �Ҽ� ����, ������
 �Ҽӵ� ���� �̸� �� ���ÿ� �ִ� �μ��� ������ ���� ����� �������� ������ �ۼ��غ����� (������ ������ ����)
 
 SELECT *
 FROM countries;
 
 SELECT *
 FROM regions;
 
 SELECT *
 FROM locations;
 
 SELECT *
 FROM departments;
 
 SELECT regions.region_id, region_name, country_name, city, department_name
 FROM regions, countries, locations, departments
 WHERE regions.region_id = countries.region_id
 AND countries.country_id = locations.country_id
 AND locations.location_id = departments.location_id
 AND region_name = 'Europe';
  
 ����(11)
  
 erd�� �����Ͽ� countries, regions, locations, departments, employees ���̺��� �̿��Ͽ� ������ �Ҽ� ����, ������
 �Ҽӵ� ���� �̸� �� ���ÿ� �ִ� �μ�, �μ��� �Ҽӵ� ���� ������ ������ ���� ����� �������� ������ �ۼ��غ����� 
 (������ ������ ����)
  
 SELECT *
 FROM countries;
  
 SELECT *
 FROM regions;
  
 SELECT *
 FROM locations;
 
 SELECT *
 FROM departments;
  
 SELECT *
 FROM employees;
 
 SELECT regions.region_id, region_name, country_name, city, (first_name || last_name) AS name
 FROM regions, countries, locations, departments, employees
 WHERE regions.region_id = countries.region_id
 AND countries.country_id = locations.country_id
 AND locations.location_id = departments.location_id
 AND departments.department_id = employees.department_id
 AND region_name = 'Europe';
  
 ����(12)
  
 erd�� �����Ͽ� employees, jobs ���̺��� �̿��Ͽ� ������ ������ ��Ī�� �����Ͽ� ������ ���� �����
 �������� �������ۼ��غ����� 

 SELECT *
 FROM employees;
  
 SELECT *
 FROM jobs;
  
 SELECT employee_id, first_name || last_name AS name, jobs.job_id, job_title
 FROM employees, jobs
 WHERE employees.job_id = jobs.job_id;
  
 ����(13)
  
 erd�� �����Ͽ� employees, jobs ���̺��� �̿��Ͽ� ������ ������ ��Ī, ������ �Ŵ��� ���� �����Ͽ� ������ ���� �����
 �������� �������ۼ��غ�����
  
 SELECT *
 FROM employees;
  
 SELECT *
 FROM jobs;
 
 SELECT e.manager_id AS mgr_id, m.first_name || m.last_name AS name, e.employee_id,  jobs.job_id, job_title
 FROM employees e, jobs, employees m
 WHERE e.job_id = jobs.job_id
    AND e.manager_id = m.employee_id;
    
 OUTER JOIN
 ���̺� ���� ������ �����ص�, �������� ���� ���̺��� �ķ��� ��ȸ�� �ǵ��� �ϴ� ���� ���
 <==> INNER JOIN(���ݱ��� ��� ���)
 
 LEFT OUTER JOIN     : ������ �Ǵ� ���̺��� JOIN Ű���� ���ʿ� ��ġ
 RIGHT OUTER JOIN    : ������ �Ǵ� ���̺��� JOIN Ű���� �����ʿ� ��ġ
 FULL OUTER JOIN     : LEFT OUTER JOIN + RIGHT OUTER JOIN - (�ߺ��Ǵ� �����Ͱ� �ѰǸ� ������ ó��)
 
 emp ���̺��� �÷��� mgr�÷��� ���� �ش� ������ ������ ������ ã�ư� �� �ִ�. ������ KING ������ ��� ����ڰ� ���� ������ 
 �Ϲ����� inner ���� ó���� ���ο� �����ϱ⶧���� KING�� ������ 13���� �����͸� ��ȸ�� �ȴ�
 
 INNER ���� ����
 
 ������ ���� ����� ���, ����� �̸�, ���� ���, ���� �̸�
 
 SELECT *
 FROM emp;
 
 ������ �����ؾ����� �����Ͱ� ��ȸ�ȴ�
 ==> KING�� ����� ����(mgr)�� NULL�̱� ������ ���ο� �����ϰ�
     KING�� ������ ������ �ʴ´� (emp ���̺� �Ǽ� 14�� ==> ���� ��� 13��)
 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp e, emp m
 WHERE e.mgr = m.empno;
 
 ANSI-SQL
 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp e JOIN emp m
 ON e.mgr = m.empno;
 
 ���� ������ OUTER �������� ����
 (KING ������ ���ο� �����ϵ� ���� ������ ���ؼ��� ��������, ������ ����� ������ ���� ������ ������ �ʴ´�);
 
 ANSI-SQL : OUTER
 
 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp e LEFT OUTER JOIN emp m
 ON e.mgr = m.empno; 
 ���� = ������ ���� ���̺�
 
 ���̺� ����Ű���� ���̺�
 �� ����Ű���忡 ���� ������ �Ǵ� ���̺��� �޶�����
 
 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp m RIGHT OUTER JOIN emp e
 ON e.mgr = m.empno; 
 ���� = �������� ���� ���̺�
 
 ORACLE-SQL : OUTER(ANSI-SQL �� ���� ���������� ���̳�)
 oracle join
 1. FROM���� ������ ���̺� ���(�޸��� ����)
 2. WHERE ���� ���� ������ ���
 3. ���� �÷�(�����) �� ������ �����Ͽ� �����Ͱ� ���� ���� �÷��� (+)�� �ٿ��ش�
    ==> ������ ���̺� �ݴ����� ���̺��� �÷�

 SELECT m.empno, m.ename, e.empno, e.ename
 FROM emp e, emp m
 WHERE e.mgr = m.empno(+);
 
 OUTER ������ ���� ��� ��ġ�� ���� ��� ��ȭ
 
 ������ ����� �̸�, ���̵� �����ؼ� ��ȸ
 ��, ������ �ҼӺμ��� 10���� ���ϴ� �����鸸 �����ؼ�;
 
 ������ ON���� ������� ��
 SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
 FROM emp e LEFT OUTER JOIN emp m
 ON (e.mgr = m.empno AND e.deptno = 10);
 ON���� JOIN�� ���� ������ ����Ѵ�
 
 ������ WHERE���� ������� ��
 SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
 FROM emp e LEFT OUTER JOIN emp m
 ON e.mgr = m.empno
 WHERE e.deptno = 10; ==> WHERE���� ��������� INNER ���ΰ� ����
 
 OUTER ������ �ϰ� ���� ���̶�� ������ ON���� ����ϴ°� �´�
 
 oracle OUTER JOIN
 
 SELECT m.empno, m.ename, e.empno, e.ename, e.deptno
 FROM emp e, emp m
 WHERE (e.mgr = m.empno(+)
 AND e.deptno = 10);
 
 OUTER JOIN(01)
 
 buyprod ���̺� �������ڰ� 2005�� 1�� 25�� �����ʹ� 3ǰ�� �ۿ� ����
 ��� ǰ���� ���� �� �ֵ��� ������ �ۼ��غ�����
 
 SELECT * 
 FROM buyprod;
 
 SELECT *
 FROM prod;
 
 ANSI-SQL
 
 SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
 FROM prod p LEFT OUTER JOIN buyprod bp
 ON p.prod_id = bp.buy_prod 
 AND buy_date = TO_DATE('2005/01/25', 'YYYY/MM/DD');
 
 ORACLE-SQL
 
 SELECT buy_date, buy_prod, prod_id, prod_name, buy_qty
 FROM prod p, buyprod bp
 WHERE p.prod_id = bp.buy_prod(+)
 AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');
 
 OUTER JOIN(02)
 
 outerjoin1���� �۾��� �����ϼ��� by_date �÷��� null�� �׸��� �ȳ������� ����ó�� �����͸� ä�������� ������ �ۼ��ϼ���
 
 SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD') as by_date, buy_prod, prod_id, prod_name, buy_qty
 FROM prod p, buyprod bp
 WHERE p.prod_id = bp.buy_prod(+)
 AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');
 
 OUTER JOIN(03)
 
 outerjoin1���� �۾��� �����ϼ��� by_qty �÷��� null�� ��� 0���� ���̵��� ������ �����ϼ���
 
 SELECT TO_DATE('2005/01/25', 'YYYY/MM/DD') as by_date, buy_prod, prod_id, prod_name, NVL(buy_qty, 0) buy_qty
 FROM prod p, buyprod bp
 WHERE p.prod_id = bp.buy_prod(+)
 AND buy_date(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD'); ==> �÷��� ����� ǥ���ϸ� �ذᰡ��
 
 OUTER JOIN(04)
 
 cycle, product ���̺��� �̿��Ͽ� ���� �����ϴ� ��ǰ ��Ī�� ǥ���ϰ�, 
 (�������� �ʴ� ��ǰ ==> product ���̺��� ������ �Ǵ°� �˼� ����)
 �� ������ ���� ��ȸ�ǵ��������� �ۼ��ϼ���
 (���� cid = 1�� ���� �������� ����, null ó��);
 
 SELECT *
 FROM cycle;
 
 SELECT *
 FROM product;
 
 SELECT p.pid, p.pnm, 1 as cid, NVL(day, 0) day, NVL(cnt, 0) cnt
 FROM cycle c RIGHT OUTER JOIN product p
 ON p.pid = c.pid
 AND c.cid = 1;
 
 SELECT p.pid, p.pnm, 1 as cid, NVL(day, 0) day, NVL(cnt, 0) cnt
 FROM cycle c RIGHT OUTER JOIN product p
 ON p.pid = c.pid
 AND c.cid = 1;
 
 OUTER JOIN(05)
 
 cycle, product, customer ���̺��� �̿��Ͽ� ���� �����ϴ� ��ǰ ��Ī�� ǥ���ϰ�,
 �������� �ʴ� ��ǰ�� ������ ���� ��ȸ�Ǹ� ���̸��� �����Ͽ� ������ �ۼ��ϼ���
 (���� cid = 1�� ���� �������� ����, null ó��);
 
 SELECT *
 FROM cycle;
 
 SELECT *
 FROM product;
 
 SELECT *
 FROM customer;
 
 SELECT a.pid, a.pnm, a.cid, cm.cnm, a.day, a.cnt
 FROM
 (SELECT p.pid, p.pnm, 1 as cid, NVL(day, 0) day, NVL(cnt, 0) cnt
 FROM cycle c RIGHT OUTER JOIN product p
 ON p.pid = c.pid
 AND c.cid = 1) a JOIN customer cm
 ON a.cid = cm.cid;
 
 ���� �ۼ��Ҷ� ���� �Ǽ��ϴ� �� : 3���� ���̺��� ������ �� 2������ ������ ���;��ϴµ� �����ϴ� ��찡 ����
 SELECT *
 FROM product, cycle, customer
 WHERE product.pid = cycle.pid;
 2������ ������ ��� ��� ���� ��� ���� ���� 15
 ���� ������ ��ȸ���� ��� ���� ���� 45
 3�� ==> customer�� ���� ����
 
 CROSS JOIN
 ���� ������ ������� ���� ���
 ��� ������ ���� �������� ����� ��ȸ�ȴ�
 
 ANSI-SQL
 
 emp 14 * dept 4 = 56 (���� ����)
 SELECT *
 FROM emp CROSS JOIN dept;
 
 ORACLE-SQL (���� ���̺� ����ϰ� WHERE ���� ������ ������� �ʴ´�)
 
 SELECT *
 FROM emp, dept;
 
 CROSS JOIN(01)
 
 customer, product ���̺��� �̿��Ͽ� ���� ������ ��� ��ǰ�� ������ �����Ͽ� ������ ����
 ��ȸ�ǵ��� ������ �ۼ��ϼ���
 
 SELECT cid, cnm, pid, pnm
 FROM customer, product;
 
 SELECT cid, cnm, pid, pnm
 FROM customer CROSS JOIN product;
 
 ��������
 WHERE : ������ �����ϴ� �ุ ��ȸ�ǵ��� ����
 
 SELECT *
 FROM emp
 WHERE 1 = 1;
 
 ���� <==> ����
 ���������� �ٸ� ���� �ȿ��� �ۼ��� ����
 
 �������� ������ ��ġ(������ �ִ�)
    1. SELECT
        - SCALAR SUB QUERY
        - * ��Į�� ���������� ��ȸ�Ǵ� ���� 1���̰�, �÷��� �Ѱ��� �÷��̾�� �Ѵ�
            EX) DUAL ���̺�
    2. FROM
        - INLINE-VIEW
        - SELECT ������ ��ȣ�� ���� ��
    3. WHERE
        - SUB QUERY
        WHERE ���� ���� ����(���ٸ� ���ǰ� ����)
 
 SMITH�� ���� �μ��� ���� �������� ���� ������?
 
 1. SMITH�� ���� �μ��� �������?
 2. 1������ �˾Ƴ� �μ���ȣ�� ���ϴ� ������ ��ȸ
 
 ==> �������� 2���� ������ ���� ����
     �ι�° ������ ù��° ������ ����� ���� ���� �ٸ��� �����;� �Ѵ�
     (SMITH(20) => WARD(30) ==> �ι�° ���� �ۼ��� 10������ 30������ ������ ����)
     ==> �������� ���鿡�� ���� ����
 
 ù��° ����;
 SELECT deptno -- 20
 FROM emp
 WHERE ename = 'SMITH';
        
 �ι�° ����;
 SELECT *
 FROM emp
 WHERE deptno = 20;
 
 ���������� ���� ���� ����
 SELECT *
 FROM emp
 WHERE deptno = (SELECT deptno
                    FROM emp
                    WHERE ename = 'SMITH'); WHERE�� ==> ������ ���� �ٲ�� ��
                    
 SELECT *
 FROM emp
 WHERE deptno = (SELECT deptno
                    FROM emp
                    WHERE ename = :ename); ==> :ename ���ε庯���� ����ϴ� ��
                    
 �������� �ǽ�(01)
 
 ��� �޿����� ���� �޿��� �޴� ������ ���� ��ȸ�ϼ���
 
 SELECT AVG(sal)
 FROM emp;
 
 SELECT COUNT(*)
 FROM emp
 WHERE sal > 2073.21;
 
 SELECT COUNT(*)
 FROM emp
 WHERE sal > (SELECT ROUND(AVG(sal), 0)
 FROM emp);
 
 �������� �ǽ�(02)
 
 ��� �޿����� ���� �޿��� �޴� ������ ������ ��ȸ�ϼ���
 
 SELECT *
 FROM emp
 WHERE sal > (SELECT ROUND(AVG(sal), 0)
 FROM emp);
 
 
 
 