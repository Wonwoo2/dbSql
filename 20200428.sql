 Join(01)
 erd�� �����Ͽ� prod ���̺�� lprod ���̺��� �����Ͽ� ������ ���� ����� ������ ������ �ۼ��غ�����
 
 SELECT lprod_gu, lprod_nm, prod_id, prod_name
 FROM lprod JOIN prod ON lprod.lprod_gu = prod.prod_lgu;
 
 Join(02)
 erd�� �����Ͽ� buyer, prod ���̺��� �����Ͽ� buyer�� ����ϴ� ��ǰ ������ ������ ���� ����� �������� ������ �ۼ��غ�����
 
 SELECT *
 FROM prod;
 
 SELECT *
 FROM buyer;
 
 SELECT buyer.buyer_id, buyer.buyer_name, prod.prod_id, prod.prod_name
 FROM prod, buyer
 WHERE prod.prod_buyer = buyer.buyer_id;
 
 Join(02) ���� ������ ���� ����;
 74�� ==> 1��
 �Ǽ� ==> COUNT
 
 SELECT COUNT(*)
 FROM
 (SELECT buyer.buyer_id, buyer.buyer_name, prod.prod_id, prod.prod_name
 FROM prod, buyer
 WHERE prod.prod_buyer = buyer.buyer_id); => IN-LINE-VIEW�� ���� �ʿ��� ������ �����غ� �ʿ䰡 �ִ�
                                          => ���� IN-LINE-VIEW�� ����ϸ� �ؼ��� ���� ��������� ����
 
 SELECT COUNT(*)
 FROM prod, buyer
 WHERE prod.prod_buyer = buyer.buyer_id;
 
 BUYER_NAME �� �Ǽ� ��ȸ ���� �ۼ�
 SELECT buyer.buyer_name, COUNT(*)
 FROM prod, buyer
 WHERE prod.prod_buyer = buyer.buyer_id
 GROUP BY buyer.buyer_name;
 
 Join(03)
 erd�� �����Ͽ� member, cart, prod ���̺��� �����Ͽ� ȸ���� ��ٱ��Ͽ� ���� ��ǰ ������ ������ ���� ����� ������
 ������ �ۼ��غ�����
 
 SELECT *
 FROM member;
 
 SELECT *
 FROM cart;
 
 SELECT *
 FROM prod;
 
 SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name, cart.cart_qty
 FROM member, cart, prod
 WHERE member.mem_id = cart.cart_member
    AND cart.cart_prod = prod.prod_id;
    
 ���̺� JOIN ���̺� ON/USING

 SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name, cart.cart_qty
 FROM member JOIN cart ON (member.mem_id = cart.cart_member)
            JOIN prod ON (cart.cart_prod = prod.prod_id);
            
 �������
 SELECT *
 FROM
 (SELECT deptno, COUNT(*)
 FROM emp
 GROUP BY deptno)
 WHERE deptno = 30;
 
 SELECT deptno, COUNT(*)
 FROM emp
 WHERE deptno = 30
 GROUP BY deptno;
 
 cid : customer id
 cnm : costomer name
 
 SELECT *
 FROM customer;
 
 pid : product id
 pnm : product name
 
 SELECT *
 FROM product;
 
 cycle : �����ֱ�
 cid : �� id
 pid : ��ǰ id
 day : ���� ���� (������, ȭ����...) => �Ͽ���1, ������2 ....
 cnt : ����
 
 SELECT *
 FROM cycle;
 
 Join(04)
 erd�� �����Ͽ� customber, cycle ���̺��� �����Ͽ� ���� ���� ��ǰ, ��������, ������ ������ ���� 
 ����� �������� ������ �ۼ��غ�����(������ brown, sally�� ���� ��ȸ)
 (*���İ� ���� ���� ���� ������ ����);
 
 SELECT customer.cid, customer.cnm, cycle.pid, cycle.day, cycle.cnt
 FROM customer, cycle
 WHERE customer.cid = cycle.cid
 AND (customer.cnm = 'brown' OR customer.cnm = 'sally');
 
 SELECT cid, cnm, pid, day, cnt
 FROM customer NATURAL JOIN cycle
 WHERE customer.cnm IN ('brown', 'sally');
 
 ����(05) 
 erd�� �����Ͽ� customber cycle, product ���̺� �����Ͽ� ���� ������ǰ, ��������, ����, ��ǰ����
 ������ ���� ����� �������� ������ �ۼ��غ�����(������ brown, sally�� ���� ��ȸ)
 (*���İ� ������� ���� ������ ����);
 
 SELECT customer.cid, cnm, product.pid, pnm, day, cnt
 FROM customer, cycle, product
 WHERE customer.cid = cycle.cid AND product.pid = cycle.pid
 AND (customer.cnm = 'brown' OR customer.cnm = 'sally');
 
 ����(06)
 erd�� �����Ͽ� customer, cycle, product ���̺��� �����Ͽ� �������ϰ� ������� ���� ���� ��ǰ��, ������ �հ�
 ��ǰ���� ������ ���� ����� �������� ������ �ۼ��غ�����
 (*���İ� ������� ���� ������ ����);
 
 SELECT customer.cid, customer.cnm, product.pid, product.pnm, SUM(cycle.cnt) cnt
 FROM customer, cycle, product
 WHERE customer.cid = cycle.cid AND product.pid = cycle.pid
 GROUP BY customer.cid, customer.cnm, product.pid, product.pnm;
 
 ����(07)
 erd�� �����Ͽ� cycle, product ���̺��� �����Ͽ� ��ǰ��, ������ �հ� ��ǰ���� ������ ���� ����� �������� ������ �ۼ��غ�����
 (*���İ� ������� ���� ������ ����);
 SELECT product.pid, product.pnm, SUM(cycle.cnt) cnt
 FROM cycle, product
 WHERE product.pid = cycle.pid
 GROUP BY product.pid, product.pnm;
 
 SELECT *
 FROM cycle;
 
 SELECT *
 FROM product;
 
 SELECT *
 FROM dba_users;

 ��й�ȣ ����
 ALTER user hr identified by java;

 ���� lock ����
 ALTER user hr ACCOUNT UNLOCK;
 
 �ǽ� 8 ~ 13 ����
 
 
 
 
 
 