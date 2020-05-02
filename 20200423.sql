 NVL(expr1, expr2)
 if expr1 == null
    return expr2
 else
    return expr1
    
 NVL2(expr1, expr2, expr3)
 if expr1 != null
    return expr2
 else
    return expr3
    
 SELECT empno, ename, sal, comm, NVL2(comm, 100, 200)
 FROM emp;
 
 NULLIF(expr1, expr2)
 expr1 == expr2
    return null
 expr1 != expr2
    return expr2
    
 sal �÷��� ���� 3000�̸� null�� ����
 SELECT empno, ename, sal, NULLIF(sal, 3000)
 FROM emp;
 
 �������� : �Լ� ������ ������ ������ ���� ����
           �� �������ڵ��� Ÿ���� ���� �ؾ���
           ex)display("test"), display("test", "test2", "test3")
 
 ���ڵ� �߿� ���� ���� ������ null�� �ƴ� ���� ���� ����         
 coalesce(expr1, expr2...)
 expr1 != null
    return expr1
 exprl == null
    return coaleasce(expr2, expr3...) ù��° ���ڸ� ������
    
 mgr �÷� null
 comm �÷� null
 
 SELECT empno, ename, comm, sal, coalesce(comm, sal)
 FROM emp;
 
 emp ���̺��� ������ ������ ���� ��ȸ�ǵ��� ������ �ۼ��ϼ���
 (nvl, nvl2, coalesce);
 
 SELECT empno, ename, mgr, NVL(mgr, 9999) AS mgr_n, 
        NVL2(mgr, mgr, 9999) AS mgr_n_1, coalesce(mgr, 9999) AS mgr_n_2
 FROM emp;
 
 users ���̺��� ������ ������ ���� ��ȸ�ϵ��� ������ �ۼ��ϼ���
 reg_dt�� null�� ��� sysdate�� ����
 
 SELECT userid, usernm, reg_dt, NVL(reg_dt,TO_DATE(sysdate, 'YY/MM/DD')) AS n_reg_dt
 FROM users
 WHERE userid != 'brown';
 
 ����ȭ --> os ���� �ٸ� os ��ġ
 1. �ϵ���� �ڿ��� �̾Ƹ���
 2. oracle mac �÷����� ����X
 
 ��Ʈ(1 ~ 2 ^ 16)
 http - 80
 mysql, ������ - 3306
 ��Ĺ - 8080
 ����Ŭ - 1521
 
 ����ȭ => 8������ ����
        Ŭ����, �Ƹ���(Web Service)
 ��Ŀ �����̳�
 
 ����Ŭ ���� : scott/tiger
 
 condition
 ���ǿ� ���� �÷� Ȥ�� ǥ������ �ٸ� ������ ��ü
 java�� if, swtich ���� ����
 - case ����
 - decode �Լ�
 
 1. CASE
 CASE
    WHEN ��/������ �Ǻ��� �� �ִ� �� THEN ������ ��
    [WHEN ��/������ �Ǻ��� �� �ִ� �� THEN ������ ��]
    [ELSE ������ �� (�Ǻ����� ���� WHEN ���� ������� ����)]
 END
 
 emp ���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
 �ش� ������ job�� SALESMAN�� ��� SAL���� 5%(5�ۼ�Ʈ) �λ�� �ݾ��� ���ʽ��� ���� (ex : sal 100 => 105)
 �ش� ������ mgr�� MANAGER�� ��� SAL���� 10%(10�ۼ�Ʈ) �λ�� �ݾ��� ���ʽ��� ����
 �ش� ������ job�� PRESIDENT�� ��� SAL���� 20%(20�ۼ�Ʈ) �λ�� �ݾ��� ���ʽ��� ����
 �׿� �������� sal��ŭ�� ����
 
 SELECT empno, ename, job, sal,
        CASE
                WHEN job = 'SALEMAN' THEN sal * 1.05
                WHEN job = 'MANMAGER' THEN sal * 1.05
                WHEN job = 'SSAL' THEN sal * 1.05                
                ELSE sal           
        END bonus
 FROM emp;
 
 2. DECODE(expr1, serch1, return1, search2, return2, serch3, return3..... (default))
    DECODE(expr1, 
            serch1, return1, 
            search2, return2, 
            serch3, return3
            default);
    expr1 == serch1
        return return1
    expr1 == serch2
        return return2
    expr1 == serch3
        return return3
    .....
    else
        return default;
 
 SELECT empno, ename, job, sal,
        DECODE(job, 'SALESMAN', sal * 1.05,
                    'MANAGER', sal * 1.10,
                    'PRESIDENT', sal * 1.20,
                    sal) bonus
 FROM emp;
 
 emp ���̺��� �̿��Ͽ� deptno�� ���� �μ������� �����ؼ� ������ ���� ��ȸ�Ǵ� ������ �ۼ��ϼ���
    - 10 => 'ACCOUTNING'
    - 20 => 'RESEARCH'
    - 30 => 'SALES'
    - 40 => 'OPERATIONS'
    - ��Ÿ �ٸ��� => 'DDIT'
    
 SELECT empno, ename, deptno,
        CASE
            WHEN deptno = 10 THEN 'ACCOUNTING'
            WHEN deptno = 20 THEN 'RESEARCH'
            WHEN deptno = 30 THEN 'SALES'
            WHEN deptno = 40 THEN 'OPERATIONS'
            ELSE 'DDIT'
        END dname
 FROM emp;
 
 SELECT empno, ename, deptno,
        DECODE(deptno, 10, 'ACCOUNTING',
                    20, 'RESEARCH',
                    30, 'SALES',
                    40, 'OPERATIONS',
                    'DDIT') dname
 FROM emp;
 
 emp ���̺��� �̿��Ͽ� hiredate�� ���� ���� �ǰ����� ������������� ��ȸ�ϴ� ������ �ۼ��ϼ���
 (������ �������� �ϳ� ���⼭�� �Ի�⵵�� �������� �Ѵ�);

 SELECT empno, ename,
        CASE
            WHEN MOD(TO_CHAR(SYSDATE, 'YY'), 2) = 0 AND MOD(TO_CHAR(hiredate, 'YY'), 2) = 0 THEN '�ǰ����� �����' 
            WHEN MOD(TO_CHAR(SYSDATE, 'YY'), 2) = 1 AND MOD(TO_CHAR(hiredate, 'YY'), 2) = 0 THEN '�ǰ����� ������'
            WHEN MOD(TO_CHAR(SYSDATE, 'YY'), 2) = 0 AND MOD(TO_CHAR(hiredate, 'YY'), 2) = 1 THEN '�ǰ����� ������'
            WHEN MOD(TO_CHAR(SYSDATE, 'YY'), 2) = 1 AND MOD(TO_CHAR(hiredate, 'YY'), 2) = 1 THEN '�ǰ����� �����'
        END contact_to_doctor
 FROM emp;
 
 users ���̺��� �̿��Ͽ� reg_dt�� ���� ���� �ǰ����� ���� ��������� ��ȸ�ϴ� ������ �ۼ��ϼ���.
 (������ �������� �ϳ� ���⼭�� reg_dt�� �������� �Ѵ�);
 
 SELECT userid, usernm, alias, reg_dt,
        CASE
            WHEN MOD(TO_CHAR(SYSDATE, 'YY'), 2) = 0 AND MOD(TO_CHAR(reg_dt, 'YY'), 2) = 0 THEN '�ǰ����� �����' 
            WHEN MOD(TO_CHAR(SYSDATE, 'YY'), 2) = 1 AND MOD(TO_CHAR(reg_dt, 'YY'), 2) = 0 THEN '�ǰ����� ������'
            WHEN MOD(TO_CHAR(SYSDATE, 'YY'), 2) = 0 AND MOD(TO_CHAR(reg_dt, 'YY'), 2) = 1 THEN '�ǰ����� ������'
            WHEN MOD(TO_CHAR(SYSDATE, 'YY'), 2) = 1 AND MOD(TO_CHAR(reg_dt, 'YY'), 2) = 1 THEN '�ǰ����� �����'
            WHEN reg_dt IS NULL THEN '�ǰ����� ������'
        END contact_to_doctor
 FROM users;