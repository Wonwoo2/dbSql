SET TRANSACTION isolation
LEVEL SERIALIZABLE;

4���� ������ ��ȸ
SELECT *
FROM dept;

INSERT INTO dept
VALUES (99, 'ddit', 'daejeon');

5���� ������ ��ȸ
SELECT *
FROM dept;

ROLLBACK;

DDL : Data DEfinition Language
�����͸� �����ϴ� ���
CREATE, DROP, ALTER

���̺� ����
���� : DROP TABLE ������ ���̺��;
ranger ���̺� ����
DROP TABLE ranger;

TABLE ����
����

CREATE TABLE [������.]���̺��(
    �÷���1 �÷�Ÿ�� DEFAULT ������ �⺻��,
    �÷���2 �÷�Ÿ��, ....
);

rager���̺��� ������ ���� Į������ ����
ranger_no �÷��� NUMBER Ÿ������ 
ranger_nm �÷��� VARCHAR(50) Ÿ������
reg_dt �÷��� DATEŸ������ (�� �⺻���� �Է´���� ������ ���� �ð�)

CREATE TABLE ranger(
    ranger_no NUMBER,
    ranger_nm VARCHAR(50),
    reg_dt DATE DEFAULT SYSDATE
);

DESC ranger;

SELECT *
FROM ranger;

���̺�������ȸ ���ǹ�
NULLABLE => �ΰ��� �� �� �ִٴ� �ǹ�
COULUMN_ID => ����

DDL�� ROLLBACK �Ұ�

ROLLBACK;

SELECT *
FROM ranger;

ranger_no
ranger_nm 'brown'

INSERT INTO ranger
(ranger_no, ranger_nm) VALUES (99, 'brown');

SELECT *
FROM ranger;

reg_dt �÷��� ���� ���� �Է����� �ʾ����� ���̺� ������ ����
�⺻ �� SYSDATE�� �Է��� �ȴ�;

member ���̺� �����̶�� �÷��� ���� ��
���� �÷��� �� �� �ִ� �� : ����, ����, ����

�������� : �������� ���Ἲ�� ��Ű�� ���� ����
�� 4���� ���������� ����

UNIQUE : ������ �÷��� ���� �ٸ� ���� ���� �ߺ����� �ʵ��� ����
        ex) ���, �й�
PRIMARY KEY : UNIQUE ���� + NOT NULL CHECK ����
        ���� �����ؾ� �ϸ�, ���� �ݵ�� ���;� �ϴ� �÷�
        ex) ���, �й�
FOREIGN KEY : �ش� �÷��� �����ϴ� ���̺��� ���� �����ϴ��� Ȯ���ϴ� ����
        ex) emp���̺� �űԻ���� ��Ͻ� deptno ���� dept ���̺� �ݵ��
        �����ϴ� ���� ����� �����ϴ�
CHECK : �÷��� �ԷµǴ� ���� �����ڰ� ���� ������ ���� üũ,���� �ϴ� ����
        ex) ���� �÷��� ���� F, M �ΰ��� ���� �� �� �ֵ��� ����

���������� �����ϴ� ���
1. ���̺� ������ �÷� �����ٰ� �ش� �÷��� ����� ���������� ���
    => �����÷� ������ �Ұ�
2. ���̺� ������ �÷� ����� ������ �ش� ���̺� ����� ���������� ���
    => �����÷� ���� ����
3. ���̺� ���� ����, ������ �������Ǹ� �ش� ���̺� ����
    => ���̺� ����, �����÷� ���� ����
    
1. ���̺� ������ �÷� �����ٰ� �ش� �÷��� ����� ���������� ���

�μ���ȣ�� �ߺ��� �Ǹ� �ȵǰ�, ���� ��� �־�� �ȵȴ�(�Ϲ�������)
=> dbms���� ���� ������ PRIMARY KEY ���������� �÷� ������ ����
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);

DESC dept_test;

INSERT INTO dept_test VALUES (99, 'ddit2', 'daejeon');
�� ������ ���������� ����

INSERT INTO dept_test VALUES (99, 'ddit2', 'daejeon');
�� ������ ù��° �������� �Է��� �μ���ȣ�� �ߺ� �Ǳ� ������
PRIMARY KEY(UNIQUE) �������ǿ� ����Ǿ� ���������� �����Ͱ� �Էµ��� �ʴ´�
=> �츮�� ������ ������ ���Ἲ�� ��������

�������� �̸��� ����� ���� �ִ�
�ش� ������ �������� ��� ��Ģ�� ����� �Ѵ�

PRIMARY KEY ���� : pk_���̺��
UNIQUE ���� : u_���̺��
FOREIGN KEY ���� : fk_���̺��_�������̺��
NOT NULL, CHECK : ������ �̸��� ������� �ʴ´�

DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);

2. ���̺� ������ �÷� ����� ������ �ش� ���̺� ����� ���������� ���

DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT pk_dept_test PRIMARY KEY (deptno, dname)
);

INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (99, 'ddit2', 'daejeon');
deptno, dname �÷��� ��� ���� ���� ����
INSERT INTO dept_test VALUES (99, 'ddit2', 'daejeon');