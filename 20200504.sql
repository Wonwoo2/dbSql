���� - ������

��Ģ ������ 
- +, -, *, / : ���� ������
- ? : ���� ������

SQL ������
= : �÷�|ǥ���� = �� => ���� ������
IN : �÷�|ǥ���� IN (���ϰ��� ���������, ������ ���� �´�)
    ���� ���, deptno IN (10, 30)

EXISTS ������
����� : EXISTS (��������) => ���� �����ڰ� �ƴϰ�, �÷��� �ƴϴ�
���������� ��ȸ����� �Ѱ��̶� ������ TRUE
�߸��� ����� : WHERE deptno EXISTS (��������)

SELECT *
FROM emp
WHERE EXISTS (SELECT 'X'
              FROM dept);
=> ���������� ���� ���� ���� ���������� ���� ����� �׻� ���� �ϱ� ������
emp ���̺��� ��� �����Ͱ� ��ȸ �ȴ�
=> ���ȣ ��������
=> �Ϲ������� EXISTS �����ڴ� ��ȣ���� ���������� ���� ���

EXISTS �������� ����
- �����ϴ� ���� �ϳ��� �߰��� �ϸ� ���̻� Ž���� ���� �ʰ� �ߴ�
- ���� ���� ���ο� ������ ���� �� ���

�Ŵ����� ���� ���� : KING
�Ŵ��� ������ �����ϴ� ���� : 13
EXISTS �����ڸ� Ȱ���Ͽ� ��ȸ

SELECT *
FROM emp e
WHERE EXISTS (SELECT 'X'
                FROM emp m
                WHERE e.mgr = m.empno);
                
IS NOT NULL�� ���ؼ��� ������ ����� ���� �� �ִ�
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

join
SELECT e.*
FROM emp e, emp, m
WHERE e.mgr = m.empno;

��cycle, product ���̺��� �̿��Ͽ� cid = 1�� ���� �����ϴ� ��ǰ�� ��ȸ�ϴ� ������ 
EXISTS �����ڸ� �̿��Ͽ� �ۼ��ϼ���

SELECT *
FROM cycle;

SELECT *
FROM product;

SELECT pid, pnm
FROM product
WHERE EXISTS (SELECT *
                FROM cycle
                WHERE cid = 1
                AND cycle.pid = product.pid);
                
��cycle, product ���̺��� �̿��Ͽ� cid = 1�� ���� �������� �ʴ� ��ǰ�� ��ȸ�ϴ� ������ 
EXISTS �����ڸ� �̿��Ͽ� �ۼ��ϼ���

SELECT pid, pnm
FROM product
WHERE NOT EXISTS (SELECT *
                FROM cycle
                WHERE cid = 1
                AND cycle.pid = product.pid);
                
���տ���
- �����͸� Ȯ���ϴ� ����� �ϳ�
- SQL���� �����ϴ� UNION ALL (�ߺ� �����͸� ���� ���� �ʴ´�)
--{1, 5, 3} UINON ALL {2, 3} = {1, 5, 3, 2, 3}
--{1, 5, 3} ������ {2, 3} = {1, 2, 3, 5}
--{1, 5, 3} ������ {2, 3} = {1, 5}
--{1, 5, 3} ������ {2, 3} = {3}

SQL������ ���տ���
������ : UNION, UNION ALL, INTERSECT, MINUS
�ΰ� SQL �������� ���� Ȯ�� (��, �Ʒ��� ������ �ȴ�)

UNION ������ : �ߺ�����(������ ������ ���հ� ����)

--SELECT empno, ename
--FROM emp
--WHERE empno IN (7566, 7698, 7369)
--UNION
--SELECT empno, ename
--FROM emp
--WHERE empno IN (7566, 7698);

UNION ALL ������ : �ߺ����

--SELECT empno, ename
--FROM emp
--WHERE empno IN (7566, 7698, 7369)
--UNION ALL
--SELECT empno, ename
--FROM emp
--WHERE empno IN (7566, 7698);

INTERSECT ������ : �����հ� �ߺ��Ǵ� ��Ҹ� ��ȸ

