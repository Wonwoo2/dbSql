SELECT *    -- ��� �÷������� ��ȸ
FROM prod;  -- �����͸� ��ȸ�� ���̺� ���
            -- Ű����� �빮��, �������� �ҹ���(��)

-- Ư�� �÷��� ���ؼ��� ��ȸ : SELECT �÷�1, �÷�2, .....

SELECT prod_id, prod_name
FROM prod; -- prod_id, prod_name�÷��� prod ���̺��� ��ȸ

SELECT * 
FROM lprod; -- lprod ���̺��� ��� �����͸� ��ȸ�ϴ� ����

SELECT buyer_id, buyer_name
FROM buyer; -- buyer ���̺��� buyer_id, buyer_name �÷��� ��ȸ�ϴ� ����

SELECT *
FROM cart; -- cart ���̺��� ��� �����͸� ��ȸ�ϴ� ����

SELECT mem_id, mem_pass, mem_name
FROM member; -- member ���̺��� mem_id, mem_pass, mem_name �÷��� ��ȸ�ϴ� ����

    SQL ���� : JAVA�� �ٸ��� ���� �����ڰ� ����, �Ϲ����� ��Ģ������ ������.
    int b = 2; = ���� ������, == ��;
    SQL ������ Ÿ�� : ����, ����, ��¥(data);

-- USERS ���̺��� ����
SELECT *
FROM USERS; -- USERS ���̺��� ��� �����͸� ��ȸ;

    ��¥ Ÿ�Կ� ���� ���� : ��¥�� +, - ���� ����
    date type + ���� : date���� ���� ��¥��ŭ �̷� ��¥�� �̵�
    data type - ���� : data���� ���� ��¥��ŭ ���� ��¥�� �̵�

SELECT userid, reg_dt, reg_dt + 5, reg_dt - 5
FROM users; -- SELECT���� ���� �����Ϳ� ������ ���� �ʴ´�.

    �÷� ��Ī : ���� �÷����� ���� �ϰ� ���� ��
    syntax : ���� �÷��� [as] ��Ī��
    ��Ī �� ������ ǥ���Ǿ�� �� ��� ���� �����̼����� ���´�.
    ���� ����Ŭ������ ��ü���� �빮�� ó�� �ϱ� ������ �ҹ��ڷ� ��Ī�� �����ϱ� ���ؼ��� ���������̼��� ����Ѵ�.

SELECT userid as id, userid id2, userid ���̵�, userid "�� �� ��"
FROM users;

SELECT prod_id as id, prod_name as name
FROM prod; -- prod ���̺��� prod_id, prod_name �� �÷��� ��ȸ�ϴ� ����(��, prod_id -> id, prod_name -> name ���� �÷� ��Ī ����)

SELECT lprod_gu as gu, lprod_nm as nm
FROM lprod; -- lprod ���̺��� lprod_gu, lprod_nm �� �÷��� ��ȸ�ϴ� ����(��, lprod_gu -> gu, lprod_nm -> nm ���� �÷� ��Ī ����)

SELECT buyer_id as ���̾���̵�, buyer_name as �̸�
FROM buyer; -- buyer ���̺��� buter_id, buter_name �� �÷��� ��ȸ�ϴ� ����(��, buyer_id -> ���̾���̵�, buyer_name -> �̸� ���� �÷� ��Ī ����)

    ���ڿ� ����(���տ���) : || (���տ����ڴ� +�� �ƴϴ�.)
    
    ���ڹ��� ��� => string str = "hello";
                str = str + ", worrld"; // str : hello, world

SELECT /*userid + 'test'*/ userid || 'test'  as concat, reg_dt + 5
FROM users;

����
SELECT '�� ' || userid || ' ��'
FROM users;

SELECT userid, usernm, userid || usernm
FROM users;

SELECT userid || usernm as id_name,
        CONCAT(userid, usernm) as concat_id_name
FROM users;

user_tables : oracle���� �����ϴ� ���̺� ������ ��� �ִ� ���̺�(view) ==> data dictionary;

SELECT table_name
FROM user_tables; -- ���� ������ ����ڰ� ������ ���̺� ����� ��ȸ

SELECT 'SELECT * FROM ' || table_name || ';' as query
FROM user_tables; -- ���ڿ� ������ �̿�

SELECT CONCAT('SELECT * FROM ', table_name) || ';' as query
FROM user_tables;

���̺��� ���� �÷��� Ȯ��
1. tool�� ���� Ȯ��
    ���̺� - Ȯ���ϰ��� �ϴ� ���̺�
2. SELECT *
    FROM ���̺�
    �ϴ� ��ü ��ȸ --> ��� �÷��� ǥ��
3. DESC ���̺��
4. data dictionary : user_tab_columns

DESC emp;

SELECT * 
FROM user_tab_columns;

���ݱ��� ��� SELECT ����
��ȸ�ϰ��� �ϴ� �÷� ��� : SELECT
��ȸ�� ���̺� ��� : FROM
��ȸ�� ���� �����ϴ� ������ ��� : WHERE
WHERE ���� ����� ������ ��(TRUE)�� �� ����� ��ȸ

JAVA�� �� ���� : a������ b������ ���� ������ ��
int a = 5;
int b = 2;
a�� b�� ���� ���� ���� Ư������ ���� 
if( a == b ) {

}

sql�� �� ���� : =

SELECT * 
FROM users
WHERE userid = 'cony';

SELECT * 
FROM users
WHERE 1 = 1;

emp���̺��� �÷��� ������ Ÿ���� Ȯ��

DESC emp;

SELECT *
FROM emp;
    emp : employee ���� ���̺�
    empno : �����ȣ
    ename : ��� �̸�
    job : ������(��å)
    mgr : �����(������)
    hiredate : �Ի�����
    sal : �޿�
    comm : ������
    deptno : �μ���ȣ
    
SELECT * 
FROM dept;

emp ���̺��� ������ ���� �μ���ȣ�� 30�� ���� ū �μ��� ���� ������ ��ȸ

SELECT *
FROM emp
WHERE deptno >= 30;

!= �ٸ� ��
users ���̺���  ����� ���̵� (userid)�� brown�� �ƴ� ����ڸ� ��ȸ

SELECT *
FROM users
WHERE userid != 'brown';


SQL ���ͷ�
    ���� : ....20, 30, 40
    ���� : �̱� �����̼�(' ')
    ��¥ : TO_DATA('��¥���ڿ�', '��¥ ���ڿ��� ����');

SELECT *
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'YYYYMMDD'); -- 1982�� 1�� 1�� ���Ŀ� �Ի��� ������ ��ȸ, ������ �Ի����� : hiredate �÷�

emp ���̺��� ���� : 14��
1982�� 1�� 1�� ���� �Ի��� : 3��
1982�� 1�� 1�� ���� �Ի��� : 11��