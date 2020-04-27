 �Ķ���ͷ� yyyymm ������ ���ڿ��� ����Ͽ� (ex : yyyymm = 201912)
 
 SELECT TO_DATE(:yyyymm, 'YYYYMM'),
        LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')),
        TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD') d
 FROM dual;
 
 EXPlAIN PLAN FOR
 SELECT *
 FROM emp
 WHERE empno = '7369';
 
 SELECT *
 FROM table(DBMS_XPLAN.DISPLAY);
 

 Plan hash value: 3956160932
  �����ȹ�� ���� ����(id)
  * �鿩���� �Ǿ������� �ڽ� ���۷��̼�
  1. ������ �Ʒ���
        *�� �ڽ� ���۷��̼��� ������ �ڽĺ��� �д´�
    1 ==> 0
    --------------------------------------------------------------------------
    | Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
    --------------------------------------------------------------------------
    |   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
    |*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
    --------------------------------------------------------------------------
 
    Predicate Information (identified by operation id):
    ---------------------------------------------------
        1 - filter("EMPNO"=7369)
    Note
    -----
    - dynamic sampling used for this statement (level=2)
    
 EXPLAIN PLAN FOR
 SELECT *
 FROM emp
 WHERE to_char(empno) = '7369';
 
 SELECT *
 FROM TABLE(DBMS_XPLAN.DISPLAY);
 
 Plan hash value: 3956160932
 
    --------------------------------------------------------------------------
    | Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
    -------------------------------------------------------------------------
    |   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
    |*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
    --------------------------------------------------------------------------
 
    Predicate Information (identified by operation id):
    ---------------------------------------------------
 
        1 - filter(TO_CHAR("EMPNO")='7369')
 
    Note
    -----
        - dynamic sampling used for this statement (level=2)
    
    EXPLAIN PLAN FOR
    SELECT *
    FROM emp
    WHERE empno = 7300 + '69';
    
    SELECT *
    FROM TABLE(DBMS_XPLAN.DISPLAY);
    
    Plan hash value: 3956160932
 
    --------------------------------------------------------------------------
    | Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
    --------------------------------------------------------------------------
    |   0 | SELECT STATEMENT  |      |     1 |    87 |     3   (0)| 00:00:01 |
    |*  1 |  TABLE ACCESS FULL| EMP  |     1 |    87 |     3   (0)| 00:00:01 |
    --------------------------------------------------------------------------
 
    Predicate Information (identified by operation id):
    ---------------------------------------------------
 
        1 - filter("EMPNO"=7369)
    
    Note
    -----
        - dynamic sampling used for this statement (level=2)
        
 SELECT *
 FROM dept;
 
 SELECT ename, sal, TO_CHAR(sal, 'L009,999.00') won
 FROM emp; ==> Ȱ�뵵 ������
 
 NULL�� ���õ� �Լ�
 NVL
 NVL2
 NULLIF
 COALESCE
 
 �� null ó���� �ؾ��ұ�?
 - NULL�� ���� �������� NULL�̴�
 
 ���� ��� emp ���̺� �����ϴ� sal, comm �ΰ��� �÷� ���� ���� ���� �˰� �;
 ������ ���� SQL�� �ۼ�
 
 SELECT empno, ename, sal, comm, sal + comm AS sal_plus_comm
 FROM emp;
 
 NVL(expr1, expr2)
  - expr1�� null�̸� expr2���� ����
  - expr1�� null�� �ƴϸ� expr1�� ����

 SELECT empno, ename, sal, comm, sal + NVL(comm, 0) AS sal_plus_comm
 FROM emp;
 
 REG_DT �÷��� NULL�� ��� ���� ��¥�� ���� ���� ������ ���ڷ� ǥ��
 
 SELECT userid, usernm, reg_dt, NVL(reg_dt, TO_CHAR(LAST_DAY(SYSDATE), 'YYMMDD')) 
 FROM users;