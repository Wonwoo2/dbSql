�θ� - �ڽ� ���̺� ����

1. ���̺� ������ ����
    1) �θ� (dept)
    2) �ڽ� (emp)
2. ������ ������(INSERT) ����
    1) �θ� (dept)
    2) �ڽ� (emp)
3. ������ ������(DELETE) ����
    1) �ڽ� (emp)
    2) �θ� (dept)

���̺� �����(���̺��� �̹� �����Ǿ� �ִ� ���) �������� �߰� ����

CREATE TABLE emP_test (
	empno NUMBER(4),
	ename VARCHAR(10),
	deptno NUMBER(2)
);

���̺� ������ ���������� Ư���� �������� ����

�� ���̺� ������ ���� PRIMARY KEY �߰�

ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� �������� Ÿ��(������ �÷�, �÷��� �������� �ü� ����);
�������� Ÿ�� : PRIMARY KEY, UNIQUE, FOREIGN KEY, CHECK
��� ���� �� 5���� �̳� ������ �ϳ��� ���� ����ϱ� ������ Ű����� ���� �����Ѵ��ϼ���(NOT NULL)
PRIMARY KEY�� ����ϴ� ������ ������ ���Ἲ ������

ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY (empno);

���̺� ����� �������� ����

ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;

�� ������ �߰��� �������� pk_emp_test ����

ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;

�� ���̺� �������� �ܷ�Ű �������� �߰�
emp_test.deptno ==> dept_test.deptno

dept_test���̺��� deptno�� �ε��� ���� �Ǿ��ִ��� Ȯ��

ALTER TABLE emp_test ADD CONSTRAINT �������Ǹ� �������� Ÿ�� (�÷�) 
                                REFERENCES �������̺�� (�������̺� �÷���);

ALTER TABLE emp_test ADD CONSTRAINT fk_emp_dept_test FOREIGN KEY (deptno) 
REFERENCES dept_test (deptno);

������ ����(PRIMARY KEY ������ �����ϴٴ� ��)
ALTER TABLE emp_test DROP CONSTRAINT fk_emp_dept_test FOREIGN KEY (deptno) 
REFERENCES dept_test (deptno);

�������� Ȱ��ȭ / ��Ȱ��ȭ
���̺� ������ ���������� ���� �ϴ� ���� �ƴ϶� ��� ����� ����, Ű�� ����

ALTER TABLE ���̺�� ENABLE | DISABLE CONSTRAINT �������Ǹ�;

�� ������ ������ fk_emp_dept_test FOREIGN KEY ���������� ��Ȱ��ȭ

ALTER TABLE emp_test DISABLE CONSTRAINT fk_emp_dept_test;

fk_emp_dept_test ���������� ��Ȱ��ȭ�Ǿ� �ֱ� ������ emp_test ���̺��� 99�� �μ� �̿���
���� �Է� ������ ��Ȳ

INSERT INTO emp_test VALUES(9999, 'brown', 88);

���� ��Ȳ : emp_test ���̺� dept_test ���̺� �������� �ʴ� 88�� �μ��� ����ϰ� �ִ� ��Ȳ
            fk_emp_dept_test ���������� ��Ȱ��ȭ�� ����
            
�������� ���Ἲ�� ���� ���¿��� fk_emp_dept_test�� Ȱ��ȭ��Ű��??
==> ������ ���Ἲ�� ��ų �� �����Ƿ� Ȱ��ȭ �� �� ����

ALTER TABLE emp_test ENABLE CONSTRAINT fk_emp_dept_test;

emp, dept ���̺��� ���� PRIMARY KEY, FOREIGN KEY ������ �ɷ� ���� ���� ��Ȳ
emp ���̺��� empno�� key��, dept ���̺��� deptno�� key�� PRIMARY KEY ������ �߰��ϰ�

emp.deptno => dept.deptno�� �����ϵ��� FOREIGN KEY�� �߰�

�������� ���� �����ð��� �ȳ��� ������� ���.

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept FOREIGN KEY (deptno)
REFERENCES dept (deptno);

�������� Ȯ��
 - ������ �������ִ� �޴�(���̺� ���� ==> �������� tab)
 - USER_CONSTRAINTS : �������� ����(MASTER);
 - USER_CONS_COLUMNS : �������� �÷� ����(��);

�÷� Ȯ��
 - ��
 - SELECT
 - DESC
 - USER_TAB_COLUMNS (data dictionary, ����Ŭ���� ���������� �����ϴ� view);