--SELECT empno, ename
--FROM emp
--WHERE empno IN (7566, 7698, 7369)
--INTERSECT
--SELECT empno, ename
--FROM emp
--WHERE empno IN (7566, 7698);

MINUS ������ : ���� ���տ��� �Ʒ��� ���� ��Ҹ� ����

--SELECT empno, ename
--FROM emp
--WHERE empno IN (7566, 7698, 7369)
--MINUS
--SELECT empno, ename
--FROM emp
--WHERE empno IN (7566, 7698);

SQL ���տ������� Ư¡

���� �̸� : ù��° SQL�� �÷��� ���󰣴�

ù��° ������ �÷��� ��Ī �ο�
--SELECT ename nm, empno no
--FROM emp
--WHERE empno IN (7369)
--UNION
--SELECT ename, empno
--FROM emp
--WHERE empno IN (7698);

������ �ϰ� ���� ��� �������� ���� ����
���� SQL���� ORDER BY �Ұ� (�ζ��� �並 ����Ͽ� ������������ ORDER BY�� �������� ������ ����)

--SELECT ename nm, empno no
--FROM emp
--WHERE empno IN (7369)
----ORDER BY nm, �߰� ������ ���� �Ұ�
--UNION
--SELECT ename, empno
--FROM emp
--WHERE empno IN (7698)
--ORDER BY nm;

SQL�� ���� �����ڴ� �ߺ��� �����Ѵ�(������ ���� ����� ����), ��, UNION ALL�� �ߺ� ���
�ΰ��� ���տ��� �ߺ��� �����ϱ� ���� ������ ������ �����ϴ� �۾��� �ʿ�
=> ����ڿ��� ����� �����ִ� �������� ������
UNION ALL�� ����� �� �ִ� ��Ȳ�� ��� UNION�� ������� �ʾƾ� �ӵ����� ���鿡�� �����ϴ� 
�˰���(���� - ����, ���� ..)
    �ڷ� ���� : Ʈ������(���� Ʈ��, �뷱�� Ʈ��)
                heap
                stack, queue
                list

���տ��꿡�� �߿��� ���� : �ߺ�����

���ù�������

SELECT ROWNUM rn, a.sido, a.sigungu, a.city_idx
FROM
(SELECT bk.sido, bk.sigungu, bk.cnt, lot.cnt, ROUND((bk.cnt + kfc.cnt + mac.cnt)/ lot.cnt, 2) city_idx
FROM
(SELECT sido, sigungu, COUNT(gb) cnt
FROM fastfood
WHERE gb = '����ŷ'
GROUP BY sido, sigungu, gb) bk,

(SELECT sido, sigungu, COUNT(gb) cnt
FROM fastfood
WHERE gb = 'KFC'
GROUP BY sido, sigungu, gb) kfc,

(SELECT sido, sigungu, COUNT(gb) cnt
FROM fastfood
WHERE gb = '�Ƶ�����'
GROUP BY sido, sigungu, gb) mac,
(SELECT sido, sigungu, COUNT(gb) cnt
FROM fastfood
WHERE gb = '�Ե�����'
GROUP BY sido, sigungu, gb) lot
WHERE bk.sido = kfc.sido
    AND bk.sigungu = kfc.sigungu
    AND bk.sido = mac.sido
    AND bk.sigungu = mac.sigungu
    AND bk.sido = lot.sido
    AND bk.sigungu = lot.sigungu
ORDER BY city_idx DESC ) a;


����1) fastfood ���̺�� tax ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� SQL �ۼ�
1. �õ� ���ñ����� ���ù��������� ���ϰ�(������ ���� ���ð� ������ ����)
2. �δ� ���� �Ű���� ���� �õ� �ñ������� ������ ���Ͽ�
3. ���ù��������� �δ� �Ű�� ������ ���� ������ ���� �����Ͽ� �Ʒ��� ���� �÷��� ��ȸ�ǵ��� SQL �ۼ�
���� �õ� �ñ��� �ܹ��� ���ù�������, ����û �õ�, ����û �ñ���, ����û �������� �ݾ�1�δ� �Ű��

