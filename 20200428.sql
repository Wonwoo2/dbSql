 Join(01)
 erd를 참고하여 prod 테이블과 lprod 테이블을 조인하여 다음과 같은 결과가 나오는 쿼리를 작성해보세요
 
 SELECT lprod_gu, lprod_nm, prod_id, prod_name
 FROM lprod JOIN prod ON lprod.lprod_gu = prod.prod_lgu;
 
 Join(02)
 erd를 참고하여 buyer, prod 테이블을 조인하여 buyer별 담당하는 제품 정보를 다음과 같은 결과가 나오도록 쿼리를 작성해보세요
 
 SELECT *
 FROM prod;
 
 SELECT *
 FROM buyer;
 
 SELECT buyer.buyer_id, buyer.buyer_name, prod.prod_id, prod.prod_name
 FROM prod, buyer
 WHERE prod.prod_buyer = buyer.buyer_id;
 
 Join(02) 문제 정답을 행의 갯수;
 74건 ==> 1건
 건수 ==> COUNT
 
 SELECT COUNT(*)
 FROM
 (SELECT buyer.buyer_id, buyer.buyer_name, prod.prod_id, prod.prod_name
 FROM prod, buyer
 WHERE prod.prod_buyer = buyer.buyer_id); => IN-LINE-VIEW는 정말 필요한 것인지 생각해볼 필요가 있다
                                          => 많은 IN-LINE-VIEW를 사용하면 해석이 점점 어려워지기 때문
 
 SELECT COUNT(*)
 FROM prod, buyer
 WHERE prod.prod_buyer = buyer.buyer_id;
 
 BUYER_NAME 별 건수 조회 쿼리 작성
 SELECT buyer.buyer_name, COUNT(*)
 FROM prod, buyer
 WHERE prod.prod_buyer = buyer.buyer_id
 GROUP BY buyer.buyer_name;
 
 Join(03)
 erd를 참고하여 member, cart, prod 테이블을 조인하여 회원별 장바구니에 담은 제품 정보를 다음과 같은 결과가 나오는
 쿼리를 작성해보세요
 
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
    
 테이블 JOIN 테이블 ON/USING

 SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name, cart.cart_qty
 FROM member JOIN cart ON (member.mem_id = cart.cart_member)
            JOIN prod ON (cart.cart_prod = prod.prod_id);
            
 참고사항
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
 
 cycle : 애음주기
 cid : 고객 id
 pid : 제품 id
 day : 애음 요일 (월요일, 화요일...) => 일요일1, 월요일2 ....
 cnt : 수량
 
 SELECT *
 FROM cycle;
 
 Join(04)
 erd를 참고하여 customber, cycle 테이블을 조인하여 고객별 애음 제품, 애음요일, 개수를 다음과 같은 
 결과가 나오도록 쿼리를 작성해보세요(고객명이 brown, sally인 고객만 조회)
 (*정렬과 관계 없이 값이 맞으면 정답);
 
 SELECT customer.cid, customer.cnm, cycle.pid, cycle.day, cycle.cnt
 FROM customer, cycle
 WHERE customer.cid = cycle.cid
 AND (customer.cnm = 'brown' OR customer.cnm = 'sally');
 
 SELECT cid, cnm, pid, day, cnt
 FROM customer NATURAL JOIN cycle
 WHERE customer.cnm IN ('brown', 'sally');
 
 조인(05) 
 erd를 참고하여 customber cycle, product 테이블 조인하여 고개별 애음제품, 애음요일, 개수, 제품명을
 다음과 같은 결과가 나오도록 쿼리를 작성해보세요(고객명이 brown, sally인 고객만 조회)
 (*정렬과 관계없이 값이 맞으면 정답);
 
 SELECT customer.cid, cnm, product.pid, pnm, day, cnt
 FROM customer, cycle, product
 WHERE customer.cid = cycle.cid AND product.pid = cycle.pid
 AND (customer.cnm = 'brown' OR customer.cnm = 'sally');
 
 조인(06)
 erd를 참고하여 customer, cycle, product 테이블을 조인하여 애음요일과 관계없이 고객별 애음 제품별, 개수의 합과
 제품명을 다음과 같은 결과가 나오도록 쿼리를 작성해보세요
 (*정렬과 관계없이 값이 맞으면 정답);
 
 SELECT customer.cid, customer.cnm, product.pid, product.pnm, SUM(cycle.cnt) cnt
 FROM customer, cycle, product
 WHERE customer.cid = cycle.cid AND product.pid = cycle.pid
 GROUP BY customer.cid, customer.cnm, product.pid, product.pnm;
 
 조인(07)
 erd를 참고하여 cycle, product 테이블을 조인하여 제품별, 개수의 합과 제품명을 다음과 같은 결과가 나오도록 쿼리를 작성해보세요
 (*정렬과 관계없이 값이 맞으면 정답);
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

 비밀번호 변경
 ALTER user hr identified by java;

 계정 lock 해제
 ALTER user hr ACCOUNT UNLOCK;
 
 실습 8 ~ 13 과제
 
 
 
 
 
 