���̺�, �÷� �ּ� : USER_TAB_COMMENTS, USER_COL_COMMENTS;

���� ���񽺼� ���Ǵ� ���̺��� ���� ���ʰ��� ������ �ʴ� ����̴�
���̺��� : ī�װ� + �Ϸù�ȣ

���̺��� �ּ� �����ϱ�

COMMEMT ON TABLE ���̺�� IS '�ּ�';

�� emp ���̺� �ּ� �����ϱ�
COMMENT ON TABLE emp IS '����';

SELECT *
FROM user_tab_comments;

�÷� �ּ� Ȯ��
SELECT *
FROM user_col_comments
WHERE TABLE_NAME = 'EMP';



COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�';

empno : ���, ename �̸�, hiredate �Ի����� ������ user_col_comments�� ���� Ȯ��

COMMENT ON COLUMN emp.empno IS '���';
COMMENT ON COLUMN emp.ename IS '�̸�';
COMMENT ON COLUMN emp.hiredate IS '�Ի�����';

SELECT *
FROM user_col_comments
WHERE TABLE_NAME = 'EMP';

�� user_tab_comments, user_col_comments view�� �̿��Ͽ� customer,
product, cycle, daily ���̺�� �÷��� �ּ� ������ ��ȸ�ϴ� ������ �ۼ�

SELECT *
FROM user_tab_comments;

SELECT *
FROM user_col_comments;

SELECT a.TABLE_NAME, TABLE_TYPE, a.COMMENTS, b.COLUMN_NAME, b.COMMENTS COL_COMMENTS
FROM user_tab_comments a, user_col_comments b
WHERE a.TABLE_NAME = b.TABLE_NAME
AND a.TABLE_NAME IN ('PRODUCT', 'CYCLE', 'CUSTOMER', 'DAILY');

View : ����
������ ������ ���� = SQL
�������� ������ ������ �ƴϴ�

view ��� �뵵
 - ������ ����(���ʿ��� �÷� ������ ����)
 - ���� ����ϴ� ������ ���� ����
 - IN-LINE VIEW�� ����ص� ������ ����� ����� �� �� ������
    MAIN ������ ������� ������ �ִ�

view�� �����ϱ� ���ؼ��� CREATE VIEW ������ ���� �־�� �Ѵ�(DBA ����)
SYSTEM ������ ���ؼ�
GRANT CREATE VIEW TO ����� ������ �ο��� ������;

CREATE (OR REPLACE) VIEW ���̸� [�÷���Ī1, �÷���Ī2....] AS
        SELECT ����;

�� emp���̺��� sal, comm �÷��� ������ 6���� �÷��� ��ȸ�� ������ v_emp_ view�� ����

CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

�� view (v_emp)�� ���� ������ ��ȸ

SELECT *
FROM v_emp;

v_emp view�� sem���� ����
HR�������� �λ� �ý��� ������ ���ؼ� emp���̺��� �ƴ� sal, comm ��ȸ�� ���ѵ�
v_emp view�� ��ȸ�� �� �ֵ��� ������ �ο�

[hr����]���Ѻο��� hr �������� v_emp ��ȸ
SELECT * 
FROM PC01.v_emp; -- � ������ �並 ��ȸ���� ������־���Ѵ�

pc01�������� hr�������� v_emp view�� ��ȸ�� �� �ִ� ���� �ο�

GRANT SELECT ON v_emp TO hr;

[hr����]v_emp view������ hr ������ �ο��� ���� ��ȸ �׽�Ʈ

SELECT *
FROM sem.v_emp;

�� v_emp_dept �並 ����
emp, dept ���̺��� deptno �÷����� �����ϰ�
emp.empno, ename, dept.deptno, dname 4���� �÷����� ����

CREATE OR REPLACE VIEW v_emp_dept AS
SELECT e.empno, ename, d.deptno, dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;

SELECT *
FROM v_emp_dept;

SELECT *
FROM
    (SELECT e.empno, ename, d.deptno, dname
    FROM emp e, dept d
    WHERE e.deptno = d.deptno);
    
�� �� ��ü�� ��� ���� �ʿ�� ���� ��� ������ ���� �ζ��κ並 ����Ѵ�
- �ζ��κ�� ��ȸ���� ������ ���� �� ���

VIEW ����
DROP VIEW ������ �� �̸�;

