 ����¡ ó��
    - ROWNUM
    - INLINE-VIEW(����Ŭ ����)
    - ����¡ ����
    - ���ε� ����

 �Լ� : ������ ���ȭ �� �ڵ�
 ==> ���� ���(ȣ��)�ϴ� ���� �Լ��� �����Ǿ� �ִ� �κ��� �и�
 ==> ���������� ���̼��� ����

 �Լ��� ������� ���� �汸
 ==> ȣ���ϴ� �κп� �Լ� �ڵ带 ���� ����ؾ� �ϹǷ�, �ڵ尡 �������
 ==> �������� ��������

 ����Ŭ �Լ��� ����
  �Է� ����
    - single row funbction
    - multi row function
  ������ ����
    - ���� �Լ� : ����Ŭ���� �����ϴ� �Լ�
    - ����� ���� �Լ� : �����ڰ� ���� ������ �Լ�(pl/sql ��� ��)
    
 DUAL TABLE
 SYS ������ ���� �ִ� ���̺�
 ����Ŭ�� ��� ����ڰ� �������� ����� �� �ִ� ���̺�
 
 �Ѱ��� ��, �ϳ��� �÷�(dummy) - ���� 'x'
 
 ��� �뵵 
 1. �Լ��� �׽�Ʈ�� ����
 2. merge ����
 3. ������ ����
 
 ����Ŭ ���� �Լ� �׽�Ʈ (��ҹ��� ����)
 LOWER, UPPER, INITCAP : ���ڷ� ���ڿ� �ϳ��� �޴´�.
 
 SELECT LOWER ('Helllo, World'), UPPER('Helllo, World'), INITCAP('helllo, world')
 FROM dual;
 
 SELECT LOWER ('Helllo, World'), UPPER('Helllo, World'), INITCAP('helllo, world')
 FROM emp1;
 
 �Լ��� WHERE�������� ��� �����ϴ�.
 emp ���̺��� SMITH ����� �̸��� �빮�ڷ� ����Ǿ� ����
 
 SELECT *
 FROM emp
 WHERE LOWER(ename) = 'smith'; �̷������� �ۼ��ϸ� �ȵȴ�
 WHERE ename = UPPER('smith'); �ΰ��� ����߿��� �������ٴ� �Ʒ������ �ùٸ� ����̴�
 WHERE ename = 'smith'; ���̺��� ������ ���� �빮�ڷ� ����Ǿ� �����Ƿ� ��ȸ�Ǽ� 0
 WHERE ename = 'SMITH'; ���� ����
 
 ���ڿ� ���� �Լ�
 CONCAT : 2���� ���ڿ��� �Է����� �޾�, ������ ���ڿ��� ��ȯ�Ѵ�
 
 SELECT CONCAT('start', 'end')
 FROM dual;
 
 CONCAT �Լ��� �ۼ��ϱ� (�� ||�� ������� �ʴ´�)
 SELECT table_name, tablespace_name, CONCAT('start', 'end'),
    CONCAT(table_name, tablespace_name),
    'SELECT * FROM ' || table_name || ';',
    CONCAT('SELECT * FROM ', CONCAT(table_name, ';'))
 FROM user_tables;
 
 SUBSTR(���ڿ�, ���� �ε���, ���� �ε���) : ���ڿ��� ���� �ε������� ���� �ε��������� �κ� ���ڿ�
 ���� �ε����� 1���� (*java�� ���� 0�����̰� ���� �ε��� -1������ �κ� ���ڿ�)
 
 LENGTH(���ڿ�) : ���ڿ��� ���̸� ��ȯ
 
 INSTR(���ڿ�, ã�� ���ڿ�, [�˻� ���� �ε���]) : ���ڿ����� ã�� ���ڿ��� �����ϴ���, ������ ��� ã�� ���ڿ��� �ε���(��ġ) ��ȯ
 
 LPAD, RPAD(���ڿ�, ���߰� ���� ��ü ���ڿ� ����, [�е� ���ڿ� - �⺻���� ����])
 
 REPLACE(���ڿ�, �˻��� ���ڿ�, ������ ���ڿ�) : ���ڿ����� �˻��� ���ڿ� ã�� ������ ���ڿ��� ����
 
 TRIM(���ڿ�) : ���ڿ��� �� ���� �����ϴ� ������ ����, ���ڿ� �߰��� �ִ� ������ ���� ����� �ƴ�
 
 SELECT SUBSTR('Hello, World', 1, 5) sub,
        LENGTH('Hello, World') len,
        INSTR('Hello, World', 'o') ins,
        INSTR('Hello, World', 'o', 6) ins2,
        INSTR('Hello, World', 'o', INSTR('Hello, World', 'o') + 1) ins3,
        LPAD('hello', 15, '*') lp,
        RPAD('hello', 15, '*') rp,
        LPAD('hello', 15) lp,
        RPAD('hello', 15) rp,
        REPLACE('Hello, World', 'll', 'LL') rep,
        TRIM('        Hello     ') tr,
        TRIM('H' FROM 'Hello') tr1
 FROM dual;
 
 NUMBER ���� �Լ�
  ROUND(����, �ݿø� ��ġ) : �ݿø�
   ROUND(105.54, 1) : �Ҽ��� ù��°�ڸ����� ����� ���� ==> �Ҽ��� �ι�° �ڸ����� �ݿø�
  TRUNC(����, [���� ��ġ-default - 0]) : ���� 
  MOD(������, ����) : ������ ����
  
 SELECT ROUND(105.54, 1) round,
        ROUND(105.55, 1) round2,
        ROUND(105.55, 0) round3,
        ROUND(105.55, -1) round4
 FROM dual;
 
 SELECT MOD(10, 3)
 FROM dual;
 
 SELECT MOD(10, 3), sal, MOD(sal, 1000)
 FROM emp;
 
 ��¥ ���� �Լ�
 SYSDATE : ������� ����Ŭ �����ͺ��̽� ������ ���� �ð�, ��¥�� ��ȯ�Ѵ�
            �Լ������� ���ڰ� ���� �Լ�
            (���ڰ� ���� ��� JAVA : �޼ҵ�()
                            SQL : �Լ���;
 
 date type +- ���� : ���� ���ϱ� ����
    ���� 1 = �Ϸ�
    1/24 = �ѽð�
    1/24/60 = 1��
 SELECT SYSDATE, SYSDATE + 5
 FROM dual;
 
 ���ͷ�
    ���� :
    ���� : ''
    ��¥ : TO_DATE('��¥ ���ڿ�', '����')
    
 SELECT *
 FROM emp
 WHERE hiredate = TO_DATE('1980/12/17', 'YYYY/MM/DD');
 
 SELECT *
 FROM emp
 WHERE hiredate = '1980/12/17';
 
 SELECT TO_DATE('2019/12/31', 'YYYY/MM/DD') lastday,
        TO_DATE('2019/12/31', 'YYYY/MM/DD')-5 lastday_before5,
        SYSDATE now, SYSDATE -3 now_before3
 FROM dual;
 
 TO_DATE(���ڿ�, ����) : ���ڿ��� ���信 �°� �ؼ��Ͽ� ��¥ Ÿ������ ����ȯ
 TO_CHAR(��¥, ����) : ��¥Ÿ���� ���信 �°� ���ڿ��� ��ȯ
 
 YYYY : �⵵
 MM : ��
 DD : ��
 D : �ְ�����(1 ~ 7, 1-�Ͽ���, 2-������..., 7-�����)
 IW : ���� (1���� 52 ~ 53����)
 HH : �ð�(12�ð�)
 HH24 : 24�ð� ǥ��
 MI : ��
 SS : ��
 
 ����ð�(SYSDATE) �ú��� �������� ǥ�� ==> TO_CHAR�� �̿��Ͽ� ����ȯ
 
 SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') now,
        TO_CHAR(SYSDATE, 'D') d,
        TO_CHAR(SYSDATE-1/24, 'YYYY/MM/DD HH24:MI:SS') now_before_1hour
 FROM dual;
 
 SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') dt_dash,
        TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') dt_dash_with_time,
        TO_CHAR(SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY
 FROM dual;
 
 MONTHS_BETWEEN(DATE1, DATE2) : DATE1�� DATE2 ������ �������� ��ȯ
 4���� ��¥ �����Լ��߿� ��� �󵵰� ����
 
 SELECT MONTHS_BETWEEN(TO_DATE('2020/04/21', 'YYYY/MM/DD'),
        TO_DATE('2020/03/21', 'YYYY/MM/DD')),
        MONTHS_BETWEEN(TO_DATE('2020/04/22', 'YYYY/MM/DD'),
        TO_DATE('2020/03/21', 'YYYY/MM/DD'))
 FROM dual;
 
 ADD_MONTHS(DATE1, ������ ������) : DATE1�� ���� �ι�° �Էµ� ������ ��ŭ ������ DATE
 ���� ��¥�κ��� 5���� �� ��¥
 SELECT ADD_MONTHS(SYSDATE, 5) AS dt1,
        ADD_MONTHS(SYSDATE, -5) AS dt2
 FROM dual;
 
 NEXT_DAY(date1, �ְ�����) : date1���� �����ϴ� ù��° �ְ������� ��¥�� ��ȯ
 
 SELECT NEXT_DAY(SYSDATE, 7)
 FROM dual;
 
 LAST_DAY(date1) : date1�� ���� ���� ������ ��¥�� ��ȯ
 SYSDATE : 2020/04/21 ==> 2020/04/30
 
 SELECT LAST_DAY(SYSDATE)
 FROM dual;
 
 ��¥�� ���� ���� ù��° ��¥ ���ϱ�
 SYSDATE : 2020/04/21 ==> 2020/04/01;
 
 SYSDATE�κ��� ��������� ���ڿ� ���ϱ� => 202004
 SELECT LAST_DAY(SYSDATE), LAST_DAY(SYSDATE) + 1,
        ADD_MONTHS(LAST_DAY(SYSDATE) + 1, -1),
        TO_DATE(TO_CHAR(SYSDATE, 'YYYYMM') || '01', 'YYYYMMDD')
 FROM dual;
 
 