SELECT sido, sigungu, COUNT(gb) cnt
                    FROM fastfood
                    WHERE gb = '����ŷ'
                    GROUP BY sido, sigungu, gb;

SELECT ROWNUM srn, ci.sido, ci.sigungu, ci.city_idx, k.sido ta_sido, k.sigungu ta_sigungu, k.sp ta_sp
FROM
    (SELECT ROWNUM crn, a.sido, a.sigungu, a.city_idx
        FROM
    (SELECT bk.sido, bk.sigungu, bk.cnt, lot.cnt, ROUND((bk.cnt + kfc.cnt + mac.cnt)/ lot.cnt, 2) city_idx
        FROM
            (SELECT sido, sigungu, COUNT(gb) cnt
                    FROM fastfood
                    WHERE gb = '����ŷ'
                    GROUP BY sido, sigungu, gb) bk,

            (SELECT sido, sigungu, COUNT(gb) cnt
                    FROM fastfood
                    WHERE gb = 'KFC'
                    GROUP BY sido, sigungu, gb) kfc,

            (SELECT sido, sigungu, COUNT(gb) cnt
                    FROM fastfood
                    WHERE gb = '�Ƶ�����'
                    GROUP BY sido, sigungu, gb) mac,
            (SELECT sido, sigungu, COUNT(gb) cnt
                    FROM fastfood
                    WHERE gb = '�Ե�����'
                    GROUP BY sido, sigungu, gb) lot
            WHERE bk.sido = kfc.sido
            AND bk.sigungu = kfc.sigungu
            AND bk.sido = mac.sido
            AND bk.sigungu = mac.sigungu
            AND bk.sido = lot.sido
            AND bk.sigungu = lot.sigungu
            ORDER BY city_idx DESC ) a) ci,

    (SELECT ROWNUM trn, ta.sido, ta.sigungu, ta.sp
        FROM
        (SELECT sido, sigungu, ROUND(sal/people, 2) sp
            FROM tax
            GROUP BY sido, sigungu, people, sal
            ORDER BY sp DESC) ta) k
    WHERE k.trn = ci.crn;

����2)
�ܹ��� ���ù��� ������ ���ϱ� ���� 4���� �ζ��� �並 ����Ͽ��µ� (fastfood ���̺��� 4�� ���)
�̸� �����Ͽ� ���̺��� �ѹ��� �д� ���·� ������ ���� (fastfood ���̺��� 1���� ���)

SELECT sido, sigungu, gb,
                
            NVL(DECODE(gb, '�Ƶ�����', COUNT(gb)), 0),
            NVL(DECODE(gb, '����ŷ', COUNT(gb)), 0),
            NVL(DECODE(gb, 'KFC', COUNT(gb)), 0),    
            NVL(DECODE(gb, '�Ե�����', COUNT(gb)), 0)
            
    FROM fastfood
    WHERE gb != '�����̽�'
    AND gb != '������ġ'
    GROUP BY sido, sigungu, gb
    ORDER BY sido;
    
SELECT sido, sigungu, gb, COUNT(*)
    FROM fastfood
    WHERE gb != '�����̽�'
    AND gb != '������ġ'
    GROUP BY sido, sigungu, gb
    ORDER BY sido;
    
SELECT sido, sigungu,
        NVL(DECODE(gb, '�Ƶ�����', COUNT(*)), 0),
        NVL(DECODE(gb, '����ŷ', COUNT(*)), 0) +
        NVL(DECODE(gb, 'KFC', COUNT(*)), 0) 
        NVL(DECODE(gb, '�Ե�����', COUNT(*)), 0)
FROM fastfood
GROUP BY sido, sigungu, gb;

SELECT sido, sigungu, COUNT(gb) cnt
FROM fastfood
WHERE gb = '�Ƶ�����'
GROUP BY sido, sigungu, gb;

SELECT sido, sigungu, gb
FROM fastfood
WHERE sido = '��⵵'
AND sigungu = '���ֽ�'
AND gb = '�Ƶ�����';


����3)
�ܹ��� ���� sql�� �ٸ� ���·� �����ϱ