VIEW�� ���� DML ó��

SIMPLE VIEW�� ���� ����

SIMPLE VIEW : ���ε��� �ʰ�, �Լ�, GROUP BY, ROWNUM�� ������� ���� ������ ������ VIEW
COMPLEX VIEW : SIMPLE VIEW�� �ƴ� ����

v_emp : SIMPLE VIEW

SELECT *
FROM v_emp;

�� v_emp�� ���� 7360 SMITH ����� �̸��� brown���� ����

UPDATE v_emp set ename = 'brown'
WHERE empno = 7369;

SELECT *
FROM emp;

v_emp �÷����� sal �÷��� �������� �ʱ� ������ ����
UPDATE v_emp set sal = 1000
WHERE empno = 7369;

ROLLBACK;

SEQUENCE
������ �������� �������ִ� ����Ŭ ��ü
���� �ĺ��� ���� ������ �� �ַ� ���

�ĺ��� ==> �ش� ���� �����ϰ� ������ �� �ִ� ��
���� <==> ���� �ĺ���
���� : ���� �׷��� ��
���� : �ٸ糽 ��

�Ϲ������� � ���̺�(����Ƽ)�� �ĺ��ڸ� ���ϴ� ����� [����], [����], [������]
�����ϸ� �ȴ�

�Խ����� �Խñ� : �Խñ� �ۼ��ڰ� ����, � ���� �ۼ� �ߴ���
�Խñ��� �ĺ��� : �ۼ���ID, �ۼ�����, ������
==> ���� �ĺ��ڰ� �ʹ� �����ϱ� ������ ������ ���̼��� ���� ���� �ĺ��ڸ�
��ü�� �� �ִ� (�ߺ����� �ʴ�) ���� �ĺ��ڸ� ���

������ �ϴٺ��� ������ ���� �����ؾ��� ���� ����

ex : ���, �й�, �Խñ� ��ȣ
    ���, �й� : ü��
    ��� : 15101001 - ȸ�簡 �������� 15, 10�� 10�� �Ի���, �ش� ��¥�� ù��° �Ի��� ��� 01
    �й� : 
    
    ü�谡 �ִ� ���� �ڵ�ȭ�Ǳ� ���ٴ� ����� ���� Ÿ�� ��찡 ����
    
    �Խñ� ��ȣ : ü�谡 ����, ��ġ�� �ʴ� ����
    ü�谡 ���� ���� �ڵ�ȭ�� ���� ==> SEQUENCE ��ü�� Ȱ���Ͽ� �ս��� ���� ����
    ==> �ߺ����� �ʴ� ���� ���� ��ȯ
    
�ߺ����� �ʴ� ���� �����ϴ� ���
1. KEY TABLE�� ����
    ==> SELECT FOR UPDATE �ٸ� ����� ���ÿ� ������� ���ϵ��� ���°� ����
    ==> ���� ���� ���� ��, ������ ���� �̻ڰ� �����ϴ°� ���� (SEQUENCE ������ �Ұ���)

2. JAVA�� UUID Ŭ������ Ȱ��, ������ ���̺귯�� Ȱ��(����) ==> ������, ����, ī��
    ==> jsp �Խ��� ����
    
3. ORACLE DB - SEQUENCE
    
SEQUENCE ����
CREATE SEQUENCE ������ ��;

seq_emp��� �������� ����

CREATE SEQUENCE seq_emp;

���� : ��ü���� �������ִ� �Լ��� ���ؼ� ���� �޾ƿ´�
NEXTVAL : �������� ���� ���ο� ���� �޾ƿ´�
CURRVAL : ������ ��ü�� NEXTVAL�� ���� ���� ���� �ٽ��ѹ� Ȯ���� �� ���
            (Ʈ����ǿ��� NEXTVAL �����ϰ� ���� ����� ����);
            
SELECT seq_emp.NEXTVAL
FROM dual;

SELECT seq_emp.CURRVAL
FROM dual;

SELECT *
FROM emp_test;

�� SEQUENCE�� ���� �ߺ����� �ʴ� empno �� �����Ͽ� INSERT �ϱ�
�Ʒ� ������ ������ ����

INSERT INTO emp_test VALUES(seq_emp.NEXTVAL, 'sally', 88);

SELECT *
FROM emp_test;

SEQUENCE �� ������ ����
SEQUENCE ����
DROP SEQUENCE ��������;